package com.twogether.usMemo.service;

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

}
