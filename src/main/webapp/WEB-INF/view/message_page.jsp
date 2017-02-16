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

<title>页面访问提示</title>
</head>

<body>
<div class="container">
  <div class="one_question" id="first" style="display: block;">
        <div class="title_box">
            <span>${message}</span>
        </div>
   </div>
</div>

<script type="text/javascript">

</script>
</body>
</html>

