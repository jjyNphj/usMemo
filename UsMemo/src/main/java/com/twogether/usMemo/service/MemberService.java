package com.twogether.usMemo.service;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.twogether.usMemo.dao.MemberDao;
import com.twogether.usMemo.dto.Member;


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

}
