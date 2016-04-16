package com.twogether.usMemo.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.CardDao;
import com.twogether.usMemo.dto.Card;

@Service
public class CardService {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	CardDao cardDao;

	public void addCard(Card card){
		
		cardDao.addCard(card);
		
	}

	
	
	
}
