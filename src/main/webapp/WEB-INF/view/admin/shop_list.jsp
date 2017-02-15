<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/slides.css">
<title>店铺列表</title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<div class="store_list">
			<c:forEach items="${shopList}" var="shop">
				<div class="bj_store">
					<div class="${shop.labelCssName}">${shop.statusName}</div>
					<a class="" href="${shear_admin_url}/admin/shop/detail/${shop.id}"> <img
						src="${shop_img}/${shop.mainImageUrl}"
						class="store_list_img" />
					</a>
					<p class="store_name">${shop.name}</p>
					<p class="store_address">${shop.address}</p>
					<hr style="background: #f2f2f2;height: 1px;border: none">
				</div>
			</c:forEach>
		</div>
		<!--底部固定End-->
		<div style="height: 50px;"></div>
		<div class="fixed_menu">
			<div class="amount"></div>
			<a href="${shear_admin_url}/admin/shop/add" id="addnew">
				<div class="fixed_btn">新增店铺</div>
			</a>
		</div>
	</div>
	<script type="text/javascript">
	
	</script>
</body>
</html>