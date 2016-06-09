package com.twogether.usMemo.service;

import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.ActivityDao;
import com.twogether.usMemo.dto.Activity;
import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.dto.Member;
import com.twogether.usMemo.dto.MemberGrade;

@Service
public class ActivityService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired ActivityDao activityDao;
	//@Autowired Activity requestInfo;
	
	public void create_board(String memId,int bNum){
		
	Activity requestInfo= new Activity();
		requestInfo.setMemId(memId);
		requestInfo.setbNum(bNum);
		activityDao.create_board(requestInfo);		
	}


	public List<Activity> getSomeActivity(int bNum) {
		Activity requestInfo= new Activity();
		requestInfo.setbNum(bNum);
		
		List<Activity> result= activityDao.getSomeActivity(requestInfo);
		return result;
	}
	
	public List<Activity> getAllActivity(int bNum) {
		Activity requestInfo= new Activity();
		requestInfo.setbNum(bNum);
		
		List<Activity> result= activityDao.getAllActivity(requestInfo);
		return result;
	}


	public void addList(ListDTO listDTO,String memId) {
		Activity requestInfo= new Activity();
		requestInfo.setMemId(memId);
		requestInfo.setbNum(listDTO.getbNum());
		requestInfo.setValue_num(listDTO.getNum());
		
		activityDao.addList(requestInfo);
	}


	public ListDTO getListInfo(int listNum) {
		
	return activityDao.getListInfo(listNum);
	}


	public void addCard(Card card, int bNum) {
		Activity requestInfo= new Activity();
			requestInfo.setMemId(card.getMemId());
			requestInfo.setbNum(bNum);
			requestInfo.setValue_num(card.getNum());
			requestInfo.setTo_num(card.getlNum());
		activityDao.addCard(requestInfo);
	}


	public Card getCardInfo(int cardNum) {
		// TODO Auto-generated method stub
		return activityDao.getCardInfo(cardNum);
	}


	public void updateCardLocation(String cardLocation) throws ParseException {
		
		JSONParser jsonPaser=new JSONParser();
		//string¿ª json¿∏∑Œ ∆ƒΩÃΩ√≈¥.
		JSONObject obj=(JSONObject)jsonPaser.parse(cardLocation);
		
		Activity requestInfo= new Activity();
		requestInfo.setMemId((String) obj.get("memId"));
		requestInfo.setbNum(parseObjToInt(obj.get("bNum")));
		requestInfo.setValue_num(parseObjToInt(obj.get("currentNum")));
		requestInfo.setTo_num(parseObjToInt(obj.get("afterLNum")));
		requestInfo.setFrom_num(parseObjToInt(obj.get("beforeLNum")));
		
		activityDao.updateCardLocation(requestInfo);
	}
	
	public int parseObjToInt(Object object){

		return Integer.parseInt(object.toString());
	}


	public void addFriend(MemberGrade addMemberInfo, String memId) {
		
		Activity requestInfo= new Activity();
		requestInfo.setMemId(memId);
		requestInfo.setbNum(addMemberInfo.getbNum());
		requestInfo.setValue_string(addMemberInfo.getmemId());
		activityDao.addFriend(requestInfo);
	}


	public Member getFriendInfo(MemberGrade memberInfo) {
		
		return activityDao.getFriendInfo(memberInfo);
	}
	
	
}
