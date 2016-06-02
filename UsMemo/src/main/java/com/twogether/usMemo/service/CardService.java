package com.twogether.usMemo.service;

import java.io.File;
import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Iterator;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import oracle.sql.BLOB;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.twogether.usMemo.dao.CardDao;
import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.DownLoadDTO;
import com.twogether.usMemo.dto.ListAndCard;
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
	
	public ListAndCard editCardWindow(int cNum) {
		ListAndCard listAndcard = new ListAndCard();
		listAndcard = cardDao.getCardInfoBycNum(cNum);
				
		//logger.info("check : card{}" , listAndcard);
		return listAndcard;
	}
	
	public void addCardContent(Card card) {
		cardDao.addCardContent(card);
	}
	
	public void editCardName(Card card) {
		cardDao.editCardName(card);
		System.out.println("CardService card name: " + card.getName());
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
			// 옮기기 전 리스트에서 한장남아있던 카드를 다른 리스트로 옮기면
			//pre와 post 모두 0이 되는데, 아무것도 없으니까 아무일도 안하면됨.
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
			
			
			if(preNum==0 && postNum!=0){
				//맨 앞으로 이동한거니깐 current의 llink를 -1, 
				//post의 llink만 current로 
				currentCard.setLlink(-1);
				currentCard.setRlink(postNum);
				
				postCard.setNum(postNum);
				postCard.setLlink(currentNum);
				cardDao.update_llink(postCard);
				
			}
			else if(preNum!=0 && postNum==0){
				//맨 뒤로 이동한것이므로 current가 맨 뒤가 됨.그러면? current의 rlink를 -1
				//pre의 rlink 만 current로 
				currentCard.setLlink(preNum);
				currentCard.setRlink(-1);
				
				
				preCard.setNum(preNum);
				preCard.setRlink(currentNum);
				cardDao.update_rlink(preCard);
				
			}else if(preNum==0 && postNum==0){
				//옮긴 곳이 아무것도 없는 리스트였을 때이므로 pre,post 카드가 아무것도 없다. 
				//그러니 현재 카드의 llink,rlink만 -1로 바꿔주면 됨.
				currentCard.setLlink(-1);
				currentCard.setRlink(-1);
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
	

	/**
	 * 파일 업로드와 해당 카드 넘버에 파일 이름 넣기
	 * @throws SQLException 
	 * @throws SerialException 
	 */
	public DownLoadDTO fileUpload(MultipartHttpServletRequest mRequest, int cNum) throws SerialException, SQLException {
		DownLoadDTO result= new DownLoadDTO();
		boolean isSuccess = false;
		
		String uploadPath = "D:\\save\\";
		
		File dir = new File(uploadPath);

		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		/* 
		 * [multiparthttpservletrequest] 주요 메소드 
		 * getFileNames() : Iterator<String> - 업로드된 파일명들 조회
		 * getFile(String name) : MultipartFile - 업로드된 파일정보 조회
		 * getFiles(String name) : List<MultipartFile> - 업로드된 파일정보들 조회
		 * [MultipartFile] 주요 메소드
		 * 업로드된 파일정보를 저장하는 객체
		 * getName() : String-요청파라미터의 name
		 * getOriginalFilename(): String-upload된 파일명
		 * transferTo(File dest)-upload된 파일을 특정 경로로 이동
		 * */
		Iterator<String> iter = mRequest.getFileNames();
		while(iter.hasNext()) {
			String uploadFileName = iter.next();
			
			/*MultipartFile mFile = mRequest.getFile(uploadFileName);*/
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			String saveFileName = originalFileName;
			
			if(saveFileName != null && !saveFileName.equals("")) {
				//똑같은 이름의 파일이 local 폴더에 있을경우 currentTimeMillis로 시간에 따른 값을 쪼개서 이름 뒤에 붙임 
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();

					System.out.println(saveFileName);
					System.out.println(originalFileName);
				}
				
				try {
					mFile.transferTo(new File(uploadPath + saveFileName));
					//Card DTO에 첨부파일 이름과, 카드의 넘버를 넣어줌.
					Card card = new Card();
					
					/*byte[] byteSaveFile = saveFileName.getBytes();*/
					/*Blob blobSaveFile = new SerialBlob(byteSaveFile);
					*/
					/*card.setAttach(byteSaveFile);*/
					//card.setAttach(saveFileName);
					card.setAttach(originalFileName);
					card.setNum(cNum);
					cardDao.fileUploadName(card);
					result.setAttach(originalFileName);
					isSuccess = true;				
				} catch (IllegalStateException e) {
					e.printStackTrace();
					isSuccess = false;
				} catch (IOException e) {
					e.printStackTrace();
					isSuccess = false;
				}
			} // if end
		} // while end
		
	
		
		result.setSuccess(isSuccess);
		return result;
	} // fileUpload end


}
