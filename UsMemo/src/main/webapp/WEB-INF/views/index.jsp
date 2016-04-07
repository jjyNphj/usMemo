<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>UsMemo.index</title>

<script src="resources/naverLogin.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
<!-- 없으면 http://ip:8080/favicon.ico 404 Not Found 오류남, 근데 아래 사용시 보안 허술해질수도..? 아마도..-->
<intercept-url pattern="/favicon.ico" access="ROLE_ANONYMOUS" />
</head>

<body>
	<div id="area">
	<center><h1>UsMemo 메인화면</h1></center>
	<button id="loginBtn" onclick='loginNaver()'>네이버로 로그인하기</button>
	<button id="logoutBtn" onclick='logoutNaver()'>로그아웃</button>
	<button id="userinfoBtn" onclick='getNaverUserInfo()'>내 정보 보기</button>
	
	</div>
	<script type="text/javascript">
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
		var naver = NaverAuthorize({
			client_id : "ZnxAOuCVv8j9OLASYEHE",
			redirect_uri : "http://192.168.0.2:8080/usMemo/loginPro",
			client_secret : "tJrkiSgMRo"
		});

		function loginNaver() {
			var state = generateState();
			saveState(state);
			naver.login(state);
		}

		$("#NaverIdLoginBTN").click(function() {
			var state = generateState();
			saveState(state);
			naver.login(state);
		});

		function getNaverUserInfo() {
			naver.api(/* URI, */tokenInfo.access_token, function(data) {
				var response = data._response.responseJSON;
				console.log("success to get user info", response);
				/*컨트롤러로 사용자 정보 넘기기*/
				
				/* alert(response.response.email + ', ' + response.response.id
						+ ', ' + response.response.nickname); */
			});
		}
		function logoutNaver() {

			naver.logout(tokenInfo.access_token, function(data) {

				$.removeCookie("state_token");
				var response = data._response.responseJSON;
				tokenInfo.access_token = response.access_token;
				tokenInfo.refresh_token = response.refresh_token;

			});
			console.log("access", tokenInfo.access_token);
			console.log("refresh", tokenInfo.refresh_token);
			//console.log("state",state_check);

		}
	</script>
	<script type="text/javascript">
		/* function loginButton() {
			var button='';
		function loginButton() {
			var dynamicTag = '';
			$('#area').append(dynamicTag);
			$('#logout').click(function() {
				logoutNaver();
			});

			var dynamicTag2 = '';
			$('#area').append(dynamicTag2);
			$('#userinfo').click(function() {
				getNaverUserInfo();
			});
		}
 */
		window.onload = function() {
			// callback이 오면 checkLoginState()함수를 호출한다.
			checkLoginState();
			if(checkCookie()==undefined)
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