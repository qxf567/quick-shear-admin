<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.quickshear.common.enumeration.ShopStatusEnum"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<%@ include file="../common/fileuploadlibs.jsp"%>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/slides.css">
<c:set var="shopStatusEnum" value="<%=ShopStatusEnum.values()%>" />

<title><c:if test="${addOrEdit eq 'add'}">新增店铺</c:if> <c:if test="${addOrEdit eq 'edit'}">编辑店铺</c:if></title>
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
						</select> 
						<select id="city" class="gray">
							<option value="-100">选择城市</option>
						</select> 
						<select id="town" class="gray">
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

	$(document).ready(function() {
		    if (${addOrEdit eq 'edit'}) {
			   $("#mainImage").attr("src",'${shop_img}/${shop.mainImageUrl}');
			   $("#mainImage").attr("style", '');
			   //添加省份菜单
			   var provinceSel = document.getElementById("province");
			   var objData = ajaxCitys(0);
			   var citys;
			   if (objData != null && objData.code == 200) {
			       citys=objData.businessObj;
			       for (var i = 0; i < citys.length; i++) {
				       provinceSel.add(new Option(citys[i].name,citys[i].id)); 
				   }
			    } else {
				  pop_up_alert("warning","获取城市列表失败");
			    } 
			   //设置选中项
			   $('#province').attr('value','${shop.selectProvinceId}');
			   
			   //添加城市菜单
			   var citySel = document.getElementById("city");
			   var objData = ajaxCitys(${shop.selectProvinceId});
			   if (objData != null && objData.code == 200) {
			       citys=objData.businessObj;
			       for (var i = 0; i < citys.length; i++) {
				   citySel.add(new Option(citys[i].name,citys[i].id)); 
				   }
			    } else {
				  pop_up_alert("warning","获取城市列表失败");
			    } 
			   //设置选中项
			   $('#city').attr('value','${shop.selectCityId}');
			   
			   //添加区县菜单
			   var townSel = document.getElementById("town");
			   var objData = ajaxCitys(${shop.selectCityId});
			   if (objData != null && objData.code == 200) {
			       citys=objData.businessObj;
			       for (var i = 0; i < citys.length; i++) {
				   townSel.add(new Option(citys[i].name,citys[i].id)); 
				   }
			    } else {
				  pop_up_alert("warning","获取城市列表失败");
			    } 
			   //设置选中项
			   $('#town').attr('value','${shop.selectTownId}');
			   
		    } else {
			   $("#mainImage").attr("src", '');
			   $("#mainImage").attr("style", 'display:none');
			   //添加省份菜单
			   var provinceSel = document.getElementById("province");
			   var objData = ajaxCitys(0);
			   if (objData != null && objData.code == 200) {
			       var citys=objData.businessObj;
			       for (var i = 0; i < citys.length; i++) {
				       provinceSel.add(new Option(citys[i].name,citys[i].id)); 
				   }
			    } else {
				  pop_up_alert("warning","获取城市列表失败");
			    } 
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
	$('#province').change(function() {
	    var citys;
	    var cityid = $("#province option:selected").val(); //获得选中的值
	    var objData = ajaxCitys(cityid);
		if (objData != null && objData.code == 200) {
			   //清空城市菜单
			   var citySel = document.getElementById("city");
			   citySel.options.length = 0;
			   citySel.add(new Option("选择城市","-100"));
			   //添加城市菜单
			   citys=objData.businessObj;
			   for (var i = 0; i < citys.length; i++) {
			       citySel.add(new Option(citys[i].name,citys[i].id)); 
			   }
			   //清空区县菜单
			   var townSel = document.getElementById("town");
			   townSel.options.length = 0;
			   townSel.add(new Option("选择区县","-100"));
		} else {
			  pop_up_alert("warning","获取城市列表失败");
	    } 
	});
	
	//选择城市
	$('#city').change(function() {
	    var citys;
	    var cityid = $("#city option:selected").val(); //获得选中的值
	    var objData = ajaxCitys(cityid);
		if (objData != null && objData.code == 200) {
		   //清空区县菜单
		   var townSel = document.getElementById("town");
		   townSel.options.length = 0;
		   townSel.add(new Option("选择区县","-100"));
		   //添加区县菜单
		   citys=objData.businessObj;
		   for (var i = 0; i < citys.length; i++) {
		       townSel.add(new Option(citys[i].name,citys[i].id)); 
		   }
		} else {
			  pop_up_alert("warning","获取城市列表失败");
		} 
	});
	
	function ajaxCitys(pid){
	    var objData=null;
	    $.ajax({
		type : "post",
		dataType : "json",
		url : city_select_url + pid,
		data : "",
		async: false, 
		success : function(data) {
		    objData = data;
		},
		error : function() {
		}
	 });
	    return objData;
   };
	
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