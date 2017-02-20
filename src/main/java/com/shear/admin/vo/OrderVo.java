package com.shear.admin.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 页面使用订单相关信息
 *
 */
public class OrderVo implements Serializable {
	/** 订单号 */
    private Long orderId;

    /** 顾客姓名 */
    private String customerName;

    /** 顾客联系电话 */
    private String customerNumber;

    /** 预约时间 */
    private String appointmentTime;

    /** 服务号 */
    private String serviceCode;

    /** 订单状态(0待支付1支付完成50已接单100服务完成300取消) */
    private Integer orderStatus;
    /** 订单状态(0待支付1支付完成50已接单100服务完成300取消) */
    private String orderStatusName;

    /** 合计价格 */
    private BigDecimal totalPrice;

    /** 实际收费价格(默认为total_price) */
    private BigDecimal actualPrice;

    /** 下单时间 */
    private String orderTime;
    
    /** 门店id */
    private Long shopId;
    
    /** 门店名称 */
    private String shopName;
    
    /** 门店主图 */
    private String shopMainImageUrl;

    private static final long serialVersionUID = 1L;

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerNumber() {
		return customerNumber;
	}

	public void setCustomerNumber(String customerNumber) {
		this.customerNumber = customerNumber;
	}

	public String getAppointmentTime() {
		return appointmentTime;
	}

	public void setAppointmentTime(String appointmentTime) {
		this.appointmentTime = appointmentTime;
	}

	public String getServiceCode() {
		return serviceCode;
	}

	public void setServiceCode(String serviceCode) {
		this.serviceCode = serviceCode;
	}

	public Integer getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(Integer orderStatus) {
		this.orderStatus = orderStatus;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public BigDecimal getActualPrice() {
		return actualPrice;
	}

	public void setActualPrice(BigDecimal actualPrice) {
		this.actualPrice = actualPrice;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}

	public Long getShopId() {
		return shopId;
	}

	public void setShopId(Long shopId) {
		this.shopId = shopId;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getShopMainImageUrl() {
		return shopMainImageUrl;
	}

	public void setShopMainImageUrl(String shopMainImageUrl) {
		this.shopMainImageUrl = shopMainImageUrl;
	}

	public String getOrderStatusName() {
		return orderStatusName;
	}

	public void setOrderStatusName(String orderStatusName) {
		this.orderStatusName = orderStatusName;
	}

}