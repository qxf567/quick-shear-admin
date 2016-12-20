package com.shear.admin.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
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

import com.quickshear.common.enumeration.ShopStatusEnum;
import com.quickshear.common.util.BeanCopierUtil;
import com.quickshear.common.util.RetdCodeType;
import com.quickshear.common.vo.ResObj;
import com.quickshear.domain.City;
import com.quickshear.domain.Shop;
import com.quickshear.domain.query.CityQuery;
import com.quickshear.domain.query.ShopQuery;
import com.quickshear.service.CityService;
import com.quickshear.service.ShopService;
import com.shear.admin.controller.base.AbstractController;
import com.shear.admin.vo.ShopVo;

@Controller
@RequestMapping("/admin/shop")
public class ShopController extends AbstractController {

    private static final Logger LOGGER = LoggerFactory
	    .getLogger(ShopController.class);

    @Autowired
    private ShopService shopService;
    @Autowired
    private CityService cityService;

    @RequestMapping(value = "/list")
    public String list(Model model) {
	ShopQuery queryObj = new ShopQuery();
	List<Shop> shopList = null;
	List<ShopVo> shopVoList = new ArrayList<ShopVo>();
	try {
	    shopList = shopService.selectByParam(queryObj);
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}
	if (shopList != null) {
	    for (Shop shop : shopList) {
		ShopVo shopVo = new ShopVo();
		BeanCopier copier = BeanCopierUtil.copy(Shop.class,
			ShopVo.class);
		copier.copy(shop, shopVo, null);
		// 店铺状态
		shopVo.setStatusName(ShopStatusEnum.valueOfCode(
			shop.getStatus()).getName());
		if (shop.getStatus() != 1) {
		    shopVo.setLabelCssName("status rest");
		} else {
		    shopVo.setLabelCssName("status");
		}
		shopVoList.add(shopVo);
	    }
	}
	model.addAttribute("shopList", shopVoList);
	return "admin/shop_list";
    }

    @RequestMapping(value = "/add")
    public String add(Model model) {
	ShopVo shopVo = new ShopVo();
	model.addAttribute("shop", shopVo);
	model.addAttribute("addOrEdit", "add");
	return "admin/shop_edit";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(Model model, @PathVariable(value = "id") Long id) {
	Shop shop = null;
	try {
	    shop = shopService.findbyid(id);
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}

	ShopVo shopVo = new ShopVo();
	if (shop != null) {
	    BeanCopier copier = BeanCopierUtil.copy(Shop.class, ShopVo.class);
	    copier.copy(shop, shopVo, null);

	    try {
		City city = cityService.findbyid(shop.getCityId());
		if (city != null) {
		    String[] cityIdStrs = city.getFullPathId().split("\\|");
		    // 已选省份
		    shopVo.setSelectProvinceId(Long.valueOf(cityIdStrs[0]));
		    // 已选城市
		    shopVo.setSelectCityId(Long.valueOf(cityIdStrs[1]));
		    // 已选区县
		    shopVo.setSelectTownId(Long.valueOf(cityIdStrs[2]));
		}
	    } catch (Exception e) {
		LOGGER.error(e.getMessage());
	    }

	}
	model.addAttribute("shop", shopVo);
	model.addAttribute("addOrEdit", "edit");
	return "admin/shop_edit";
    }

    @RequestMapping(value = "/detail/{id}")
    public String view(Model model, @PathVariable(value = "id") Long id) {
	Shop shop = null;
	try {
	    shop = shopService.findbyid(id);
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}

	ShopVo shopVo = new ShopVo();
	BeanCopier copier = BeanCopierUtil.copy(Shop.class, ShopVo.class);
	copier.copy(shop, shopVo, null);
	// 店铺状态
	shopVo.setStatusName(ShopStatusEnum.valueOfCode(shop.getStatus())
		.getName());
	// 城市名称
	try {
	    City city = cityService.findbyid(shop.getCityId());
	    shopVo.setFullPathName(city.getFullPathName());
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}

	model.addAttribute("shop", shopVo);
	return "admin/shop_detail";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public ResObj<String> save(HttpServletRequest request) {
	ResObj<String> resObj = new ResObj<String>();
	resObj.setCode(RetdCodeType.PASS_OK.getCode());
	resObj.getMessage().setMsg(RetdCodeType.PASS_OK.getMsg());
	try {
	    Shop shop = new Shop();
	    if (null != request.getParameter("id")
		    && request.getParameter("id").length() != 0) {
		shop.setId(Long.valueOf(request.getParameter("id")));
	    }
	    shop.setName(request.getParameter("name"));
	    shop.setPhoneNumber(request.getParameter("phoneNumber"));
	    shop.setPrice(new BigDecimal(request.getParameter("price")));
	    shop.setBusinessHours(request.getParameter("businessHours"));
	    shop.setCityId(Long.valueOf(request.getParameter("cityId")));
	    shop.setAddress(request.getParameter("address"));
	    shop.setMainImageUrl(request.getParameter("mainImageUrl"));
	    shop.setMultiImageUrls("");
	    shop.setStatus(Integer.valueOf(request.getParameter("status")));
	    shop.setLatitude((double) 0);
	    shop.setLongitude((double) 0);
	    shop.setGeocode("0");
	    // 保存操作
	    int rlt = 0;
	    if (shop.getId() == null) {// 新增
		// shop.setStatus(0);
		rlt = shopService.save(shop);
	    } else {
		rlt = shopService.update(shop);
	    }

	    if (rlt < 0) {
		resObj.setCode(RetdCodeType.EX_APP.getCode());
		resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
	    }
	} catch (Exception e) {
	    resObj.setCode(RetdCodeType.EX_APP.getCode());
	    resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
	    LOGGER.error(e.getMessage());
	}

	return resObj;
    }

    @RequestMapping(value = "/citys/{pid}", method = RequestMethod.POST)
    @ResponseBody
    public ResObj<List<City>> ajaxCitys(@PathVariable(value = "pid") Long pid) {
	ResObj<List<City>> resObj = new ResObj<List<City>>();
	List<City> citys = selectCityByPid(pid);
	if (citys == null) {
	    resObj.setCode(RetdCodeType.EX_APP.getCode());
	    resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
	} else {
	    resObj.setCode(RetdCodeType.PASS_OK.getCode());
	    resObj.getMessage().setMsg(RetdCodeType.PASS_OK.getMsg());
	    resObj.setBusinessObj(citys);
	}
	return resObj;
    }

    private List<City> selectCityByPid(Long pid) {
	CityQuery queryObj = new CityQuery();
	queryObj.setStatus(1);
	queryObj.setPid(pid);
	try {
	    return cityService.selectByParam(queryObj);
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}
	return null;
    }
}
