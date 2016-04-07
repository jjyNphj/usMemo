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
		
		list=boardDao.getMemberGradeBymNum(mNum);
		
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
	
	public List<List> getList(Board board){
		/*
		 * ���õ� ������ bNum���� �ش� ������ ����Ʈ������ ������ ����
		 * ������ ����Ʈ�� num���� ������ card����Ʈ�� �ҷ���
		 * 
		 */
		List<List> list = new ArrayList<List>();
		list=boardDao.getListBybNum(board.getbNum());
						
		return list;
		
	}
	public List<Card> getCard(Board board){
		/*
		 * ���õ� ����Ʈ�� lNum���� �ش� ����Ʈ�� ī�� ������ ������ ����
		 */
		List<Card> list = new ArrayList<Card>();
//		list=boardDao.getCardBybNum(boardDao.getListNum());
		
		return list;
	}
	
}
