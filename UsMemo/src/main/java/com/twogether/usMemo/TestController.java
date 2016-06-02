package com.twogether.usMemo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {
	@RequestMapping("/test/boardMain")
	public String boardViewTest(){

		return "/board/testListView";
	}
	@RequestMapping("/test/sortable")
	public String sortableTest(){

		return "/board/test/sortableTest";
	}
	@RequestMapping("/test/dropdown")
	public String dropDownTest(){
		return "/board/test/dropdown-ex";
	}
	
}
