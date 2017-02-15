<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/slides.css">

<title>发型列表</title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<div class="info_list">
		  <c:forEach items="${hairstyleList}" var="hairstyle">
			<a href="${shear_admin_url}/admin/hairstyle/detail/${hairstyle.id}">
				<div class="info_one" style="height: 6.5rem;line-height: 6.2rem;">
					<span></span> <img src="${hairstyle_img}/${hairstyle.mainImageUrl}" style="height: 5.5rem;width:5rem;"/> <span
						class="checked_title">${hairstyle.name}</span>
					<div class="checked_info_main">
						<span></span> <img
							src="${admin_img}/checked_icon.png" />
					</div>
				</div>
			</a> 
		  </c:forEach>
		</div>
		<!--底部固定End-->
		<div style="height: 50px;"></div>
		<div class="fixed_menu">
			<div class="amount"></div>
			<a href="${shear_admin_url}/admin/hairstyle/add" id="addnew">
				<div class="fixed_btn">新增发型</div>
			</a>
		</div>
	</div>
	<script type="text/javascript">

	</script>
</body>
</html>