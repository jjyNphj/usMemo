package com.twogether.usMemo.service;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.ListDao;
import com.twogether.usMemo.dto.ListDTO;

@Service
public class ListService {
	@Autowired
	ListDao listDao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public void addList(ListDTO listDTO){
		
		listDao.addList(listDTO);
	}

	public void updateLocation(List<Map<String, Object>> listLocation) {
		/*
		 * 1) �ϴ� �Ľ�
		 * 2) �� list row�� location �ٲٱ� 
		 */
		
		for(Map<String,Object> l: listLocation){
		ListDTO listDto = new ListDTO();
		listDto.setNum(Integer.parseInt((String)l.get("num")));
		//listDto.setLocation((Integer) l.get("location"));
		listDao.updateLocation(listDto);//�ٲٱ�
		}
	}
	
	public void updateLocationNew(List<ListDTO> list){
		/*
		 * ����Ʈ�� ������ �ö� �ٲ� �ΰ��� ����� ���� ������ ������ ����.
		 * ������ �� �� ����� ��ũ�� ���θ� ���ϰ� ��ġ�� �ٲ���.
		 * 
		 * ù��° ����� num�� �ι�°����� llink�� 
		 * �ι�° ����� num�� ����° ����� llink��  
		 * 
		 */
		list.get(1).setLlink(list.get(0).getNum());
		list.get(2).setLlink(list.get(1).getNum());
		
		
		
	}

	public int parsingObjectToInt(Object object){
		
		return Integer.parseInt(object.toString());
	}
	public void updateLocation(String listLocation) throws ParseException {
		/*
		 * �Ľ� �� DAO ȣ���ϱ�
		 * 1) before�� ���� �� ���� ��ũ����
		 * 2) after�� current�� ���� 
		 */
		//�Ľ�
		JSONObject obj= parsingJson(listLocation);
	
//		logger.info("before-> pre: {}, ",parsingObjectToInt(obj.get("beforePreNum")));
//		logger.info("before-> post: {} ",parsingObjectToInt(obj.get("beforePostNum")));
//		logger.info("after-> pre: {}, ",parsingObjectToInt(obj.get("afterPreNum")));
//		logger.info("after-> post: {} ",parsingObjectToInt(obj.get("afterPostNum")));
//		logger.info("after-> current: {}",parsingObjectToInt(obj.get("currentNum")));
//	
		beforeListUpdate(parsingObjectToInt(obj.get("beforePreNum")),parsingObjectToInt(obj.get("beforePostNum")));
		afterListUpdate(parsingObjectToInt(obj.get("afterPreNum")),parsingObjectToInt(obj.get("afterPostNum")),parsingObjectToInt(obj.get("currentNum")));
		
	}

	private void afterListUpdate(Integer preNum, Integer postNum,
			Integer currentNum) {
		
		/*
		 * 1) ���̿� ���� current�̴ϱ�, current�� llink�� preNum, rlink�� postNum�� �ִ´�.
		 * 2) �ճ���� rlink�� currentNum, �޳���� llink�� currentNum���� ����
		 * 3) preNum�� postNum�� 0�ϰ�� ó�� 
		 */
		
		ListDTO currentList = new ListDTO();
		ListDTO preList = new ListDTO();
		ListDTO postList = new ListDTO();
		
		if(postNum==0 || preNum==0){
			
			currentList.setNum(currentNum);
			
			if(preNum==0){
				//�� ������ �̵��ѰŴϱ� current�� llink�� -1, 
				//post�� llink�� current�� 
				currentList.setLlink(-1);
				currentList.setRlink(postNum);
				
				postList.setNum(postNum);
				postList.setLlink(currentNum);
				listDao.update_llink(postList);
				
			}
			else if(postNum==0){
				//�� �ڷ� �̵��Ѱ��̹Ƿ� current�� �� �ڰ� ��.�׷���? current�� rlink�� -1
				//pre�� rlink �� current�� 
				currentList.setLlink(preNum);
				currentList.setRlink(-1);
				
				
				preList.setNum(preNum);
				preList.setRlink(currentNum);
				listDao.update_rlink(preList);
			}
		
			listDao.update_allLink(currentList);
		}
		else{
			currentList.setNum(currentNum);
			currentList.setLlink(preNum);
			currentList.setRlink(postNum);
			
			listDao.update_allLink(currentList);
			
			
			preList.setNum(preNum);
			preList.setRlink(currentNum);
			listDao.update_rlink(preList);
			
			postList.setNum(postNum);
			postList.setLlink(currentNum);
			listDao.update_llink(postList);
		}
		
}

	private void beforeListUpdate(Integer preNum, Integer postNum) {
		//����Ʈ ���� �� ���� ��ġ������ ����Ʈ���� ����.
		
		//�ճ���� rlink�� postNum����,
		//�޳���� llink�� preNum���� ����
		//0�ϰ�� ó���ϱ� 
		
		ListDTO preList= new ListDTO();
		ListDTO postList= new ListDTO();
		
		if(preNum==0){
			//�� ���ڸ��� �� �Ŵϱ�, postNum�� llink�� -1�̸� ��.
			
			postList.setNum(postNum);
			postList.setLlink(-1);
			//�޳���� llink�� �ճ���� num���� �ٲ��� 
			listDao.update_llink(postList);
			
		}else if(postNum==0){
			//�� ���ڸ��� �� �Ŵϱ�, preNum�� rlink�� -1�̸� ��.
			
			preList.setNum(preNum);
			preList.setRlink(-1);
			//�ճ���� rlink�� �ڳ���� num���� �ٲ���.
			listDao.update_rlink(preList);
			
		}else if(preNum!=0 && postNum!=0){
			
			preList.setNum(preNum);
			postList.setNum(postNum);
			
			preList.setRlink(postNum);
			postList.setLlink(preNum);
		
			//�ճ���� rlink�� �ڳ���� num���� �ٲ���.
			listDao.update_rlink(preList);
			
			//�޳���� llink�� �ճ���� num���� �ٲ��� 
			listDao.update_llink(postList);
		}
		
	}


	public JSONObject parsingJson(String listLocation) throws ParseException {

		
		JSONParser jsonPaser=new JSONParser();
		
		//string�� json���� �Ľ̽�Ŵ.
		JSONObject obj=(JSONObject)jsonPaser.parse(listLocation);
		
		
		
		logger.info("currentNum�� �Ľ̰��: {}",obj.get("currentNum"));
		
		return obj;
		}

}
