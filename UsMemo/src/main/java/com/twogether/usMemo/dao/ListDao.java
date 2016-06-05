package com.twogether.usMemo.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.ListDTO;

@Repository
public class ListDao {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	
	public ListDTO addList(ListDTO listDTO){
		//프로시저의 out변수에 담긴 num값이 별다른 설정이 없어도 매개변수로 넣었던 listDTO에 저장된 상태로 반환된다. 
		//굳이 객체를 다시 생성하여 ListDTO result= sqlMappClientTemplate.queryForObject("List.addListProc",listDTO); 이런식으로 반환할 필요가 없다. 
		//이때는 null 이 반환되니 참고할것. 
		sqlMapClientTemplate.queryForObject("List.addListProc",listDTO);
		return listDTO;
	}

	public void update_rlink(ListDTO listDTO) {
		
		sqlMapClientTemplate.update("List.update_rlink",listDTO);
	}


	public void update_llink(ListDTO listDTO) {
		
		sqlMapClientTemplate.update("List.update_llink",listDTO);
		
	}
	
	public void update_allLink(ListDTO listDTO) {
		
		sqlMapClientTemplate.update("List.update_allLink",listDTO);
		
	}


}
