package com.twogether.usMemo.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.twogether.usMemo.dto.ListDTO;

@Repository
public class ListDao {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	
	public void addList(ListDTO listDTO){
//		Map<String, Object> map=new HashMap<String, Object>();
//		map.put("name", listDTO.getName());
//		map.put("bNum", listDTO.getbNum());
		sqlMapClientTemplate.update("List.addListProc",listDTO);
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
