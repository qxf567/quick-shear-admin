<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>

<title>发型师详情</title>
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
						value="${shop.phoneNumber}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>店铺</span>
				<div class="input_info_main">
					<input type="text" id="price"
						value="${hairdresser.shopName}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one" style="height: 6.5rem;line-height: 6.2rem;">
				<span>照片</span>
				<div class="input_info_main" style="height: 6.0rem;">
				<img src="${user_img}/${hairdresser.poto}" class="view_img"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>休息日</span>
				<div class="input_info_main">
					<input type="text" id="address"
						value="${hairdresser.restday}" readonly="readonly" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>状态</span>
				<div class="input_info_main">
				<input type="text" id="statusName"
						value="${hairdresser.statusName}" readonly="readonly" />
				</div>
			</div>
		</div>
		<!--底部固定End-->
		<div class="fixed_menu">
			<div class="amount"></div>
			<a href="/admin/shop/edit/${hairdresser.id}" id="edit">
				<div class="fixed_btn">编辑</div>
			</a>
		</div>
	</div>
	<script type="text/javascript">

	</script>
</body>
</html>