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
<input id="vertify_code" value="" type="hidden" /> 
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
var second_count = 60;  //倒数计时
var counting = 0;  //是否正在倒计时中
var timer;  //定时器
//点击获取验证码事件
function do_get_code( obj ){
    var phoneNumber   = $("#sign_up_mobile").val();
    if(phoneNumber == '')
    {
	    pop_up_alert("warning","请填写手机号码！");
        return false;
    }
    if(!(/^[1][34578][0-9]{9}$/.test(phoneNumber)))
    {
	    pop_up_alert("warning","请填写正确的手机号码！");
        return false;
    }

    var _this = obj;
    $.ajax({
        url         :   '<c:url value="/admin/user/sendvertifycode"/>',
        type        :   'post',
        dataType    :   'json',
        data        :   {"phoneNumber":phoneNumber},
        beforeSend  :   function()
        {
            _this.unbind("click");
            _this.html("获取中...");
            _this.css("color","gray");
        },
        success     :   function(data)
        {
            if(data != null && data.code == 200)
            {
                var i = second_count;
                //验证码60秒后重新获取
                timer = setInterval(function(){
                    counting = 1;
                    _this.val(i+'秒后重试');
                    i--;
                    if(i < 0)
                    {
                        _this
                            .val("获取验证码")
                            .css("color",'#1c436f');
                        $("#J_code_btn").unbind().bind("click",function(){do_get_code($("#J_code_btn"));})
                        counting = 0;
                        clearInterval(timer);
                    }
                },1000);
                $("#vertify_code").val(data.message.msg);
            }
            else
            {
                _this.val("获取验证码");
                _this.css("color","#1c436f");
                $("#J_code_btn").unbind().bind("click",function(){do_get_code($("#J_code_btn"));})
                alert(data.message.msg);
            }
        }
    });
}
//发送验证码
$("#sign_up_mobile")
    .keyup(function(){
        mobile_keyup_act();
    })
    .blur(function(){
        mobile_keyup_act();
    });

//电话号码keyup、blur事件
function mobile_keyup_act()
{
    var phoneNumber = $("#sign_up_mobile").val();

    //验证手机号码是否符合规范
    if((/^[1][34578][0-9]{9}$/.test(phoneNumber)))
    {
        $("#J_code_btn").css("color","#1c436f").unbind().bind("click",function(){do_get_code($("#J_code_btn"));})
    }
    else
    {
        if(counting == 0)
        {
            $("#J_code_btn").css("color","#999").unbind("click");
        }
    }
}

//保存
$('#save').click(function() {
    var phoneNumber = $("#sign_up_mobile").val();
    var vertifyCode = $("#vertify_code").val();
    var identifyingCode = $("#sign_up_identifying").val();
    if(phoneNumber == '')
    {
	    pop_up_alert("warning","请填写手机号码！");
        return false;
    }
    if(!(/^[1][34578][0-9]{9}$/.test(phoneNumber)))
    {
	    pop_up_alert("warning","请填写正确的手机号码！");
        return false;
    }
    if(identifyingCode == '')
    {
	    pop_up_alert("warning","请填写验证码！");
        return false;
    }
    $.ajax({
		type : "post",
		dataType : "json",
		url : save_url,
		data : {'phoneNumber':phoneNumber,'vertifyCode':vertifyCode,'identifyingCode':identifyingCode},
		success : function(data) {
		    if (data != null && data.code == 200) {
			    window.location.href='<c:url value="/admin/login/${openid}"/>';
		    } else {
			   pop_up_alert("warning",data.message.msg);
		    }
		},
		error : function() {
		    pop_up_alert("warning",data.message.msg);
		}
	});
});
</script>
</body>
</html>

