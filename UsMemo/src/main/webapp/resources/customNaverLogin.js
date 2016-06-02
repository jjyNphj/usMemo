


/*지정 함수*/
var naver = NaverAuthorize({
	client_id : "ZnxAOuCVv8j9OLASYEHE",
	redirect_uri : "http://192.168.0.2:8080/usMemo/login",
	client_secret : "tJrkiSgMRo"
});

function generateState() {
	// CSRF 방지를 위한 state token 생성 코드
	// state token은 추후 검증을 위해 세션에 저장 되어야 합니다.
	var oDate = new Date();
	return oDate.getTime();
}
function saveState(state) {
	$.removeCookie("state_token");
	$.cookie("state_token", state);
}

function loginNaver() {
	var state = generateState();
	saveState(state);
	naver.login(state);
}

function deleteNaverInfo() {
	var access_token= $.cookie("access_token");
	var refresh_token= $.cookie("refresh_token");
	var state_token= $.cookie("state_token");

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

function getNaverUserInfo() {
	naver.api(/* URI, */tokenInfo.access_token, function(data) {
		var res = data._response.responseJSON;
		console.log("success to get user info", res);
		console.log(res.response);
		/*
		토큰 모두 지우기(사실상 네이버에서의 로그아웃)
		컨트롤러로 사용자 정보 넘기기
		*/
		
/*   alert(res.response.email + ', ' + res.response.id
				+ ', ' + res.response.nickname);  
		     */
		     
		var url ='/usMemo/loginPro?id='+ res.response.id+'&nickname='+res.response.nickname
				+'&name='+res.response.name+'&email='+res.response.email+'&profile_image='+res.response.profile_image;
            window.open(url, "_self",  '');
		     //logoutNaver();

		
	});
}

/* function logoutNaver() {
	  alert('로그아웃들어옴'); 
	naver.logout(tokenInfo.access_token);
	console.log("access", tokenInfo.access_token);
	console.log("refresh", tokenInfo.refresh_token);
	//console.log("state",state_check);

}
 */


var tokenInfo = {
access_token : "",	refresh_token : ""
};

function checkLoginState() {
var state = $.cookie("state_token");
if (naver.checkAuthorizeState(state) === "connected") {

	//정상적으로 Callback정보가 전달되었을 경우 Access Token발급 요청 수행
	naver.getAccessToken(function(data) {

		var response = data._response.responseJSON;
		if (response.error === "fail") {
			//access token 생성 요청이 실패하였을 경우에 대한 처리
			return;
		}
		tokenInfo.access_token = response.access_token;
		tokenInfo.refresh_token = response.refresh_token;

 	 /* 	$.cookie("refresh_token", response.refresh_token);
		$.cookie("access_token", response.access_token);
  */
		console.log("success to get access token", response);
		getNaverUserInfo();
	});
} else {
	//Callback으로 전달된 데이터가 정상적이지 않을 경우에 대한 처리
	return;
}

}