package com.twogether.usMemo;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Member;
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
		//logger.info("memberInfo: bNum-> {}, memId-> {}", memberInfo.getbNum(),memberInfo.getmemId());
		ModelAndView mv= new ModelAndView();
		mv.addObject("memberList", memberService.getMemberList(memberInfo));
		mv.addObject("bNum",memberInfo.getbNum());
		mv.setViewName("/board/menu");
		
		return mv;
	}
	
	@RequestMapping("/friend/find/{memberFindInfo}")
	public @ResponseBody List<Member> friendFind(@PathVariable("memberFindInfo") String memberFindInfo){
		//{memberFindInfo}�� pathVariable�� �޾Ƽ� ���
		logger.info("memberFindInfo: -> {}",memberFindInfo);
		List<Member> friendList=memberService.friendFind(memberFindInfo);
		//logger.info("memberFindInfoName: -> {}",friendList.get(0).getName());
		
		return friendList;
	}
	
	/**
	 * ģ���߰�
	 */
	@RequestMapping("/friend/add")
	public String addFriend(@ModelAttribute MemberGrade addMemberInfo){
		
		memberService.addFriend(addMemberInfo);
		
		return "/board/menu";
	}


}
