package com.twogather.usMemo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RequestMapping("/board")
@Controller
public class BoardController {
	
	/*
	 * 로그인 회원정보-> 회원번호로 회원의 보드 보여주기 / 보드의 메인인 셈 
	 */
	
	
	@RequestMapping("/main")
	public String boardMain(@RequestParam int memberNum){
		
		/*
		 * 회원번호를 서비스로 넘기기 
		 * 서비스에서는 dao에서 가지고 온 정보 넘겨주기
		 * dao호출로 db에서 board의 이름,보드번호를 가지고오기
		 * 
		 */
		
		String a=null;
		return a;
		
	}
	
	
	
	
	

}
