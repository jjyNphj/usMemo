package com.twogether.usMemo.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.MemberDao;
import com.twogether.usMemo.dto.Member;
import com.twogether.usMemo.dto.MemberGrade;


@Service
public class MemberService {

	@Autowired
	MemberDao memberDao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public void loginMember(Member member,HttpSession session) throws SQLException {
		/*
		 * 1) ȸ����ȸ
		 * 2) ������ ����
		 * 3) ������ insert �� ����
		 */
/*		HttpSession session = null;
		session= pageContext.getSession();*/
		/**///�ʱ�ȭ
		String id=member.getId();
		/*memberDao.test(id);*/
		int result=memberDao.getMemberById(id);
			if(result==0){
				//���� ���Խ��Ѿ���
				memberDao.setMember(member);
				
			}
			if(session != null){
//			session.invalidate();
				session.setAttribute("id",null);
				
			}
			session.setAttribute("id", member.getId());
			String check=(String)session.getAttribute("id");
	
		logger.info("���Ǿ��̵�: {}", check);
		
	}

	/**
	 * ���忡�� �޴�â�� ���� �����ϴ� ȸ������Ʈ �ҷ����� ����
	 * @param memberInfo
	 * @throws ParseException 
	 */
	public List<Member> getMemberList(MemberGrade memberInfo) {
		
		
/*		//Json�Ľ�
		JSONParser jsonPaser = new JSONParser();
		JSONObject inputObj = (JSONObject)jsonPaser.parse(memberInfoString);
		MemberGrade memberInfo=new MemberGrade();
		memberInfo.setbNum(Integer.parseInt(inputObj.get("bNum").toString()));
		memberInfo.setmemId(inputObj.get("memId").toString());*/
		
		return memberDao.getMemberList(memberInfo.getbNum());
		
	}

	/**
	 * ģ�� ã�� ����
	 * @param memberFindInfo
	 */
	public List<Member> friendFind(String memberFindInfo,int bNum) {
		//member ���̺��� ã��
		//memberFindInfo�� name,nickname,email������.
		List<Member> memberList=new ArrayList<Member>();
		memberList=memberDao.getMemberList(bNum);
		List<Member> findMembetList=new ArrayList<Member>();
		findMembetList=	memberDao.friendFind(memberFindInfo);
		
		ListIterator<Member> it = findMembetList.listIterator();
		
		while(it.hasNext()){
			Member findFriend=it.next();
			for(Member m:memberList){
				if(findFriend.getId().equals(m.getId()))
				{
					it.remove();
			}
		}
		}
			
		return findMembetList;
		
	}

	/**
	 * ģ���߰� ����
	 * @param addMemberInfo
	 */
	public void addFriend(MemberGrade addMemberInfo) {
		memberDao.addFriend(addMemberInfo);
	}
	
	/**
	 * ģ������
	 * @param id
	 */

	public void deleteFriend(MemberGrade member) {
		memberDao.deleteFriend(member);
		
	}

	/**
	 * ģ�� ��޺���
	 * @param member
	 */
	public void updateFriend(MemberGrade member) {
		memberDao.updateFriend(member);
	}
	
	/**
	 * ���� �α����� ����� ���� 
	 * @param id
	 * @return
	 */
	public Member getMyInfo(String id){
		Member member = new Member();
		member=memberDao.getMyInfo(id);
		return member;
	}

}
