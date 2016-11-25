<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<title>店铺列表</title>
<script type="text/javascript"
	src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.js/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.js/common.js"></script>
<script type="text/javascript"
	src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.js/fastclick.js"></script>
<script type="text/javascript">
	//移动设备快速响应点击事件
	$(document).ready(function() {
		FastClick.attach(document.body);
	});
</script>
<link type="text/css" rel="stylesheet"
	href="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.css/common.css">
<link type="text/css" rel="stylesheet"
	href="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.css/user_center.css">
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<div class="info_list">
			<c:if test="${empty shopList}">
				<div class="max_box">
					<div class="info_box">
						<img
							src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.img/my-icon08.png">
						<p>未找到店铺～</p>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty shopList}">
				<div class="total_main">
					<c:forEach items="${shopList}" var="shop">
						<a class="" href="/shear/detail/11"> <img
							src="/img/index/yingyezhong.png" class="status"> <img
							src="/img/index/dianpu.png" class="shop-img" />
							<div class="checked_info_main">
								<span></span> <img
									src="http://qiansishun.oss-cn-beijing.aliyuncs.com/admin.img/checked_icon.png" />
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