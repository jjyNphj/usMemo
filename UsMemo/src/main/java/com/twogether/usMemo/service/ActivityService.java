package com.twogether.usMemo.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.ActivityDao;
import com.twogether.usMemo.dto.Activity;
import com.twogether.usMemo.dto.ListDTO;

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


	public List<Activity> getAllActivity(int bNum) {
		Activity activity= new Activity();
		activity.setbNum(bNum);
		
		List<Activity> result= activityDao.getAllActivity(activity);
		return result;
	}


	public void addList(ListDTO listDTO,String memId) {
		Activity requestInfo= new Activity();
		requestInfo.setMemId(memId);
		requestInfo.setbNum(listDTO.getbNum());
		requestInfo.setValue_num(listDTO.getNum());
		
		activityDao.addList(requestInfo);
	}


	public ListDTO getListInfo(int listNum) {
		
	return activityDao.getListInfo(listNum);
	}
	
	
}
