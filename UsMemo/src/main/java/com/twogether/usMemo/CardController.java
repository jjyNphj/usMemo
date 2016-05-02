package com.twogether.usMemo;

import java.util.HashMap;
import java.util.List;

import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.service.CardService;

@RequestMapping("/card")
@Controller
public class CardController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
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
	
	@RequestMapping("/update/location")
	public String update(@RequestBody String cardLocation) throws ParseException{
		
		
		logger.info("check change location: {}",cardLocation.toString());
		cardService.updateLocation(cardLocation);
		return "/board/boardMain";
	}
	
	@RequestMapping("/edit")
	public ModelAndView editCardWindow(@RequestParam int lNum, @RequestParam int cNum){
		logger.info("check : Num{}, cNum{}" , lNum, cNum);
		
		HashMap<String, List> map=cardService.editCardWindow(lNum,cNum);
		
		ModelAndView mv= new ModelAndView();
		
		mv.addObject("sucess","y");
		mv.setViewName("board/boardMain");
		mv.addObject("cardInfo", map.get("cardInfo"));
		logger.info("check : Num{}, cNum{}" , lNum, cNum);
		//cardService.editCardWindow(lNum,cNum);
		return mv;
		
	}
}
