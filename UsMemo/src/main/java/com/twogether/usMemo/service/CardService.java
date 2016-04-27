package com.twogether.usMemo.service;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.CardDao;
import com.twogether.usMemo.dto.Card;
/**
 * card의 model
 * @author HyeJin
 * 
 */
@Service
public class CardService {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	CardDao cardDao;

	public void addCard(Card card){

		cardDao.addCard(card);

	}

	/**
	 * 카드의 위치가 변경 되었을 때의 모델<br>
	 * 
	 * 1) Json으로 파싱<br>
	 * 2) 기본적으로 같은 리스트에서 카드위치가 변경이 되는 것과 다른 리스트로 카드가 이동할때
	 * 동일한 방식의 카드처리가 수행되어야한다. <br>
	 * 3) 다른 리스트로의 이동일때만 현재 이동하는 카드의 lNum을 afterLNum으로 바꿔준다.  
	 * 
	 * @param cardLocation String타입으로 가지고 온 카드의 자세한 위치를 담은 Json데이터 
	 * @throws ParseException json의 parsing의 예외
	 * 
	 */
	public void updateLocation(String cardLocation) throws ParseException {

		//만든 함수임. String을 JSON으로 바꿔줌. 
		JSONObject obj = parsingJson(cardLocation);
		
		//카드 변경 전의 앞뒤노드의 link 연결
		beforeCardUpdate(parseObjToInt(obj.get("beforePreNum")),parseObjToInt(obj.get("beforePostNum")));
		
		//다른 리스트로 카드를 옮긴 경우
		if(parseObjToInt(obj.get("beforeLNum"))!=parseObjToInt(obj.get("afterLNum"))){
			//옮기는 카드의 lNum을 바뀐 afterLNum으로 변경 
			afterlNumUpdate(parseObjToInt(obj.get("currentNum")),parseObjToInt(obj.get("afterLNum")));
		}
		afterCardUpdate(parseObjToInt(obj.get("afterPreNum")),parseObjToInt(obj.get("afterPostNum")),parseObjToInt(obj.get("currentNum")));

	}
	
	/**
	 * 다른 리스트로 이동한 카드의 lNum정보를 바꿔주는 메서드
	 * 
	 * @param currentNum 위치가 이동한 카드 num
	 * @param afterLNum 이동한 리스트의 num 
	 */
	private void afterlNumUpdate(Integer currentNum, Integer afterLNum) {
		Card card = new Card();
		
		card.setNum(currentNum);
		card.setlNum(afterLNum);
		
		cardDao.update_lNum(card);
		
	}

	/**
	 * 위치가 바뀌기 전의 카드의 link를 변경하는 메서드
	 * @author HyeJin
	 * @param preNum 앞노드의 num
	 * @param postNum 뒷노드의 num
	 * 
	 * @see ListService#beforeListUpdate(Integer, Integer)
	 * 
	 */
	public void beforeCardUpdate(Integer preNum, Integer postNum) {
		//앞노드의 rlink를 postNum으로,
		//뒷노드의 llink를 preNum으로 변경
		//0일경우 처리하기 
		
		Card preCard= new Card();
		Card postCard= new Card();
		if(preNum==0 && postNum==0){
			return;
		}
		else if(preNum==0||postNum==0){
			if(preNum==0){
				//맨 앞자리가 된 거니깐, postNum의 llink만 -1이면 됨.
				
				postCard.setNum(postNum);
				postCard.setLlink(-1);
				//뒷노드의 llink를 앞노드의 num으로 바꿔줌 
				cardDao.update_llink(postCard);
				
			}else if(postNum==0){
				//맨 뒷자리가 된 거니깐, preNum의 rlink만 -1이면 됨.
				
				preCard.setNum(preNum);
				preCard.setRlink(-1);
				//앞노드의 rlink를 뒤노드의 num으로 바꿔줌.
				cardDao.update_rlink(preCard);
		}
		}else if(preNum!=0 && postNum!=0){
			
			preCard.setNum(preNum);
			postCard.setNum(postNum);
			
			preCard.setRlink(postNum);
			postCard.setLlink(preNum);
		
			//앞노드의 rlink를 뒤노드의 num으로 바꿔줌.
			cardDao.update_rlink(preCard);
			
			//뒷노드의 llink를 앞노드의 num으로 바꿔줌 
			cardDao.update_llink(postCard);
		}
		
	}
	
	/**
	 * 위치가 바뀐 후 바뀐Card의 앞,뒤,바뀐노드의 link정보를 변경하는 메서드
	 * preNum과 postNum이 둘다 0일 경우는 없으므로 기존대로 진행.
	 * @param preNum 앞노드의 num
	 * @param postNum 뒷노드의 num
	 * @param currentNum 바뀐노드의 num
	 * 
	 * @see ListService#afterListUpdate(Integer, Integer, Integer)
	 */
	private void afterCardUpdate(Integer preNum, Integer postNum,
			Integer currentNum) {
		
		/*
		 * 1) 사이에 낀게 current이니깐, current의 llink에 preNum, rlink에 postNum을 넣는다.
		 * 2) 앞노드의 rlink를 currentNum, 뒷노드의 llink를 currentNum으로 변경
		 * 3) preNum과 postNum이 0일경우 처리 
		 */
		
		Card currentCard = new Card();
		Card preCard = new Card();
		Card postCard = new Card();

		currentCard.setNum(currentNum);
		
		if(postNum==0 || preNum==0){
			
			
			if(preNum==0){
				//맨 앞으로 이동한거니깐 current의 llink를 -1, 
				//post의 llink만 current로 
				currentCard.setLlink(-1);
				currentCard.setRlink(postNum);
				
				postCard.setNum(postNum);
				postCard.setLlink(currentNum);
				cardDao.update_llink(postCard);
				
			}
			else if(postNum==0){
				//맨 뒤로 이동한것이므로 current가 맨 뒤가 됨.그러면? current의 rlink를 -1
				//pre의 rlink 만 current로 
				currentCard.setLlink(preNum);
				currentCard.setRlink(-1);
				
				
				preCard.setNum(preNum);
				preCard.setRlink(currentNum);
				cardDao.update_rlink(preCard);
			}
		
			cardDao.update_allLink(currentCard);
		}
		else if(preNum!=0 && postNum!=0){//중간->중간으로 바뀐후
			currentCard.setLlink(preNum);
			currentCard.setRlink(postNum);
			cardDao.update_allLink(currentCard);
			
			preCard.setNum(preNum);
			preCard.setRlink(currentNum);
			cardDao.update_rlink(preCard);
			
			postCard.setNum(postNum);
			postCard.setLlink(currentNum);
			cardDao.update_llink(postCard);
		}
		
}


	public JSONObject parsingJson(String cardLocation) throws ParseException {


		JSONParser jsonPaser=new JSONParser();

		//string을 json으로 파싱시킴.
		JSONObject obj=(JSONObject)jsonPaser.parse(cardLocation);

		return obj;
	}
	public int parseObjToInt(Object object){

		return Integer.parseInt(object.toString());
	}




}
