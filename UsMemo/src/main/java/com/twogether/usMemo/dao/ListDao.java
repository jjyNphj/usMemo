package com.twogether.usMemo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.ListDTO;

@Repository
public class ListDao {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	
	public void addList(ListDTO listDTO){
		sqlMapClientTemplate.insert("List.addList",listDTO);
		
	}
}