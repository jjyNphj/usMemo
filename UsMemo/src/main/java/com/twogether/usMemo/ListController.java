package com.twogether.usMemo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.twogether.usMemo.dto.ListChange;
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
	
	@RequestMapping("/update")
	public String update(@RequestBody ListChange data){
		logger.info("check change location: first - {} second - {}",data.getFirst(),data.getSecond());
		return "/board/boardMain";
	}

}
