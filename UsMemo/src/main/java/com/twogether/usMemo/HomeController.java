package com.twogether.usMemo;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Member;
import com.twogether.usMemo.service.MemberService;

/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {
	@Autowired
	MemberService memberService;
	
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
		return "join/login";
	}
	@RequestMapping("/loginPro")
	public ModelAndView loginPro(@ModelAttribute Member member,HttpSession session) throws SQLException{
		
		ModelAndView mv=new ModelAndView();
		
		memberService.loginMember(member,session);
/*		
		mv.addObject("memberInfo", member);*/
		mv.setViewName("join/loginPro");
		return mv;	
	}
	@RequestMapping("/index.do")
	public String logout(HttpSession session){
		session.invalidate();
		return "index";
	}
	
}
