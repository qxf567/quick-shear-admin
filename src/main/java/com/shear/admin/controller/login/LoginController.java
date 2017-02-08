package com.shear.admin.controller.login;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quickshear.common.util.RetdCodeType;
import com.quickshear.common.vo.ResObj;
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

    @RequestMapping(value = "/login")
    public String login(Model model, HttpServletRequest request) {
	String openid = storageService.get(request, "openid");
	UserQuery queryObj = new UserQuery();
	queryObj.setWechatOpenId(openid);
	List<User> userList = null;
	try {
	    userList = userService.selectByParam(queryObj);
	    if (userList == null || userList.size() == 0) {
		model.addAttribute("isNewUser", "1");
		model.addAttribute("message", "您还不是系统用户,请提交资料进行审核："+openid);
		return "register";
	    }
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
    @ResponseBody
    public ResObj<String> save(HttpServletRequest request) {
	ResObj<String> resObj = new ResObj<String>();
	resObj.setCode(RetdCodeType.PASS_OK.getCode());
	resObj.getMessage().setMsg(RetdCodeType.PASS_OK.getMsg());
	try {
	    String openid = storageService.get(request, "openid");
	    User user=new User();
	    user.setWechatOpenId(openid);
	    user.setRoles("300");
	    user.setPhoneNumber(request.getParameter("phoneNumber"));
	    user.setPassword("");
	    // 保存操作
	    int rlt = 0;
	    rlt = userService.save(user);
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
