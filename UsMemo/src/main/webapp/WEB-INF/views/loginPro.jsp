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
	
</head>
<body>
	<script type="text/javascript">
	var naver = NaverAuthorize({
		client_id : "ZnxAOuCVv8j9OLASYEHE",
		redirect_uri : "http://192.168.0.2:8080/usMemo/loginPro",
		client_secret : "tJrkiSgMRo"
	});
	function getNaverUserInfo() {
		naver.api(/* URI, */tokenInfo.access_token, function(data) {
			var response = data._response.responseJSON;
			console.log("success to get user info", response);
			/*��Ʈ�ѷ��� ����� ���� �ѱ��*/
			
		 	 alert(response.response.email + ', ' + response.response.id
					+ ', ' + response.response.nickname); 
			    
			var url ='/usMemo/testLogin/make?userEmail='+ response.response.email;
                window.open(url, "_self",  '');
			
		});
	}
	
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

	/* 	 	$.cookie("refresh_token", response.refresh_token);
			$.cookie("access_token", response.access_token);
	 */
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