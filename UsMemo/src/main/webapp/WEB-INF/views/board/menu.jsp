<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- 1) 현재 보드에 속해있는 인원 보여주기
	 2) 현재 접속자정보, 권한을 표시
	 3) 그 권한에 따라 권한변경버튼, 삭제버튼 보이기
	 -->
	 
	<c:forEach var="m" items="${memberList }">
		memId: ${m.id }<br>
		name: ${m.name } <br>
		nick: ${m.nickname }<br>
		email: ${m.email }<br>
		image: <img alt="profile_image" src="${m.profile_image }"> <br>
		grade: <c:if test="${m.grade == 1}"> 관리자</c:if>
				<c:if test="${m.grade == 2}"> 일반등급멤버</c:if>
		

	</c:forEach>
</body>
</html>