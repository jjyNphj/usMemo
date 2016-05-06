<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script src="/usMemo/resources/textchange.js"></script>
<style type="text/css">
.hide {
	display: none;
}
img {margin: 5px 2px 2px 2px}
.list-group-item:hover{
	background-color: gray;}
/* 마진이 바깥쪽 여백, 패딩이 안쪽여백 의미, 숫자는 순서대로 윗쪽부터 시계방향 */
</style>

</head>
<body>


<script type="text/javascript">
$(document).ready(function(){
	//팝업설정
	$('[data-toggle="popover"]').popover();   
	
	$(".addMemberBtn").click(function(){
	    // 현재 버튼의 옆의 태그중 div 태그에 hide 클래스 태그를 넣던지 빼던지 한다.
	    $(this).next(".hide").toggleClass("hide");
	    $(this).hide();
	});
	
	$(".cancelAddMemberBtn").click(function(){
		//cancel 클릭하면 기존에 적었던 정보 지우기
		$("#findMember").val('');
	    //cancel 클릭했을 때 입력창 감추기! 
	/*     $(this).parents("div").toggleClass("hide"); */
		$("#findOption").toggleClass("hide");
	    //원래 버튼인 add card... 버튼 보이기 
	   $(this).parents("div").prev(":button").show();
	});
	
	$("#findMember").keyup(function(){
	/* 	alert("gg");
	 */
	 var url='/usMemo/member/friend/find/'+$(this).val()+'/'+${bNum};
		 
		  $.ajax({
	            url: url,
	            type:'post',
	            datatype: 'json',
	            success:function(data){
	               	console.log(data);
	               	var result='';
	               	$.each(data,function(index,val){
	               		result+='<br><a class="list-group-item"><div id="friendFinding_'+val.id+'" class="row" onclick="addMemberFunc('+val.id
	               				+',${bNum})"><div class="col-xs-2"><img src="'+val.profile_image
	               				+'" class="img-rounded" /></div><div class="col-xs-4"><span>'+val.name
	               				+'<br>('+val.nickname+')<br>'+val.email+'</span></div></div></a>';
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
<div class="container">
	<div class="panel-group">
    <div class="panel panel-default">
    	<div class="panel-heading">이 보드의 멤버</div>
    	 <div class="panel-body">
			<c:forEach var="m" items="${memberList }">
				<c:if test="${m.grade == 1}">
					<img src="${m.profile_image }"  title="${m.name }(admin)" data-toggle="popover" data-trigger="hover" data-content="${m.email }" data-placement="bottom" class="img-circle">
				</c:if>
				<c:if test="${m.grade == 2}">
					<img src="${m.profile_image }"  title="${m.name }(member)" data-toggle="popover" data-trigger="hover" data-content="${m.email }" data-placement="bottom" class="img-circle">
				</c:if>
			</c:forEach>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-body">
		 	<form role="form">
		 		<!-- input상자의 설정 -->
		 		<div class="col-xs-8">
				<input type="button" class="addMemberBtn" value="addMembers...">
				<div id="findOption" class="hide">
					<label for="pwd">친구검색</label>
					<input type="text" class="form-control" id="findMember" placeholder="이름, 닉네임, email 등으로 검색해보세요.">
					<span class="help-block">당신의 보드에 팀멤버를 등록하세요. 쉽게 공유할 수 있습니다. </span>
					<div id="findMemberResult" class="list-group"></div>
					<br> <input type="button" value="specialLink생성"/> 
					<br><input type="button" class="cancelAddMemberBtn" value="cancel" />
				</div>
				<!-- /end input상자의 설정-->
				</div>
			</form>
		</div>
	</div>
	</div>
</div>

</body>
</html>