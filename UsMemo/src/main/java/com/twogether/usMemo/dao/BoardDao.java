package com.twogether.usMemo.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Board;
import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.Member;
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
	
	public List<MemberGrade> getMemberGradeBymNum(int memId){
		
		List<MemberGrade> list= new ArrayList<MemberGrade>();
		list=(List<MemberGrade>) sqlMapClientTemplate.queryForList("Board.getMemberGradeBymNum",memId);
		
		return list;
		
	}
	
	public List<List> getListBybNum(int bNum){
		List<List> list= new ArrayList<List>();
		
		list=(List<List>) sqlMapClientTemplate.queryForList("List.getListByNum",bNum);
		return list;
	}
	
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
