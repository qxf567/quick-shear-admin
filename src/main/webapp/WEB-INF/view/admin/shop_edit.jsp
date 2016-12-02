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
		<input id="id" value="${shop.id}" type="hidden" />
		<div class="input_list">
			<div class="input_one">
				<span>名称</span>
				<div class="input_info_main">
					<input type="text" placeholder="输入门店名称" id="name"
						value="${shop.name}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>电话</span>
				<div class="input_info_main">
					<input type="text" placeholder="输入联系电话" id="phoneNumber"
						value="${shop.phoneNumber}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>价格￥</span>
				<div class="input_info_main">
					<input type="text" placeholder="理发价格单位:元" id="price"
						value="${shop.price}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>营业时间</span>
				<div class="input_info_main">
					<input type="text" placeholder="时间格式:10:00-21:00"
						id="businessHours" value="${shop.businessHours}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>地址</span>
				<div class="input_info_main">
					<section>
						<select id="province" class="gray">
							<option value="-100">选择省份</option>
						</select> <select id="city" class="gray">
							<option value="-100">选择城市</option>
						</select> <select id="town" class="gray">
							<option value="-100">选择区县</option>
						</select>
					</section>
				</div>
			</div>
			<div class="input_one">
				<span></span>
				<div class="input_info_main">
					<input type="text" placeholder="输入详细地址" id="address"
						value="${shop.address}" readonly="readonly" /> <img
						src="${admin_img}/checked_icon.png" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one" style="height: 6.5rem;line-height: 6.2rem;">
				<span>图片</span>
				<div class="input_info_main" style="height: 6.0rem;">
					<form id="form-upload-img-main" method="post"
						enctype="multipart/form-data">
						<input id="input-upload-img-main" type="file"
							name="input-upload-img-main"
							accept="image/jpg, image/jpeg, image/png" /> <img
							src="${admin_img}/upload01.png" class="upload_img" />
					</form>
					<c:if test="${not empty  shop.mainImageUrl}">
						<img src="${shop_img}/${shop.mainImageUrl}" class="view_img" />
					</c:if>
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>状态</span>
				<div class="input_info_main">
					<section>
						<select id="province" class="gray">
							<option value="-100">正常营业</option>
						</select>
					</section>
				</div>
			</div>
		</div>
		<!--底部固定End-->
		<div class="fixed_menu">
			<div class="amount"></div>
			<a href="/admin/shop/save" id="save">
				<div class="fixed_btn">保存</div>
			</a>
		</div>
	</div>
	<script type="text/javascript"
		src="${admin_js}/jquery-ui-1.10.3.interactions.min.js"></script>
	<script type="text/javascript"
		src="${admin_js}/jQuery-File-Upload-8.2.1/jquery.iframe-transport.min.js"></script>
	<script type="text/javascript"
		src="${admin_js}/jQuery-File-Upload-8.2.1/jquery.fileupload.min.js"></script>
	<script type="text/javascript"
		src="${admin_js}/jQuery-File-Upload-8.2.1/jquery.fileupload-process.min.js"></script>
	<script type="text/javascript"
		src="${admin_js}/jQuery-File-Upload-8.2.1/jquery.fileupload-validate.min.js"></script>
	<script type="text/javascript">
		var upload_img_main_url = '<c:url value="/fileupload/single"/>';
		// 主图上传
		$('#input-upload-img-main').fileupload({
			dataType : 'json',
			type : "POST",
			url : upload_img_main_url,
			autoUpload : true,
			maxFileSize : 22020096, // Maximum File Size in Bytes - 10 MB
			minFileSize : 1000, // Minimum File Size in Bytes - 1 KB
			acceptFileTypes : /(\.|\/)(jpg|png|jpeg)$/i,
			limitConcurrentUploads : 50,
			limitMultiFileUploads : 50,
			forceIframeTransport : true,
			done : function(e, data) {
				if (data.result.success) {
					alert(data.result.message);

				} else {
					alert(data.result.message);
				}
			},
			fail : function(e, data) {
				pop_up_alert("warning", "上传失败，可能文件太大，请重试");
			}
		});
	</script>
</body>
</html>