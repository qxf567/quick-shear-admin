<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<title>发型师列表</title>
<script src="/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/fastclick.js"></script>
<script type="text/javascript">
	//移动设备快速响应点击事件
	$(document).ready(function() {
		FastClick.attach(document.body);
	});
</script>
<link type="text/css" rel="stylesheet" href="/css/common.css">
<link type="text/css" rel="stylesheet" href="/css/slides.css">
<link type="text/css" rel="stylesheet" href="/css/new_store_detail.css">
<script type="text/javascript" src="/js/slides.js"></script>
<script type="text/javascript" src="/js/zepto.min.js"></script>
<script type="text/javascript" src="/js/TouchSlide.1.1.js"></script>
<script type="text/javascript" src="/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="/js/btn_active.js"></script>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<c:forEach items="${hairdresserList}" var="hairdresser">
			<p>${hairdresser.shopName}</p>
			<p>${hairdresser.name}</p>
		</c:forEach>
	</div>
	<script type="text/javascript">
		
	</script>
</body>