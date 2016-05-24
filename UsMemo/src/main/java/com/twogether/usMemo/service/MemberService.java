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
		 * 1) 회원조회
		 * 2) 있으면 세션
		 * 3) 없으면 insert 후 세션
		 */
/*		HttpSession session = null;
		session= pageContext.getSession();*/
		/**///초기화
		String id=member.getId();
		/*memberDao.test(id);*/
		int result=memberDao.getMemberById(id);
			if(result==0){
				//새로 가입시켜야함
				memberDao.setMember(member);
				
			}
			if(session != null){
//			session.invalidate();
				session.setAttribute("id",null);
				
			}
			session.setAttribute("id", member.getId());
			String check=(String)session.getAttribute("id");
	
		logger.info("세션아이디: {}", check);
		
	}

	/**
	 * 보드에서 메뉴창의 현재 참여하는 회원리스트 불러오는 서비스
	 * @param memberInfo
	 * @throws ParseException 
	 */
	public List<Member> getMemberList(MemberGrade memberInfo) {
		
		
/*		//Json파싱
		JSONParser jsonPaser = new JSONParser();
		JSONObject inputObj = (JSONObject)jsonPaser.parse(memberInfoString);
		MemberGrade memberInfo=new MemberGrade();
		memberInfo.setbNum(Integer.parseInt(inputObj.get("bNum").toString()));
		memberInfo.setmemId(inputObj.get("memId").toString());*/
		
		return memberDao.getMemberList(memberInfo.getbNum());
		
	}

	/**
	 * 친구 찾기 서비스
	 * @param memberFindInfo
	 */
	public List<Member> friendFind(String memberFindInfo,int bNum) {
		//member 테이블에서 찾기
		//memberFindInfo는 name,nickname,email정보임.
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
	 * 친구추가 서비스
	 * @param addMemberInfo
	 */
	public void addFriend(MemberGrade addMemberInfo) {
		memberDao.addFriend(addMemberInfo);
	}
	
	/**
	 * 친구삭제
	 * @param id
	 */

	public void deleteFriend(MemberGrade member) {
		memberDao.deleteFriend(member);
		
	}

	/**
	 * 친구 등급변경
	 * @param member
	 */
	public void updateFriend(MemberGrade member) {
		memberDao.updateFriend(member);
	}
	
	/**
	 * 현재 로그인한 사람의 정보 
	 * @param id
	 * @return
	 */
	public Member getMyInfo(String id){
		Member member = new Member();
		member=memberDao.getMyInfo(id);
		return member;
	}

}
