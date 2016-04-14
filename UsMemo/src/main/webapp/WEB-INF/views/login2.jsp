<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>로그인하면 보이는 보드 목록화면</h1>

<form action="/usMemo/board/main">
<input type="hidden" name="memId" value=${sessionScope.id } />
<button type="submit">보드보러가기 </button>
</form>


</body>
</html>