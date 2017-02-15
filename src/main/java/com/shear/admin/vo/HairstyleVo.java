package com.shear.admin.vo;

import java.io.Serializable;
import java.math.BigDecimal;

public class HairstyleVo implements Serializable {

    /**
	 * 
	 */
    private static final long serialVersionUID = 1L;

    /** id(自增) */
    private Long id;

    /** 发型名称 */
    private String name;

    /** 介绍明细 */
    private String detail;
    
    /** 男（0）女(1) */
    private Integer sex;
    
    /** 男（0）女(1) */
    private String sexName;

    /** 图片(主图) */
    private String mainImageUrl;

    /** 图片(副图) */
    private String multiImageUrls;

    /** 收费价格 */
    private BigDecimal price;

    /** 状态(0无效1有效) */
    private Integer status;
    
    /** 状态名称(0无效1有效) */
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

    public String getDetail() {
	return detail;
    }

    public void setDetail(String detail) {
	this.detail = detail;
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

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getSexName() {
		return sexName;
	}

	public void setSexName(String sexName) {
		this.sexName = sexName;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

}
