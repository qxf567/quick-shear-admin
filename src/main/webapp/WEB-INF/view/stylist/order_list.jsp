<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="${admin_js}/touchslider.js"></script>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<title>我的服务订单</title>
<style type="text/css">
.max_box {
	max-width: 640px;
	padding-top: 50%;
	font-family: "microsoft yahei", Arial, sans-serif
}

.info_box img {
	width: 30%;
	display: block;
	margin: 0 auto
}

.info_box {
	color: #999;
	font-size: 1rem;
	text-align: center;
}

.info_box p {
	line-height: 26px;
}

.store_text p {
	padding-right: 0.5rem;
}

p.product_name {
	color: #333;
	font-size: 1.1rem
}

p.product_name span {
	float: right;
}
</style>
</head>
<body>
	<div class="container">
		<div class="tab_switch">
			<ul id="pagenavi" class="page fixed_top">
				<li><a href="javascript:;" class="active">待服务</a></li>
				<li><a href="javascript:;" class="">已完成</a></li>
			</ul>
			<div id="slider" class="swipe mt37"
				style="overflow: hidden; visibility: visible; list-style: none; position: relative;">
				<ul class="tab_switch_list"
					style="position: relative; transition: left 300ms ease-out; width: 2560px; left: -1280px;">
					<!--  待服务  -->
					<li class="li_list"
						style="width: 640px; display: table-cell; padding: 0px; margin: 0px; float: left; vertical-align: top; min-height: 807px; line-height: 807px;">
                        <c:if test="${empty inServiceOrders}">
							<div class="gap"></div>
							<div class="one_order hide_order_li">
								<div class="max_box">
									<div class="info_box">
										<img src="${admin_img}/no_has_order.jpg">
										<p>可以接单啦!</p>
									</div>
								</div>
							</div>
						</c:if>
						<c:forEach items="${inServiceOrders}" var="sOrder">
							<div class="gap"></div>
							<div class="one_order">
								<p class="store_name_id">${sOrder.shopName}</p>
								<div class="order_info">
									<div class="store_img">
										<img src="${shop_img}/${sOrder.shopMainImageUrl}">
									</div>
									<div class="store_text">
										<p>服务号：${sOrder.serviceCode}</p>
										<p>订单号：${sOrder.orderId}</p>
										<p>预约时间：${sOrder.appointmentTime}</p>
									</div>
								</div>
								<div class="total_main">
									<span class="total_price">合计</span> <span class="sum">${sOrder.actualPrice}元</span>
								</div>
								<div class="btn_block">
									<a href=""><div class="tips_btn" style="background: #1c436f;">确认服务完成</div></a>
								</div>
							</div>
						</c:forEach>
					</li>

					<!--  已完成  -->
					<li class="li_list"
						style="width: 640px; display: table-cell; padding: 0px; margin: 0px; float: left; vertical-align: top; min-height: 807px; line-height: 807px;">
						<c:if test="${empty completedOrders}">
							<div class="gap"></div>
							<div class="one_order hide_order_li">
								<div class="max_box">
									<div class="info_box">
										<img src="${admin_img}/no_has_order.jpg">
										<p>您还没有完成过订单，努力接单吧！</p>
									</div>
								</div>
							</div>
						</c:if>
						<c:forEach items="${completedOrders}" var="cOrder">
							<div class="gap"></div>
							<div class="one_order">
								<p class="store_name_id">${cOrder.shopName}</p>
								<div class="order_info">
									<div class="store_img">
										<img src="${shop_img}/${cOrder.shopMainImageUrl}">
									</div>
									<div class="store_text">
										<p>服务号：${cOrder.serviceCode}</p>
										<p>订单号：${cOrder.orderId}</p>
										<p>预约时间：${cOrder.appointmentTime}</p>
									</div>
								</div>
								<div class="total_main">
									<span class="total_price">合计</span> <span class="sum">${cOrder.actualPrice}元</span>
								</div>
							</div>
						</c:forEach>
					</li>

				</ul>
			</div>
		</div>
		<!--底部固定End-->
		<div style="height: 50px;"></div>
		<div class="fixed_menu">
			<div class="amount"></div>
			<a onclick="wxScanQRCode()" id="receive">
				<div class="fixed_btn">扫码接单</div>
			</a>
		</div>
	</div>
	<script type="text/javascript">
	
		//微信jsApi授权
		wx.config({
			debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			appId : '${appid}', // 必填，公众号的唯一标识
			timestamp : '${timestamp}', // 必填，生成签名的时间戳
			nonceStr : '${nonceStr}', // 必填，生成签名的随机串
			signature : '${sign}',// 必填，签名，见附录1
			jsApiList : [ 'scanQRCode'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		});
		
		//扫码接口  
		function wxScanQRCode() {
			wx.scanQRCode({
				needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
				scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有
				success : function(res) {
					var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
					window.location.href = '<c:url value="/stylist/order/receive/' + result + '"/>';
				}
			});
		};
	</script>
	<script type="text/javascript">
		var page = 'pagenavi';
		var mslide = 'slider';
		//    var mtitle='emtitle';
		arrdiv = 'arrdiv';

		var as = document.getElementById(page).getElementsByTagName('a');

		var tt = new TouchSlider({
			id : mslide,
			'auto' : '-1',
			fx : 'ease-out',
			direction : 'left',
			speed : 300,
			timeout : 5000,
			'before' : function(index) {
				var as = document.getElementById(this.page)
						.getElementsByTagName('a');
				as[this.p].className = '';
				as[index].className = 'active';
				this.p = index;
				var txt = as[index].innerText;
				//        $("javascript:;"+this.page).parent().find('.emtitle').text(txt);
				var txturl = as[index].getAttribute('href');
				var turl = txturl.split('#');
				//        $("javascript:;"+this.page).parent().find('.go_btn').attr('href',turl[1]);
			}
		});

		tt.page = page;
		tt.p = 0;
		//console.dir(tt); console.dir(tt.__proto__);
		for (var i = 0; i < as.length; i++) {
			(function() {
				var j = i;
				as[j].tt = tt;
				as[j].onclick = function() {
					this.tt.slide(j);
					return false;
				}
			})();
		}
	</script>
</body>
</html>