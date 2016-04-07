package com.twogether.usMemo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.twogether.usMemo.dao.BoardDao;
import com.twogether.usMemo.dto.Board;
import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.MemberGrade;


@Component
public class BoardService {
	
	@Autowired
	BoardDao boardDao;
	
	public List<Board> myBoardList(int mNum){
		//로그인 후 보이는 회원의 보드목록
		/*
		 * 1) 회원번호를 memberGrade로 가서 그 사람의 모든 boardNum가지고오기
		 * 2) 모든 boardNum으로 board 테이블에서 이름과 boardNum을 가지고오기
		 * 3) 뷰에서 해당 board이름 적어주기 
		 * 
		 */
		/*
		 * 회원번호-> 회원등급-> 보드번호리스트가져오기-> 각각의 보드 이름 가져오기-> 완료
		 */
		
		List<MemberGrade> list = new ArrayList<MemberGrade>();
		
		list=boardDao.getMemberGradeBymNum(mNum);
		
		List<Board> resultList=new ArrayList<Board>();
		
		for(MemberGrade i:list){
			Board resultBoard=new Board();
			
			resultBoard.setbNum(i.getbNum());
			resultBoard.setName(boardDao.getBoardNameBybNum(i.getbNum()));
			
			System.out.println("보드: "+resultBoard.getName());
			
			resultList.add(resultBoard);
			
		}
		
		return resultList;
		
		
	}
	
	public List<List> getList(Board board){
		/*
		 * 선택된 보드의 bNum으로 해당 보드의 리스트정보를 가지고 오기
		 * 가져온 리스트의 num으로 각각의 card리스트를 불러옴
		 * 
		 */
		List<List> list = new ArrayList<List>();
		list=boardDao.getListBybNum(board.getbNum());
						
		return list;
		
	}
	public List<Card> getCard(Board board){
		/*
		 * 선택된 리스트의 lNum으로 해당 리스트의 카드 정보를 가지고 오기
		 */
		List<Card> list = new ArrayList<Card>();
//		list=boardDao.getCardBybNum(boardDao.getListNum());
		
		return list;
	}
	
}
