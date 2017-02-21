package com.shear.admin.controller.login;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quickshear.common.enumeration.HairdresserStatusEnum;
import com.quickshear.common.enumeration.RoleEnum;
import com.quickshear.common.util.Md5Utils;
import com.quickshear.common.util.RetdCodeType;
import com.quickshear.common.vo.ResObj;
import com.quickshear.common.wechat.WechatUserInfoManager;
import com.quickshear.domain.Hairdresser;
import com.quickshear.domain.User;
import com.quickshear.domain.query.HairdresserQuery;
import com.quickshear.domain.query.UserQuery;
import com.quickshear.service.HairdresserService;
import com.quickshear.service.UserService;
import com.quickshear.service.sms.MessageService;
import com.quickshear.service.sms.StorageService;
import com.shear.admin.controller.base.AbstractController;

@Controller
@RequestMapping("/admin")
public class LoginController extends AbstractController {

    private static final Logger LOGGER = LoggerFactory
	    .getLogger(LoginController.class);

    @Autowired
    private UserService userService;
    @Autowired
    private HairdresserService hairdresserService;
    @Autowired
    private MessageService messageService;
    @Autowired
    private StorageService storageService;
    @Autowired
    private WechatUserInfoManager wechatUserInfoManager;

    @RequestMapping(value = "/login/{openid}")
    public String login(Model model,HttpServletResponse response,HttpServletRequest request,@PathVariable(value = "openid") String openid) {
	try {
	    //存cookie
	    String cookie_openid = storageService.get(request, "openid");
	    if (cookie_openid == null) {
		    storageService.set("openid", openid, response);
	    }
	    //查询用户是否存在
	    UserQuery queryObj = new UserQuery();
	    queryObj.setWechatOpenId(openid);
	    List<User> userList = null;
	    userList = userService.selectByParam(queryObj);
	    if (userList == null || userList.size() == 0) {
				model.addAttribute("isNewUser", "1");
				model.addAttribute("openid", openid);
				model.addAttribute("message", "您还不是系统用户,请提交资料进行审核：");
				return "register";
	    }
	    //存cookie
	    String roles = userList.get(0).getRoles();
	    String vertifyCode = Md5Utils.md5Hex(roles, "uyYI787%%…#8uYkj");
	    storageService.set("sysrole", vertifyCode, response);
	    // 获取用户信息
	    Map<String, Object> userInfo = new HashMap<String, Object>();
	    Map<String, Object> wechatUserInfo = wechatUserInfoManager.getWechatUserInfoByPageAccess(openid);
	    if (wechatUserInfo != null) {
		userInfo.put("nickname", wechatUserInfo.get("nickname"));
		userInfo.put("headimgurl", wechatUserInfo.get("headimgurl"));
	    }
	    //页面跳转
	    //userInfo = (Map<String, Object>) JsonUtil.json2Object(cookie_userInfo, Map.class);
	    model.addAttribute("nickname", userInfo.get("nickname"));
	    model.addAttribute("headimgurl", userInfo.get("headimgurl")); 
	    if (RoleEnum.ADMIN.getCode().equals(roles)) {// 管理员
		return "admin/index";
	    }
	    if (RoleEnum.STYLIST.getCode().equals(roles)) {// 发型师
	    	//存cookie
		    String hairdresserId = String.valueOf(userList.get(0).getHairdresserId());
		    //LOGGER.info("cookie_hairdresserid save:"+hairdresserId);
		    storageService.set("hairdresserid", hairdresserId, response);
		    HairdresserQuery queryHairObj =new HairdresserQuery();
		    queryHairObj.setPhoneNumber(userList.get(0).getPhoneNumber());
		    List<Hairdresser> hairdresserList= hairdresserService.selectByParam(queryHairObj);
		    if(hairdresserList==null || hairdresserList.size()<=0 ){
		    	model.addAttribute("isNewUser", "0");
				model.addAttribute("message", "用户信息查询失败。");
				return "register";
		    }
		    if(hairdresserList.get(0).getShopId()<=0){
		    	return "redirect:http://m.qiansishun.com/v1/stylist/hairdresser/edit/"+hairdresserList.get(0).getId();
		    }
		    return "stylist/index";
	    }
	    if(RoleEnum.PENDING.getCode().equals(roles)){// 待审核用户
		model.addAttribute("isNewUser", "0");
		model.addAttribute("message", "您的资料正在审核中。");
		return "register";
	    }
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}

	return "register";
    }
    
    @RequestMapping(value = "/authfail")
    public String authFail(Model model) {
    	model.addAttribute("message", "您没有权限访问该页面。");
    	return "message_page";
    }
    
    @RequestMapping(value = "/user/save", method = RequestMethod.POST)
    @ResponseBody
    public ResObj<String> save(HttpServletRequest request) {
	ResObj<String> resObj = new ResObj<String>();
	resObj.setCode(RetdCodeType.PASS_OK.getCode());
	resObj.getMessage().setMsg(RetdCodeType.PASS_OK.getMsg());
	try {
	    //短信验证码校验
	    String vertifyCode = request.getParameter("vertifyCode");
	    String identifyingCode = request.getParameter("identifyingCode");
	    if(!vertifyCode.equals(Md5Utils.md5Hex(identifyingCode, "uyYI787%%…#8uYkj"))){
		resObj.setCode(RetdCodeType.EX_APP.getCode());
		resObj.getMessage().setMsg("验证码无效");
		return resObj;
	    }
	    //获取openid
	    String openid = storageService.get(request, "openid");
	    if (openid == null) {
		resObj.setCode(RetdCodeType.EX_APP.getCode());
		resObj.getMessage().setMsg("提交失败");
		return resObj;
	    }
	    
	    // 保存发型师数据
	    int rlt=0;
	    Hairdresser hairdresser=new Hairdresser();
	    hairdresser.setName(request.getParameter("name"));
	    hairdresser.setPhoneNumber(request.getParameter("phoneNumber"));
	    HairdresserQuery queryHairObj =new HairdresserQuery();
	    queryHairObj.setPhoneNumber(request.getParameter("phoneNumber"));
	    rlt = hairdresserService.update(hairdresser,queryHairObj);
	    if (rlt <= 0) {
				hairdresser.setCardBackPhoto("");
				hairdresser.setCardFacePhoto("");
				hairdresser.setPhoto("");
				hairdresser.setRestday("");
				hairdresser.setShopId((long) 0);
				hairdresser.setShopName("");
				hairdresser.setStatus(HairdresserStatusEnum.PENDING.getCode());
				rlt = hairdresserService.save(hairdresser);
	    }
	    if (rlt <= 0) {
			resObj.setCode(RetdCodeType.EX_APP.getCode());
			resObj.getMessage().setMsg("提交失败");
		}
	    // 保存用户数据
	    User user=new User();
	    user.setWechatOpenId(openid);
	    user.setRoles(RoleEnum.PENDING.getCode());
	    user.setPhoneNumber(request.getParameter("phoneNumber"));
	    user.setPassword("");
	    if(hairdresser.getId() != null){
	    	user.setHairdresserId(hairdresser.getId());
	    }
	    UserQuery queryUserObj = new UserQuery();
	    queryUserObj.setWechatOpenId(openid);
	    rlt = userService.update(user,queryUserObj);
	    if (rlt <= 0) {
	    	rlt = userService.save(user);
		}
	    if (rlt <= 0) {
		   resObj.setCode(RetdCodeType.EX_APP.getCode());
		   resObj.getMessage().setMsg("提交失败");
	    }
	    
	} catch (Exception e) {
	    resObj.setCode(RetdCodeType.EX_APP.getCode());
	    resObj.getMessage().setMsg("提交失败");
	    LOGGER.error(e.getMessage());
	}

	return resObj;
    }
    
    @RequestMapping(value = "/user/sendvertifycode", method = RequestMethod.POST)
    @ResponseBody
    public ResObj<String> sendVertifyCode(HttpServletRequest request) {
	ResObj<String> resObj = new ResObj<String>();
	resObj.setCode(RetdCodeType.PASS_OK.getCode());
	resObj.getMessage().setMsg(RetdCodeType.PASS_OK.getMsg());
	try {
	    String code = messageService.sendRandomCode(request.getParameter("phoneNumber"));
	    String vertifyCode = Md5Utils.md5Hex(code, "uyYI787%%…#8uYkj");
	    resObj.getMessage().setMsg(vertifyCode);
	} catch (Exception e) {
	    resObj.setCode(RetdCodeType.EX_APP.getCode());
	    resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
	    LOGGER.error(e.getMessage());
	}
	return resObj;
    }
}
