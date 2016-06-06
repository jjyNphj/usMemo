package com.twogether.usMemo.dao;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Activity;
import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.ListDTO;

@Repository
public class ActivityDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired SqlMapClientTemplate sqlMapClientTemplate;

	public void create_board(Activity requestInfo) {
		sqlMapClientTemplate.insert("Activity.createBoard",requestInfo);
		
	}

	public List<Activity> getAllActivity(Activity activity) {
		return sqlMapClientTemplate.queryForList("Activity.getAllActivity",activity.getbNum());
	}

	public void addList(Activity requestInfo) {
		sqlMapClientTemplate.insert("Activity.addList",requestInfo);
	}

	public ListDTO getListInfo(int num) {
		// TODO Auto-generated method stub
		return (ListDTO) sqlMapClientTemplate.queryForObject("List.getListByLNum",num);
	}

	public void addCard(Activity requestInfo) {
		
		sqlMapClientTemplate.insert("Activity.addCard",requestInfo);
		
	}

	public Card getCardInfo(int cardNum) {
		// TODO Auto-generated method stub
		return (Card) sqlMapClientTemplate.queryForObject("Card.getCardBycNum",cardNum);
	}
	
	
}
