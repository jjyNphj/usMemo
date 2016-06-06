package com.twogether.usMemo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.ListAndCard;

@Repository
public class CardDao {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	public void addCard(Card card) {
	
		sqlMapClientTemplate.insert("Card.addCard", card);
	}
	
	public void addCardContent(Card card) {
		
		sqlMapClientTemplate.update("Card.addCardContent", card);
	}
	
	public void editCardName(Card card) {
		
		sqlMapClientTemplate.update("Card.editCardName", card);
		System.out.println("CardDao card name: " + card.getName());
	}
	
	public void deleteCardInfo(Card card) {
		
		sqlMapClientTemplate.delete("Card.deleteCardInfo", card);
	}
	
	public ListAndCard getCardInfoBycNum(int cNum) {

		ListAndCard listAndcard = new ListAndCard();
		
		/*1개의 레코드(행)만을 select해서 가져 오는 경우 queryForList을 사용. Map,int,String으로만 반환 받을 수 있음*/
		/*cardInfoView에서 가져온 cNum으로  ListAndCard 테이블의 C.num과 같으면서 card의 lnum과 list의 num과 같은 행의 정보를 찾아 전부 가져오기*/
		listAndcard = (ListAndCard) sqlMapClientTemplate.queryForObject("Card.getCardInfoBycNum", cNum);
		//System.out.println("CardDao card= 명세:" + listAndcard);
		return listAndcard;
		
	}

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
	
	//CardService에서 넘겨줌 saveFileName를 attach로 받음.(DTO에 있는 이름으로 맞춰주려고)
	public void fileUploadName(Card card) {	
		sqlMapClientTemplate.update("Card.fileUploadName", card);
	}
	
}
