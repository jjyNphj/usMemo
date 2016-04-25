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
	
	public void boardCreate(String name, String memId) throws SQLException {
		/*
		 * board ������  �߰��� bNum�� ȸ�� id ���� memberGrade ����
		 * */
		//memberGrade ��ü�� ȸ�� id�� �־����(������ null)
		MemberGrade memberGrade = new MemberGrade();
		memberGrade.setmemId(memId);
		
		boardDao.addBoard(name, memberGrade);
	}
}
