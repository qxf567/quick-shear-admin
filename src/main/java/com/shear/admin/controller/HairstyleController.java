package com.shear.admin.controller;

import java.math.BigDecimal;
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

import com.quickshear.common.enumeration.HairstyleStatusEnum;
import com.quickshear.common.enumeration.RoleEnum;
import com.quickshear.common.enumeration.SexEnum;
import com.quickshear.common.util.BeanCopierUtil;
import com.quickshear.common.util.RetdCodeType;
import com.quickshear.common.vo.ResObj;
import com.quickshear.common.wechat.utils.WechatJsApiUtil;
import com.quickshear.domain.Hairstyle;
import com.quickshear.domain.query.HairstyleQuery;
import com.quickshear.service.HairstyleService;
import com.shear.admin.aop.annotation.Permission;
import com.shear.admin.controller.base.AbstractController;
import com.shear.admin.vo.HairstyleVo;

@Controller
@RequestMapping("/admin/hairstyle")
@Permission(roleTypes = { RoleEnum.ADMIN })
public class HairstyleController extends AbstractController {

    private static final Logger LOGGER = LoggerFactory
	    .getLogger(HairstyleController.class);

    @Autowired
    private HairstyleService hairstyleService;
    @Autowired
    private WechatJsApiUtil wechatJsApiUtil;

    // 当前网页的URL，不包含参数部分
    private String url = "http://m.qiansishun.com/v1/admin/hairstyle";

    @RequestMapping(value = "/list")
    public String list(Model model) {
	HairstyleQuery query = new HairstyleQuery();
	List<Hairstyle> hairstyleList = null;
	try {
	    hairstyleList = hairstyleService.selectByParam(query);
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}

	model.addAttribute("hairstyleList", hairstyleList);
	return "admin/hairstyle_list";
    }

    @RequestMapping(value = "/add")
    public String add(Model model) {
	HairstyleVo hairstyleVo = new HairstyleVo();
	wechatJsApiUtil.setWxJsApiToModel(model,url+"/add");
	model.addAttribute("hairstyle", hairstyleVo);
	model.addAttribute("addOrEdit", "add");
	return "admin/hairstyle_edit";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(Model model, @PathVariable(value = "id") Long id) {
	Hairstyle hairstyle = null;
	try {
	    hairstyle = hairstyleService.findbyid(id);
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}
	HairstyleVo hairstyleVo = new HairstyleVo();
	if (hairstyle != null) {
	    BeanCopier copier = BeanCopierUtil.copy(Hairstyle.class,
		    HairstyleVo.class);
	    copier.copy(hairstyle, hairstyleVo, null);
	}
	wechatJsApiUtil.setWxJsApiToModel(model,url+"/edit/"+id);
	model.addAttribute("hairstyle", hairstyleVo);
	model.addAttribute("addOrEdit", "edit");
	return "admin/hairstyle_edit";
    }

    @RequestMapping(value = "/detail/{id}")
    public String view(Model model, @PathVariable(value = "id") Long id) {
	Hairstyle hairstyle = null;
	try {
	    hairstyle = hairstyleService.findbyid(id);
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}
	HairstyleVo hairstyleVo = new HairstyleVo();
	if (hairstyle != null) {
	    BeanCopier copier = BeanCopierUtil.copy(Hairstyle.class,
		    HairstyleVo.class);
	    copier.copy(hairstyle, hairstyleVo, null);
	}
	hairstyleVo.setSexName(SexEnum.valueOfCode(hairstyle.getSex()).getName());
	hairstyleVo.setStatusName(HairstyleStatusEnum.valueOfCode(hairstyle.getStatus()).getName());
	model.addAttribute("hairstyle", hairstyleVo);
	return "admin/hairstyle_detail";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public ResObj<String> save(HttpServletRequest request) {
	ResObj<String> resObj = new ResObj<String>();
	resObj.setCode(RetdCodeType.PASS_OK.getCode());
	resObj.getMessage().setMsg(RetdCodeType.PASS_OK.getMsg());
	try {
	    Hairstyle hairstyle = new Hairstyle();
	    if (null != request.getParameter("id")
		    && request.getParameter("id").length() != 0) {
		hairstyle.setId(Long.valueOf(request.getParameter("id")));
	    }
	    hairstyle.setName(request.getParameter("name"));
	    hairstyle.setPrice(BigDecimal.ZERO);
	    hairstyle.setSex(Integer.valueOf(request.getParameter("sex")));
	    hairstyle.setMainImageUrl(request.getParameter("mainImageUrl"));
	    hairstyle.setMultiImageUrls("");
	    hairstyle.setDetail(request.getParameter("detail"));
	    hairstyle.setStatus(Integer.valueOf(request.getParameter("status")));
	    // 保存操作
	    if(null != request.getParameter("mainImageUrl") && request.getParameter("mainImageUrl").length()> 2 && !request.getParameter("mainImageUrl").equals(request.getParameter("originalMainImageUrl"))){
	    	//图片
	    	wechatJsApiUtil.writeImageToDisk(request.getParameter("mainImageUrl"),"hairstyle.img");
	    }
	    int rlt = 0;
	    if (hairstyle.getId() == null) {// 新增
		rlt = hairstyleService.save(hairstyle);
	    } else {
		rlt = hairstyleService.update(hairstyle);
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
    

}
