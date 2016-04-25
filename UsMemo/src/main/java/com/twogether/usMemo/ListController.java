package com.twogether.usMemo;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.service.ListService;

@RequestMapping("/list")
@Controller
public class ListController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	ListService listService;
	
	@RequestMapping("/add")
	public String addList(@ModelAttribute ListDTO listDTO){
		listService.addList(listDTO);
		
		return "/board/boardMain";
	}
	
	@RequestMapping("/update/location")
	public String update(@RequestBody String listLocation) throws ParseException{
		
		
		logger.info("check change location: {}",listLocation.toString());
		listService.updateLocation(listLocation);
		return "/board/boardMain";
	}

}
