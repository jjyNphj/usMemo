package com.twogether.usMemo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Card;

@Repository
public class CardDao {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	public void addCard(Card card) {
		
		sqlMapClientTemplate.insert("Card.addCard", card);
	}

	
}
