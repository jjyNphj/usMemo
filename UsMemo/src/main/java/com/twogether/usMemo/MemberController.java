package com.twogether.usMemo;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Member;
import com.twogether.usMemo.dto.MemberGrade;
import com.twogether.usMemo.service.ActivityService;
import com.twogether.usMemo.service.MemberService;

@RequestMapping("/member")
@Controller
public class MemberController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	@Autowired
	MemberService memberService;
	@Autowired ActivityService activityService;
	
	@RequestMapping("/friend/index")
	public @ResponseBody List<Member> friendIndex(@RequestBody MemberGrade memberInfo){
		//logger.info("memberInfo: bNum-> {}, memId-> {}", memberInfo.getbNum(),memberInfo.getmemId());
	/*	ModelAndView mv= new ModelAndView();
		
		mv.addObject("memberList", memberService.getMemberList(memberInfo));
		mv.addObject("bNum",memberInfo.getbNum());
		mv.setViewName("/board/menu");
		
		return mv;*/
		List<Member> resultMemberList=new ArrayList<Member>();
		resultMemberList=memberService.getMemberList(memberInfo);
		
		return resultMemberList;
	}
	
	@RequestMapping("/friend/find/{memberFindInfo}/{bNum}")
	public @ResponseBody List<Member> friendFind(@PathVariable("memberFindInfo") String memberFindInfo,@PathVariable("bNum") int bNum){
		//{memberFindInfo}를 pathVariable로 받아서 사용
		logger.info("memberFindInfo: -> {}",memberFindInfo);
		List<Member> friendList=memberService.friendFind(memberFindInfo,bNum);
		//logger.info("memberFindInfoName: -> {}",friendList.get(0).getName());
		
		return friendList;
	}
	
	/**
	 * 친구추가
	 */
	@RequestMapping("/friend/add/{request_memId}")
	public String addFriend(@ModelAttribute MemberGrade addMemberInfo, @PathVariable("request_memId") String request_memId){
		
		memberService.addFriend(addMemberInfo);
		//addMemberInfo 를 반환받아서 가지고오지 않아도 이 객체에는 selectKey로 받은 값이 저장되어있음. 
		//그러니 현재 addMemberInfo를 activity로 가지고가면됨.
		activityService.addFriend(addMemberInfo,request_memId);
		return "/board/menu";
	}
	
	@RequestMapping("/friend/delete")
	public String deleteFriend(@ModelAttribute MemberGrade member){
		memberService.deleteFriend(member);
		
		return "/board/menu";
	}
	
	@RequestMapping("/friend/update")
	public String updateFriend(@ModelAttribute MemberGrade member){
		memberService.updateFriend(member);
		return "/board/menu";
	}
	
	@RequestMapping("/updateStar")
	public String updateStar(@ModelAttribute MemberGrade boardInfo){
		
		memberService.updateStar(boardInfo);
	
		return "board/boardMain";
	}


}
