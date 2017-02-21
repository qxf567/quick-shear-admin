package com.shear.admin.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.beans.BeanCopier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.quickshear.common.enumeration.OrderStatusEnum;
import com.quickshear.common.util.BeanCopierUtil;
import com.quickshear.common.util.DateUtil;
import com.quickshear.domain.Order;
import com.quickshear.domain.Shop;
import com.quickshear.domain.query.OrderQuery;
import com.quickshear.service.OrderService;
import com.quickshear.service.ShopService;
import com.shear.admin.controller.base.AbstractController;
import com.shear.admin.vo.OrderVo;

@Controller
@RequestMapping("/admin/order")
public class OrderController extends AbstractController {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private OrderService orderService;
	@Autowired
	private ShopService shopService;

	@RequestMapping(value = "/list")
	public String list(Model model) {
		OrderQuery queryObj = new OrderQuery();
		List<Order> orderList = null;
		List<OrderVo> inServiceOrders = new ArrayList<OrderVo>();
		List<OrderVo> allOrders = new ArrayList<OrderVo>();
		try {
			List<Integer> orderStatusList = new ArrayList<Integer>();
			orderList = orderService.selectByParam(queryObj);
			if (orderList != null && orderList.size()>0) {
				Shop shop = null;
				for (Order order : orderList) {
					OrderVo orderVo = new OrderVo();
					BeanCopier copier = BeanCopierUtil.copy(Order.class,
							OrderVo.class);
					copier.copy(order, orderVo, null);
					// 预约时间
					orderVo.setAppointmentTime(DateUtil.format(order.getAppointmentTime(), DateUtil.ALL));
					// 门店信息
					try {
						shop = shopService.findbyid(order.getShopId());
					} catch (Exception e) {
						LOGGER.error(e.getMessage());
					}
					if(shop != null){
						orderVo.setShopName(shop.getName());
						orderVo.setShopMainImageUrl(shop.getMainImageUrl());
					}
					orderVo.setOrderStatusName(OrderStatusEnum.valueOfCode(order.getOrderStatus()).getName());
					allOrders.add(orderVo);
					if (order.getOrderStatus().equals(OrderStatusEnum.ORDER_RECEIVE.getCode()) || order.getOrderStatus().equals(OrderStatusEnum.PAY_COMPLETE.getCode())) {
						inServiceOrders.add(orderVo);
					}
				}
			}
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		model.addAttribute("inServiceOrders", inServiceOrders);
		model.addAttribute("allOrders", allOrders);
		return "admin/order_list";
	}
    
}
