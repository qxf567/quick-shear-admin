<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<link type="text/css" rel="stylesheet" href="${admin_css}/user_center.css">

<title>后台管理</title>
</head>
<body>
	<div class="container">
		<div class="head" align="center"
			style="background-image:url(${admin_img}/user_bg.jpg);">
			<img src="${headimgurl}" style="" />
			<div class="name">${nickname}</div>
		</div>
		<div class="gap"></div>
		<div class="info_list">
			<a href="${shear_admin_url}/admin/shop/list">
				<div class="info_one">
					<span></span> <img src="${admin_img}/order_icon.png" /> <span
						class="checked_title">店铺管理</span>
					<div class="checked_info_main">
						<span></span> <img
							src="${admin_img}/checked_icon.png" />
					</div>
				</div>
			</a> <a href="${shear_admin_url}/admin/order/list">
				<div class="info_one">
					<hr style="background: #f2f2f2;height: 1px;border: none">
					<span></span> <img
						src="${admin_img}/order_icon.png" />
					<span class="checked_title">订单管理</span>
					<div class="checked_info_main">
						<span></span> <img
							src="${admin_img}/checked_icon.png" />
					</div>
				</div>
			</a> <a href="${shear_admin_url}/admin/hairdresser/list">
				<div class="info_one">
					<hr style="background: #f2f2f2;height: 1px;border: none">
					<span></span> <img
						src="${admin_img}/order_icon.png" />
					<span class="checked_title">发型师管理</span>
					<div class="checked_info_main">
						<span></span> <img
							src="${admin_img}/checked_icon.png" />
					</div>
				</div>
			</a> <a href="${shear_admin_url}/admin/hairstyle/list">
				<div class="info_one">
					<hr style="background: #f2f2f2;height: 1px;border: none">
					<span></span> <img
						src="${admin_img}/order_icon.png" />
					<span class="checked_title">发型管理</span>
					<div class="checked_info_main">
						<span></span> <img
							src="${admin_img}/checked_icon.png" />
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