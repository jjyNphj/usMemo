<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<title>Insert title here</title>

<script type="text/javascript">
function goPage(bNum,name){
    var answer=confirm("선택하신 보드를 보러 가시겠습니까?");
        if(answer){ 
            var url ='/usMemo/board/index?bNum='+ bNum.value+'&name='+name.value;
                window.open(url, "_self",  '');
         }   
    }
/* function goDeletePage(bNum,name) {
	var answer=confirm("선택하신 보드를 삭제하시겠습니까?");
		if(answer){ 
	        var url ='/usMemo/board/deleteBoard?bNum='+ bNum.value+'&name='+name.value;
	            window.open(url, "_self",  '');
	     }
} */
function deleteBoard(bNum,name){
	console.log(bNum);
	var answer=confirm("보드의 하위 내용도 전부 사라집니다. 정말로 삭제 하시겠습니까?");
	if(answer){ 
		 /*lnum과 sessionid로 card에 정보 넣기*/
		 /* var u='#boardContents'+bNum.value;
		 var name=name; */
		 var url='/usMemo/board/deleteBoard?bNum='+bNum.value+'&name='+name.value;
		  $.ajax({
	       url: url,	      
	       type:'post',
	       
	       success:function(){	       
	       	alert("보드가 삭제 되었습니다.");
	       	window.location.reload();
	       } ,
	      error : function(xhr, status, error) {
	          alert(error);
	    }
	   })
	}
}
</script>

</head>

<body>
	<form>
		<!-- 현재 memId에 연결된 Board의 bNum들  뷰에 보여주기-->
		<c:forEach var="list" items="${Board}" varStatus="i">
			<!-- Board.java의 변수 bNum,name? var="변수이름",items="반복데이터가 있는 아이템(리스트or배열)", --> 
			<!-- varStatus="반복 상태값 지닌 변수" value="출력될 값" varStatus인덱스 종류 i.index=0부터 시작, i.count=1부터 시작 -->
			<input type="hidden" name=bNum${i.index} value="${list.bNum}" />
			<input type="hidden" name=name${i.index} value="${list.name}" />

			<h1>${list.bNum}, ${list.name} </h1>
			<input type="button" value="보러가기" onclick="goPage(bNum${i.index},name${i.index })" />
			<input type="button" value="삭제하기" class="deleteBoardBtn" onclick="deleteBoard(bNum${i.index},name${i.index })" />
			<%-- <input type="button" value="삭제하기" onclick="goDeletePage(bNum${i.index},name${i.index })" /> --%>
			</br>
		</c:forEach>
	</form>
	

</body>
</html>