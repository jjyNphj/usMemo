package com.twogether.usMemo.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Activity;

@Repository
public class ActivityDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired SqlMapClientTemplate sqlMapClientTemplate;

	public void create_board(Activity requestInfo) {
		sqlMapClientTemplate.insert("Activity.createBoard",requestInfo);
		
	}
	
	
}
