package com.twogether.usMemo;

import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.service.ActivityService;
import com.twogether.usMemo.service.ListService;

@RequestMapping("/list")
@Controller
public class ListController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	ListService listService;
	@Autowired ActivityService activityService;
	
	@RequestMapping("/add/{memId}")
	public String addList(@ModelAttribute ListDTO listDTO,@PathVariable("memId") String memId){
		listService.addList(listDTO);
		activityService.addList(listDTO,memId);
		return "/board/boardMain";
	}
	
	@RequestMapping("/update/location")
	public String update(@RequestBody String listLocation) throws ParseException{
		
		
		logger.info("check change location: {}",listLocation.toString());
		listService.updateLocation(listLocation);
		return "/board/boardMain";
	}
	
	@RequestMapping("/delete/ListInfo/{bNum}/{memId}/{num}")
	public ModelAndView deleteListInfo(@PathVariable("bNum") int bNum,@PathVariable("memId") String memId, @PathVariable("num") int num){
		
		//리스트 삭제 버튼 누르고 삭제하는 부분
		ModelAndView mv= new ModelAndView();
		ListDTO listDTO= new ListDTO();
		listDTO.setNum(num);
		listDTO.setbNum(bNum);
		
		mv.setViewName("board/boardMain");
		activityService.deleteList(listDTO,memId);
		listService.deleteListInfo(listDTO);
		return mv;
	}
	
	@RequestMapping("/edit/listName")
	public ModelAndView editListName(@ModelAttribute ListDTO list){
		
		//카드 수정하기 창에서 카드 이름을 수정하고 엔터를 칠 경우 저장하는 부분
		ModelAndView mv= new ModelAndView();

		mv.setViewName("board/boardMain");
		listService.editListName(list);
		activityService.updateActivity("changeListName",list.getNum());
		return mv;
	}

}
