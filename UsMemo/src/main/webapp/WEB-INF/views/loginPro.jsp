<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
window.onload = function() {
	// callback이 오면 checkLoginState()함수를 호출한다.
	checkLoginState();
	/* if(checkCookie()==undefined)
		{
			$('#loginBtn').show();	
			$('#logoutBtn').hide();	
			$('#userinfoBtn').hide();
		}
	else{
			$('#loginBtn').hide();
			$('#logoutBtn').show();
			$('#userinfoBtn').show();
	}
 */
}

function checkCookie(){
	return $.cookie("state_token");
}

var tokenInfo = {
	access_token : "",
	refresh_token : ""
};
function checkLoginState() {
	var state = $.cookie("state_token");
	//state_check=state;
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
			$.cookie("access_token", response.access_token); */
			//sonsole.log에 나온다.
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