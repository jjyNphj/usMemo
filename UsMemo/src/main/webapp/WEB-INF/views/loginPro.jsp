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
	// callback�� ���� checkLoginState()�Լ��� ȣ���Ѵ�.
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

		//���������� Callback������ ���޵Ǿ��� ��� Access Token�߱� ��û ����
		naver.getAccessToken(function(data) {

			var response = data._response.responseJSON;
			if (response.error === "fail") {
				//access token ���� ��û�� �����Ͽ��� ��쿡 ���� ó��
				return;
			}
			tokenInfo.access_token = response.access_token;
			tokenInfo.refresh_token = response.refresh_token;

		/* 	$.cookie("refresh_token", response.refresh_token);
			$.cookie("access_token", response.access_token); */
			//sonsole.log�� ���´�.
			console.log("success to get access token", response);
			getNaverUserInfo();
		});
	} else {
		//Callback���� ���޵� �����Ͱ� ���������� ���� ��쿡 ���� ó��
		return;
	}

}

</script>
</body>
</html>