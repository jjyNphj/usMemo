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
		//�α��� �� ���̴� ȸ���� ������
		/*
		 * 1) ȸ����ȣ�� memberGrade�� ���� �� ����� ��� boardNum���������
		 * 2) ��� boardNum���� board ���̺��� �̸��� boardNum�� ���������
		 * 3) �信�� �ش� board�̸� �����ֱ� 
		 * 
		 */
		/*
		 * ȸ����ȣ-> ȸ�����-> �����ȣ����Ʈ��������-> ������ ���� �̸� ��������-> �Ϸ�
		 */
		
		List<MemberGrade> list = new ArrayList<MemberGrade>();
		
		list=boardDao.getMemberGradeBymNum(memId);
		
		List<Board> resultList=new ArrayList<Board>();
		
		for(MemberGrade i:list){
			Board resultBoard=new Board();
			
			resultBoard.setbNum(i.getbNum());
			resultBoard.setName(boardDao.getBoardNameBybNum(i.getbNum()));
			resultBoard.setStar(i.getStar());
			System.out.println("����: "+resultBoard.getName());
			
			resultList.add(resultBoard);			
		}
		
		return resultList;		
	}
	
	public HashMap<String, List> getListAndCard(Board board){
		/*
		 * ����Ʈ->lNum���� card ������ȸ ->Map���� �ѱ�� 
		 * 
		 */
		
		HashMap<String, List> mapList = new HashMap<String, List>();
		
		List<ListDTO> listArray = boardDao.getListBybNum(board.getbNum());
		//sorting�ϱ�
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
	 * ī�带 ������� sorting�ϴ� �޼���<br>
	 * �ϳ��� ����Ʈ ���� ī�带 �����ؾ��ϴµ�, ���� ��ȯ���� �������� ����Ʈ�� ��� ī�带 ��ȯ�ؾ���.<br>
	 * lNum�� ���������� ���� �ʴ� ���� �������� ������, llink�� rlink�� ������ ��������, view���� ������� ���� �� ����.<br>
	 * 
	 *  ����: listIterator()�� iterator()�� ���� <br>
	 *  iterator()�� add�� ��������� ������ �Ұ���������, listIteratro()�� �����ϴ�.
	 * 
	 * @param list
	 * @return ���� ������ ��� ����Ʈ�� ī�带 ���������� ������ array�� ��ȯ 
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
			
			//�ݺ����� ������, ���� ���� lNum�� �������� card�� rlink�� num�� ���������� �ٷ� �ڿ� ������ ���� �ΰ��°���.
			//�߰��� break�� �Ժη� ������ �ȵ�. �����ڰ� ����.
			//���� ���� result�� ����ִ� �� ������ ��尡 ���� ã�� ����Ʈ�� ī��� �߿��� �� ������(rlink�� -1)�� �ƴϸ�
			//������ �ƴϹǷ� ����ؼ� ã�´�. 
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
		
		//listIterator �迭�� �ϳ��ϳ� ������ ����(while,for�� �ȿ� ��������)
		ListIterator<ListDTO> it= list.listIterator();
		
		//hasNext->Ŀ������(listIterartor)
		//���� ��ü ���� ���� (������ true ��ȯ),���� ó���� -1���� ������.
		while(it.hasNext()){
			//next()�� ���� ��ü�� ������. ��ȯ�� ������ ListDTO��
			ListDTO listDto = it.next();
			if(listDto.getLlink()==-1){
				//add->ArrayList �����Լ�, ���� �������� ������ �ֱ�
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
		
		 * ���õ� ������ bNum���� �ش� ������ ����Ʈ������ ������ ����
		 * ������ ����Ʈ�� num���� ������ card����Ʈ�� �ҷ���
		 * 
		 
		List<List> list = new LinkedList<List>();
		list=boardDao.getListBybNum(board.getbNum());
						
		return list;	
	}
	public List<Card> getCard(Board board){
		
		 * ���õ� ����Ʈ�� lNum���� �ش� ����Ʈ�� ī�� ������ ������ ����
		 
		List<Card> list = new ArrayList<Card>();
//		list=boardDao.getCardBybNum(boardDao.getListNum());
		
		return list;
	}*/
	public void getBoardDelete(int bNum) throws SQLException {
		//���� ���� �߿�! ���� �ٲ��� ����!
		
		//���޹��� bNum�� list�� bNum���� �����鼭(and) list�� num�� card�� lNum�� ���� card�� �� ��� ����
		boardDao.deleteCardBybNum(bNum);
		//list���̺��� bNum�� board ���̺��� num(���޹��� bNum) ���� �� ��� ����
		boardDao.deleteListBybNum(bNum);
		/*bNum���� memberGarde�� ����� ���� ã�Ƽ� ����(������� ������ ��� ������)*/
		boardDao.deleteMemberGradeBybNum(bNum);
		/*���� ���� bNum���� board���� �ش� �� ����*/
		boardDao.deleteBoardBybNum(bNum);
	}
	
	public int boardCreate(String name, String memId) throws SQLException {
		/*
		 * board ������  �߰��� bNum�� ȸ�� id ���� memberGrade ����
		 * */
		//memberGrade ��ü�� ȸ�� id�� �־����(������ null)
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
