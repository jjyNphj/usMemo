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
import com.twogether.usMemo.dto.ActivityData;
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
		
	ActivityData requestInfo= new ActivityData();
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
		ActivityData requestInfo= new ActivityData();
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
		ActivityData requestInfo= new ActivityData();
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
		//string¿ª json¿∏∑Œ ∆ƒΩÃΩ√≈¥.
		JSONObject obj=(JSONObject)jsonPaser.parse(cardLocation);
		
		ActivityData requestInfo= new ActivityData();
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
		
		ActivityData requestInfo= new ActivityData();
		requestInfo.setMemId(memId);
		requestInfo.setbNum(addMemberInfo.getbNum());
		requestInfo.setValue_string(addMemberInfo.getmemId());
		activityDao.addFriend(requestInfo);
	}


	public Member getFriendInfo(MemberGrade memberInfo) {
		
		return activityDao.getFriendInfo(memberInfo);
	}


	public void addActivity(ActivityData requestInfo) {
		requestInfo=activityDao.getActivityDataByNum(requestInfo);
		
		ListDTO listInfo,toListInfo,fromListInfo = new ListDTO();
		Card cardInfo = new Card();
		
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
				//format=format.replace("#me#","<span class=\"memberInfo-dropdown-view\">"+requestInfo.getNickname()+"</span>");
				//result+=format;
				break;
			case "addList":
				listInfo=getListInfo(requestInfo.getValue_num());
				//var get_list_name=activity_getListInfo(requestInfo.getValue_num());
				//format=format.replace("#me#","<span class=\"memberInfo-dropdown-view\">"+requestInfo.getNickname()+"</span>");
				format=format.replace("#listName#","<span class=\"listInfo-dropdown-view\">"+listInfo.getName()+"</span>");
				//result+=format;
				break;
			case "addCard":
				toListInfo=getListInfo(requestInfo.getTo_num());
				//var get_list_name=activity_getListInfo(val.to_num);
				cardInfo=getCardInfo(requestInfo.getValue_num());
				//format=format.replace("#me#","<span class=\"memberInfo-dropdown-view\">"+val.nickname+"</span>");
				format=format.replace("#listName#","<span class=\"listInfo-dropdown-view\">"+toListInfo.getName()+"</span>");
				format=format.replace("#cardName#",
						"<a class=\"cardInfo-dropdown-view\"  onclick=\"editCard("+cardInfo.getNum()+")\" data-toggle=\"modal\" data-target=\"#cardInfoView\">"+cardInfo.getName()+"</a>"
						);
				break;
			case "updateCardLocation":
				toListInfo=getListInfo(requestInfo.getTo_num());
				fromListInfo=getListInfo(requestInfo.getFrom_num());
				cardInfo=getCardInfo(requestInfo.getValue_num());
/*			var get_to_list_name=activity_getListInfo(val.to_num);
			var get_from_list_name=activity_getListInfo(val.from_num);
			var get_card_name=activity_getCardInfo(val.value_num);*/
			//format=format.replace("#me#","<span class=\"memberInfo-dropdown-view\">"+val.nickname+"</span>");
			format=format.replace("#toListName#","<span class=\"listInfo-dropdown-view\">"+toListInfo.getName()+"</span>");
			format=format.replace("#fromListName#","<span class=\"listInfo-dropdown-view\">"+fromListInfo.getName()+"</span>");
			format=format.replace("#cardName#",
					"<a class=\"cardInfo-dropdown-view\"  onclick=\"editCard("+cardInfo.getNum()+")\" data-toggle=\"modal\" data-target=\"#cardInfoView\">"+cardInfo.getName()+"</a>"
					);
			break;
			/*case "addFriend":
			var get_friend_info=activity_getFriendInfo(val.value_string);
			format=format.replace("#me#","<span class=\"memberInfo-dropdown-view\">"+val.nickname+"</span>");
			format=format.replace("#firendName#",activity_memberInfo_setting_dropdown(get_friend_info));
			format=format.replace("#authority#","<span class=\"friendInfo-auth-dropdown-view\">"+get_friend_info.grade+"</span>");
			break;
		}*/
			}
		result+=format;
		result+="</div></div>";

		
		
		
	/*	
		$.each(data,function(index,val){
			var format=val.format;
			result+="<div class="activity-unit">"+
						"<div class="dropdown activity-unit-my">"+
							"<div class="my-img-wrapper dropdown-toggle" data-toggle="dropdown">"+
								"<span><img id="my-img_"+val.memId+"" class="my-img" src="+val.profile_image+"><span>"+
							"</div>"+
							"<div id="my-dropdown-view-content" class="dropdown-menu" >"+
								"<div class="my-members-info">"+
									"<div class="my-members-info-wrapper">"+
										"<div class="my-members-info-img-wrapper">"+
											"<img class="my-members-info-img" src=""+val.profile_image+"">"+
										"</div>"+
										"<div class="my-members-info-text-wrapper">"+
											"<span class="my-member-name">"+val.name+"</span>"+
											"<span class="my-member-nickname">("+val.nickname+")</span>"+
											"<br><span class="my-member-email">"+val.email+"</span>"+
										"</div>"+
										"<div class="my-members-close-btn"><span class="glyphicon glyphicon-remove"></span></div>"+
									"</div>"+
								"</div>"+
							"</div>"+
						"</div>"+
						"<div class="activity-unit-contents-wrapper">";
			format=format.replace("#me#",activity_memberInfo_setting_dropdown(val));
			
			switch (val.activity_name) {
			case "create_board":
				format=format.replace("#me#","<span class="memberInfo-dropdown-view">"+val.nickname+"</span>");
				//result+=format;
				break;
			case "addList":
				var get_list_name=activity_getListInfo(val.value_num);
				format=format.replace("#me#","<span class="memberInfo-dropdown-view">"+val.nickname+"</span>");
				format=format.replace("#listName#","<span class="listInfo-dropdown-view">"+get_list_name+"</span>");
				//result+=format;
				break;
			case "addCard":
				var get_list_name=activity_getListInfo(val.to_num);
				var get_card_name=activity_getCardInfo(val.value_num);
				format=format.replace("#me#","<span class="memberInfo-dropdown-view">"+val.nickname+"</span>");
				format=format.replace("#listName#","<span class="listInfo-dropdown-view">"+get_list_name+"</span>");
				format=format.replace("#cardName#",
						"<a class="cardInfo-dropdown-view"  onclick="editCard("+val.value_num+")" data-toggle="modal" data-target="#cardInfoView">"+get_card_name+"</a>"
						);
				break;
			case "updateCardLocation":
				var get_to_list_name=activity_getListInfo(val.to_num);
				var get_from_list_name=activity_getListInfo(val.from_num);
				var get_card_name=activity_getCardInfo(val.value_num);
				format=format.replace("#me#","<span class="memberInfo-dropdown-view">"+val.nickname+"</span>");
				format=format.replace("#toListName#","<span class="listInfo-dropdown-view">"+get_to_list_name+"</span>");
				format=format.replace("#fromListName#","<span class="listInfo-dropdown-view">"+get_from_list_name+"</span>");
				format=format.replace("#cardName#",
						"<a class="cardInfo-dropdown-view"  onclick="editCard("+val.value_num+")" data-toggle="modal" data-target="#cardInfoView">"+get_card_name+"</a>"
						);
				break;
			case "addFriend":
				var get_friend_info=activity_getFriendInfo(val.value_string);
				format=format.replace("#me#","<span class="memberInfo-dropdown-view">"+val.nickname+"</span>");
				format=format.replace("#firendName#",activity_memberInfo_setting_dropdown(get_friend_info));
				format=format.replace("#authority#","<span class="friendInfo-auth-dropdown-view">"+get_friend_info.grade+"</span>");
				break;
			}
			result+=format;
			result+="</div></div>"; //end of div, activity-unit
		});
*/	
		Activity activityInfo=new Activity();
		activityInfo.setActivity_data_num(requestInfo.getNum());
		activityInfo.setLast_activity(result);
		activityDao.addActivity(activityInfo);
	}
	
	public String activity_memberInfo_setting_dropdown(ActivityData val){
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
	
	
}
