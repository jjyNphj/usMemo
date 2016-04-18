<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>

<script type="text/javascript">
function goPage(bNum,name){
    var answer=confirm("선택하신 보드를 보러 가시겠습니까?");
        if(answer){ 
            var url ='/usMemo/board/index?bNum='+ bNum.value+'&name='+name.value;
                window.open(url, "_self",  '');
         }   
    }
function goDeletePage(bNum,name) {
	var answer=confirm("선택하신 보드를 삭제하시겠습니까?");
		if(answer){ 
	        var url ='/usMemo/board/deleteBoard?bNum='+ bNum.value+'&name='+name.value;
	            window.open(url, "_self",  '');
	     } 
} 
</script>
</head>

<body>
	<form>
		<c:forEach var="list" items="${Board}" varStatus="i">
			<!-- Board.java의 변수 bNum,name? var="변수이름",items="반복데이터가 있는 아이템(리스트or배열)", --> 
			<!-- varStatus="반복 상태값 지닌 변수" value="출력될 값" varStatus인덱스 종류 i.index=0부터 시작, i.count=1부터 시작 -->
			<input type="hidden" name=bNum${i.index} value="${list.bNum}" />
			<input type="hidden" name=name${i.index} value="${list.name}" />

			${list.bNum}, ${list.name}
			<input type="button" value="보러가기" onclick="goPage(bNum${i.index},name${i.index })" />
			<input type="button" value="삭제하기" onclick="goDeletePage(bNum${i.index},name${i.index })" />
			</br>
		</c:forEach>
	</form>
</body>
</html>