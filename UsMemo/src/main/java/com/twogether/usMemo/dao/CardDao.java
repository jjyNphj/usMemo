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
		
		/*1���� ���ڵ�(��)���� select�ؼ� ���� ���� ��� queryForList�� ���. Map,int,String���θ� ��ȯ ���� �� ����*/
		/*cardInfoView���� ������ cNum����  ListAndCard ���̺��� C.num�� �����鼭 card�� lnum�� list�� num�� ���� ���� ������ ã�� ���� ��������*/
		listAndcard = (ListAndCard) sqlMapClientTemplate.queryForObject("Card.getCardInfoBycNum", cNum);
		//System.out.println("CardDao card= ��:" + listAndcard);
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
	
	//CardService���� �Ѱ��� saveFileName�� attach�� ����.(DTO�� �ִ� �̸����� �����ַ���)
	public void fileUploadName(Card card) {	
		sqlMapClientTemplate.update("Card.fileUploadName", card);
	}
	
}
