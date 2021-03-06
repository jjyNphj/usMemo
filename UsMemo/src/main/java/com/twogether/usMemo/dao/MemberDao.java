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
		
		/**
		 * 친구검색 서비스
		 * @param memberFindInfo
		 * @return 검색결과가 여러개일 경우를 대비하여 list로 반환
		 */
		public List<Member> friendFind(String memberFindInfo) {
			
			return sqlMapClientTemplate.queryForList("Member.friendFind",memberFindInfo);
		}
		
		/**
		 * 친구 추가 서비스
		 * @param addMemberInfo
		 */
		public void addFriend(MemberGrade addMemberInfo) {
			
			sqlMapClientTemplate.insert("Member.addFriend",addMemberInfo);	
			
		}
		/**
		 * 친구 삭제 
		 * @param id
		 */
		public void deleteFriend(MemberGrade member) {
			
			sqlMapClientTemplate.delete("Member.deleteFriend",member);
		}
		
		/**
		 * 친구등급 변경
		 * @param member
		 */
		public void updateFriend(MemberGrade member) {
			sqlMapClientTemplate.update("Member.updateFriend",member);
		}
		
		/**
		 * 현재 로그인한 사람의 정보 
		 * @param id
		 * @return
		 */
		public Member getMyInfo(String id) {
			Member member= new Member();
			member=(Member) sqlMapClientTemplate.queryForObject("Member.getMyInfo",id);
			return member;
		}
		/**
		 * 현재 사용자가 이 보드를 즐겨찾기 선택 및 해제.
		 * @param boardInfo
		 */
		public void updateStar(MemberGrade boardInfo) {
			sqlMapClientTemplate.update("Member.updateStar",boardInfo);
		}
		/**
		 * 현재 사용자가 현재의 보드를 즐겨찾기로 설정했는지 여부 확인.
		 * @param memberGrade
		 * @return
		 */
		public String getThisBoardStar(MemberGrade memberGrade) {
			String result= (String)sqlMapClientTemplate.queryForObject("Member.getThisBoardStar", memberGrade);
			return result;
		}

}
