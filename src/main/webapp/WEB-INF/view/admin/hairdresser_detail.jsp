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
<title>发型师详情</title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<input id="id" value="${shop.id}" type="hidden" />
		<div class="input_list">
			<div class="input_one">
				<span>名称</span>
				<div class="input_info_main">
					<input type="text" id="name"
						value="${shop.name}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>电话</span>
				<div class="input_info_main">
					<input type="text" id="phoneNumber"
						value="${shop.phoneNumber}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>价格￥</span>
				<div class="input_info_main">
					<input type="text" id="price"
						value="${shop.price}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>营业时间</span>
				<div class="input_info_main">
					<input type="text" id="businessHours"
						value="${shop.businessHours}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>地址</span>
				<div class="input_info_main">
					<input type="text" id="fullPathName"
						value="${shop.fullPathName}" readonly="readonly"/>
				</div>
			</div>
			<div class="input_one">
				<span></span>
				<div class="input_info_main">
					<input type="text" id="address"
						value="${shop.address}" readonly="readonly" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one" style="height: 6.5rem;line-height: 6.2rem;">
				<span>图片</span>
				<div class="input_info_main" style="height: 6.0rem;">
				<img src="${shop_img}/${shop.mainImageUrl}" class="view_img"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>状态</span>
				<div class="input_info_main">
				<input type="text" id="statusName"
						value="${shop.statusName}" readonly="readonly" />
				</div>
			</div>
		</div>
		<!--底部固定End-->
		<div class="fixed_menu">
			<div class="amount"></div>
			<a href="/admin/shop/edit/${shop.id}" id="edit">
				<div class="fixed_btn">编辑</div>
			</a>
		</div>
	</div>
	<script type="text/javascript">

	</script>
</body>
</html>