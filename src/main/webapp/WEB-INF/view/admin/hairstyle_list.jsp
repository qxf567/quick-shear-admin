<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>

<title>发型列表</title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<div class="info_list">
		  <c:forEach items="${hairstyleList}" var="hairstyle">
			<a href="/admin/hairstyle/detail/${hairstyle.id}">
				<div class="info_one">
					<span></span> <img src="${hairstyle_img}/${hairstyle.mainImageUrl}" /> <span
						class="checked_title">${hairstyle.name} - ${hairstyle.price}</span>
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
			<a href="/admin/hairstyle/add" id="addnew">
				<div class="fixed_btn">新增发型</div>
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