package com.twogether.usMemo;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.twogether.usMemo.dto.Activity;
import com.twogether.usMemo.dto.ActivityData;
import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.dto.Member;
import com.twogether.usMemo.dto.MemberGrade;
import com.twogether.usMemo.service.ActivityService;

@RequestMapping("/activity")
@Controller
public class ActivityController {

	@Autowired ActivityService activityService;
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping("/getSomeActivity/{bNum}")
	@ResponseBody
	public List<Activity> getSomeActivity(@PathVariable("bNum") int bNum){
		List<Activity> activity=new ArrayList<Activity>();
				activity=activityService.getSomeActivity(bNum);
			return activity;	
	}
	@RequestMapping("/getAllActivity/{bNum}")
	@ResponseBody
	public List<Activity> getAllActivity(@PathVariable("bNum") int bNum){
		List<Activity> activity=new ArrayList<Activity>();
				activity=activityService.getAllActivity(bNum);
			return activity;	
	}
	
/*	@RequestMapping("/getListInfo/{listNum}")
	@ResponseBody
	public ListDTO getListInfo(@PathVariable("listNum") int listNum){
		
		ListDTO result = new ListDTO();
		result=activityService.getListInfo(listNum);
		return result; 
	}
	
	@RequestMapping("/getCardInfo/{cardNum}")
	@ResponseBody
	public Card getCardInfo(@PathVariable("cardNum") int cardNum){
		
		Card result = new Card();
		result=activityService.getCardInfo(cardNum);
		return result; 
	}
	
	@RequestMapping("/getFriendInfo/{bNum}/{memId}")
	@ResponseBody
	public Member getFriendInfo(@ModelAttribute MemberGrade memberInfo){
		Member result = new Member();
		result = activityService.getFriendInfo(memberInfo);
		return result; 
	}*/
	
	
}
