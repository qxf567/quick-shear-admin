<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.quickshear.common.enumeration.HairstyleStatusEnum"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<link type="text/css" rel="stylesheet" href="${admin_css}/slides.css">
<c:set var="hairstyleStatusEnum" value="<%=HairstyleStatusEnum.values()%>" />

<title><c:if test="${addOrEdit eq 'add'}">新增发型</c:if> <c:if test="${addOrEdit eq 'edit'}">编辑发型</c:if></title>
</head>
<body>
	<div class="container">
		<div class="gap"></div>
		<input id="id" value="${hairstyle.id}" type="hidden" /> 
		<input id="mainImageUrl" value="${hairstyle.mainImageUrl}" type="hidden" />
		<div class="input_list">
			<div class="input_one">
				<span>发型名称</span>
				<div class="input_info_main">
					<input type="text" placeholder="输入发型名称" id="name" value="${hairstyle.name}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>性别</span>
				<div class="input_info_main">
					<input type="radio" name="sex" value="0" checked="checked" />男士
					<br>
					<input type="radio" name="sex" value="1" />女士
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<%-- <div class="input_one">
				<span>价格￥</span>
				<div class="input_info_main">
					<input type="text" placeholder="理发价格单位:元" id="hairstyle" value="${hairstyle.price}" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div> --%>
			<div class="input_one" style="height: 6.5rem;line-height: 6.2rem;">
				<span>图片</span>
				<div class="input_info_main" style="height: 6.0rem;">
					<img src="${admin_img}/upload01.png" class="upload_img" onclick="wxChooseImage()"/> 
					<img id="mainImage" src="" class="view_img" style="display:none" />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>详情</span>
				<div class="input_info_main">
					<input type="text" id="detail" placeholder="输入详情" value="${hairstyle.detail}"  />
				</div>
				<hr style="background: #f2f2f2;height: 1px;border: none">
			</div>
			<div class="input_one">
				<span>状态</span>
				<div class="input_info_main">
					<section>
						<select id="hairstyleStatus" class="gray">
							<c:if test="${empty hairstyle.status}">
								<option value="-100">选择状态</option>
							</c:if>
							<c:forEach items="${hairstyleStatusEnum}" var="hairstyleStatus">
								<option value="${hairstyleStatus.code}"
									<c:if test="${hairstyleStatus.code eq hairstyle.status}"> selected="selected"</c:if>>${hairstyleStatus.name}</option>
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
	var save_url = '<c:url value="/admin/hairstyle/save"/>';

	$(document).ready(function() {
		    if (${addOrEdit eq 'edit'}) {
			   $("#mainImage").attr("src",'${user_img}/${hairstyle.mainImageUrl}');
			   $("#mainImage").attr("style", '');
			   $('input:radio[name="sex"]:checked').val() == '${hairstyle.sex}';
			   
		    } else {
			   $("#mainImage").attr("src", '');
			   $("#mainImage").attr("style", 'display:none');
		    }
		});
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
	//保存
	$('#save').click(function() {
	    var id = $("#id").val();
	    var name = $("#name").val();
	    var detail = $("#detail").val();
	    var sex = $('input:radio[name="sex"]:checked').val()
	    var mainImageUrl = $("#mainImageUrl").val();
	    var status = $("#hairstyleStatus option:selected").val();
	    $.ajax({
			type : "post",
			dataType : "json",
			url : save_url,
			data : {'id':id,
			    	'name':name,
			    	'detail':detail,
			    	'price':price,
			    	'sex':sex,
			    	'mainImageUrl':mainImageUrl,
			    	'status':status},
			success : function(data) {
			    if (data != null && data.code == 200) {
				  pop_up_alert("warning","保存成功");
				  window.location.href='<c:url value="/admin/hairstyle/list"/>';
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