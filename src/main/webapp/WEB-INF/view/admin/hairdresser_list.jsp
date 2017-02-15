<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/slides.css">
<title>发型师列表</title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<div class="info_list">
		  <c:forEach items="${hairdresserList}" var="hairdresser">
			<a href="${shear_admin_url}/admin/hairdresser/detail/${hairdresser.id}">
				<div class="info_one">
					<span></span> <img src="${user_img}/${hairdresser.photo}" /> <span
						class="checked_title">${hairdresser.name} - ${hairdresser.shopName}</span>
					<div class="checked_info_main">
						<span></span> <img
							src="${admin_img}/checked_icon.png" />
					</div>
				</div>
			</a> 
		  </c:forEach>
		</div>
		<!--底部固定End-->
		<div class="fixed_menu">
			<div class="amount"></div>
			<a href="${shear_admin_url}/admin/hairdresser/add" id="addnew">
				<div class="fixed_btn">新增发型师</div>
			</a>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
</body>
</html>