<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<%@ include file="common/meta.jsp"%>
<%@ include file="common/taglibs.jsp"%>
<link type="text/css" rel="stylesheet" href="${admin_css}/personal_set.css">
<style>
        .sign_up{width: 100%;margin-bottom: 1rem}
        form.sign_up_main{width: 80%;margin: 0 auto}
        .sign_up_main .field_set {position: relative;margin: 1.5rem auto 1rem;}
        p.field_set{border-bottom: 1px solid #1c436f;margin: 1.5rem auto;}
        .field_set input{padding: 0 5px;border: none;background: rgba(255,255,255,0);width: 100%;line-height: 3rem;outline:none;font-size: 1.1rem;font-family: "microsoft yahei", Arial, sans-serif}
        input.identifying{width: 70%;position: relative}
        input.btn-xs {width: 40%;margin-top:10px;padding: 0 10px;height:30px;line-height: normal;cursor: pointer;border-left: 1px solid #1c436f;border-radius: 0;color: #1c436f;font-size: 1.1rem;}
        input.btn-xs:hover{color: #f2dede}
        .voice span{color: #1c436f}
        .field_set input{font-size: 0.8rem;}
</style>

<title>系统用户登录</title>
</head>

<body>
<div class="container">
<div class="one_question" id="first" style="display: block;">
        <div class="title_box">
            <span>${message}</span>
        </div>
        <div class="option_box">
        <c:if test="${isNewUser eq '1'}">
            <div class="sign_up"> <!-- 注册表单 -->
                <form class="sign_up_main">
                    <p class="field_set">
                        <input id="sign_up_mobile" name="f_mobile" placeholder="请输入您的手机号" type="tel">
                    </p>
                    <p class="field_set">
                        <input class="identifying" id="sign_up_identifying" name="f_code" autocomplete="off" placeholder="请输入验证码" type="text">
                        <input id="J_code_btn" class="btn-xs" value="获取验证码" style="color: rgb(153, 153, 153);" type="button">
                    </p>
<!--                    <p class="field_set">-->
<!--                        <input class="" name="f_pw" type="password" placeholder="请设置登录密码(6～16位字母、数字或字符)" id="password">-->
<!--                    </p>-->
<!--                    <div class="voice"><span style="color: #999;">· 请为您的账号设置密码，以保证下次正常登陆</span></div>-->

                </form>
            </div>
        </div>
        <div class="next_box"><a id="save">提交</a></div>
      </c:if>
    </div>
</div>

<script type="text/javascript">
var save_url = '<c:url value="/admin/user/save"/>';
//保存
$('#save').click(function() {
    var phoneNumber = $("#sign_up_mobile").val();
    $.ajax({
		type : "post",
		dataType : "json",
		url : save_url,
		data : {'phoneNumber':phoneNumber},
		success : function(data) {
		    window.location.href='<c:url value="/admin/login/${openid}"/>';
		},
		error : function() {
		    window.location.href='<c:url value="/admin/login/${openid}"/>';
		}
	});
});
</script>
</body>
</html>

