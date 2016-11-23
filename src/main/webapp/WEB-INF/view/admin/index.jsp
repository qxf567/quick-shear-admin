<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<title>后台管理</title>
<script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/fastclick.js"></script>
<script type="text/javascript">
	//移动设备快速响应点击事件
	$(document).ready(function() {
		FastClick.attach(document.body);
	});
</script>
<link type="text/css" rel="stylesheet" href="/css/common.css">
<link type="text/css" rel="stylesheet" href="/css/user_center.css">
</head>
<body>
	<div class="container">
		<div class="head" align="center"></div>
		<div class="gap"></div>
		<div class="info_list">
			<a href="javascript:;">
				<div class="info_one">
					<span></span> <img src="/js/detail/appointment_icon.png" /> <span
						class="checked_title">店铺管理</span>
					<div class="checked_info_main">
						<span></span> <img src="/js/detail/checked_icon.png" />
					</div>
				</div>
			</a> <a href="javascript:;">
				<div class="info_one">
					<span></span> <img src="/js/detail/appointment_icon.png" /> <span
						class="checked_title">发型管理</span>
					<div class="checked_info_main">
						<span></span> <img src="/js/detail/checked_icon.png" />
					</div>
				</div>
			</a> <a href="javascript:;">
				<div class="info_one">
					<span></span> <img src="/js/detail/appointment_icon.png" /> <span
						class="checked_title">订单管理</span>
					<div class="checked_info_main">
						<span></span> <img src="/js/detail/checked_icon.png" />
					</div>
				</div>
			</a> <a href="javascript:;">
				<div class="info_one">
					<span></span> <img src="/js/detail/appointment_icon.png" /> <span
						class="checked_title">发型师管理</span>
					<div class="checked_info_main">
						<span></span> <img src="/js/detail/checked_icon.png" />
					</div>
				</div>
			</a>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".info_one,.list_default").mouseover(function() {
				$(".info_one,.list_default").removeClass("info_one_active");//移除所有.handle的active类
				$(this).addClass("info_one_active");//再将滑倒的这个添加上active类
			});

			$(".info_one,.list_default").mouseout(function() {
				$(this).removeClass("info_one_active");
			});

		});
	</script>
</body>
</html>