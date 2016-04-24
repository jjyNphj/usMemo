package com.twogether.usMemo;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Board;
import com.twogether.usMemo.dto.Card;
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

	@RequestMapping("/login2")
	public String boardLogin(){
		return "login2";
	}
	
	@RequestMapping("/main")
	public ModelAndView boardMain(@RequestParam String memId){
		
		/*
		 * 1) 회원번호를 memberGrade로 가서 그 사람의 모든 boardNum가지고오기
		 * 2) 모든 boardNum으로 board 테이블에서 이름과 boardNum을 가지고오기
		 * 3) 뷰에서 해당 board이름 적어주기 
		 * 
		 */
		ModelAndView mv= new ModelAndView();
		//myBoard.jsp 부름
		mv.setViewName("myBoard");	
		mv.addObject("Board",boardService.myBoardList(memId));
		
	//	logger.info("보드리스트이다.{}",boardService.myBoardList(mNum));
		
		return mv;
	}
	
	//ModelAttribute는 RequestParam과 비슷함. 그저 하나의 파라메터가 아닌 객체로 바인딩해서 받아오는것.
	@RequestMapping("/index")
	public ModelAndView boardIndex(@ModelAttribute Board board){
		//하나의 보드 화면 
		/*
		 * bNum으로 해당 보드의 리스트, 카드정보 가지고와야함. 
		 */
		HashMap<String, List> map=boardService.getListAndCard(board);
		ModelAndView mv= new ModelAndView();
		mv.setViewName("board/boardMain");
		mv.addObject("listList", map.get("listList"));
		mv.addObject("cardList",map.get("cardList"));
		mv.addObject("bNum",board.getbNum());
		return mv;
	}
	
	@RequestMapping("/deleteBoard")
	public ModelAndView boardDelete(@RequestParam int bNum) throws SQLException {
		logger.info("bNum: {}",bNum);
		/*
		 * 사용자가 선택한 보드(bNum)에 해당하는 card,list,memberGrade,board 행 모두 삭제
		 * */

		ModelAndView mv= new ModelAndView();
		mv.addObject("sucess","y");
		//myBoard.jsp 부름
		//mv.setViewName("board/myBoard");
		mv.setViewName("myBoard");	
		//DB 지우기 위해 보내는 부분, myBoard.jsp에서 선택된 bNum 전달
		boardService.getBoardDelete(bNum);
		//mv.addObject("Board",boardService.myBoardList(memId));
		return mv;
	}
	
	@RequestMapping("/createBoard")
	public ModelAndView boardCreate(@RequestParam String name, @RequestParam String memId) throws SQLException{
		logger.info("memId: {}",memId);
		
		ModelAndView mv = new ModelAndView();
		
		boardService.boardCreate(name, memId);

		mv.setViewName("index");

		return mv;	
	}

}
