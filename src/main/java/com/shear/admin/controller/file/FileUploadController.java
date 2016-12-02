/**
 * FileUploadController.java
 */
package com.shear.admin.controller.file;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * 文件上传
 * 
 * @author brody
 * 
 */
@Controller
@RequestMapping("/fileupload")
public class FileUploadController {

	private static final Logger logger = Logger
			.getLogger(FileUploadController.class);

	@RequestMapping(value = "/single", method = RequestMethod.POST)
	@ResponseBody
	public String processSingleUpload(@RequestParam final MultipartFile mf) {
		String msg = "{\"success\":%b, \"filePath\":\"%s\", \"message\":\"%s\"}";
		String result = "";
		// String result = super.uploadSinglePicToCms(mfs,
		// Boolean.valueOf(iswater),0, trackerCmsGroup);
		logger.info("upload pic result" + result);

		return String.format(msg,true, "", "上传成功");
	}

	@RequestMapping(value = "/multi", method = RequestMethod.POST)
	@ResponseBody
	public String processMultiUpload(@RequestParam final MultipartFile mfs) {

		String msg = "{\"success\":%b, \"filePath\":\"%s\", \"message\":\"%s\"}";
		String result = "";
		// String result = super.uploadSinglePicToCms(mfs,
		// Boolean.valueOf(iswater),0, trackerCmsGroup);
		logger.info("upload pic result" + result);

		return String.format(msg,true, "", "上传成功");
	}
}
