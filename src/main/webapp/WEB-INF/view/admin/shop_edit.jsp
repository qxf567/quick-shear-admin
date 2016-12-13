<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.quickshear.common.enumeration.ShopStatusEnum"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ include file="../common/fileuploadlibs.jsp"%>
<c:set var="shopStatusEnum" value="<%=ShopStatusEnum.values()%>" />
<script type="text/javascript">
    //移动设备快速响应点击事件
    $(document).ready(function() {
	FastClick.attach(document.body);
    });
</script>
<title><c:if test="${addOrEdit eq 'add'}">新增店铺</c:if> <c:if test="${addOrEdit eq 'add'}">编辑店铺</c:if></title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<input id="id" value="${shop.id}" type="hidden" /> 
		<input id="mainImageUrl" value="${shop.mainImageUrl}" type="hidden" />
		<div class="input_list">
			<div class="input_one">
				<span>名称</span>
				<div class="input_info_main">
					<input type="text" placeholder="输入门店名称" id="name" value="${shop.name}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>电话</span>
				<div class="input_info_main">
					<input type="text" placeholder="输入联系电话" id="phoneNumber" value="${shop.phoneNumber}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>价格￥</span>
				<div class="input_info_main">
					<input type="text" placeholder="理发价格单位:元" id="price" value="${shop.price}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>营业时间</span>
				<div class="input_info_main">
					<input type="text" placeholder="时间格式:10:00-21:00" id="businessHours"
						value="${shop.businessHours}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>地址</span>
				<div class="input_info_main">
					<section>
						<select id="province" class="gray">
							<option value="-100">选择省份</option>
							<c:forEach items="${shop.provinces}" var="city">
								<option value="${city.id}">${city.name}</option>
							</c:forEach>
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
					<input type="text" placeholder="输入详细地址" id="address" value="${shop.address}"
						readonly="readonly" /> <img src="${admin_img}/checked_icon.png" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one" style="height: 6.5rem;line-height: 6.2rem;">
				<span>图片</span>
				<div class="input_info_main" style="height: 6.0rem;">
					<input id="input-upload-img-main" type="file" name="mf"
						accept="image/jpg, image/jpeg, image/png" /> 
					<img src="${admin_img}/upload01.png" class="upload_img" /> 
					<img id="mainImage" src="" class="view_img" style="display:none" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>状态</span>
				<div class="input_info_main">
					<section>
						<select id="shopStatus" class="gray">
							<c:if test="${empty shop.status}">
								<option value="-100">选择店铺状态</option>
							</c:if>
							<c:forEach items="${shopStatusEnum}" var="shopStatus">
								<option value="${shopStatus.code}"
									<c:if test="${shopStatus.code eq shop.status}"> selected="selected"</c:if>>${shopStatus.name}</option>
							</c:forEach>
						</select>
					</section>
				</div>
			</div>
		</div>
		<!--底部固定End-->
		<div class="fixed_menu">
			<div class="amount"></div>
			<a id="save">
				<div class="fixed_btn">保存</div>
			</a>
		</div>
	</div>

	<script type="text/javascript">
	var upload_img_main_url = '<c:url value="/fileupload/single"/>';
	var city_select_url = '<c:url value="/admin/shop/citys/"/>';
	var save_url = '<c:url value="/admin/shop/save"/>';

	$(document).ready(
		function() {
		    if (${not empty shop.mainImageUrl}) {
			$("#mainImage").attr("src",
				'${shop_img}/${shop.mainImageUrl}');
			$("#mainImage").attr("style", '');
		    } else {
			$("#mainImage").attr("src", '');
			$("#mainImage").attr("style", 'display:none');
		    }
		});
	// 主图上传
	$('#input-upload-img-main')
		.fileupload(
			{
			    dataType : 'json',
			    type : "POST",
			    url : upload_img_main_url,
			    formData : {
				folderName : 'shop.img'
			    },
			    autoUpload : true,
			    maxFileSize : 5400000, // Maximum File Size in Bytes - 5 MB
			    minFileSize : 1000, // Minimum File Size in Bytes - 1 KB
			    acceptFileTypes : /(\.|\/)(jpg|png|jpeg)$/i,
			    limitConcurrentUploads : 50,
			    limitMultiFileUploads : 50,
			    forceIframeTransport : true,
			    done : function(e, data) {
				if (data.result.success) {
				    $("#mainImage").attr(
					    'src',
					    '${shop_img}' + '/'
						    + data.result.filePath);
				    $("#mainImageUrl")
					    .val(data.result.filePath);
				    $("#mainImage").attr('style', '');

				} else {
				    pop_up_alert("warning", "上传失败");
				}
			    },
			    fail : function(e, data) {
				pop_up_alert("warning", "上传失败，可能文件太大，请重试");
			    }
	});

	//选择省份
	$('#province').change(
			function() {
			    var cityid = $("#province option:selected").val(); //获得选中的值
			    $.ajax({
					type : "post",
					dataType : "json",
					url : city_select_url + cityid,
					data : "",
					success : function(data) {
					    if (data != null && data.code == 200) {
						var citys = data.businessObj;
						if (citys != null && citys.length >= 0) {
						   //清空城市菜单
						   var citySel = document.getElementById("city");
						   citySel.options.length = 0;
						   citySel.add(new Option("选择城市","-100"));
						   //添加城市菜单
						   for (var i = 0; i < citys.length; i++) {
						       citySel.add(new Option(citys[i].name,citys[i].id)); 
						   }
						   //清空区县菜单
						   var townSel = document.getElementById("town");
						   townSel.options.length = 0;
						   townSel.add(new Option("选择区县","-100"));
						}
					    } else {
						   pop_up_alert("warning","获取城市信息失败");
					    }
					},
					error : function() {
					    pop_up_alert("warning","获取城市信息失败");
					}
			});
	});
	
	//选择城市
	$('#city').change(function() {
	    var cityid = $("#city option:selected").val(); //获得选中的值
	    $.ajax({
			type : "post",
			dataType : "json",
			url : city_select_url + cityid,
			data : "",
			success : function(data) {
			    if (data != null && data.code == 200) {
				var citys = data.businessObj;
				if (citys != null && citys.length >= 0) {
				   //清空区县菜单
				   var townSel = document.getElementById("town");
				   townSel.options.length = 0;
				   townSel.add(new Option("选择区县","-100"));
				   //添加区县菜单
				   for (var i = 0; i < citys.length; i++) {
				       townSel.add(new Option(citys[i].name,citys[i].id)); 
				   }
				}
			    } else {
				  pop_up_alert("warning","获取区县信息失败");
			    }
			},
			error : function() {
			    pop_up_alert("warning","获取区县信息失败");
			}
		});
	});
	
	//保存
	$('#save').click(function() {
	    var id = $("#id").val();
	    var name = $("#name").val();
	    var phoneNumber = $("#phoneNumber").val();
	    var price = $("#price").val();
	    var businessHours = $("#businessHours").val();
	    var cityId = $("#town option:selected").val();
	    var address = $("#address").val();
	    var mainImageUrl = $("#mainImageUrl").val();
	    var status = $("#shopStatus option:selected").val();
	    $.ajax({
			type : "post",
			dataType : "json",
			url : save_url,
			data : {'id':id,
			    	'name':name,
			    	'phoneNumber':phoneNumber,
			    	'price':price,
			    	'businessHours':businessHours,
			    	'cityId':cityId,
			    	'address':address,
			    	'mainImageUrl':mainImageUrl,
			    	'status':status},
			success : function(data) {
			    if (data != null && data.code == 200) {
				  pop_up_alert("warning","保存成功");
				  window.location.href='<c:url value="/admin/shop/list"/>';
			    } else {
				  pop_up_alert("warning","保存失败");
			    }
			},
			error : function() {
			    pop_up_alert("warning","保存失败");
			}
		});
	});
	
    </script>
</body>
</html>