package com.twogether.usMemo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.MemberGrade;
import com.twogether.usMemo.service.MemberService;

@RequestMapping("/member")
@Controller
public class MemberController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	@Autowired
	MemberService memberService;
	
	
	@RequestMapping("/friend/index")
	public ModelAndView friendIndex(@ModelAttribute MemberGrade memberInfo){
		logger.info("memberInfo: bNum-> {}, memId-> {}", memberInfo.getbNum(),memberInfo.getmemId());
		ModelAndView mv= new ModelAndView();
		mv.addObject("memberList", memberService.getMemberList(memberInfo));
		mv.setViewName("/board/menu");
		
		return mv;
	}


}
