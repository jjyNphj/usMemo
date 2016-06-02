package com.twogether.usMemo.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.BoardDao;
import com.twogether.usMemo.dto.Board;
import com.twogether.usMemo.dto.BoardInfo;
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
			resultBoard.setStar(i.getStar());
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
		listArray=sortingList(listArray);
		mapList.put("listList", listArray);
		
//		List<Card> cardArray = new ArrayList<Card>();
//		for(ListDTO list :listArray){
//			Card cardOfListNum= new Card();
//			cardOfListNum.setlNum(list.getNum());
//			cardArray.add(cardOfListNum);
//		}
//		
		List<ListAndCard> cardList=boardDao.getCardBybNum(board.getbNum());
		cardList=sortingCard(cardList);
		mapList.put("cardList", cardList);
//		
		return mapList;
		
	}
	
	/**
	 * 카드를 순서대로 sorting하는 메서드<br>
	 * 하나의 리스트 안의 카드를 정렬해야하는데, 현재 반환값은 여러개의 리스트의 모든 카드를 반환해야함.<br>
	 * lNum이 순차적으로 되지 않는 것은 문제되지 않으나, llink와 rlink의 순서만 지켜지면, view에서 순서대로 나올 수 있음.<br>
	 * 
	 *  참고: listIterator()과 iterator()의 차이 <br>
	 *  iterator()은 add나 이전노드의 참조가 불가능하지만, listIteratro()은 가능하다.
	 * 
	 * @param list
	 * @return 현재 보드의 모든 리스트의 카드를 순차적으로 저장한 array를 반환 
	 */
	public List<ListAndCard> sortingCard(List<ListAndCard> list){
	
		List<ListAndCard> result=new ArrayList<ListAndCard>();
		List<ListAndCard> firstNode=new ArrayList<ListAndCard>();
		
		ListIterator<ListAndCard> it= list.listIterator();
		
	
		
		
			
		while(it.hasNext()){
			ListAndCard listDto = it.next();
			if(listDto.getLlink()==-1){
				firstNode.add(listDto);
				it.remove();
			}
		}
		
		ListIterator<ListAndCard> firstNodeIt= firstNode.listIterator();
		while(firstNodeIt.hasNext()){
			ListAndCard firstObj=firstNodeIt.next();
			result.add(firstObj);
			
			//반복문이 없으면, 만일 같은 lNum을 가졌더라도 card의 rlink와 num이 같지않은게 바로 뒤에 나오면 갸는 두고가는것임.
			//중간에 break로 함부로 나가도 안됨. 낙오자가 생김.
			//따라서 현재 result에 들어있는 맨 마지막 노드가 현재 찾는 리스트의 카드들 중에서 맨 마지막(rlink가 -1)이 아니면
			//끝난게 아니므로 계속해서 찾는다. 
		while(result.get(result.size()-1).getRlink()!=-1){
		for(it = list.listIterator() ; it.hasNext() ;){
			ListAndCard dto=it.next();
			if(firstObj.getlNum()==dto.getlNum()){
				if(result.get(result.size()-1).getRlink()==dto.getCard_num()){
					result.add(dto);
					it.remove();
				}
				
			}
		}
		}
		}

		return result;
	}
	public List<ListDTO> sortingList(List<ListDTO> list){
		
		List<ListDTO> result=new ArrayList<ListDTO>();
		
		//listIterator 배열을 하나하나 뒤지는 역할(while,for문 안에 있을떄만)
		ListIterator<ListDTO> it= list.listIterator();
		
		//hasNext->커서역할(listIterartor)
		//다음 객체 여부 검증 (있으면 true 반환),제일 처음엔 -1값이 들어가있음.
		while(it.hasNext()){
			//next()는 다음 객체를 가져옴. 반환은 생성한 ListDTO로
			ListDTO listDto = it.next();
			if(listDto.getLlink()==-1){
				//add->ArrayList 제공함수, 가장 마지막에 데이터 넣기
				result.add(listDto);
				it.remove();
				break;
			}
		}
		
		while(list.size()!=0){
		for(it = list.listIterator() ; it.hasNext() ;){
			
			ListDTO dto=it.next();
			if(result.get(result.size()-1).getRlink()==dto.getNum()){
				result.add(dto);
				it.remove();
			}
		}
		}

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
	
	public int boardCreate(String name, String memId) throws SQLException {
		/*
		 * board 생성과  추가한 bNum과 회원 id 넣은 memberGrade 생성
		 * */
		//memberGrade 객체에 회원 id만 넣어놓기(나머진 null)
		MemberGrade memberGrade = new MemberGrade();
		memberGrade.setmemId(memId);
		
		Board board= new Board();
		board.setName(name);
		
		int nowBNum=boardDao.addBoard(board, memberGrade);
		
		return nowBNum;
	}
	
	public List<BoardInfo> getAllBoards(String memId){
		return boardDao.getAllBoards(memId);
	}
}
