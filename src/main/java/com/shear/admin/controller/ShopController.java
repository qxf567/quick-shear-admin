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
import com.quickshear.domain.Shop;
import com.quickshear.domain.query.ShopQuery;
import com.quickshear.service.ShopService;
import com.shear.admin.base.controller.AbstractController;
import com.shear.admin.vo.ShopVo;

@Controller
@RequestMapping("/shear/amin/shop")
public class ShopController extends AbstractController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(ShopController.class);

	@Autowired
	private ShopService shopService;

	@RequestMapping(value = "/list")
	public String list(Model model) {
		ShopQuery query = new ShopQuery();
		List<Shop> shopList = null;
		try {
			shopList = shopService.selectByParam(query);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}

		model.addAttribute("shopList", shopList);
		return "admin/shop_list";
	}

	@RequestMapping(value = "/add")
	public String add(@ModelAttribute("formBean") ShopVo shopVo, Model model) {
		model.addAttribute("addOrEdit", "add");
		return "admin/shop_edit";
	}

	@RequestMapping(value = "/edit")
	public String edit(@ModelAttribute("formBean") ShopVo shopVo, Model model,
			@RequestParam Long id) {
		Shop shop = null;
		try {
			shop = shopService.findbyid(id);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		BeanCopier copier = BeanCopierUtil.copy(Shop.class, ShopVo.class);
		copier.copy(shop, shopVo, null);
		model.addAttribute("addOrEdit", "edit");
		return "admin/shop_edit";
	}

	@RequestMapping(value = "/view")
	public String view(@ModelAttribute("formBean") ShopVo shopVo, Model model,
			@RequestParam Long id) {
		Shop shop = null;
		try {
			shop = shopService.findbyid(id);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		BeanCopier copier = BeanCopierUtil.copy(Shop.class, ShopVo.class);
		copier.copy(shop, shopVo, null);
		return "admin/shop_view";
	}

	@RequestMapping(value = "/save")
	@ResponseBody
	public String save(@ModelAttribute("formBean") ShopVo shopVo, Model model,
			@RequestParam Long id) {
		String success = "{\"success\": true}";
		try {
			Shop shop = new Shop();
			BeanCopier copier = BeanCopierUtil.copy(ShopVo.class, Shop.class);
			copier.copy(shopVo, shop, null);
			// 保存操作
			int rlt = 0;
			if (shop.getId() == null) {// 新增
				shop.setStatus(0);
				rlt = shopService.save(shop);
			} else {
				rlt = shopService.update(shop);
			}

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
