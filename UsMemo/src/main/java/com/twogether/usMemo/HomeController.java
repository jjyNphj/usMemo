package com.twogether.usMemo;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Member;

/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {
	
//	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	Logger logger = LoggerFactory.getLogger(this.getClass());
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.debug("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	@RequestMapping("/index")
	public String index(){
		
		return "index";
	}
	@RequestMapping("/login")
	public String login(){
		
		return "/join/login";
	}
	
	@RequestMapping("/loginPro")
	public ModelAndView loginPro(@ModelAttribute Member member){
		
		ModelAndView mv=new ModelAndView();
		mv.addObject("checklogout", "Y");
		mv.setViewName("/join/loginPro");
		return mv;
		
//		logger.info("userEmail: {}", member.getEmail());
		
		/*
		 * 가져온 memeber의 id로 Dao에서 조회
		 * ->있으면 세션넣기
		 * ->없으면 insert 후 로그인 
		 *
		 */
		
	}
	
}
