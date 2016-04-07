package com.twogether.usMemo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.twogether.usMemo.service.MemberService;

@RequestMapping("/member")
@Controller
public class MemberController {
	@Autowired
	MemberService memberService;
	


}
