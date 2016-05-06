<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<script src="/usMemo/resources/textchange.js"></script>
<style type="text/css">
.hide {
	display: none;
}
</style>

</head>
<body>


<script type="text/javascript">
$(document).ready(function(){
	
$(".addMemberBtn").click(function(){
    // 현재 버튼의 옆의 태그중 div 태그에 hide 클래스 태그를 넣던지 빼던지 한다.
    $(this).next(".hide").toggleClass("hide");
    $(this).hide();
});

$(".cancelAddMemberBtn").click(function(){
	//cancel 클릭하면 기존에 적었던 정보 지우기
	$("#findMember").val('');
    //cancel 클릭했을 때 입력창 감추기! 
    $(this).parents("div").toggleClass("hide");
    //원래 버튼인 add card... 버튼 보이기 
   $(this).parents("div").prev(":button").show();
});

$("#findMember").keyup(function(){
/* 	alert("gg");
 */
 var url='/usMemo/member/friend/find/'+$(this).val();
	 
	  $.ajax({
            url: url,
            type:'post',
            datatype: 'json',
            success:function(data){
               	console.log(data);
               	var result='';
               	$.each(data,function(index,val){
               		result+='<br><div id="friendFinding_'+val.id+'" onclick="addMemberFunc('+val.id+',${bNum})"><img src="'
               				+val.profile_image+'"/><span>'
               				+val.name+'</span><span>('+val.nickname+')</span><br><span>'+val.email+'</span></div>';
               	});
               		$("#findMemberResult").html(result);
               	
            } ,
	       error : function(xhr, status, error) {
              console.log(error);
         }
        }) 
});
});


</script>
<script type="text/javascript">
	function addMemberFunc(id,bNum){
		//보드에 member를 추가 
		var answer=confirm("이 보드의 멤버로 추가하시겠습니까?");
		if(answer){ 
			 $.ajax({
		            url: 'add?memId='+id+'&bNum='+bNum,
		            type :'post',
		            success:function(){
		            	alert("success!");
		            	window.location.reload();
		            } ,
			       error :function(data,status,er) { 
			    	   alert("error: "+data+" status: "+status+" er:"+er);
			    	   console.log("error: "+data+" status: "+status+" er:"+er);
		         }
		        }); 
		 }
	}
</script>

	<!-- 1) 현재 보드에 속해있는 인원 보여주기
	 2) 현재 접속자정보, 권한을 표시
	 3) 그 권한에 따라 권한변경버튼, 삭제버튼 보이기
	 -->

	<c:forEach var="m" items="${memberList }">
		memId: ${m.id }<br>
		name: ${m.name } <br>
		nick: ${m.nickname }<br>
		email: ${m.email }<br>
		image: <img alt="profile_image" src="${m.profile_image }"><br>
		grade: <c:if test="${m.grade == 1}"> 관리자</c:if>
		<c:if test="${m.grade == 2}"> 일반등급멤버</c:if>
		<br><br>
	</c:forEach>
	<br>
	<br>
	<form>
		<input type="button" class="addMemberBtn" value="addMembers...">
		<div class="hide">
			email 또는 name/nick으로 검색
			<input type="text" id="findMember">
			<div id="findMemberResult">
			</div>
			<br> <input type="button" value="specialLink생성"/> 
			<br><input type="button" class="cancelAddMemberBtn" value="cancel" />
		</div>
	</form>
</body>
</html>