package com.shear.admin.vo;

import java.io.Serializable;

public class HairdresserVo implements Serializable {

    private static final long serialVersionUID = 1L;

    /** id(自增) */
    private Long id;

    /** 姓名 */
    private String name;

    /** 电话 */
    private String phoneNumber;

    /** 所属门店 */
    private Long shopId;

    /** 所属门店 */
    private Long shopName;
    
    /** 照片 */
    private String photo;

    /** 身份证正面照 */
    private String cardFacePhoto;

    /** 身份证背面照 */
    private String cardBackPhoto;

    /** 休息日 */
    private String restday;

    /** 状态(0无效1有效300待审核) */
    private Integer status;
    
    /** 状态(0无效1有效300待审核) */
    private String statusName;

    /** 创建时间 */
    private String cTime;

    /** 最后修改时间 */
    private String mTime;

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

    public Long getShopId() {
	return shopId;
    }

    public void setShopId(Long shopId) {
	this.shopId = shopId;
    }

    public String getRestday() {
	return restday;
    }

    public void setRestday(String restday) {
	this.restday = restday;
    }

    public Integer getStatus() {
	return status;
    }

    public void setStatus(Integer status) {
	this.status = status;
    }

    public String getcTime() {
	return cTime;
    }

    public void setcTime(String cTime) {
	this.cTime = cTime;
    }

    public String getmTime() {
	return mTime;
    }

    public void setmTime(String mTime) {
	this.mTime = mTime;
    }

    public Long getShopName() {
	return shopName;
    }

    public void setShopName(Long shopName) {
	this.shopName = shopName;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getCardFacePhoto() {
        return cardFacePhoto;
    }

    public void setCardFacePhoto(String cardFacePhoto) {
        this.cardFacePhoto = cardFacePhoto;
    }

    public String getCardBackPhoto() {
        return cardBackPhoto;
    }

    public void setCardBackPhoto(String cardBackPhoto) {
        this.cardBackPhoto = cardBackPhoto;
    }

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

}
