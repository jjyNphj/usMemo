package com.twogether.usMemo.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
//		list=boardDao.getListAndCardBybNum(board.getbNum());
		
		
		
		HashMap<String, List> mapList = new HashMap<String, List>();
		
		List<ListDTO> listList = boardDao.getListBybNum(board.getbNum());
		mapList.put("listList", listList);
		/*
		
		List<List> cardList=new LinkedList<List>();
		
		for(ListDTO i:listList){
			List<Card> resultCards=new LinkedList<Card>();
			resultCards=boardDao.getCardBybNum(i.getNum());
			//lNum�� ���� �������� card�� linkedList�� �����.
			cardList.add(resultCards);
			//list�� ��ȯ������ �����ϰ� �ֱ� 
			//��, list�� ��ġ�� ���ϸ� cardList�� index�� ���ؾ���.
		}
		
	*/	
		
		
		List<ListAndCard> cardList=boardDao.getCardBybNum(board.getbNum());
		mapList.put("cardList", cardList);
		
		return mapList;
		
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
	
	public void boardCreate(String name, String memId) throws SQLException {
		/*���� ����*/
		MemberGrade memberGrade = new MemberGrade();
		memberGrade.setmemId(memId);
		
		boardDao.addBoard(name, memberGrade);
	}
}
