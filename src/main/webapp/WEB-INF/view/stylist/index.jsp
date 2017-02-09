<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<link type="text/css" rel="stylesheet" href="${admin_css}/user_center.css">
<title>员工自助</title>
<script type="text/javascript" src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.js/common.js"></script>
<script type="text/javascript" src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.js/fastclick.js"></script>
<script type="text/javascript">
	//移动设备快速响应点击事件
	$(document).ready(function() {
		FastClick.attach(document.body);
	});
</script>
<link type="text/css" rel="stylesheet" href="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.css/common.css">
<link type="text/css" rel="stylesheet" href="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.css/user_center.css">
</head>
<body>
	<div class="container">
		<div class="head" align="center">
			<img
				src="http://wx.qlogo.cn/mmopen/PiajxSqBRaEKJMd8lLra88qsIJIdYcWdSKwx4t6foBuwRr4ef58gTC0BxnKDlGjaoABKWfc4WiaNQGhl09RIicpeQ/0"
				style="" />
			<div class="name">Den</div>
		</div>
		<div class="gap"></div>
		<div class="info_list">
			<a href="javascript:;">
				<div class="info_one">
					<span></span> <img src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.img/order_icon.png" /> <span
						class="checked_title">我的订单</span>
					<div class="checked_info_main">
						<span></span> <img src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.img/checked_icon.png" />
					</div>
				</div>
			</a> <a href="javascript:;">
				<div class="info_one">
				<hr style="background: #f2f2f2;height: 1px;border: none">
					<span></span> <img src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.img/appointment_icon.png" /> <span
						class="checked_title">我的休息日</span>
					<div class="checked_info_main">
						<span></span> <img src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.img/checked_icon.png" />
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