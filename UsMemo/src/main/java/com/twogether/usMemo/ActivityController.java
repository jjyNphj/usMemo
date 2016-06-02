package com.twogether.usMemo;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.twogether.usMemo.dto.Activity;
import com.twogether.usMemo.service.ActivityService;

@RequestMapping("/activity")
@Controller
public class ActivityController {

	@Autowired ActivityService activityService;
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping("/getAllActivity/{bNum}")
	public void getAllActivity(@PathVariable("bNum") int bNum){
		List<Activity> activity=new ArrayList<Activity>();
			//	activity=activityService.getAllActivity(bNum);
				
	}
}
