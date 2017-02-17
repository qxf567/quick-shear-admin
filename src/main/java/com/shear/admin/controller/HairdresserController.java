package com.shear.admin.controller;

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

import com.quickshear.common.enumeration.HairdresserStatusEnum;
import com.quickshear.common.enumeration.RoleEnum;
import com.quickshear.common.util.BeanCopierUtil;
import com.quickshear.common.util.RetdCodeType;
import com.quickshear.common.vo.ResObj;
import com.quickshear.common.wechat.utils.WechatJsApiUtil;
import com.quickshear.domain.Hairdresser;
import com.quickshear.domain.Shop;
import com.quickshear.domain.User;
import com.quickshear.domain.query.HairdresserQuery;
import com.quickshear.domain.query.ShopQuery;
import com.quickshear.domain.query.UserQuery;
import com.quickshear.service.HairdresserService;
import com.quickshear.service.ShopService;
import com.quickshear.service.UserService;
import com.shear.admin.aop.annotation.Permission;
import com.shear.admin.controller.base.AbstractController;
import com.shear.admin.vo.HairdresserVo;

@Controller
@RequestMapping("/admin/hairdresser")
@Permission(roleTypes = { RoleEnum.ADMIN })
public class HairdresserController extends AbstractController {

    private static final Logger LOGGER = LoggerFactory
	    .getLogger(HairdresserController.class);

    @Autowired
    private UserService userService;
    @Autowired
    private HairdresserService hairdresserService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private WechatJsApiUtil wechatJsApiUtil;

    // 当前网页的URL，不包含参数部分
    private String url = "http://m.qiansishun.com/v1/admin/hairdresser";


    @RequestMapping(value = "/list")
    public String list(Model model) {
	HairdresserQuery query = new HairdresserQuery();
	List<Hairdresser> hairdresserList = null;
	query.setSort("shop_id");
	try {
	    hairdresserList = hairdresserService.selectByParam(query);
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}

	model.addAttribute("hairdresserList", hairdresserList);
	return "admin/hairdresser_list";
    }

    @RequestMapping(value = "/add")
    public String add(Model model) {
	HairdresserVo hairdresserVo = new HairdresserVo();
	hairdresserVo.setShopList(selectShops(null));
	wechatJsApiUtil.setWxJsApiToModel(model,url+"/add");
	model.addAttribute("hairdresser", hairdresserVo);
	model.addAttribute("addOrEdit", "add");
	return "admin/hairdresser_edit";
    }

    @RequestMapping(value = "/edit/{id}")
    public String edit(Model model, @PathVariable(value = "id") Long id) {
	Hairdresser hairdresser = null;
	try {
	    hairdresser = hairdresserService.findbyid(id);
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}
	HairdresserVo hairdresserVo = new HairdresserVo();
	if (hairdresser != null) {
	    BeanCopier copier = BeanCopierUtil.copy(Hairdresser.class,
		    HairdresserVo.class);
	    copier.copy(hairdresser, hairdresserVo, null);
	}
	hairdresserVo.setShopList(selectShops(null));
	wechatJsApiUtil.setWxJsApiToModel(model,url+"/edit/"+id);
	model.addAttribute("hairdresser", hairdresserVo);
	model.addAttribute("addOrEdit", "edit");
	return "admin/hairdresser_edit";
    }

    @RequestMapping(value = "/detail/{id}")
    public String view(Model model, @PathVariable(value = "id") Long id) {
	Hairdresser hairdresser = null;
	try {
	    hairdresser = hairdresserService.findbyid(id);
	} catch (Exception e) {
	    LOGGER.error(e.getMessage());
	}
	HairdresserVo hairdresserVo = new HairdresserVo();
	if (hairdresser != null) {
	    BeanCopier copier = BeanCopierUtil.copy(Hairdresser.class,
		    HairdresserVo.class);
	    copier.copy(hairdresser, hairdresserVo, null);
	}
	hairdresserVo.setStatusName(HairdresserStatusEnum.valueOfCode(hairdresser.getStatus()).getName());
	model.addAttribute("hairdresser", hairdresserVo);
	return "admin/hairdresser_detail";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public ResObj<String> save(HttpServletRequest request) {
	ResObj<String> resObj = new ResObj<String>();
	resObj.setCode(RetdCodeType.PASS_OK.getCode());
	resObj.getMessage().setMsg(RetdCodeType.PASS_OK.getMsg());
	try {
	    Hairdresser hairdresser = new Hairdresser();
	    if (null != request.getParameter("id")
		    && request.getParameter("id").length() != 0) {
		hairdresser.setId(Long.valueOf(request.getParameter("id")));
	    }
	    hairdresser.setName(request.getParameter("name"));
	    hairdresser.setPhoneNumber(request.getParameter("phoneNumber"));
	    Long shopId=Long.valueOf(request.getParameter("shopId"));
	    hairdresser.setShopId(shopId);
	    hairdresser.setShopName("");
        List<Shop> shops = selectShops(shopId);
        if(shops != null && shops.size()>0){
        	hairdresser.setShopName(shops.get(0).getName());
        }
	    hairdresser.setPhoto(request.getParameter("photo"));
	    hairdresser.setRestday("1|2");
	    hairdresser.setStatus(Integer.valueOf(request.getParameter("status")));
	    hairdresser.setCardFacePhoto("");
	    hairdresser.setCardBackPhoto("");
	    // 保存操作
	    if(null != request.getParameter("photo") && request.getParameter("photo").length()> 2 && !request.getParameter("photo").equals(request.getParameter("originalPhoto"))){
	    	//图片
	    	wechatJsApiUtil.writeImageToDisk(request.getParameter("photo"),"user.img"); 
	    }
	    int rlt = 0;
	    if (hairdresser.getId() == null) {// 新增
		rlt = hairdresserService.save(hairdresser);
	    } else {
		rlt = hairdresserService.update(hairdresser);
	    }
	    if (rlt < 0) {
		resObj.setCode(RetdCodeType.EX_APP.getCode());
		resObj.getMessage().setMsg(RetdCodeType.EX_APP.getMsg());
	    }
	    // 更新user表状态
	    if(hairdresser.getStatus().equals(HairdresserStatusEnum.VALID.getCode())){
	    	User user=new User();
		    user.setRoles(RoleEnum.STYLIST.getCode());
		    UserQuery queryUserObj = new UserQuery();
		    queryUserObj.setPhoneNumber(request.getParameter("phoneNumber"));
		    rlt = userService.update(user,queryUserObj);
	    }
	    if (rlt <= 0) {
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
    
	private List<Shop> selectShops(Long shopId) {
		ShopQuery queryObj = new ShopQuery();
		if(shopId != null){
			queryObj.setId(shopId);
		}
		queryObj.setStatus(1);
		try {
			return shopService.selectByParam(queryObj);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		return null;
	}
}
