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
 * card�� model
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
	 * ī���� ��ġ�� ���� �Ǿ��� ���� ��<br>
	 * 
	 * 1) Json���� �Ľ�<br>
	 * 2) �⺻������ ���� ����Ʈ���� ī����ġ�� ������ �Ǵ� �Ͱ� �ٸ� ����Ʈ�� ī�尡 �̵��Ҷ�
	 * ������ ����� ī��ó���� ����Ǿ���Ѵ�. <br>
	 * 3) �ٸ� ����Ʈ���� �̵��϶��� ���� �̵��ϴ� ī���� lNum�� afterLNum���� �ٲ��ش�.  
	 * 
	 * @param cardLocation StringŸ������ ������ �� ī���� �ڼ��� ��ġ�� ���� Json������ 
	 * @throws ParseException json�� parsing�� ����
	 * 
	 */
	public void updateLocation(String cardLocation) throws ParseException {

		//���� �Լ���. String�� JSON���� �ٲ���. 
		JSONObject obj = parsingJson(cardLocation);
		
		//ī�� ���� ���� �յڳ���� link ����
		beforeCardUpdate(parseObjToInt(obj.get("beforePreNum")),parseObjToInt(obj.get("beforePostNum")));
		
		//�ٸ� ����Ʈ�� ī�带 �ű� ���
		if(parseObjToInt(obj.get("beforeLNum"))!=parseObjToInt(obj.get("afterLNum"))){
			//�ű�� ī���� lNum�� �ٲ� afterLNum���� ���� 
			afterlNumUpdate(parseObjToInt(obj.get("currentNum")),parseObjToInt(obj.get("afterLNum")));
		}
		afterCardUpdate(parseObjToInt(obj.get("afterPreNum")),parseObjToInt(obj.get("afterPostNum")),parseObjToInt(obj.get("currentNum")));

	}
	
	/**
	 * �ٸ� ����Ʈ�� �̵��� ī���� lNum������ �ٲ��ִ� �޼���
	 * 
	 * @param currentNum ��ġ�� �̵��� ī�� num
	 * @param afterLNum �̵��� ����Ʈ�� num 
	 */
	private void afterlNumUpdate(Integer currentNum, Integer afterLNum) {
		Card card = new Card();
		
		card.setNum(currentNum);
		card.setlNum(afterLNum);
		
		cardDao.update_lNum(card);
		
	}

	/**
	 * ��ġ�� �ٲ�� ���� ī���� link�� �����ϴ� �޼���
	 * @author HyeJin
	 * @param preNum �ճ���� num
	 * @param postNum �޳���� num
	 * 
	 * @see ListService#beforeListUpdate(Integer, Integer)
	 * 
	 */
	public void beforeCardUpdate(Integer preNum, Integer postNum) {
		//�ճ���� rlink�� postNum����,
		//�޳���� llink�� preNum���� ����
		//0�ϰ�� ó���ϱ� 
		
		Card preCard= new Card();
		Card postCard= new Card();
		if(preNum==0 && postNum==0){
			// �ű�� �� ����Ʈ���� ���峲���ִ� ī�带 �ٸ� ����Ʈ�� �ű��
			//pre�� post ��� 0�� �Ǵµ�, �ƹ��͵� �����ϱ� �ƹ��ϵ� ���ϸ��.
			return;
		}
		else if(preNum==0||postNum==0){
			if(preNum==0){
				//�� ���ڸ��� �� �Ŵϱ�, postNum�� llink�� -1�̸� ��.
				
				postCard.setNum(postNum);
				postCard.setLlink(-1);
				//�޳���� llink�� �ճ���� num���� �ٲ��� 
				cardDao.update_llink(postCard);
				
			}else if(postNum==0){
				//�� ���ڸ��� �� �Ŵϱ�, preNum�� rlink�� -1�̸� ��.
				
				preCard.setNum(preNum);
				preCard.setRlink(-1);
				//�ճ���� rlink�� �ڳ���� num���� �ٲ���.
				cardDao.update_rlink(preCard);
		}
		}else if(preNum!=0 && postNum!=0){
			
			preCard.setNum(preNum);
			postCard.setNum(postNum);
			
			preCard.setRlink(postNum);
			postCard.setLlink(preNum);
		
			//�ճ���� rlink�� �ڳ���� num���� �ٲ���.
			cardDao.update_rlink(preCard);
			
			//�޳���� llink�� �ճ���� num���� �ٲ��� 
			cardDao.update_llink(postCard);
		}
		
	}
	
	/**
	 * ��ġ�� �ٲ� �� �ٲ�Card�� ��,��,�ٲ����� link������ �����ϴ� �޼���
	 * preNum�� postNum�� �Ѵ� 0�� ���� �����Ƿ� ������� ����.
	 * @param preNum �ճ���� num
	 * @param postNum �޳���� num
	 * @param currentNum �ٲ����� num
	 * 
	 * @see ListService#afterListUpdate(Integer, Integer, Integer)
	 */
	private void afterCardUpdate(Integer preNum, Integer postNum,
			Integer currentNum) {
		
		/*
		 * 1) ���̿� ���� current�̴ϱ�, current�� llink�� preNum, rlink�� postNum�� �ִ´�.
		 * 2) �ճ���� rlink�� currentNum, �޳���� llink�� currentNum���� ����
		 * 3) preNum�� postNum�� 0�ϰ�� ó�� 
		 */
		
		Card currentCard = new Card();
		Card preCard = new Card();
		Card postCard = new Card();

		currentCard.setNum(currentNum);
		
		if(postNum==0 || preNum==0){
			
			
			if(preNum==0 && postNum!=0){
				//�� ������ �̵��ѰŴϱ� current�� llink�� -1, 
				//post�� llink�� current�� 
				currentCard.setLlink(-1);
				currentCard.setRlink(postNum);
				
				postCard.setNum(postNum);
				postCard.setLlink(currentNum);
				cardDao.update_llink(postCard);
				
			}
			else if(preNum!=0 && postNum==0){
				//�� �ڷ� �̵��Ѱ��̹Ƿ� current�� �� �ڰ� ��.�׷���? current�� rlink�� -1
				//pre�� rlink �� current�� 
				currentCard.setLlink(preNum);
				currentCard.setRlink(-1);
				
				
				preCard.setNum(preNum);
				preCard.setRlink(currentNum);
				cardDao.update_rlink(preCard);
				
			}else if(preNum==0 && postNum==0){
				//�ű� ���� �ƹ��͵� ���� ����Ʈ���� ���̹Ƿ� pre,post ī�尡 �ƹ��͵� ����. 
				//�׷��� ���� ī���� llink,rlink�� -1�� �ٲ��ָ� ��.
				currentCard.setLlink(-1);
				currentCard.setRlink(-1);
			}
		
			cardDao.update_allLink(currentCard);
		}
		else if(preNum!=0 && postNum!=0){//�߰�->�߰����� �ٲ���
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

		//string�� json���� �Ľ̽�Ŵ.
		JSONObject obj=(JSONObject)jsonPaser.parse(cardLocation);

		return obj;
	}
	public int parseObjToInt(Object object){

		return Integer.parseInt(object.toString());
	}
	

	/**
	 * ���� ���ε�� �ش� ī�� �ѹ��� ���� �̸� �ֱ�
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
		 * [multiparthttpservletrequest] �ֿ� �޼ҵ� 
		 * getFileNames() : Iterator<String> - ���ε�� ���ϸ�� ��ȸ
		 * getFile(String name) : MultipartFile - ���ε�� �������� ��ȸ
		 * getFiles(String name) : List<MultipartFile> - ���ε�� ���������� ��ȸ
		 * [MultipartFile] �ֿ� �޼ҵ�
		 * ���ε�� ���������� �����ϴ� ��ü
		 * getName() : String-��û�Ķ������ name
		 * getOriginalFilename(): String-upload�� ���ϸ�
		 * transferTo(File dest)-upload�� ������ Ư�� ��η� �̵�
		 * */
		Iterator<String> iter = mRequest.getFileNames();
		while(iter.hasNext()) {
			String uploadFileName = iter.next();
			
			/*MultipartFile mFile = mRequest.getFile(uploadFileName);*/
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			String saveFileName = originalFileName;
			
			if(saveFileName != null && !saveFileName.equals("")) {
				//�Ȱ��� �̸��� ������ local ������ ������� currentTimeMillis�� �ð��� ���� ���� �ɰ��� �̸� �ڿ� ���� 
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();

					System.out.println(saveFileName);
					System.out.println(originalFileName);
				}
				
				try {
					mFile.transferTo(new File(uploadPath + saveFileName));
					//Card DTO�� ÷������ �̸���, ī���� �ѹ��� �־���.
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
