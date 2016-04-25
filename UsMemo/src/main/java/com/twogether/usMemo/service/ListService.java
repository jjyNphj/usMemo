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
		 * 1) 일단 파싱
		 * 2) 두 list row의 location 바꾸기 
		 */
		
		for(Map<String,Object> l: listLocation){
		ListDTO listDto = new ListDTO();
		listDto.setNum(Integer.parseInt((String)l.get("num")));
		//listDto.setLocation((Integer) l.get("location"));
		listDao.updateLocation(listDto);//바꾸기
		}
	}
	
	public void updateLocationNew(List<ListDTO> list){
		/*
		 * 리스트를 가지고 올땐 바꿀 두개의 노드의 앞의 노드까지 가지고 오기.
		 * 인접한 두 개 노드의 링크를 서로를 향하게 위치를 바꾸자.
		 * 
		 * 첫번째 노드의 num을 두번째노드의 llink로 
		 * 두번째 노드의 num을 세번째 노드의 llink로  
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
		 * 파싱 및 DAO 호출하기
		 * 1) before이 붙은 것 끼리 링크연결
		 * 2) after과 current를 연결 
		 */
		//파싱
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
		 * 1) 사이에 낀게 current이니깐, current의 llink에 preNum, rlink에 postNum을 넣는다.
		 * 2) 앞노드의 rlink를 currentNum, 뒷노드의 llink를 currentNum으로 변경
		 * 3) preNum과 postNum이 0일경우 처리 
		 */
		
		ListDTO currentList = new ListDTO();
		ListDTO preList = new ListDTO();
		ListDTO postList = new ListDTO();
		
		if(postNum==0 || preNum==0){
			
			currentList.setNum(currentNum);
			
			if(preNum==0){
				//맨 앞으로 이동한거니깐 current의 llink를 -1, 
				//post의 llink만 current로 
				currentList.setLlink(-1);
				currentList.setRlink(postNum);
				
				postList.setNum(postNum);
				postList.setLlink(currentNum);
				listDao.update_llink(postList);
				
			}
			else if(postNum==0){
				//맨 뒤로 이동한것이므로 current가 맨 뒤가 됨.그러면? current의 rlink를 -1
				//pre의 rlink 만 current로 
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
		//리스트 변경 후 이전 위치에서의 리스트정보 갱신.
		
		//앞노드의 rlink를 postNum으로,
		//뒷노드의 llink를 preNum으로 변경
		//0일경우 처리하기 
		
		ListDTO preList= new ListDTO();
		ListDTO postList= new ListDTO();
		
		if(preNum==0){
			//맨 앞자리가 된 거니깐, postNum의 llink만 -1이면 됨.
			
			postList.setNum(postNum);
			postList.setLlink(-1);
			//뒷노드의 llink를 앞노드의 num으로 바꿔줌 
			listDao.update_llink(postList);
			
		}else if(postNum==0){
			//맨 뒷자리가 된 거니깐, preNum의 rlink만 -1이면 됨.
			
			preList.setNum(preNum);
			preList.setRlink(-1);
			//앞노드의 rlink를 뒤노드의 num으로 바꿔줌.
			listDao.update_rlink(preList);
			
		}else if(preNum!=0 && postNum!=0){
			
			preList.setNum(preNum);
			postList.setNum(postNum);
			
			preList.setRlink(postNum);
			postList.setLlink(preNum);
		
			//앞노드의 rlink를 뒤노드의 num으로 바꿔줌.
			listDao.update_rlink(preList);
			
			//뒷노드의 llink를 앞노드의 num으로 바꿔줌 
			listDao.update_llink(postList);
		}
		
	}


	public JSONObject parsingJson(String listLocation) throws ParseException {

		
		JSONParser jsonPaser=new JSONParser();
		
		//string을 json으로 파싱시킴.
		JSONObject obj=(JSONObject)jsonPaser.parse(listLocation);
		
		
		
		logger.info("currentNum의 파싱결과: {}",obj.get("currentNum"));
		
		return obj;
		}

}
