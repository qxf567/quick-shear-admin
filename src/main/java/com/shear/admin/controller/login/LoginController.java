package com.shear.admin.controller.login;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.quickshear.domain.User;
import com.quickshear.domain.query.UserQuery;
import com.quickshear.service.UserService;
import com.shear.admin.controller.base.AbstractController;

@Controller
@RequestMapping("/admin")
public class LoginController extends AbstractController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(LoginController.class);

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/login/{openid}")
	public String login(Model model,
			@PathVariable(value = "openid") String openid) {

		UserQuery queryObj = new UserQuery();
		queryObj.setWechatOpenId(openid);
		List<User> userList = null;
		try {
			userList = userService.selectByParam(queryObj);
			if (userList == null || userList.size() == 0) {
				model.addAttribute("message", "您还不是系统注册用户");
				return "register";
			}
			String roles = userList.get(0).getRoles();
			if (roles == "1") {//管理员
				return "admin/index";
			}
			if (roles == "2") {//发型师
				return "stylist/index";
			}
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}

		return "register";
	}
}
