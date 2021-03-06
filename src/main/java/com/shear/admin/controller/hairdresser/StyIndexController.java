package com.shear.admin.controller.hairdresser;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shear.admin.controller.base.AbstractController;

@Controller
@RequestMapping("/stylist")
public class StyIndexController extends AbstractController {
	
    private static final Logger LOGGER = LoggerFactory.getLogger(StyIndexController.class);

	@RequestMapping(value = "/index")
	public String index(Model model) {
		
		return "stylist/index";
	}
 }
