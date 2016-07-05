package com.twogether.usMemo.dao;

import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Activity;
import com.twogether.usMemo.dto.ActivityDataMember;
import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.dto.Member;
import com.twogether.usMemo.dto.MemberGrade;

@Repository
public class ActivityDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired SqlMapClientTemplate sqlMapClientTemplate;

	public void create_board(ActivityDataMember requestInfo) {
		sqlMapClientTemplate.insert("Activity.createBoard",requestInfo);

	}

	public List<Activity> getSomeActivity(Activity activity) {
		return sqlMapClientTemplate.queryForList("Activity.getSomeActivity",activity.getbNum());
	}

	public List<Activity> getAllActivity(Activity activity) {
		return sqlMapClientTemplate.queryForList("Activity.getAllActivity",activity.getbNum());
	}

	public void addList(ActivityDataMember requestInfo) {
		sqlMapClientTemplate.insert("Activity.addList",requestInfo);
	}

	public ListDTO getListInfo(int num) {
		// TODO Auto-generated method stub
		return (ListDTO) sqlMapClientTemplate.queryForObject("List.getListByLNum",num);
	}

	public void addCard(ActivityDataMember requestInfo) {

		sqlMapClientTemplate.insert("Activity.addCard",requestInfo);

	}

	public Card getCardInfo(int cardNum) {
		// TODO Auto-generated method stub
		return (Card) sqlMapClientTemplate.queryForObject("Card.getCardBycNum",cardNum);
	}

	public void updateCardLocation(ActivityDataMember requestInfo) {

		sqlMapClientTemplate.insert("Activity.updateCardLocation",requestInfo);

	}

	public void addFriend(ActivityDataMember requestInfo) {
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

	public ActivityDataMember getActivityDataByNum(ActivityDataMember requestInfo) {

		return (ActivityDataMember) sqlMapClientTemplate.queryForObject("Activity.getActivityDataByNum",requestInfo);

	}

	public void addActivity(Activity result) {

		sqlMapClientTemplate.insert("Activity.addActivity",result);

	}

	/*
	 * 카드의 번호를 value_num에 가지고 있는 모든 액티비티의 정보를 가지고옴. 
	 */
	public List<Activity> getActivityByCardNum(int cNum) {

		return sqlMapClientTemplate.queryForList("Activity.getActivityByCardNum",cNum);

	}
	/*
	public void updateDeletedCards(List<Activity> allCardActivity) {

		Iterator<Activity> it = allCardActivity.iterator();

		while(it.hasNext()){
			sqlMapClientTemplate.update("Activity.updateDeletedCards",it.next());
		}

	}*/

	public List<ActivityDataMember> getActivityDataByCardNum(int num) {

		return sqlMapClientTemplate.queryForList("Activity.getActivityDataByCardNum",num);
	}

	public List<ActivityDataMember> getActivityDataByListNum(int num) {
		return sqlMapClientTemplate.queryForList("Activity.getActivityDataByListNum",num);
	}

	public void updateActivity(Activity activityInfo) {

		sqlMapClientTemplate.update("Activity.updateActivity",activityInfo);
	}

	public void deleteActivityCardByNum(List<Activity> allCardActivity) {

		//activity에서 cardnum을 가진 모든 액티비티정보 지우기.
		Iterator<Activity> it = allCardActivity.iterator();

		while(it.hasNext()){
			sqlMapClientTemplate.delete("Activity.deleteActivityCardByNum",it.next().getNum());
		}

	}

	public void deleteActivityDataCardByActivityDataNum(
			List<Activity> allCardActivity) {

		//해당 카드가 가지고 있는 액티비디 data를 모두 지우기.

		Iterator<Activity> it = allCardActivity.iterator();

		while(it.hasNext()){
			sqlMapClientTemplate.delete("Activity.deleteActivityDataCardByActivityDataNum",it.next().getActivity_data_num());
			
		}

		}


	

	public void insertCardDeleteActivityData(ActivityDataMember requestInfo) {
		sqlMapClientTemplate.insert("Activity.insertCardDeleteActivityData",requestInfo);
		
	}}
