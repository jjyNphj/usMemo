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
    var answer=confirm("선택하신 도서를 대출목록에서 삭제하시겠습니까?");
        if(answer){ 
            var url ='/usMemo/board/index?bNum='+ bNum.value+'&name='+name.value;
                window.open(url, "_self",  '');
         }   
    }
    
    window.onload = function() {
    	var check=${cardList0};
    }
</script>
</head>
<body>

 <form >
<c:forEach var="list" items="${listList}" varStatus="i">
		<%-- <input type="hidden" name=bNum${i.index}  value="${list.bNum}" />
		<input type="hidden" name=name${i.index}  value="${list.name}" /> --%>

<center><h1> ${list.num}, ${list.name}, ${list.location}</h1>
 <c:forEach var="c" items="${cardList}" >
		<c:if test="${list.num == c.card_lNum }">
		 	[${c.card_num }] ${c.card_name }, [${c.card_lNum }/${c.card_location }] </br>
		 </c:if>
		</c:forEach> </center>
	 <%-- <c:forEach var="num" begin="0" end="${cardListSize }" varStatus="k">
		 <c:set value="cardList${num }" var="cardListName" />
		 ${cardListName}
		 <c:forEach var="card" items="${${cardListName}}" varStatus="j">
	
		 [${card.num }] ${card.name }, [${card.lNum }/${card.location }] 
		</c:forEach> 
	</c:forEach>  --%>
<%-- <input type="button" value="선택" onclick="goPage(bNum${i.index},name${i.index })"/> --%>

</br>
</c:forEach>
</form>
</body>
</html>