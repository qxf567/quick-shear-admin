package com.shear.admin.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.beans.BeanCopier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quickshear.common.util.BeanCopierUtil;
import com.quickshear.domain.Order;
import com.quickshear.domain.query.OrderQuery;
import com.quickshear.service.OrderService;
import com.shear.admin.base.controller.AbstractController;
import com.shear.admin.vo.OrderVo;

@Controller
@RequestMapping("/admin/order")
public class OrderController extends AbstractController {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private OrderService orderService;

	@RequestMapping(value = "/list")
	public String list(Model model) {
		OrderQuery query = new OrderQuery();
		List<Order> orderList = null;
		try {
			orderList = orderService.selectByParam(query);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}

		model.addAttribute("orderList", orderList);
		return "admin/order_list";
	}

	@RequestMapping(value = "/edit")
	public String edit(@ModelAttribute("formBean") OrderVo orderVo, Model model,
			@RequestParam Long orderId) {
		Order order = null;
		try {
			order = orderService.findbyid(orderId);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		BeanCopier copier = BeanCopierUtil.copy(Order.class, OrderVo.class);
		copier.copy(order, orderVo, null);
		model.addAttribute("addOrEdit", "edit");
		return "admin/order_edit";
	}

	@RequestMapping(value = "/view")
	public String view(@ModelAttribute("formBean") OrderVo orderVo, Model model,
			@RequestParam Long orderId) {
		Order order = null;
		try {
			order = orderService.findbyid(orderId);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		BeanCopier copier = BeanCopierUtil.copy(Order.class, OrderVo.class);
		copier.copy(order, orderVo, null);
		return "admin/order_view";
	}

	@RequestMapping(value = "/save")
	@ResponseBody
	public String save(@ModelAttribute("formBean") OrderVo orderVo, Model model,
			@RequestParam Long orderId) {
		String success = "{\"success\": true}";
		try {
			Order order = new Order();
			BeanCopier copier = BeanCopierUtil.copy(OrderVo.class, Order.class);
			copier.copy(orderVo, order, null);
			// 保存操作
			int rlt = orderService.update(order);

			if (rlt < 0) {
				success = "{\"success\": false, \"exception\": \"保存失败\"}";
			}
		} catch (Exception e) {
			success = "{\"success\": false, \"exception\": \"保存失败\"}";
			LOGGER.error(e.getMessage());
		}

		return success;
	}
    
}
