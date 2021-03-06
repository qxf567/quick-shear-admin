<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<%@ include file="../common/meta.jsp"%>
<%@ include file="../common/taglibs.jsp"%>
<script type="text/javascript" src="${admin_js}/touchslider.js"></script>
<link type="text/css" rel="stylesheet" href="${admin_css}/order_list.css">
<title>订单列表</title>
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
				<li><a href="javascript:;" class="active">全部</a></li>
				<li><a href="javascript:;" class="">待服务</a></li>
			</ul>
			<div id="slider" class="swipe mt37"
				style="overflow: hidden; visibility: visible; list-style: none; position: relative;">
				<ul class="tab_switch_list"
					style="position: relative; transition: left 300ms ease-out; width: 2560px; left: -1280px;">
					<!--  全部  -->
					<li class="li_list"
						style="width: 640px; display: table-cell; padding: 0px; margin: 0px; float: left; vertical-align: top; min-height: 807px; line-height: 807px;">
                        <c:if test="${empty allOrders}">
							<div class="gap"></div>
							<div class="one_order hide_order_li">
								<div class="max_box">
									<div class="info_box">
										<img src="${admin_img}/no_has_order.jpg">
										<p>还没有顾客下单哦！</p>
									</div>
								</div>
							</div>
						</c:if>
						<c:forEach items="${allOrders}" var="aOrder">
							<div class="gap"></div>
							<div class="one_order">
								<p class="store_name_id">${aOrder.shopName}<span class="state_label">${aOrder.orderStatusName}</span></p>
								<div class="order_info">
									<div class="store_img">
										<img src="${shop_img}/${aOrder.shopMainImageUrl}">
									</div>
									<div class="store_text">
										<p>服务号：${aOrder.serviceCode}</p>
										<p>订单号：${aOrder.orderId}</p>
										<p>顾客电话：${aOrder.customerNumber}</p>
										<p>预约时间：${aOrder.appointmentTime}</p>
									</div>
								</div>
								<div class="total_main">
									<span class="total_price">合计</span> <span class="sum">${aOrder.actualPrice}元</span>
								</div>
							</div>
						</c:forEach>
					</li>

					<!--  待服务  -->
					<li class="li_list"
						style="width: 640px; display: table-cell; padding: 0px; margin: 0px; float: left; vertical-align: top; min-height: 807px; line-height: 807px;">
						<c:if test="${empty inServiceOrders}">
							<div class="gap"></div>
							<div class="one_order hide_order_li">
								<div class="max_box">
									<div class="info_box">
										<img src="${admin_img}/no_has_order.jpg">
										<p>没有待服务订单!</p>
									</div>
								</div>
							</div>
						</c:if>
						<c:forEach items="${inServiceOrders}" var="sOrder">
							<div class="gap"></div>
							<div class="one_order">
								<p class="store_name_id">${sOrder.shopName}<span class="state_label">${sOrder.orderStatusName}</span></p>
								<div class="order_info">
									<div class="store_img">
										<img src="${shop_img}/${sOrder.shopMainImageUrl}">
									</div>
									<div class="store_text">
										<p>服务号：${sOrder.serviceCode}</p>
										<p>订单号：${sOrder.orderId}</p>
										<p>顾客电话：${sOrder.customerNumber}</p>
										<p>预约时间：${sOrder.appointmentTime}</p>
									</div>
								</div>
								<div class="total_main">
									<span class="total_price">合计</span> <span class="sum">${sOrder.actualPrice}元</span>
								</div>
							</div>
						</c:forEach>
					</li>

				</ul>
			</div>
		</div>
	</div>
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