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
<!-- ������ http://ip:8080/favicon.ico 404 Not Found ������, �ٵ� �Ʒ� ���� ���� �����������..? �Ƹ���..-->
<intercept-url pattern="/favicon.ico" access="ROLE_ANONYMOUS" />
</head>

<body>
	<div id="area">
	<center><h1>UsMemo ����ȭ��</h1></center>
	����������: ${sessionScope.id}
	
	<c:if test="${sessionScope.id == null }">
	<button id="loginBtn" onclick='loginNaver()'>���̹��� �α����ϱ�</button>
	</c:if>
		<c:if test="${sessionScope.id != null }">
			<button id="logoutBtn" onclick="location.href='/usMemo/index.do'">�α׾ƿ�</button>
			<button id="userinfoBtn" onclick=''>�� ���� ����</button>
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
			// CSRF ������ ���� state token ���� �ڵ�
			// state token�� ���� ������ ���� ���ǿ� ���� �Ǿ�� �մϴ�.
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