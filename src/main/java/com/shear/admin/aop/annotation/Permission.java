package com.shear.admin.aop.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.quickshear.common.enumeration.RoleEnum;

/**
 * 页面访问权限校验注解
 * @author Administrator
 *
 */
@Target(ElementType.TYPE)  
@Retention(RetentionPolicy.RUNTIME)  
public @interface Permission {  
    /** 访问角色校验枚举 */  
	RoleEnum[] roleTypes() default {};  
}  
