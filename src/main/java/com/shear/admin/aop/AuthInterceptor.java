package com.shear.admin.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.quickshear.common.enumeration.RoleEnum;
import com.quickshear.common.util.Md5Utils;
import com.quickshear.service.sms.StorageService;
import com.shear.admin.aop.annotation.Permission;

/**
 * 页面访问权限拦截器
 * @author Administrator
 *
 */
public class AuthInterceptor extends HandlerInterceptorAdapter{
	@Autowired
    private StorageService storageService;
	@Override  
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		if (HandlerMethod.class.equals(handler.getClass())) {
			Class<?> clazz = ((HandlerMethod) handler).getBeanType();
			if (clazz.isAnnotationPresent(Permission.class)) {  
	        	//取cookie中role
				String cookie_sysrole = storageService.get(request, "sysrole");
				if (cookie_sysrole != null) {
					// 角色页面访问权限校验
					Permission permission = (Permission) clazz
							.getAnnotation(Permission.class);
					RoleEnum[] roles = permission.roleTypes();
					for (RoleEnum role : roles) {
						if (cookie_sysrole.equals(Md5Utils.md5Hex(
								String.valueOf(role.getCode()),
								"uyYI787%%…#8uYkj"))) {
							return true;
						}
					}
				}
	        	response.sendRedirect("/admin/authfail"); 
	        	return false; 
	        }  
		}
		return true;  
	}
}
