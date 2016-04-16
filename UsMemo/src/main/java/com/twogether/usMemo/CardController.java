package com.twogether.usMemo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.service.CardService;

@RequestMapping("/card")
@Controller
public class CardController {
	
	@Autowired
	CardService cardService;
	
	
	@RequestMapping("/add")
	public ModelAndView addCard(@ModelAttribute Card card){
		
		ModelAndView mv= new ModelAndView();
		mv.addObject("sucess","y");
		mv.setViewName("board/boardMain");
		cardService.addCard(card);
		return mv;
		
	}
}
