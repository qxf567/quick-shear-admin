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
import com.quickshear.domain.Hairdresser;
import com.quickshear.domain.Shop;
import com.quickshear.domain.query.HairdresserQuery;
import com.quickshear.service.HairdresserService;
import com.quickshear.service.ShopService;
import com.shear.admin.base.controller.AbstractController;
import com.shear.admin.vo.HairdresserVo;

@Controller
@RequestMapping("/shear/admin/hairdresser")
public class HairdresserController extends AbstractController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(HairdresserController.class);

	@Autowired
	private HairdresserService hairdresserService;
	@Autowired
	private ShopService shopService;

	@RequestMapping(value = "/list")
	public String list(Model model) {
		HairdresserQuery query = new HairdresserQuery();
		List<Hairdresser> hairdresserList = null;
		query.setSort( "shop_id");
		try {
			hairdresserList = hairdresserService.selectByParam(query);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}

		model.addAttribute("hairdresserList", hairdresserList);
		return "admin/hairdresser_list";
	}

	@RequestMapping(value = "/add")
	public String add(@ModelAttribute("formBean") HairdresserVo hairdresserVo, Model model) {
		model.addAttribute("addOrEdit", "add");
		return "admin/hairdresser_edit";
	}

	@RequestMapping(value = "/edit")
	public String edit(@ModelAttribute("formBean") HairdresserVo hairdresserVo, Model model,
			@RequestParam Long id) {
		Hairdresser hairdresser = null;
		try {
			hairdresser = hairdresserService.findbyid(id);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		BeanCopier copier = BeanCopierUtil.copy(Hairdresser.class, HairdresserVo.class);
		copier.copy(hairdresser, hairdresserVo, null);
		model.addAttribute("addOrEdit", "edit");
		return "admin/hairdresser_edit";
	}

	@RequestMapping(value = "/view")
	public String view(@ModelAttribute("formBean") HairdresserVo hairdresserVo, Model model,
			@RequestParam Long id) {
		Hairdresser hairdresser = null;
		try {
			hairdresser = hairdresserService.findbyid(id);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		BeanCopier copier = BeanCopierUtil.copy(Hairdresser.class, HairdresserVo.class);
		copier.copy(hairdresser, hairdresserVo, null);
		return "admin/hairdresser_view";
	}

	@RequestMapping(value = "/save")
	@ResponseBody
	public String save(@ModelAttribute("formBean") HairdresserVo hairdresserVo, Model model,
			@RequestParam Long id) {
		String success = "{\"success\": true}";
		try {
			Hairdresser hairdresser = new Hairdresser();
			BeanCopier copier = BeanCopierUtil.copy(HairdresserVo.class, Hairdresser.class);
			copier.copy(hairdresserVo, hairdresser, null);
			// 保存操作
			int rlt = 0;
			if (hairdresser.getId() == null) {// 新增
				hairdresser.setStatus(0);
				rlt = hairdresserService.save(hairdresser);
			} else {
				rlt = hairdresserService.update(hairdresser);
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
