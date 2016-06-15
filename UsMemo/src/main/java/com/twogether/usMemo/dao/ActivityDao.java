package com.twogether.usMemo.dao;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Activity;
import com.twogether.usMemo.dto.ActivityData;
import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.dto.Member;
import com.twogether.usMemo.dto.MemberGrade;

@Repository
public class ActivityDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired SqlMapClientTemplate sqlMapClientTemplate;

	public void create_board(ActivityData requestInfo) {
		sqlMapClientTemplate.insert("Activity.createBoard",requestInfo);
		
	}

	public List<Activity> getSomeActivity(Activity activity) {
		return sqlMapClientTemplate.queryForList("Activity.getSomeActivity",activity.getbNum());
	}
	
	public List<Activity> getAllActivity(Activity activity) {
		return sqlMapClientTemplate.queryForList("Activity.getAllActivity",activity.getbNum());
	}

	public void addList(ActivityData requestInfo) {
		sqlMapClientTemplate.insert("Activity.addList",requestInfo);
	}

	public ListDTO getListInfo(int num) {
		// TODO Auto-generated method stub
		return (ListDTO) sqlMapClientTemplate.queryForObject("List.getListByLNum",num);
	}

	public void addCard(ActivityData requestInfo) {
		
		sqlMapClientTemplate.insert("Activity.addCard",requestInfo);
		
	}

	public Card getCardInfo(int cardNum) {
		// TODO Auto-generated method stub
		return (Card) sqlMapClientTemplate.queryForObject("Card.getCardBycNum",cardNum);
	}

	public void updateCardLocation(ActivityData requestInfo) {
		
		sqlMapClientTemplate.insert("Activity.updateCardLocation",requestInfo);
		
	}

	public void addFriend(ActivityData requestInfo) {
		sqlMapClientTemplate.insert("Activity.addFriend",requestInfo);
		
	}

	public Member getFriendInfo(MemberGrade memberInfo) {
		Member result= new Member();
		result = (Member) sqlMapClientTemplate.queryForObject("Member.getFriendInfo",memberInfo);
		return result;
		
	}

	public int getActivityNumByActivityName(String activity_name) {
		return (int) sqlMapClientTemplate.queryForObject("Activity.getActivityNumByActivityName",activity_name);
	}

	public ActivityData getActivityDataByNum(ActivityData requestInfo) {
		
		return (ActivityData) sqlMapClientTemplate.queryForObject("Activity.getActivityDataByNum",requestInfo);
		
	}

	public void addActivity(Activity result) {
		
		sqlMapClientTemplate.insert("Activity.addActivity",result);
		
	}
	
	
}
