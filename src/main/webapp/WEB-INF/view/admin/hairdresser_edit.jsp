<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.quickshear.common.enumeration.HairdresserStatusEnum"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/slides.css">
<c:set var="hairdresserStatusEnum" value="<%=HairdresserStatusEnum.values()%>" />

<title><c:if test="${addOrEdit eq 'add'}">新增发型师</c:if> <c:if test="${addOrEdit eq 'edit'}">编辑发型师</c:if></title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<input id="id" value="${hairdresser.id}" type="hidden" /> 
		<input id="photo" value="${hairdresser.photo}" type="hidden" />
		<input id="originalPhoto" value="${hairdresser.photo}" type="hidden" />
		<div class="input_list">
			<div class="input_one">
				<span>姓名</span>
				<div class="input_info_main">
					<input type="text" placeholder="输入发型师姓名" id="name" value="${hairdresser.name}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>电话</span>
				<div class="input_info_main">
					<input disabled="disabled" type="text" placeholder="输入联系电话" id="phoneNumber" value="${hairdresser.phoneNumber}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>店铺</span>
				<div class="input_info_main">
					<section>
						<select id="shop" class="gray">
						    <c:if test="${empty hairdresser.shopId}">
								<option value="-100">选择店铺</option>
							</c:if>
							<c:forEach items="${hairdresser.shopList}" var="shop">
								<option value="${shop.id}"
									<c:if test="${hairdresser.shopId eq shop.id}"> selected="selected"</c:if>>${shop.name}</option>
							</c:forEach>
						</select>
					</section>
				</div>
			</div>
			<div class="input_one" style="height: 6.5rem;line-height: 6.2rem;">
				<span>照片</span>
				<div class="input_info_main" style="height: 6.0rem;">
					<img src="${admin_img}/upload01.png" class="upload_img" onclick="wxChooseImage()"/> 
					<img id="mainImage" src="" class="view_img" style="display:none" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<%-- <div class="input_one">
				<span></span>
				<div class="input_info_main">
					<input type="text" placeholder="输入休息日" id="restday" value="${hairdresser.restday}"
						readonly="readonly" /> <img src="${admin_img}/checked_icon.png" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div> --%>
			<div class="input_one">
				<span>状态</span>
				<div class="input_info_main">
					<section>
						<select id="hairdresserStatus" class="gray">
							<c:if test="${empty hairdresser.status}">
								<option value="-100">选择状态</option>
							</c:if>
							<c:forEach items="${hairdresserStatusEnum}" var="hairdresserStatus">
								<option value="${hairdresserStatus.code}"
									<c:if test="${hairdresserStatus.code eq hairdresser.status}"> selected="selected"</c:if>>${hairdresserStatus.name}</option>
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
	var save_url = '<c:url value="/admin/hairdresser/save"/>';

	$(document).ready(function() {
		    if (${addOrEdit eq 'edit'}) {
			   $("#mainImage").attr("src",'${user_img}/${hairdresser.photo}');
			   $("#mainImage").attr("style", '');
		    } else {
			   $("#mainImage").attr("src", '');
			   $("#mainImage").attr("style", 'display:none');
			  
		    }
		});
	//微信jsApi授权
	wx.config({
	    debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
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
			$("#photo").val(mediaId);
			$("#mainImage").attr('style', '');

		},
		fail : function(error) {

		}
	    });
	}
	//保存
	$('#save').click(function() {
	    var id = $("#id").val();
	    var name = $("#name").val();
	    var phoneNumber = $("#phoneNumber").val();
	    var shopId = $("#shop option:selected").val();
	    var photo = $("#photo").val();
	    var originalPhoto = $("#originalPhoto").val();
	    var status = $("#hairdresserStatus option:selected").val();
	    if (confirm("确认保存?")) {
	    $.ajax({
			type : "post",
			dataType : "json",
			url : save_url,
			data : {'id':id,
			    	'name':name,
			    	'phoneNumber':phoneNumber,
			    	'shopId':shopId,
			    	'photo':photo,
			    	'originalPhoto':originalPhoto,
			    	'status':status},
			success : function(data) {
			    if (data != null && data.code == 200) {
				  pop_up_alert("warning","保存成功");
				  window.location.href='<c:url value="/admin/hairdresser/list"/>';
			    } else {
				  pop_up_alert("warning","保存失败");
			    }
			},
			error : function() {
			    pop_up_alert("warning","保存失败");
			}
		});
	    }
	});
	
    </script>
</body>
</html>