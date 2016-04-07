package com.twogether.usMemo;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Board;
import com.twogether.usMemo.dto.MemberGrade;
import com.twogether.usMemo.service.BoardService;


@RequestMapping("/board")
@Controller
public class BoardController {
	@Autowired
	BoardService boardService;
	

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	/*
	 * 로그인 회원정보-> 회원번호로 회원의 보드 보여주기 / 보드의 메인인 셈 
	 */

	@RequestMapping("/login")
	public String boardLogin(){
		return "login";
	}
	
	@RequestMapping("/main")
	public ModelAndView boardMain(@RequestParam int mNum){
		
		/*
		 * 1) 회원번호를 memberGrade로 가서 그 사람의 모든 boardNum가지고오기
		 * 2) 모든 boardNum으로 board 테이블에서 이름과 boardNum을 가지고오기
		 * 3) 뷰에서 해당 board이름 적어주기 
		 * 
		 */
		ModelAndView mv= new ModelAndView();
		mv.setViewName("myBoard");
		mv.addObject("Board",boardService.myBoardList(mNum));
		
	//	logger.info("보드리스트이다.{}",boardService.myBoardList(mNum));
		
		return mv;
		
	}
	
	//ModelAttribute는 RequestParam과 비슷함. 그저 하나의 파라메터가 아닌 객체로 바인딩해서 받아오는것.
	@RequestMapping("/index")
	public ModelAndView boardIndex(@ModelAttribute Board board){
		//하나의 보드 화면 
		/*
		 * bNum으로 해당 보드의 리스트, 카드정보 가지고와야함. 
		 * 
		 */
		ModelAndView mv= new ModelAndView();
		mv.setViewName("board");
		mv.addObject("list", boardService.getList(board));
		mv.addObject("card",boardService.getCard(board));
		
		return mv;
		
	}
	
	

}
