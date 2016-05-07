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
	
	/*public List<Card> getCardInfoBycNum(int cNum) {
		
		boardMain.jsp���� ������ cNum����  Card ���̺��� num�� ���� ���� ������ ã�� ���� ��������
		System.out.println("cNum��: " + cNum);
		
		List<Card> list = new ArrayList<Card>();
		list=(List<Card>) sqlMapClientTemplate.queryForList("Card.getCardInfoBycNum", cNum);
		
		System.out.println("Cardlist ��:" + list);
		
		return list;
				
	}*/
	public ListAndCard getCardInfoBycNum(int cNum) {
		ListAndCard listAndcard = new ListAndCard();
		
		/*1���� ���ڵ�(��)���� select�ؼ� ���� ���� ��� queryForList�� ���. Map,int,String���θ� ��ȯ ���� �� ����*/
		listAndcard = (ListAndCard) sqlMapClientTemplate.queryForObject("Card.getCardInfoBycNum", cNum);
		System.out.println("CardDao card= ��:" + listAndcard);
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
	
}
