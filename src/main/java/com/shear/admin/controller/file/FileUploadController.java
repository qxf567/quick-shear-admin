/**
 * FileUploadController.java
 */
package com.shear.admin.controller.file;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.quickshear.common.fileupload.FileService;

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
	
	@Autowired
	private FileService fileService;
	

	@RequestMapping(value = "/single", method = RequestMethod.POST)
	@ResponseBody
	public String processSingleUpload(@RequestParam final MultipartFile mf,String folderName) {
		
		String result = fileService.uploadSinglePic(mf, false,folderName);
		logger.info("upload pic result" + result);
		return result;
	}

	@RequestMapping(value = "/multi", method = RequestMethod.POST)
	@ResponseBody
	public String processMultiUpload(@RequestParam final MultipartFile[] mfs,String folderName) {

		String result = fileService.uploadSinglePic(mfs[0], false,folderName);
		logger.info("upload pic result" + result);
		return result;
	}
}
