<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	세션적었음: ${sessionScope.id}
	
	<c:if test="${sessionScope.id == null }">
	<button id="loginBtn" onclick='loginNaver()'>네이버로 로그인하기</button>
	</c:if>
		<c:if test="${sessionScope.id != null }">
			<button id="logoutBtn" onclick="location.href='/usMemo/index.do'">로그아웃</button>
			<button id="userinfoBtn" onclick=''>내 정보 보기</button>
		</c:if>
	<%-- <c:choose>
	    <c:when test="${empty sessionScope.id } ">
			
		</c:when>
		
		<c:otherwise>
		</c:otherwise>
	</c:choose>
	 --%>
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
			redirect_uri : "http://192.168.0.2:8080/usMemo/login",
			client_secret : "tJrkiSgMRo"
		});

		function loginNaver() {
			var state = generateState();
			saveState(state);
			naver.login(state);
		}


	</script>
	

</body>
</html>