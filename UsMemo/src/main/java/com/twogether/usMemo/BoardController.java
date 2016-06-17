package com.twogether.usMemo;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Board;
import com.twogether.usMemo.dto.BoardInfo;
import com.twogether.usMemo.dto.ListDTO;
import com.twogether.usMemo.service.ActivityService;
import com.twogether.usMemo.service.BoardService;
import com.twogether.usMemo.service.MemberService;


@RequestMapping("/board")
@Controller
public class BoardController {
	@Autowired BoardService boardService;
	@Autowired MemberService memberService;
	@Autowired ActivityService activityService;
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	/*
	 * �α��� ȸ������-> ȸ����ȣ�� ȸ���� ���� �����ֱ� / ������ ������ �� 
	 */

	@RequestMapping("/login2")
	public String boardLogin(){
		return "login2";
	}
	
	@RequestMapping("/main")
	public ModelAndView boardMain(@RequestParam String memId){
		
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
		mv.addObject("myInfo",memberService.getMyInfo(memId));
	//	logger.info("���帮��Ʈ�̴�.{}",boardService.myBoardList(mNum));
		
		return mv;
	}
	
	//ModelAttribute�� RequestParam�� �����. ���� �ϳ��� �Ķ���Ͱ� �ƴ� ��ü�� ���ε��ؼ� �޾ƿ��°�.
	@RequestMapping("/index/{memId}")
	public ModelAndView boardIndex(@ModelAttribute Board board, @PathVariable("memId") String id){
		//�ϳ��� ���� ȭ�� 
		/*
		 * bNum���� �ش� ������ ����Ʈ, ī������ ������;���. 
		 */
		HashMap<String, List> map=boardService.getListAndCard(board);
		ModelAndView mv= new ModelAndView();
		mv.setViewName("board/boardMain");
		mv.addObject("listList", map.get("listList"));
		mv.addObject("cardList",map.get("cardList"));
		mv.addObject("bNum",board.getbNum());
		mv.addObject("bName",boardService.getBoardName(board.getbNum()));
		mv.addObject("myInfo",memberService.getMyInfo(id));
		mv.addObject("star",memberService.getThisBoardStar(board.getbNum(),id));
		return mv;
	}
	
	@RequestMapping("/deleteBoard")
	public ModelAndView boardDelete(@RequestParam int bNum) throws SQLException {
		logger.info("bNum: {}",bNum);
		/*
		 * ����ڰ� ������ ����(bNum)�� �ش��ϴ� card,list,memberGrade,board �� ��� ����
		 * */

		ModelAndView mv= new ModelAndView();
		mv.addObject("sucess","y");
		//myBoard.jsp �θ�
		//mv.setViewName("board/myBoard");
		mv.setViewName("myBoard");	
		//DB ����� ���� ������ �κ�, myBoard.jsp���� ���õ� bNum ����
		boardService.getBoardDelete(bNum);
		//mv.addObject("Board",boardService.myBoardList(memId));
		return mv;
	}
	
	@RequestMapping("/createBoard")
	public ModelAndView boardCreate(@RequestParam String name, @RequestParam String memId) throws SQLException{
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("sucess","y");
		mv.setViewName("myBoard");
		int nowBNum=boardService.boardCreate(name, memId);
		activityService.create_board(memId,nowBNum);
		
		return mv;	
	}
	
	@RequestMapping("/allBoards/{memId}")
	public @ResponseBody List<BoardInfo> getAllBoards(@PathVariable("memId") String memId ){
		List<BoardInfo> boardInfo= new ArrayList<BoardInfo>();
		boardInfo=boardService.getAllBoards(memId);

		return boardInfo;
	}
	
	@RequestMapping("/edit/boardName")
	public ModelAndView editBoardName(@ModelAttribute Board board){
		
		ModelAndView mv= new ModelAndView();

		mv.setViewName("board/boardMain");
		boardService.editBoardName(board);
		return mv;
	}

}
