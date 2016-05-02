package com.twogether.usMemo.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.dto.MemberGrade;

@Repository
public class CardDao {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	public void addCard(Card card) {
		
		sqlMapClientTemplate.insert("Card.addCard", card);
	}
	
	public List<Card> getCardInfoBycNum(int cNum) {
		
		/*boardMain에서 가져온 cNum으로  Card 테이블의 num과 같은 행의 정보를 찾아 전부 가져오기*/
		 
		List<Card> list = new ArrayList<Card>();
		list=(List<Card>) sqlMapClientTemplate.queryForList("Card.getCardInfoBycNum", cNum);
		
		return list;
				
	}
	/*public Card getCardInfoBycNum(int cNum) {
		Card card = new Card();
		
		card = sqlMapClientTemplate.queryForList("Card.getCardInfoBycNum", cNum);
		
		return card;
		
	}*/

	public void update_rlink(Card card) {
		
		sqlMapClientTemplate.update("Card.update_rlink",card);
	}


	public void update_llink(Card card) {
		
		sqlMapClientTemplate.update("Card.update_llink",card);
		
	}
	
	public void update_allLink(Card card) {
		
		sqlMapClientTemplate.update("Card.update_allLink",card);
		
	}

	public void update_lNum(Card card) {
		sqlMapClientTemplate.update("Card.update_lNum",card);
		
	}
	
}
