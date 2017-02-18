package com.shear.admin.controller.hairdresser;

import com.quickshear.common.enumeration.HairdresserStatusEnum;
import com.quickshear.common.enumeration.RoleEnum;
import com.quickshear.common.util.BeanCopierUtil;
import com.quickshear.common.util.RetdCodeType;
import com.quickshear.common.vo.ResObj;
import com.quickshear.common.wechat.utils.WechatJsApiUtil;
import com.quickshear.domain.Hairdresser;
import com.quickshear.domain.Shop;
import com.quickshear.domain.query.ShopQuery;
import com.quickshear.service.HairdresserService;
import com.quickshear.service.ShopService;
import com.quickshear.service.sms.StorageService;
import com.shear.admin.aop.annotation.Permission;
import com.shear.admin.controller.base.AbstractController;
import com.shear.admin.vo.HairdresserVo;
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

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by denglongshan on 2017/2/18.
 */
@Controller
@RequestMapping("/stylist/hairdresser")
@Permission(roleTypes = { RoleEnum.STYLIST })
public class StyHairdresserController extends AbstractController {

    private static final Logger LOGGER = LoggerFactory
            .getLogger(StyHairdresserController.class);

    @Autowired
    private HairdresserService hairdresserService;
    @Autowired
    private ShopService shopService;
    @Autowired
    private StorageService storageService;
    @Autowired
    private WechatJsApiUtil wechatJsApiUtil;

    // 当前网页的URL，不包含参数部分
    private String url = "http://m.qiansishun.com/v1/stylist/hairdresser";

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
        return "stylist/hairdresser_edit";
    }

    @RequestMapping(value = "/detail")
    public String view(Model model,HttpServletRequest request) {
        String cookie_openid = storageService.get(request, "openid");
        String cookie_hairdresserid = storageService.get(request, "hairdresserid");
        if (cookie_hairdresserid == null) {//取不到cookie，跳转到登录页
            return "admin/login/"+cookie_openid;
        }
        Hairdresser hairdresser = null;
        try {
            hairdresser = hairdresserService.findbyid(Long.valueOf(cookie_hairdresserid));
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
        return "stylist/hairdresser_detail";
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
            Long shopId=Long.valueOf(request.getParameter("shopId"));
            hairdresser.setShopId(shopId);
            hairdresser.setShopName("");
            List<Shop> shops = selectShops(shopId);
            if(shops != null && shops.size()>0){
                hairdresser.setShopName(shops.get(0).getName());
            }
            hairdresser.setPhoto(request.getParameter("photo"));
            hairdresser.setRestday("1|2");
            hairdresser.setCardFacePhoto("");
            hairdresser.setCardBackPhoto("");
            // 保存操作
            if(null != request.getParameter("photo") && request.getParameter("photo").length()> 2 && !request.getParameter("photo").equals(request.getParameter("originalPhoto"))){
                //图片
                wechatJsApiUtil.writeImageToDisk(request.getParameter("photo"),"user.img");
            }
            int rlt = hairdresserService.update(hairdresser);
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
