package com.shear.admin.controller.hairdresser;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.beans.BeanCopier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quickshear.common.enumeration.OrderStatusEnum;
import com.quickshear.common.enumeration.RoleEnum;
import com.quickshear.common.util.BeanCopierUtil;
import com.quickshear.common.util.DateUtil;
import com.quickshear.common.util.RetdCodeType;
import com.quickshear.common.vo.ResObj;
import com.quickshear.common.wechat.utils.WechatJsApiUtil;
import com.quickshear.domain.Order;
import com.quickshear.domain.Shop;
import com.quickshear.domain.query.OrderQuery;
import com.quickshear.service.OrderService;
import com.quickshear.service.ShopService;
import com.quickshear.service.sms.StorageService;
import com.shear.admin.aop.annotation.Permission;
import com.shear.admin.controller.base.AbstractController;
import com.shear.admin.vo.OrderVo;

@Controller
@RequestMapping("/stylist/order")
@Permission(roleTypes = { RoleEnum.STYLIST })
public class StyOrderController extends AbstractController {
    private static final Logger LOGGER = LoggerFactory.getLogger(StyOrderController.class);

    @Autowired
    private ShopService shopService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private StorageService storageService;
    @Autowired
    private WechatJsApiUtil wechatJsApiUtil;
    // 当前网页的URL，不包含参数部分
    private String url = "http://m.qiansishun.com/v1/stylist/order";
    
    @RequestMapping("/list")
    public String list(Model model,HttpServletRequest request) {
    	String cookie_openid = storageService.get(request, "openid");
    	String cookie_hairdresserid = storageService.get(request, "hairdresserid");
 	    if (cookie_hairdresserid == null) {//取不到cookie，跳转到登录页
 	    	return "admin/login/"+cookie_openid;
 	    }
 	   LOGGER.info("cookie_hairdresserid:"+cookie_hairdresserid);
    	OrderQuery queryObj = new OrderQuery();
    	List<Order> orderList = null;
    	List<OrderVo> inServiceOrders = new ArrayList<OrderVo>();
    	List<OrderVo> completedOrders = new ArrayList<OrderVo>();
    	try {
    		List<Integer> orderStatusList = new ArrayList<Integer>();
    		orderStatusList.add(OrderStatusEnum.ORDER_RECEIVE.getCode());
    		orderStatusList.add(OrderStatusEnum.SERVICE_COMPLETE.getCode());
    		queryObj.setOrderStatusList(orderStatusList);
    		queryObj.setHairdresserId(Long.valueOf(cookie_hairdresserid));
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
					
					if (order.getOrderStatus() == OrderStatusEnum.ORDER_RECEIVE.getCode()) {
						inServiceOrders.add(orderVo);
					} 
					if (order.getOrderStatus() == OrderStatusEnum.SERVICE_COMPLETE.getCode()) {
						completedOrders.add(orderVo);
					}
				}
    		}
    	} catch (Exception e) {
    	    LOGGER.error(e.getMessage());
    	}
    	wechatJsApiUtil.setWxJsApiToModel(model,url+"/list");
    	model.addAttribute("inServiceOrders", inServiceOrders);
    	model.addAttribute("completedOrders", completedOrders);
		return "stylist/order_list";
    }
    
    @RequestMapping("/receive/{orderId}")
    public String orderReceive(Model model,HttpServletRequest request,@PathVariable(value = "orderId") Long orderId) {
    	Order order = null;
    	Shop shop = null;
    	OrderVo orderVo = new OrderVo();
		try {
			order = orderService.findbyid(orderId);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		if (order != null) {
			BeanCopier copier = BeanCopierUtil.copy(Order.class, OrderVo.class);
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
		}
		model.addAttribute("order", orderVo);
    	return "stylist/order_receive";
    }
    
    //接单确认
    @RequestMapping(value ="/receive/confirm", method = RequestMethod.POST)
    @ResponseBody
    public ResObj<String> receiveConfirm(HttpServletRequest request) {
    	
    	ResObj<String> resObj = new ResObj<String>();
    	resObj.setCode(RetdCodeType.PASS_OK.getCode());
    	resObj.getMessage().setMsg(RetdCodeType.PASS_OK.getMsg());
    	
    	String cookie_hairdresserid = storageService.get(request, "hairdresserid");
 	    if (cookie_hairdresserid == null) {//取不到cookie，跳转到登录页
 	    	resObj.setCode(RetdCodeType.EX_APP.getCode());
    	    resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
    	    LOGGER.error("cookie_hairdresserid 获取失败");
    	    return resObj;
 	    }
    	try {
    		//一次只能接一张订单
    		OrderQuery queryObj = new OrderQuery();
    		queryObj.setOrderStatus(OrderStatusEnum.ORDER_RECEIVE.getCode());
    		queryObj.setHairdresserId(Long.valueOf(cookie_hairdresserid));
    		List<Order> orders = orderService.selectByParam(queryObj);
    		if(orders == null){
    			resObj.setCode(RetdCodeType.EX_APP.getCode());
        	    resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
        	    return resObj;
    		}
    		if(orders.size()>0){
    			resObj.setCode(RetdCodeType.EX_APP.getCode());
        	    resObj.getMessage().setMsg("接单失败，您还有未处理订单!");
        	    return resObj;
    		}
			queryObj = new OrderQuery();
    		queryObj.setOrderId(Long.valueOf(request.getParameter("orderId")));
    		queryObj.setOrderStatus(OrderStatusEnum.PAY_COMPLETE.getCode());
    		Order order = new Order();
    		order.setOrderStatus(OrderStatusEnum.ORDER_RECEIVE.getCode());
    		order.setHairdresserId(Long.valueOf(cookie_hairdresserid));
    		int rlt = orderService.updateByParam(order, queryObj);
    		if(rlt<=0){
    			 resObj.setCode(RetdCodeType.EX_APP.getCode());
    	    	 resObj.getMessage().setMsg("订单状态异常!");
    		}
    		
    	} catch (Exception e) {
    	    resObj.setCode(RetdCodeType.EX_APP.getCode());
    	    resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
    	    LOGGER.error(e.getMessage());
    	}

    	return resObj;
    }
    
    //服务完成确认
    @RequestMapping(value ="/complete/confirm", method = RequestMethod.POST)
    @ResponseBody
    public ResObj<String> completeConfirm(HttpServletRequest request) {
    	
    	ResObj<String> resObj = new ResObj<String>();
    	resObj.setCode(RetdCodeType.PASS_OK.getCode());
    	resObj.getMessage().setMsg(RetdCodeType.PASS_OK.getMsg());
    	
    	String cookie_hairdresserid = storageService.get(request, "hairdresserid");
 	    if (cookie_hairdresserid == null) {//取不到cookie，跳转到登录页
 	    	resObj.setCode(RetdCodeType.EX_APP.getCode());
    	    resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
    	    LOGGER.error("cookie_hairdresserid 获取失败");
    	    return resObj;
 	    }
    	try {
    		OrderQuery queryObj = new OrderQuery();
    		queryObj.setOrderId(Long.valueOf(request.getParameter("orderId")));
    		queryObj.setOrderStatus(OrderStatusEnum.ORDER_RECEIVE.getCode());
    		queryObj.setHairdresserId(Long.valueOf(cookie_hairdresserid));
    		Order order = new Order();
    		order.setOrderStatus(OrderStatusEnum.SERVICE_COMPLETE.getCode());
    		order.setServiceCompletionTime(new Date());
    		int rlt = orderService.updateByParam(order, queryObj);
    		if(rlt<=0){
    			 resObj.setCode(RetdCodeType.EX_APP.getCode());
    	    	 resObj.getMessage().setMsg("订单状态异常!");
    		}
    		
    	} catch (Exception e) {
    	    resObj.setCode(RetdCodeType.EX_APP.getCode());
    	    resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
    	    LOGGER.error(e.getMessage());
    	}

    	return resObj;
    }
}
