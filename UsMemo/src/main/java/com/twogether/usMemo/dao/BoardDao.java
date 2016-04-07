package com.twogether.usMemo.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Card;
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
	
	public List<MemberGrade> getMemberGradeBymNum(int mNum){
		
		List<MemberGrade> list= new ArrayList<MemberGrade>();
		list=(List<MemberGrade>) sqlMapClientTemplate.queryForList("Board.getMemberGradeBymNum",mNum);
		
		return list;
		
	}
	
	public List<List> getListBybNum(int bNum){
		List<List> list= new ArrayList<List>();
		
		list=(List<List>) sqlMapClientTemplate.queryForList("List.getListByNum",bNum);
		return list;
	}
//	
//	public List<Card> getCardBybNum(int bNum){
//		List<Card> list= new ArrayList<Card>();
//		
//		list=(List<Card>) sqlMapClientTemplate.queryForList("Board.getCardByNum",bNum);
//		return list;
//	}


}
