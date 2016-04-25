package com.twogether.usMemo.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.BoardDao;
import com.twogether.usMemo.dto.Board;
import com.twogether.usMemo.dto.ListAndCard;
import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.dto.MemberGrade;


@Service
public class BoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	BoardDao boardDao;
	
	public List<Board> myBoardList(String memId){
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
		
		list=boardDao.getMemberGradeBymNum(memId);
		
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
	
	public HashMap<String, List> getListAndCard(Board board){
		/*
		 * 리스트->lNum으로 card 정보조회 ->Map으로 넘기기 
		 * 
		 */
		
		HashMap<String, List> mapList = new HashMap<String, List>();
		
		List<ListDTO> listArray = boardDao.getListBybNum(board.getbNum());
		//sorting하기
		listArray=sortingLinkedList(listArray);
		mapList.put("listList", listArray);
		
//		List<ListAndCard> cardList=boardDao.getCardBybNum(board.getbNum());
//		mapList.put("cardList", cardList);
//		
		return mapList;
		
	}
	public List<ListDTO> sortingLinkedList(List<ListDTO> list){
		
		List<ListDTO> result=new ArrayList<ListDTO>();
		
		ListIterator<ListDTO> it= list.listIterator();
		
		while(it.hasNext()){
			ListDTO listDto = it.next();
			if(listDto.getLlink()==-1){
				result.add(listDto);
				it.remove();
				break;
			}
		}
		
		while(list.size()!=0){
		for(Iterator<ListDTO> itt = list.iterator() ; itt.hasNext() ;){
			
			ListDTO dto=itt.next();
			if(result.get(result.size()-1).getRlink()==dto.getNum()){
				result.add(dto);
				itt.remove();
			}
		}
		}
/*		
		ListIterator<ListDTO> it2= list.listIterator();
		while(list.size()!=0){
			while(it2.hasNext()){
				it2= list.listIterator();
				ListDTO listDto = it2.next();
				
				if(result.get(result.size()-1).getRlink()==listDto.getNum()){
				result.add(listDto);
				it2.remove();
				}
			}
		}*/
		return result;
	}
/*	public List<List> getList(Board board){
		
		 * 선택된 보드의 bNum으로 해당 보드의 리스트정보를 가지고 오기
		 * 가져온 리스트의 num으로 각각의 card리스트를 불러옴
		 * 
		 
		List<List> list = new LinkedList<List>();
		list=boardDao.getListBybNum(board.getbNum());
						
		return list;	
	}
	public List<Card> getCard(Board board){
		
		 * 선택된 리스트의 lNum으로 해당 리스트의 카드 정보를 가지고 오기
		 
		List<Card> list = new ArrayList<Card>();
//		list=boardDao.getCardBybNum(boardDao.getListNum());
		
		return list;
	}*/
	public void getBoardDelete(int bNum) throws SQLException {
		//삭제 순서 중요! 순서 바꾸지 말기!
		
		//전달받은 bNum과 list의 bNum값과 같으면서(and) list의 num과 card의 lNum과 같은 card의 행 모두 삭제
		boardDao.deleteCardBybNum(bNum);
		//list테이블의 bNum과 board 테이블의 num(전달받은 bNum) 같은 행 모두 삭제
		boardDao.deleteListBybNum(bNum);
		/*bNum으로 memberGarde에 저장된 보드 찾아서 삭제(여러명과 공유할 경우 여러개)*/
		boardDao.deleteMemberGradeBybNum(bNum);
		/*전달 받은 bNum으로 board에서 해당 행 삭제*/
		boardDao.deleteBoardBybNum(bNum);
	}
	
	public void boardCreate(String name, String memId) throws SQLException {
		/*
		 * board 생성과  추가한 bNum과 회원 id 넣은 memberGrade 생성
		 * */
		//memberGrade 객체에 회원 id만 넣어놓기(나머진 null)
		MemberGrade memberGrade = new MemberGrade();
		memberGrade.setmemId(memId);
		
		boardDao.addBoard(name, memberGrade);
	}
}
