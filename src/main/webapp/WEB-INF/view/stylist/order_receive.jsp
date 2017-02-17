<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<script type="text/javascript" src="${admin_js}/touchslider.js"></script>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<title>接单</title>
<style type="text/css">
.max_box {
	max-width: 640px;
	padding-top: 50%;
	font-family: "microsoft yahei", Arial, sans-serif
}

.info_box img {
	width: 30%;
	display: block;
	margin: 0 auto
}

.info_box {
	color: #999;
	font-size: 1rem;
	text-align: center;
}

.info_box p {
	line-height: 26px;
}

.store_text p {
	padding-right: 0.5rem;
}

p.product_name {
	color: #333;
	font-size: 1.1rem
}

p.product_name span {
	float: right;
}
</style>
</head>
<body>
	<div class="container">
		<div class="tab_switch">
			<div id="slider" class="swipe mt37"
				style="overflow: hidden; visibility: visible; list-style: none; position: relative;">
				 <c:if test="${empty order}">
							<div class="gap"></div>
							<div class="one_order hide_order_li">
								<div class="max_box">
									<div class="info_box">
										<img src="${admin_img}/no_has_order.jpg">
										<p>订单查询失败!</p>
									</div>
								</div>
							</div>
						</c:if>
						<c:if test="${not empty order}">
							<div class="gap"></div>
							<div class="one_order">
								<p class="store_name_id">${order.shopName}</p>
								<div class="order_info">
									<div class="store_img">
										<img src="${shop_img}/${order.shopMainImageUrl}">
									</div>
									<div class="store_text">
										<p>服务号：${order.serviceCode}</p>
										<p>订单号：${order.orderId}</p>
										<p>预约时间：${order.appointmentTime}</p>
									</div>
								</div>
								<div class="total_main">
									<span class="total_price">合计</span> <span class="sum">${order.actualPrice}元</span>
								</div>
								<div class="btn_block">
									<a href=""><div class="tips_btn" style="background: #1c436f;">确认服务完成</div></a>
								</div>
							</div>
						</c:if>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
</html>