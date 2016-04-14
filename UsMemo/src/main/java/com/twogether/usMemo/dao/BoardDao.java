package com.twogether.usMemo.dao;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.ListAndCard;
import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.dto.MemberGrade;

@Repository
public class BoardDao {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	
	public String getBoardNameBybNum(int bNum){
		
		String bName;
		bName=(String) sqlMapClientTemplate.queryForObject("Board.getBoardNameBybNum",bNum);
		
		return bName;
		
	}
	
	public List<MemberGrade> getMemberGradeBymNum(String memId){
		
		List<MemberGrade> list= new ArrayList<MemberGrade>();
		list=(List<MemberGrade>) sqlMapClientTemplate.queryForList("Board.getMemberGradeBymNum",memId);
		
		return list;
		
	}
	
	public List<ListDTO> getListBybNum(int bNum){
		List<ListDTO> list= new LinkedList<ListDTO>();
		
		list=(List<ListDTO>) sqlMapClientTemplate.queryForList("List.getListByNum",bNum);
		return list;
	}
	
	public List<ListAndCard> getCardBybNum(int bNum){
		//join 이용하기!
		List<ListAndCard> list= new LinkedList<ListAndCard>();
		
		list=(List<ListAndCard>) sqlMapClientTemplate.queryForList("Card.getCardBybNum",bNum);
		return list;
	}
	
/*	public List<ListDTO> getListAndCardBybNum(int bNum){
		//리스트와 카드 가지고 오기 
		//join 이용하기!
		List<ListDTO> list= new ArrayList<ListDTO>();
		
		list=(List<ListDTO>) sqlMapClientTemplate.queryForList("List.getListAndCardBybNum",bNum);
		return list;
	}*/

	public void addBoard(String name, MemberGrade memberGrade) {
		sqlMapClientTemplate.insert("Board.addBoard", name);
		sqlMapClientTemplate.insert("Board.addMemberGradeBybNum", memberGrade);
		
	}

	
//	public int getBoardNumById(String id){
//		//회원 id로 보드의 bNum 구하기
//		int count = (Integer) sqlMapClientTemplate.queryForObject("Board.getBoardNumById",id);
//		
//		return count ;
//	}
	

//	
//	public List<Card> getCardBybNum(int bNum){
//		List<Card> list= new ArrayList<Card>();
//		
//		list=(List<Card>) sqlMapClientTemplate.queryForList("Board.getCardByNum",bNum);
//		return list;
//	}


}
