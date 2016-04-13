package com.twogether.usMemo;

import java.io.Console;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Board;
import com.twogether.usMemo.dto.Member;
import com.twogether.usMemo.service.BoardService;


@RequestMapping("/board")
@Controller
public class BoardController {
	@Autowired
	BoardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	/*
	 * �α��� ȸ������-> ȸ����ȣ�� ȸ���� ���� �����ֱ� / ������ ������ �� 
	 */

	@RequestMapping("/login2")
	public String boardLogin(){
		return "login2";
	}
	
	@RequestMapping("/main")
	public ModelAndView boardMain(@RequestParam int memId){
		
		/*
		 * 1) ȸ����ȣ�� memberGrade�� ���� �� ����� ��� boardNum���������
		 * 2) ��� boardNum���� board ���̺��� �̸��� boardNum�� ���������
		 * 3) �信�� �ش� board�̸� �����ֱ� 
		 * 
		 */
		ModelAndView mv= new ModelAndView();
		//myBoard.jsp �θ�
		mv.setViewName("myBoard");	
		mv.addObject("Board",boardService.myBoardList(memId));
		
	//	logger.info("���帮��Ʈ�̴�.{}",boardService.myBoardList(mNum));
		
		return mv;
	}
	
	//ModelAttribute�� RequestParam�� �����. ���� �ϳ��� �Ķ���Ͱ� �ƴ� ��ü�� ���ε��ؼ� �޾ƿ��°�.
	@RequestMapping("/index")
	public ModelAndView boardIndex(@ModelAttribute Board board){
		//�ϳ��� ���� ȭ�� 
		/*
		 * bNum���� �ش� ������ ����Ʈ, ī������ ������;���. 
		 * 
		 */
		ModelAndView mv= new ModelAndView();
		mv.setViewName("board");
		mv.addObject("list", boardService.getList(board));
		mv.addObject("card",boardService.getCard(board));
		
		return mv;
	}
	
//	@RequestMapping("/createBoard")
//	public ModelAndView boardCreate(@RequestParam String name) {
//		System.out.println("���� �̸� :" + name);
//		
//		ModelAndView mv= new ModelAndView();
//		mv.setViewName("index");
//		
//		return mv;
//	}
	
	@RequestMapping("/createBoard")
	public ModelAndView boardCreate(@RequestParam String name, @RequestParam String memId) throws SQLException{
		logger.info("memId: {}",memId);
		ModelAndView mv = new ModelAndView();
		
		boardService.boardCreate(name, memId);

		mv.setViewName("index");
		//mv.addObject("Board",boardService.boardCreate(name));
		return mv;	
	}
	

}
