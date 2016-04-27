<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="resources/naverLogin.js"></script>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
	
</head>
<body>
	<script type="text/javascript">
	var naver = NaverAuthorize({
		client_id : "ZnxAOuCVv8j9OLASYEHE",
		redirect_uri : "http://192.168.0.2:8080/usMemo/login",
		client_secret : "tJrkiSgMRo"

	});
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
window.onload = function() {
	// callback이 오면 checkLoginState()함수를 호출한다.
	checkLoginState();

}


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

</script>
</body>
</html>
