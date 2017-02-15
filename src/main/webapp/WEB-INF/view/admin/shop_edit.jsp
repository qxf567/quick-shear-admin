<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.quickshear.common.enumeration.ShopStatusEnum"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
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
					<!-- <input id="input-upload-img-main" type="file" name="mf"
						accept="image/jpg, image/jpeg, image/png" />  -->
					<img src="${admin_img}/upload01.png" class="upload_img" onclick="wxChooseImage()"/> 
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
	var city_select_url = '<c:url value="/admin/shop/citys/"/>';
	var save_url = '<c:url value="/admin/shop/save"/>';
	//微信jsApi授权
	wx.config({
	    debug : true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	    appId : '${appid}', // 必填，公众号的唯一标识
	    timestamp : '${timestamp}', // 必填，生成签名的时间戳
	    nonceStr : '${nonceStr}', // 必填，生成签名的随机串
	    signature : '${sign}',// 必填，签名，见附录1
	    jsApiList : ['chooseImage', 'uploadImage', 'downloadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	});

	//拍照或从手机相册中选图接口  
	function wxChooseImage() {
	    wx.chooseImage({
		count : 1,
		needResult : 1,
		sizeType : [ 'original', 'compressed' ], // 可以指定是原图还是压缩图，默认二者都有  
		sourceType : [ 'album', 'camera' ], // 可以指定来源是相册还是相机，默认二者都有  
		success : function(data) {
		    localIds = data.localIds[0].toString(); // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片  
		    wxuploadImage(localIds);
		},
		fail : function(res) {
		    
		}
	    });
	}

	//上传图片接口  
	function wxuploadImage(e) {
	    wx.uploadImage({
		localId : e, // 需要上传的图片的本地ID，由chooseImage接口获得  
		isShowProgressTips : 1, // 默认为1，显示进度提示  
		success : function(res) {
		    mediaId = res.serverId; // 返回图片的服务器端ID  
		    $("#mainImage").attr( 'src',e);
			$("#mainImageUrl").val(mediaId);
			$("#mainImage").attr('style', '');

		},
		fail : function(error) {

		}
	    });
	}
	
	$(document).ready(
		function() {
		    if (${addOrEdit eq 'edit'}) {
			$("#mainImage").attr("src",
				'${shop_img}/${shop.mainImageUrl}');
			$("#mainImage").attr("style", '');
			//添加省份菜单
			var provinceSel = document.getElementById("province");
			var objData = ajaxCitys(0);
			var citys;
			if (objData != null && objData.code == 200) {
			    citys = objData.businessObj;
			    for (var i = 0; i < citys.length; i++) {
				provinceSel.add(new Option(citys[i].name,
					citys[i].id));
			    }
			} else {
			    pop_up_alert("warning", "获取城市列表失败");
			}
			//设置选中项
			$('#province')
				.attr('value', '${shop.selectProvinceId}');

			//添加城市菜单
			var citySel = document.getElementById("city");
			var objData = ajaxCitys(${shop.selectProvinceId});
			if (objData != null && objData.code == 200) {
			    citys = objData.businessObj;
			    for (var i = 0; i < citys.length; i++) {
				citySel.add(new Option(citys[i].name,
					citys[i].id));
			    }
			} else {
			    pop_up_alert("warning", "获取城市列表失败");
			}
			//设置选中项
			$('#city').attr('value', '${shop.selectCityId}');

			//添加区县菜单
			var townSel = document.getElementById("town");
			var objData = ajaxCitys(${shop.selectCityId});
			if (objData != null && objData.code == 200) {
			    citys = objData.businessObj;
			    for (var i = 0; i < citys.length; i++) {
				townSel.add(new Option(citys[i].name,
					citys[i].id));
			    }
			} else {
			    pop_up_alert("warning", "获取城市列表失败");
			}
			//设置选中项
			$('#town').attr('value', '${shop.selectTownId}');

		    } else {
			$("#mainImage").attr("src", '');
			$("#mainImage").attr("style", 'display:none');
			//添加省份菜单
			var provinceSel = document.getElementById("province");
			var objData = ajaxCitys(0);
			if (objData != null && objData.code == 200) {
			    var citys = objData.businessObj;
			    for (var i = 0; i < citys.length; i++) {
				provinceSel.add(new Option(citys[i].name,
					citys[i].id));
			    }
			} else {
			    pop_up_alert("warning", "获取城市列表失败");
			}
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
		citySel.add(new Option("选择城市", "-100"));
		//添加城市菜单
		citys = objData.businessObj;
		for (var i = 0; i < citys.length; i++) {
		    citySel.add(new Option(citys[i].name, citys[i].id));
		}
		//清空区县菜单
		var townSel = document.getElementById("town");
		townSel.options.length = 0;
		townSel.add(new Option("选择区县", "-100"));
	    } else {
		pop_up_alert("warning", "获取城市列表失败");
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
		townSel.add(new Option("选择区县", "-100"));
		//添加区县菜单
		citys = objData.businessObj;
		for (var i = 0; i < citys.length; i++) {
		    townSel.add(new Option(citys[i].name, citys[i].id));
		}
	    } else {
		pop_up_alert("warning", "获取城市列表失败");
	    }
	});

	function ajaxCitys(pid) {
	    var objData = null;
	    $.ajax({
		type : "post",
		dataType : "json",
		url : city_select_url + pid,
		data : "",
		async : false,
		success : function(data) {
		    objData = data;
		},
		error : function() {
		}
	    });
	    return objData;
	};

	//保存
	$('#save')
		.click(
			function() {
			    var id = $("#id").val();
			    var name = $("#name").val();
			    var phoneNumber = $("#phoneNumber").val();
			    var price = $("#price").val();
			    var businessHours = $("#businessHours").val();
			    var cityId = $("#town option:selected").val();
			    var address = $("#address").val();
			    var mainImageUrl = $("#mainImageUrl").val();
			    var status = $("#shopStatus option:selected").val();
			    $
				    .ajax({
					type : "post",
					dataType : "json",
					url : save_url,
					data : {
					    'id' : id,
					    'name' : name,
					    'phoneNumber' : phoneNumber,
					    'price' : price,
					    'businessHours' : businessHours,
					    'cityId' : cityId,
					    'address' : address,
					    'mainImageUrl' : mainImageUrl,
					    'status' : status
					},
					success : function(data) {
					    if (data != null
						    && data.code == 200) {
						pop_up_alert("warning", "保存成功");
						window.location.href = '<c:url value="/admin/shop/list"/>';
					    } else {
						pop_up_alert("warning", "保存失败");
					    }
					},
					error : function() {
					    pop_up_alert("warning", "保存失败");
					}
				    });
			});
    </script>
</body>
</html>