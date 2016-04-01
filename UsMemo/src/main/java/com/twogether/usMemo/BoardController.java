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
	 * �α��� ȸ������-> ȸ����ȣ�� ȸ���� ���� �����ֱ� / ������ ������ �� 
	 */

	@RequestMapping("/login")
	public String boardLogin(){
		return "board";
	}
	
	@RequestMapping("/main")
	public ModelAndView boardMain(@RequestParam int mNum){
		
		/*
		 * 1) ȸ����ȣ�� memberGrade�� ���� �� ����� ��� boardNum���������
		 * 2) ��� boardNum���� board ���̺��� �̸��� boardNum�� ���������
		 * 3) �信�� �ش� board�̸� �����ֱ� 
		 * 
		 */
		ModelAndView mv= new ModelAndView();
		mv.setViewName("myBoard");
		mv.addObject("Board",boardService.myBoardList(mNum));
		
	//	logger.info("���帮��Ʈ�̴�.{}",boardService.myBoardList(mNum));
		
		return mv;
		
	}
	
	

}
