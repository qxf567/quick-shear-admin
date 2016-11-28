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
		<div class="warp">
			<div class="input-list">
				<span>店铺名称</span>
				<input type="text" placeholder="请填写店铺名称" id="myName"
					value="${shop.name}">
			</div>
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