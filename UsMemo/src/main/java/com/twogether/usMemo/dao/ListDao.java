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
		//���ν����� out������ ��� num���� ���ٸ� ������ ��� �Ű������� �־��� listDTO�� ����� ���·� ��ȯ�ȴ�. 
		//���� ��ü�� �ٽ� �����Ͽ� ListDTO result= sqlMappClientTemplate.queryForObject("List.addListProc",listDTO); �̷������� ��ȯ�� �ʿ䰡 ����. 
		//�̶��� null �� ��ȯ�Ǵ� �����Ұ�. 
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
