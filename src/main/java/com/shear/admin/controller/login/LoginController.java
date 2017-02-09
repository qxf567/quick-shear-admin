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

import com.quickshear.common.util.JsonUtil;
import com.quickshear.common.util.RetdCodeType;
import com.quickshear.common.vo.ResObj;
import com.quickshear.common.wechat.WechatUserInfoManager;
import com.quickshear.domain.User;
import com.quickshear.domain.query.UserQuery;
import com.quickshear.service.UserService;
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
	    // 获取用户信息
	    if (storageService.get(request, "userInfo") == null) {
		Map<String, Object> wechatUserInfo = wechatUserInfoManager
			.getWechatUserInfoByPageAccess(openid);
		Map<String, Object> userInfo = new HashMap<String, Object>();
		if (wechatUserInfo != null) {
		    userInfo.put("nickname", wechatUserInfo.get("nickname"));
		    userInfo.put("headimgurl", wechatUserInfo.get("headimgurl"));
		}
		// 存cookie
		storageService.set("userInfo", JsonUtil.toJson(userInfo),
			response);
	    }
	    //页面跳转
	    String roles = userList.get(0).getRoles();
	    if ("1".equals(roles)) {// 管理员
		return "admin/index";
	    }
	    if ("2".equals(roles)) {// 发型师
		return "stylist/index";
	    }
	    if("300".equals(roles)){// 待审核用户
		model.addAttribute("isNewUser", "0");
		model.addAttribute("message", "您的资料正在审核中。");
		return "register";
	    }
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}

	return "register";
    }
    
    @RequestMapping(value = "/user/save", method = RequestMethod.POST)
    public ResObj<String> save(HttpServletRequest request) {
	ResObj<String> resObj = new ResObj<String>();
	resObj.setCode(RetdCodeType.PASS_OK.getCode());
	resObj.getMessage().setMsg(RetdCodeType.PASS_OK.getMsg());
	try {
	    String openid = storageService.get(request, "openid");
	    if (openid == null) {
		resObj.setCode(RetdCodeType.EX_APP.getCode());
		resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
		return resObj;
	    }
	    User user=new User();
	    user.setWechatOpenId(openid);
	    user.setRoles("300");
	    user.setPhoneNumber(request.getParameter("phoneNumber"));
	    user.setPassword("");
	    // 保存操作
	    int rlt = userService.save(user);
	    if (rlt <= 0) {
		resObj.setCode(RetdCodeType.EX_APP.getCode());
		resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
	    }
	} catch (Exception e) {
	    resObj.setCode(RetdCodeType.EX_APP.getCode());
	    resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
	    LOGGER.error(e.getMessage());
	}

	return resObj;
    }
}
