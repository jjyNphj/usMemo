package com.twogether.usMemo.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Board;
import com.twogether.usMemo.dto.BoardInfo;
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
		/*1개 이상의 레코드(행)을 select해서 가져 오는 경우 queryForList을 사용. List로 받아야함. Map,list로 반환 가능*/
		list=(List<MemberGrade>) sqlMapClientTemplate.queryForList("Board.getMemberGradeBymNum",memId);
		
		return list;
		
	}
	
	public List<ListDTO> getListBybNum(int bNum){
		List<ListDTO> list= new ArrayList<ListDTO>();
		
		list=(List<ListDTO>) sqlMapClientTemplate.queryForList("List.getListBybNum",bNum);
		
		return list;
	}
	
//	public List<Card> getCardBylNum(List<Card> cardArray) {
//		for(Card card:cardArray){
//		List<Card> list = new ArrayList<Card>();
//		list=(List<Card>) sqlMapClientTemplate.queryForList("Card.getCardBylNum",card.getlNum());
//				}
//		return list;
//	}
	public List<ListAndCard> getCardBybNum(int bNum){
		//join 이용하기!
		List<ListAndCard> list= new ArrayList<ListAndCard>();
		
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
	
	/*board 삭제시 딸려있는 정보 찾아서 모두 삭제하는 부분*/
	public void deleteBoardBybNum(int bNum)	{
		sqlMapClientTemplate.delete("Board.deleteBoardBybNum", bNum);
	}
	
	public void deleteMemberGradeBybNum(int bNum) {
		sqlMapClientTemplate.delete("Board.deleteMemberGradeBybNum", bNum);
	}
	
	public void deleteListBybNum(int bNum) {
		sqlMapClientTemplate.delete("List.deleteListBybNum", bNum);
	}
	 
	public void deleteCardBybNum(int bNum) {
		sqlMapClientTemplate.delete("Card.deleteCardBybNum", bNum);
	}	
	
	//board와 memberGarde 데이터 추가 관련 부분
	public int addBoard(Board board, MemberGrade memberGrade) {
		int nowBNum=(Integer)sqlMapClientTemplate.insert("Board.addBoard", board);
		sqlMapClientTemplate.insert("Board.addMemberGradeBybNum", memberGrade);
		
		return nowBNum;
	}

	public List<BoardInfo> getAllBoards(String memId) {
		return sqlMapClientTemplate.queryForList("Board.getAllBoardsById",memId);
	}

	public void editBoardName(Board board) {
		
		sqlMapClientTemplate.update("Board.editBoardName",board);
		
	}

	public String getBoardName(int bNum) {
		return (String) sqlMapClientTemplate.queryForObject("Board.getBoardName",bNum);
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
