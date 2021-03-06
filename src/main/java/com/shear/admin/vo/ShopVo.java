package com.shear.admin.vo;

import java.io.Serializable;
import java.math.BigDecimal;

public class ShopVo implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 门店id(自增) */
    private Long id;

    /** 门店名称 */
    private String name;

    /** 电话 */
    private String phoneNumber;

    /** 营业时间 */
    private String businessHours;

    /** 城市id */
    private Long cityId;

    /** 城市全路径id */
    private String fullPathId;

    /** 城市全路径名称 */
    private String fullPathName;

    /** 坐标经度 */
    private Double longitude;

    /** 坐标纬度 */
    private Double latitude;
    
    /** 坐标40.2222,116.33333 */
    private String gps;

    /** 详细地址 */
    private String address;

    /** 经纬度hash值 */
    private String geocode;

    /** 门店图片(主图) */
    private String mainImageUrl;

    /** 门店图片(副图) */
    private String multiImageUrls;

    /** 门店均价 */
    private BigDecimal price;

    /** 状态(0无效1正常营业2暂停营业) */
    private Integer status;

    /** 状态名称(0无效1正常营业2暂停营业) */
    private String statusName;

    /** 状态效果(0无效1正常营业2暂停营业) */
    private String labelCssName;
    
    // 已选择省份id
    private Long selectProvinceId;
    // 已选择城市id
    private Long selectCityId;
    // 已选择区县id
    private Long selectTownId;

    public Long getId() {
	return id;
    }

    public void setId(Long id) {
	this.id = id;
    }

    public String getName() {
	return name;
    }

    public void setName(String name) {
	this.name = name;
    }

    public String getPhoneNumber() {
	return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
	this.phoneNumber = phoneNumber;
    }

    public String getBusinessHours() {
	return businessHours;
    }

    public void setBusinessHours(String businessHours) {
	this.businessHours = businessHours;
    }

    public Long getCityId() {
	return cityId;
    }

    public void setCityId(Long cityId) {
	this.cityId = cityId;
    }

    public Double getLongitude() {
	return longitude;
    }

    public void setLongitude(Double longitude) {
	this.longitude = longitude;
    }

    public Double getLatitude() {
	return latitude;
    }

    public void setLatitude(Double latitude) {
	this.latitude = latitude;
    }

    public String getAddress() {
	return address;
    }

    public void setAddress(String address) {
	this.address = address;
    }

    public String getGeocode() {
	return geocode;
    }

    public void setGeocode(String geocode) {
	this.geocode = geocode;
    }

    public String getMainImageUrl() {
	return mainImageUrl;
    }

    public void setMainImageUrl(String mainImageUrl) {
	this.mainImageUrl = mainImageUrl;
    }

    public String getMultiImageUrls() {
	return multiImageUrls;
    }

    public void setMultiImageUrls(String multiImageUrls) {
	this.multiImageUrls = multiImageUrls;
    }

    public BigDecimal getPrice() {
	return price;
    }

    public void setPrice(BigDecimal price) {
	this.price = price;
    }

    public Integer getStatus() {
	return status;
    }

    public void setStatus(Integer status) {
	this.status = status;
    }

    public String getStatusName() {
	return statusName;
    }

    public void setStatusName(String statusName) {
	this.statusName = statusName;
    }

    public String getLabelCssName() {
	return labelCssName;
    }

    public void setLabelCssName(String labelCssName) {
	this.labelCssName = labelCssName;
    }

    public String getFullPathId() {
	return fullPathId;
    }

    public void setFullPathId(String fullPathId) {
	this.fullPathId = fullPathId;
    }

    public String getFullPathName() {
	return fullPathName;
    }

    public void setFullPathName(String fullPathName) {
	this.fullPathName = fullPathName;
    }

    public Long getSelectProvinceId() {
        return selectProvinceId;
    }

    public void setSelectProvinceId(Long selectProvinceId) {
        this.selectProvinceId = selectProvinceId;
    }

    public Long getSelectCityId() {
        return selectCityId;
    }

    public void setSelectCityId(Long selectCityId) {
        this.selectCityId = selectCityId;
    }

    public Long getSelectTownId() {
        return selectTownId;
    }

    public void setSelectTownId(Long selectTownId) {
        this.selectTownId = selectTownId;
    }

	public String getGps() {
		return gps;
	}

	public void setGps(String gps) {
		this.gps = gps;
	}

}
