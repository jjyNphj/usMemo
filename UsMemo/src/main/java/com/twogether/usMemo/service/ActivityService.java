package com.twogether.usMemo.service;

import java.util.ArrayList;
import java.util.Iterator;
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
import com.twogether.usMemo.dto.ActivityDataMember;
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
		
	ActivityDataMember requestInfo= new ActivityDataMember();
		requestInfo.setMemId(memId);
		requestInfo.setbNum(bNum);
		requestInfo.setActivity_name("create_board");
		requestInfo.setActivity_name_num(activityDao.getActivityNumByActivityName(requestInfo.getActivity_name()));
		activityDao.create_board(requestInfo);
		
		addActivity(requestInfo);
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
		ActivityDataMember requestInfo= new ActivityDataMember();
		requestInfo.setMemId(memId);
		requestInfo.setbNum(listDTO.getbNum());
		requestInfo.setValue_num(listDTO.getNum());
		requestInfo.setActivity_name("addList");
		requestInfo.setActivity_name_num(activityDao.getActivityNumByActivityName(requestInfo.getActivity_name()));
		activityDao.addList(requestInfo);
		
		addActivity(requestInfo);
	}


	public ListDTO getListInfo(int listNum) {
		
	return activityDao.getListInfo(listNum);
	}


	public void addCard(Card card, int bNum) {
		ActivityDataMember requestInfo= new ActivityDataMember();
			requestInfo.setMemId(card.getMemId());
			requestInfo.setbNum(bNum);
			requestInfo.setValue_num(card.getNum());
			requestInfo.setTo_num(card.getlNum());
			requestInfo.setActivity_name("addCard");
			requestInfo.setActivity_name_num(activityDao.getActivityNumByActivityName(requestInfo.getActivity_name()));
		activityDao.addCard(requestInfo);
		
		addActivity(requestInfo);
	}


	public Card getCardInfo(int cardNum) {
		// TODO Auto-generated method stub
		return activityDao.getCardInfo(cardNum);
	}


	public void updateCardLocation(String cardLocation) throws ParseException {
		
		JSONParser jsonPaser=new JSONParser();
		//string을 json으로 파싱시킴.
		JSONObject obj=(JSONObject)jsonPaser.parse(cardLocation);
		
		ActivityDataMember requestInfo= new ActivityDataMember();
		requestInfo.setMemId((String) obj.get("memId"));
		requestInfo.setbNum(parseObjToInt(obj.get("bNum")));
		requestInfo.setValue_num(parseObjToInt(obj.get("currentNum")));
		requestInfo.setTo_num(parseObjToInt(obj.get("afterLNum")));
		requestInfo.setFrom_num(parseObjToInt(obj.get("beforeLNum")));
		requestInfo.setActivity_name("updateCardLocation");
		requestInfo.setActivity_name_num(activityDao.getActivityNumByActivityName(requestInfo.getActivity_name()));
		
		activityDao.updateCardLocation(requestInfo);
		addActivity(requestInfo);
	}
	
	public int parseObjToInt(Object object){

		return Integer.parseInt(object.toString());
	}


	public void addFriend(MemberGrade addMemberInfo, String memId) {
		
		ActivityDataMember requestInfo= new ActivityDataMember();
		requestInfo.setMemId(memId);
		requestInfo.setbNum(addMemberInfo.getbNum());
		requestInfo.setValue_string(addMemberInfo.getmemId());
		requestInfo.setActivity_name("addFriend");
		requestInfo.setActivity_name_num(activityDao.getActivityNumByActivityName(requestInfo.getActivity_name()));
		
		activityDao.addFriend(requestInfo);
		addActivity(requestInfo);
	}


	public Member getFriendInfo(MemberGrade memberInfo) {
		
		return activityDao.getFriendInfo(memberInfo);
	}


	public void addActivity(ActivityDataMember requestInfo) {
		requestInfo=activityDao.getActivityDataByNum(requestInfo);
		String result=makeActivityString(requestInfo);
		Activity activityInfo=new Activity();
		activityInfo.setActivity_data_num(requestInfo.getNum());
		activityInfo.setLast_activity(result);
		activityDao.addActivity(activityInfo);
	}
	
	/**
	 * 액티비티 html 문서를 생성하는 함수
	 * @param requestInfo
	 * @return
	 */
	public String makeActivityString(ActivityDataMember requestInfo){
		
		ListDTO listInfo,toListInfo,fromListInfo = new ListDTO();
		Card cardInfo = new Card();
		MemberGrade memberGradeInfo=new MemberGrade();
		Member memberInfo= new Member();
		
		String result="";
		String format=requestInfo.getFormat();
		
		result+="<div class=\"activity-unit\">"+
				"<div class=\"dropdown activity-unit-my\">"+
					"<div class=\"my-img-wrapper dropdown-toggle\" data-toggle=\"dropdown\">"+
						"<span><img id=\"my-img_"+requestInfo.getMemId()+"\" class=\"my-img\" src="+requestInfo.getProfile_image()+"><span>"+
					"</div>"+
					"<div id=\"my-dropdown-view-content\" class=\"dropdown-menu\" >"+
						"<div class=\"my-members-info\">"+
							"<div class=\"my-members-info-wrapper\">"+
								"<div class=\"my-members-info-img-wrapper\">"+
									"<img class=\"my-members-info-img\" src=\""+requestInfo.getProfile_image()+"\">"+
								"</div>"+
								"<div class=\"my-members-info-text-wrapper\">"+
									"<span class=\"my-member-name\">"+requestInfo.getName()+"</span>"+
									"<span class=\"my-member-nickname\">("+requestInfo.getNickname()+")</span>"+
									"<br><span class=\"my-member-email\">"+requestInfo.getEmail()+"</span>"+
								"</div>"+
								"<div class=\"my-members-close-btn\"><span class=\"glyphicon glyphicon-remove\"></span></div>"+
							"</div>"+
						"</div>"+
					"</div>"+
				"</div>"+
				"<div class=\"activity-unit-contents-wrapper\">";
			
			format=format.replace("#me#",activity_memberInfo_setting_dropdown(requestInfo));
		
			switch(requestInfo.getActivity_name()){
			case "create_board":
				break;
			case "addList":
				listInfo=getListInfo(requestInfo.getValue_num());
				format=format.replace("#listName#","<span class=\"listInfo-dropdown-view\">"+listInfo.getName()+"</span>");
				break;
			case "addCard":
				toListInfo=getListInfo(requestInfo.getTo_num());
				cardInfo=getCardInfo(requestInfo.getValue_num());
				format=format.replace("#listName#","<span class=\"listInfo-dropdown-view\">"+toListInfo.getName()+"</span>");
					format=format.replace("#cardName#",
							"<a class=\"cardInfo-dropdown-view\"  onclick=\"editCard("+cardInfo.getNum()+")\" data-toggle=\"modal\" data-target=\"#cardInfoView\">"+cardInfo.getName()+"</a>"
							);
				break;
			case "updateCardLocation":
				toListInfo=getListInfo(requestInfo.getTo_num());
				fromListInfo=getListInfo(requestInfo.getFrom_num());
				cardInfo=getCardInfo(requestInfo.getValue_num());
				format=format.replace("#toListName#","<span class=\"listInfo-dropdown-view\">"+toListInfo.getName()+"</span>");
				format=format.replace("#fromListName#","<span class=\"listInfo-dropdown-view\">"+fromListInfo.getName()+"</span>");
			
				format=format.replace("#cardName#",
						"<a class=\"cardInfo-dropdown-view\"  onclick=\"editCard("+cardInfo.getNum()+")\" data-toggle=\"modal\" data-target=\"#cardInfoView\">"+cardInfo.getName()+"</a>"
						);
			break;
			case "addFriend":
				memberGradeInfo.setbNum(requestInfo.getbNum());
				memberGradeInfo.setmemId(requestInfo.getValue_string());
				/*getFriendInfo의 매개변수는 memberGrade, 리턴타입은 member임. */
				memberInfo=getFriendInfo(memberGradeInfo);
				/*dto형식 바꾸기*/
				ActivityDataMember memberInfoToActivityData= new ActivityDataMember();
				memberInfoToActivityData.setName(memberInfo.getName());
				memberInfoToActivityData.setNickname(memberInfo.getNickname());
				memberInfoToActivityData.setEmail(memberInfo.getEmail());
				memberInfoToActivityData.setProfile_image(memberInfo.getProfile_image());
				String grade="";
				if(memberInfo.getGrade()==1){grade="an admin";}
				else if(memberInfo.getGrade()==2){grade="a member";}
				//var get_friend_info=activity_getFriendInfo(val.value_string);
				//format=format.replace("#me#","<span class=\"memberInfo-dropdown-view\">"+val.nickname+"</span>");
				format=format.replace("#friendName#",activity_memberInfo_setting_dropdown(memberInfoToActivityData));
				format=format.replace("#authority#","<span class=\"friendInfo-auth-dropdown-view\">"+grade+"</span>");
				break;
			case "deleteCard":
				toListInfo=getListInfo(requestInfo.getFrom_num());
//				cardInfo=getCardInfo(requestInfo.getValue_num());
				format=format.replace("#listName#","<span class=\"listInfo-dropdown-view\">"+toListInfo.getName()+"</span>");
//				format=format.replace("#cardName#",
//							"<a class=\"cardInfo-dropdown-view\">"+cardInfo.getName()+"</a>"
//							);
				break;
		
			}
		result+=format;
		result+="</div></div>";
		
		return result;

	}
	
	public String activity_memberInfo_setting_dropdown(ActivityDataMember val){
		return "<div class=\"dropdown activity-memberInfo-dropdown-view\">"+
			"<a class=\"activity-memberInfo-dropdown-view-btn dropdown-toggle\" data-toggle=\"dropdown\">"+
				"<span>"+val.getNickname()+"</span>"+
			"</a>"+
			"<div id=\"activity-memberInfo-dropdown-view-content\" class=\"dropdown-menu\" >"+
				"<div class=\"activity-members-info\">"+
					"<div class=\"activity-members-info-wrapper\">"+
						"<div class=\"activity-members-info-img-wrapper\">"+
							"<img class=\"activity-members-info-img\" src=\""+val.getProfile_image()+"\">"+
						"</div>"+
						"<div class=\"activity-members-info-text-wrapper\">"+
							"<span class=\"activity-member-name\">"+val.getName()+"</span>"+
							"<span class=\"activity-member-nickname\">("+val.getNickname()+")</span>"+
							"<br><span class=\"activity-member-email\">"+val.getEmail()+"</span>"+
						"</div>"+
						"<div class=\"activity-members-close-btn\"><span class=\"glyphicon glyphicon-remove\"></span></div>"+
					"</div>"+
				"</div>"+
			"</div>"+
		"</div>";
		}


	public void deleteCard(int cNum, int bNum,String memId, int lNum) {
		/**
		 * 1) 카드삭제후 현재 삭제된 카드를 가지고 있는 액티비티 다 가지고오기
		 * 2) activity_data_num으로 activity 삭제
		 * 3) "delete [카드이름] from [리스트이름]" 적어주기 
		 * 
		 */
		List<Activity> allCardActivity= new ArrayList<Activity>();
		allCardActivity=activityDao.getActivityByCardNum(cNum);
		
		//모든 액티비티 지우기. 
		activityDao.deleteActivityCardByNum(allCardActivity);
		
		//모든 액티비티_data지우기.
		activityDao.deleteActivityDataCardByActivityDataNum(allCardActivity);
		
		
		//삭제했다는 액티비티 추가.
		ActivityDataMember requestInfo= new ActivityDataMember();
		requestInfo.setbNum(bNum);
//		requestInfo.setValue_num(cNum);
		requestInfo.setMemId(memId);
		requestInfo.setFrom_num(lNum);
		requestInfo.setActivity_name("deleteCard");
		requestInfo.setActivity_name_num(activityDao.getActivityNumByActivityName(requestInfo.getActivity_name()));
		activityDao.insertCardDeleteActivityData(requestInfo);
		
		
		addActivity(requestInfo);
		
		/*
		Iterator<Activity> it = allCardActivity.iterator();
		while(it.hasNext()){
			Activity tempActivity=new Activity();
			tempActivity=it.next();
			
			int activity_data_num= tempActivity.getNum();
			
			//액티비티 다 지우기
			activityDao.deleteCardByNum(activity_data_num);
			
			
			//
			
			
			
			String last_activity= tempActivity.getLast_activity();
			String [] value=last_activity.split("onclick=\"editCard\\(");
			int start=value[1].indexOf("data-target=\"#cardInfoView\"");
			String subStringResult=value[1].substring(start+27);
			
			String result= value[0]+subStringResult;
			tempActivity.setLast_activity(result);
			
		}*/
		
		//updateDeletedCards(allCardActivity);
	}


/*	private void updateDeletedCards(List<Activity> allCardActivity) {
		
		activityDao.updateDeletedCards(allCardActivity);
		
	}*/

	/**
	 * 카드이름을 바꿨을 때 액티비티에서도 모든 이름을 바꿔주어야함.
	 * @param card
	 */
	public void updateActivity(String type,int num) {
		/**
		 * 1) num으로 value_num에 있는 모든 액티비티데이터 불러오기
		 * 2) 다시 html string 으로 작성
		 * 3) activity에 update시키기
		 * 
		 *  1) num이 to_num, from_num, value_num에 있는 모든 액티비티데이터 불러오기
		 *  2) 다시 html String으로 작성
		 *  3) activity에 update시키기 
		 */
		List<ActivityDataMember> allActivityData= new ArrayList<ActivityDataMember>();
		
		switch (type){
		case "changeCardName":
			allActivityData=activityDao.getActivityDataByCardNum(num);
			break;
		case "changeListName":
			allActivityData=activityDao.getActivityDataByListNum(num);
			break;
		}
		
		Iterator<ActivityDataMember> it = allActivityData.iterator();
		while(it.hasNext()){
			ActivityDataMember requestInfo= it.next();
			String result=makeActivityString(requestInfo);
			
			Activity activityInfo=new Activity();
			activityInfo.setActivity_data_num(requestInfo.getNum());
			activityInfo.setLast_activity(result);
			
			activityDao.updateActivity(activityInfo);
		}
		
	}
	
	
}
