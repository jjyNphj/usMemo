package com.twogether.usMemo;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.twogether.usMemo.dto.Activity;
import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.service.ActivityService;

@RequestMapping("/activity")
@Controller
public class ActivityController {

	@Autowired ActivityService activityService;
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping("/getAllActivity/{bNum}")
	@ResponseBody
	public List<Activity> getAllActivity(@PathVariable("bNum") int bNum){
		List<Activity> activity=new ArrayList<Activity>();
				activity=activityService.getAllActivity(bNum);
			return activity;	
	}
	
	@RequestMapping("/getListInfo/{listNum}")
	@ResponseBody
	public ListDTO getListInfo(@PathVariable("listNum") int listNum){
		
		ListDTO result = new ListDTO();
		result=activityService.getListInfo(listNum);
		return result; 
	}
}
