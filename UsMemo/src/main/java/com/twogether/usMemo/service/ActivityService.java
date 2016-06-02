package com.twogether.usMemo.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.ActivityDao;
import com.twogether.usMemo.dto.Activity;

@Service
public class ActivityService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired ActivityDao activityDao;
	
	
	public void create_board(String memId,int bNum){
		
		Activity requestInfo= new Activity();
		requestInfo.setMemId(memId);
		requestInfo.setbNum(bNum);
		activityDao.create_board(requestInfo);		
	}
	
	
}
