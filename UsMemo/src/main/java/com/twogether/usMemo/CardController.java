package com.twogether.usMemo;

import java.text.DateFormat;

import org.codehaus.jackson.JsonParser;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.simple.ParameterizedSingleColumnRowMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.twogether.usMemo.dto.Card;
import com.twogether.usMemo.dto.ListAndCard;
import com.twogether.usMemo.service.CardService;

@RequestMapping("/card")
@Controller
public class CardController {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	CardService cardService;
	
	
	@RequestMapping("/add")
	public ModelAndView addCard(@ModelAttribute Card card){
		
		ModelAndView mv= new ModelAndView();
		mv.addObject("sucess","y");
		mv.setViewName("board/boardMain");
		cardService.addCard(card);
		return mv;
		
	}
	
	@RequestMapping("/update/location")
	public String update(@RequestBody String cardLocation) throws ParseException{
		
		
		logger.info("check change location: {}",cardLocation.toString());
		cardService.updateLocation(cardLocation);
		return "/board/boardMain";
	}
	
	@RequestMapping("/edit")
	/*
	 * ResponseBody�� jackson�� �̿��ؼ� JSON�� �Ľ��ϰ��� ��!
	 * ����> Spring3���� jackson JSON ���̺귯���� ResponseBody ������̼� �̿��� ���ؼ��� 
	 *    	pom.xml�� jackson-mapper-asl �߰��� interceptor-servlet.xml�� jacksonMessageConverter bean��  �ʼ��� �߰��ؾ���!
	 * ����2>@RequestBody�� json ���·� ���۵Ǵ� �Ķ���͸� �ڵ����� javaClass�������� ��ȯ�ؼ� ����.
	 * 		���۵� HTTP ��û �����͸� String Ÿ���� cNum �Ķ���ͷ� ����(����)
	 * ����3>@ResponseBody�� Ŭ���̾�Ʈ��û�� �������� ó�� �� �޼ҵ尡 �����ϴ� �ڹ� ��ü��  messageConverters�� ���� json ���·� ��ȯ�ؼ� ����
	 * 		RequestBody�� �Ķ���� �����͸� ResponseBody�� ����		
	 * 		return ���� View�� �ƴ� HTTP Response Body(���� ��ü)�� ���� ������
	 * 		�ٽ� ����, �ڹ� ��ü�� HTTP ���� ��ü�� ���� �� �� ���� -> ListAndCard Ÿ���� �����͸� HTTP ���� �����ͷ� ����(�۽�)		
	 * */
	@ResponseBody	//Ŭ���̾�Ʈ���� ������ ���� �����͸� JSON ��ü�� ��ȯ
	public ListAndCard editCardWindow(@RequestBody String cNum) throws ParseException{
		//ī�� �����ϱ� �������� ����â �߸鼭 ����Ʈ�� ī�� ���� �������� �κ�
		
		ListAndCard listAndcard = new ListAndCard();
		
		//JSONParser(�������̽�) ��ü ����
		JSONParser jsonPaser = new JSONParser();
		//boardMain.jsp���� �Ѿ�� JSON ���ڿ�(String)�� JSON Object�� �������.
		JSONObject inputObj = (JSONObject)jsonPaser.parse(cNum);
		//cNum�� ���� ���� �� ���� String���� ��ȯ. ��ȯ�� String Ÿ���� �ٽ� int������ ��ȯ.(card_SQL���� �˻��Ϸ��� cNum�� int���̹Ƿ�)
		int intcNum = Integer.parseInt(inputObj.get("cNum").toString());
		
		//System.out.println("CardController intcNum = "+intcNum);
		
		listAndcard = cardService.editCardWindow(intcNum);
		return listAndcard;
	}
	
	@RequestMapping("/add/CardContent")
	public ModelAndView addCardContent(@ModelAttribute Card card){

		//ī�� �����ϱ� �������� �ߴ� ����â���� �ڼ��ϰ� ī���� ������ �����ϰ� �����ϴ� �κ�
		ModelAndView mv= new ModelAndView();
		
		mv.setViewName("board/boardMain");
		cardService.addCardContent(card);
		System.out.println("CardController card content: " + card.getContent());
		return mv;
	}
	
	@RequestMapping("/edit/CardName")
	public ModelAndView editCardName(@ModelAttribute Card card){
		
		//ī�� �����ϱ� â���� ī�� �̸��� �����ϰ� ���͸� ĥ ��� �����ϴ� �κ�
		ModelAndView mv= new ModelAndView();

		mv.setViewName("board/boardMain");
		cardService.editCardName(card);
		System.out.println("CardController card name: " + card.getName());
		return mv;
	}
	
	/* ���� ���ε� ȭ�� �̵� */
	@RequestMapping(value="fileUploadAjax", method=RequestMethod.GET)
	public ModelAndView fileUploadAjaxForm() {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("board/boardMain");
		
		return mv;
	}
	
	/* ���� ���ε� ó�� */
	@RequestMapping(value="fileUploadAjax", method=RequestMethod.POST)
	public ModelAndView fileUploadAjax(MultipartHttpServletRequest mRequest, @RequestParam int cNum) {
		
		ModelAndView mv = new ModelAndView();
		
		if(cardService.fileUpload(mRequest,cNum)) {
			mv.addObject("result", "SUCCESS");
			System.out.println("success");
		} else {
			mv.addObject("result", "FAIL");
		}
		
		mv.setViewName("JSON");
		
		return mv;
	}
	
	/* ���� �ٿ�ε� ȭ�� �̵� */
	@RequestMapping(value="fileListShow", method=RequestMethod.GET)
	public ModelAndView fileListShow() {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("board/FileUploadTest");
		
		return mv;
	}
	
}
