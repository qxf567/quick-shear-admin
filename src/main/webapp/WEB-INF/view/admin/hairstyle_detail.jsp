<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/slides.css">
<title>发型详情</title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<input id="id" value="${hairstyle.id}" type="hidden" />
		<div class="input_list">
			<div class="input_one">
				<span>发型名称</span>
				<div class="input_info_main">
					<input type="text" id="name"
						value="${hairstyle.name}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>性别</span>
				<div class="input_info_main">
					<input type="radio" name="sex" value="0" checked="checked" disabled="disabled"/>男士
					<input type="radio" name="sex" value="1" disabled="disabled"/>女士
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<%-- <div class="input_one">
				<span>价格￥</span>
				<div class="input_info_main">
					<input type="text" id="price"
						value="${hairstyle.price}" readonly="readonly"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div> --%>
			<div class="input_one" style="height: 6.5rem;line-height: 6.2rem;">
				<span>图片</span>
				<div class="input_info_main" style="height: 6.0rem;">
				<img src="${hairstyle_img}/${hairstyle.mainImageUrl}" class="view_img"/>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>详情</span>
				<div class="input_info_main">
					<input type="text" id="detail"
						value="${hairstyle.detail}" readonly="readonly" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>状态</span>
				<div class="input_info_main">
				<input type="text" id="statusName"
						value="${hairstyle.statusName}" readonly="readonly" />
				</div>
			</div>
		</div>
		<!--底部固定End-->
		<div class="fixed_menu">
			<div class="amount"></div>
			<a href="${shear_admin_url}/admin/hairstyle/edit/${hairstyle.id}" id="edit">
				<div class="fixed_btn">编辑</div>
			</a>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function() {
		if(${hairstyle.sex eq '0'}){
			$("input[name='sex']").eq(0).attr("checked","checked");
			$("input[name='sex']").eq(1).removeAttr("checked");
		}else{
			$("input[name='sex']").eq(0).removeAttr("checked");
			$("input[name='sex']").eq(1).attr("checked","checked");
		}
	});
	</script>
</body>
</html>