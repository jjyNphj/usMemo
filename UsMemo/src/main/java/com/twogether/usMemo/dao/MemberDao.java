package com.twogether.usMemo.dao;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.Member;
import com.twogether.usMemo.dto.MemberGrade;

@Repository
public class MemberDao {
		
	Logger logger = LoggerFactory.getLogger(this.getClass());
		@Autowired
		private SqlMapClientTemplate sqlMapClientTemplate;
		
		
		public void test(String id){
			logger.info("member id= {}",id);
		}
		public int getMemberById(String id){
			//회원정보가 DB에 존재하는지 확인
			int count = (Integer) sqlMapClientTemplate.queryForObject("Member.getMemberById",id);
			
			return count ;
			
		}


		public void setMember(Member member) {
			sqlMapClientTemplate.insert("Member.setMember", member);
			
		}
		
		public List<Member> getMemberList(int bNum) {
			return sqlMapClientTemplate.queryForList("Member.getMemberListBybNum",bNum);
		}

}
