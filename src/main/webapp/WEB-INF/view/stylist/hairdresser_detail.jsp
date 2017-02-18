<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/slides.css">
<title>详情</title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<input id="id" value="${hairdresser.id}" type="hidden" />
		<div class="input_list">
			<div class="input_one">
				<span>姓名</span>
				<div class="input_info_main">
					<input type="text" id="name"
						value="${hairdresser.name}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>电话</span>
				<div class="input_info_main">
					<input type="text" id="phoneNumber"
						value="${hairdresser.phoneNumber}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>店铺</span>
				<div class="input_info_main">
					<input type="text" id="shopName"
						value="${hairdresser.shopName}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one" style="height: 6.5rem;line-height: 6.2rem;">
				<span>照片</span>
				<div class="input_info_main" style="height: 6.0rem;">
				<img src="${user_img}/${hairdresser.photo}" class="view_img"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
		</div>
		<!--底部固定End-->
		<div class="fixed_menu">
			<div class="amount"></div>
			<a href="${shear_admin_url}/stylist/hairdresser/edit/${hairdresser.id}" id="edit">
				<div class="fixed_btn">编辑</div>
			</a>
		</div>
	</div>
	<script type="text/javascript">

	</script>
</body>
</html>