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
import com.quickshear.domain.Hairstyle;
import com.quickshear.domain.query.HairstyleQuery;
import com.quickshear.service.HairstyleService;
import com.shear.admin.base.controller.AbstractController;
import com.shear.admin.vo.HairstyleVo;

@Controller
@RequestMapping("/admin/hairstyle")
public class HairstyleController extends AbstractController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(HairstyleController.class);

	@Autowired
	private HairstyleService hairstyleService;

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
	public String add(@ModelAttribute("formBean") HairstyleVo hairstyleVo, Model model) {
		model.addAttribute("addOrEdit", "add");
		return "admin/hairstyle_edit";
	}

	@RequestMapping(value = "/edit")
	public String edit(@ModelAttribute("formBean") HairstyleVo hairstyleVo, Model model,
			@RequestParam Long id) {
		Hairstyle hairstyle = null;
		try {
			hairstyle = hairstyleService.findbyid(id);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		BeanCopier copier = BeanCopierUtil.copy(Hairstyle.class, HairstyleVo.class);
		copier.copy(hairstyle, hairstyleVo, null);
		model.addAttribute("addOrEdit", "edit");
		return "admin/hairstyle_edit";
	}

	@RequestMapping(value = "/view")
	public String view(@ModelAttribute("formBean") HairstyleVo hairstyleVo, Model model,
			@RequestParam Long id) {
		Hairstyle hairstyle = null;
		try {
			hairstyle = hairstyleService.findbyid(id);
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		BeanCopier copier = BeanCopierUtil.copy(Hairstyle.class, HairstyleVo.class);
		copier.copy(hairstyle, hairstyleVo, null);
		return "admin/hairstyle_view";
	}

	@RequestMapping(value = "/save")
	@ResponseBody
	public String save(@ModelAttribute("formBean") HairstyleVo hairstyleVo, Model model,
			@RequestParam Long id) {
		String success = "{\"success\": true}";
		try {
			Hairstyle hairstyle = new Hairstyle();
			BeanCopier copier = BeanCopierUtil.copy(HairstyleVo.class, Hairstyle.class);
			copier.copy(hairstyleVo, hairstyle, null);
			// 保存操作
			int rlt = 0;
			if (hairstyle.getId() == null) {// 新增
				hairstyle.setStatus(0);
				rlt = hairstyleService.save(hairstyle);
			} else {
				rlt = hairstyleService.update(hairstyle);
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
