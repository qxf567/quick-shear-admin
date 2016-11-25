<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<script type="text/javascript">
	//移动设备快速响应点击事件
	$(document).ready(function() {
		FastClick.attach(document.body);
	});
</script>
<title>店铺列表</title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<div class="info_list">
			<c:if test="${empty shopList}">
				<div class="max_box">
					<div class="info_box">
						<img
							src="${admin_common_img}/my-icon08.png">
						<p>未找到店铺～</p>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty shopList}">
				<div class="total_main">
					<c:forEach items="${shopList}" var="shop">
						<a class="" href="/admin/shop/detail?id=${shop.id}"> <img
							src="/img/index/yingyezhong.png" class="status"> <img
							src="/img/index/dianpu.png" class="shop-img" />
							<div class="checked_info_main">
								<span></span> <img
									src="${admin_common_img}/checked_icon.png" />
							</div>
						</a>

						<p class="shop-title">${shop.name}</p>
						<p class="shop-text">营业时间：${shop.businessHours}</p>
						<p class="shop-text">地址：${shop.address}</p>
						<hr style="background: #f2f2f2;height: 1px;border: none">
					</c:forEach>
				</div>
			</c:if>
		</div>
		<!--底部固定End-->
		<div class="fixed_menu">
			<div class="amount"></div>
			<a href="javascript:;" id="addnew">
				<div class="payment_btn">新增店铺</div>
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