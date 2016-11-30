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
<title><c:if test="${addOrEdit eq 'add'}">新增店铺</c:if> <c:if
		test="${addOrEdit eq 'add'}">编辑店铺</c:if></title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<div class="input-list">
			<img src="${admin_img}/input-icon03.png" />
			<input type="text" placeholder="店铺名称" id="name" value="${shop.name}"/>
		</div>
		<div class="input-list">
			<img src="${admin_img}/input-icon05.png" /> <input
				type="text" placeholder="电话" id="phoneNumber" value="${shop.phoneNumber}"/>
		</div>
		<div class="input-list">
			<img src="${admin_img}/input-icon01.png" /> <input
				type="text" placeholder="营业时间" id="businessHours" value="${shop.businessHours}"/>
		</div>
		<div class="input-list">
			<img src="${admin_img}/input-icon02.png" />
			<section class="box">
			<select id="province" class="gray">
			<option value="-100">选择省份</option>
			</select>
			<select id="city" class="gray">
			<option value="-100">选择城市</option>
			</select>
			<select id="town" class="gray">
			<option value="-100">选择区县</option>
			</select>
			</section>
		</div>
		<div class="input-list">
			<img src="${admin_img}/input-icon03.png" /> <input
				type="text" placeholder="详细地址" id="address" value="${shop.address}"/>
		</div>
		<!--底部固定End-->
		<div class="fixed_menu">
			<div class="amount"></div>
			<a href="/admin/shop/save" id="save">
				<div class="fixed_btn">保存</div>
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