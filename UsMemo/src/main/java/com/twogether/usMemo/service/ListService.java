package com.twogether.usMemo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.ListDao;
import com.twogether.usMemo.dto.ListDTO;

@Service
public class ListService {
	@Autowired
	ListDao listDao;
	
	public void addList(ListDTO listDTO){
		
		listDao.addList(listDTO);
	}

	public void updateLocation(List<Map<String, Object>> listLocation) {
		/*
		 * 1) 일단 파싱
		 * 2) 두 list row의 location 바꾸기 
		 */
		
		for(Map<String,Object> l: listLocation){
		ListDTO listDto = new ListDTO();
		listDto.setNum(Integer.parseInt((String)l.get("num")));
		//listDto.setLocation((Integer) l.get("location"));
		listDao.updateLocation(listDto);//바꾸기
		}
		
				
		
	}

}
