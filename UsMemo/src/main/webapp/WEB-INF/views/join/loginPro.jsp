<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>


<script src="resources/naverLogin.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
<!-- 없으면 http://ip:8080/favicon.ico 404 Not Found 오류남, 근데 아래 사용시 보안 허술해질수도..? 아마도..-->
<intercept-url pattern="/favicon.ico" access="ROLE_ANONYMOUS" />

</head>
<body>
${sessionScope.id }
<script type="text/javascript">
/* var checklogout='${checklogout}'; */
		var access_token= $.cookie("access_token");
		var refresh_token= $.cookie("refresh_token");
		var state_token= $.cookie("state_token");

var naver = NaverAuthorize({
	client_id : "h1ZMSWqDjJSY20p865Ys",
	redirect_uri : "http://192.168.0.13:8080/usMemo/loginPro",
	client_secret : "fCKQuU8hmN"
});

window.onload = function() {
/* 	console.log("체크:",checklogout);
	if(checklogout=="Y"){ */
		deleteNaverInfo();
/* 	}
	// callback이 오면 checkLoginState()함수를 호출한다.
	else{/* checkLoginState(); }*/ 

}
function deleteNaverInfo() {
	console.log("=====로그아웃들어옴========================================"); 
	log("<로그아웃전>",access_token,refresh_token,state_token);

	
/* 	naver.logout(tokenInfo.access_token); */
	naver.logout($.cookie("access_token"),function(data){
		var response = data._response.responseJSON;
		console.log("=====로그아웃 후 콜백들어옴========================================"); 
		 access_token= response.access_token;
		 refresh_token= response.refresh_token;
		 state_token=  $.cookie("state_token");
		
		log("<네이버 로그아웃후>",access_token,refresh_token,state_token);
		
		$.removeCookie("state_token");
		/* $.removeCookie("refresh_token");
		$.removeCookie("access_token"); */
		
/* 		access_token= $.cookie("access_token");
		refresh_token= $.cookie("refresh_token"); */
		state_token= $.cookie("state_token");
		log("<쿠키 삭제후>",access_token,refresh_token,state_token);
		
		
		/*세션 넣고 index페이지로 다시 보내주기 */
		var url ='/usMemo/index';
   		window.open(url, "_self",  ''); 

	});
/* 	console.log("access", tokenInfo.access_token);
	console.log("refresh", tokenInfo.refresh_token); */
	//console.log("state",state_check);
/* 	checklogout='N'; */
}

function log(message, access, refresh, state ){
	console.log("==================================");
	console.log(message);
	console.log(" access_token : ",access );
	console.log(" refresh_token:",refresh );
	console.log(" state_token: ",state);
	console.log("==================================");
}
</script>

</body>
</html>
