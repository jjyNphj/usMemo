package com.twogather.usMemo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RequestMapping("/board")
@Controller
public class BoardController {
	
	/*
	 * �α��� ȸ������-> ȸ����ȣ�� ȸ���� ���� �����ֱ� / ������ ������ �� 
	 */
	
	
	@RequestMapping("/main")
	public String boardMain(@RequestParam int memberNum){
		
		/*
		 * ȸ����ȣ�� ���񽺷� �ѱ�� 
		 * ���񽺿����� dao���� ������ �� ���� �Ѱ��ֱ�
		 * daoȣ��� db���� board�� �̸�,�����ȣ�� ���������
		 * 
		 */
		
		String a=null;
		return a;
		
	}
	
	
	
	
	

}
