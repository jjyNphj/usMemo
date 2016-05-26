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
	 * ResponseBody와 jackson을 이용해서 JSON을 파싱하고자 함!
	 * 참고> Spring3에서 jackson JSON 라이브러리와 ResponseBody 어노테이션 이용을 위해서는 
	 *    	pom.xml에 jackson-mapper-asl 추가와 interceptor-servlet.xml에 jacksonMessageConverter bean을  필수로 추가해야함!
	 * 참고2>@RequestBody는 json 형태로 전송되는 파라미터를 자동으로 javaClass형식으로 변환해서 받음.
	 * 		전송된 HTTP 요청 데이터를 String 타입의 cNum 파라미터로 전달(수신)
	 * 참고3>@ResponseBody는 클라이언트요청을 서버에서 처리 후 메소드가 리턴하는 자바 객체를  messageConverters를 통해 json 형태로 변환해서 전송
	 * 		RequestBody의 파라미터 데이터를 ResponseBody로 전송		
	 * 		return 값이 View가 아닌 HTTP Response Body(응답 몸체)에 직접 쓰여짐
	 * 		다시 말해, 자바 객체를 HTTP 응답 몸체로 전송 할 수 있음 -> ListAndCard 타입의 데이터를 HTTP 응답 데이터로 전송(송신)		
	 * */
	@ResponseBody	//클라이언트에게 전송할 응답 데이터를 JSON 객체로 변환
	public ListAndCard editCardWindow(@RequestBody String cNum) throws ParseException{
		//카드 수정하기 눌렀을때 세부창 뜨면서 리스트와 카드 정보 가져오는 부분
		
		ListAndCard listAndcard = new ListAndCard();
		
		//JSONParser(인터페이스) 객체 생성
		JSONParser jsonPaser = new JSONParser();
		//boardMain.jsp에서 넘어온 JSON 문자열(String)을 JSON Object로 만들어줌.
		JSONObject inputObj = (JSONObject)jsonPaser.parse(cNum);
		//cNum의 값을 추출 후 값을 String으로 반환. 반환된 String 타입을 다시 int형으로 변환.(card_SQL에서 검색하려는 cNum은 int형이므로)
		int intcNum = Integer.parseInt(inputObj.get("cNum").toString());
		
		//System.out.println("CardController intcNum = "+intcNum);
		
		listAndcard = cardService.editCardWindow(intcNum);
		return listAndcard;
	}
	
	@RequestMapping("/add/CardContent")
	public ModelAndView addCardContent(@ModelAttribute Card card){

		//카드 수정하기 눌렀을때 뜨는 세부창에서 자세하게 카드의 내용을 서술하고 저장하는 부분
		ModelAndView mv= new ModelAndView();
		
		mv.setViewName("board/boardMain");
		cardService.addCardContent(card);
		System.out.println("CardController card content: " + card.getContent());
		return mv;
	}
	
	@RequestMapping("/edit/CardName")
	public ModelAndView editCardName(@ModelAttribute Card card){
		
		//카드 수정하기 창에서 카드 이름을 수정하고 엔터를 칠 경우 저장하는 부분
		ModelAndView mv= new ModelAndView();

		mv.setViewName("board/boardMain");
		cardService.editCardName(card);
		System.out.println("CardController card name: " + card.getName());
		return mv;
	}
	
	/* 파일 업로드 화면 이동 */
	@RequestMapping(value="fileUploadAjax", method=RequestMethod.GET)
	public ModelAndView fileUploadAjaxForm() {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("board/boardMain");
		
		return mv;
	}
	
	/* 파일 업로드 처리 */
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
	
	/* 파일 다운로드 화면 이동 */
	@RequestMapping(value="fileListShow", method=RequestMethod.GET)
	public ModelAndView fileListShow() {
		
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("board/FileUploadTest");
		
		return mv;
	}
	
}
