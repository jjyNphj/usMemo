package com.twogether.usMemo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.service.ListService;

@RequestMapping("/list")
@Controller
public class ListController {
	@Autowired
	ListService listService;
	
	@RequestMapping("/add")
	public String addList(@ModelAttribute ListDTO listDTO){
		listService.addList(listDTO);
		
		return "/board/boardMain";
	}

}
