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
<%-- 상대경로로 설정해야 안전함.  
 <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
 --%>
<style type="text/css">
.hide {
	display: none;
}
img {margin: 5px 2px 2px 2px}
/* 마진이 바깥쪽 여백, 패딩이 안쪽여백 의미, 숫자는 순서대로 윗쪽부터 시계방향 */

.list-group-item:hover{
	background-color: gray;}
/*멤버사진 가로정렬*/
.dropdown{ display:inline}
</style>

</head>
<body>
<input type="hidden" id="bNum" value="${bNum }"/>

	<!-- 1) 현재 보드에 속해있는 인원 보여주기
	 2) 현재 접속자정보, 권한을 표시
	 3) 그 권한에 따라 권한변경버튼, 삭제버튼 보이기
	 -->
<div class="container">
	<div class="panel-group">
    <div class="panel panel-default">
    	<div class="panel-heading">이 보드의 멤버</div>
    	 <div class="panel-body">
	
				<!-- 현재 로그인 한 사람의 grade값을 찾아서 seesionGrade라는 변수에 넣는 과정.  -->			
				<c:forEach var="m" items="${memberList }" varStatus="index">
					<c:if test="${sessionScope.id==m.id }">
						<c:set var="sessionGrade" value="${m.grade }"/>
					</c:if>
				</c:forEach>
				<!--/end 현재 로그인 한 사람의 grade값을 찾아서 seesionGrade라는 변수에 넣는 과정.  -->			
				
				<!-- 현재 이 보드에 추가된 사람의 목록을 불러오는 for문 -->
			<c:forEach var="m" items="${memberList }" varStatus="index">
				<c:if test="${m.grade == 1}">
				<!-- 드롭다운메뉴생성 -->
    	 		<div class="dropdown">
				<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
					<c:if test="${m.id!=sessionScope.id }">
						<img src="${m.profile_image }"  title="${m.name }(admin)" data-toggle="popover" data-trigger="hover" 
						data-content="${m.email }" data-placement="bottom" class="img-circle" >
					</c:if>
					<!-- 자기자신일 경우 프로필 설명 -->
					<c:if test="${m.id==sessionScope.id }">
						<img src="${m.profile_image }"  title="It's me!" data-toggle="popover" data-trigger="hover" 
						data-content="${m.email }" data-placement="bottom" class="img-circle" >
					</c:if>
				
				<span class="caret"></span>
				</button>
				<!-- 관리자일경우만 메뉴참조가능 -->
					<c:if test="${sessionGrade ==1 }">
				<!-- 자기자신일 경우는 메뉴참조못함 -->
				<c:if test="${m.id!=sessionScope.id }">
					  <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
							  <!-- 함수에 리턴값이 있던 없던 상관 없음. 클릭해도 페이지의 최상위(href의 경로)로 이동하지 않음 -->
						     <li><a tabindex="-1" href='javascript:void(0);' onclick="updateMemberGrade(${m.id},${bNum },2)">일반멤버로 변경</a></li>					  		
					  		
						     <li class="divider"></li>
						    <li><a tabindex="-1" href='javascript:void(0);' onclick="deleteMember(${m.id},${bNum })">삭제</a></li>
						</ul>
				<!--/end 자기자신일 경우는 메뉴참조못함 -->
				</c:if>
				<!--/end 관리자일경우만 메뉴참조가능 -->
				</c:if>
				</div>
				</c:if>
				<c:if test="${m.grade == 2}">
				 <!-- 드롭다운메뉴생성 -->
    	 		<div class="dropdown">
				<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
				<c:if test="${m.id!=sessionScope.id }">
					<img src="${m.profile_image }"  title="${m.name }(member)" data-toggle="popover" data-trigger="hover" data-content="${m.email }" data-placement="bottom" class="img-circle">
				</c:if>
				<!-- 자기자신일 경우 프로필 설명 -->
				<c:if test="${m.id==sessionScope.id }">
					<img src="${m.profile_image }"  title="It's me!" data-toggle="popover" data-trigger="hover" data-content="${m.email }" data-placement="bottom" class="img-circle">
				</c:if>
				<span class="caret"></span>
				</button>
				<!-- 관리자일경우만 메뉴참조가능 -->
					<c:if test="${sessionGrade ==1 }">
				<!-- 자기자신일 경우는 메뉴참조못함 -->
				<c:if test="${m.id!=sessionScope.id }">
					  <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
					  		<!-- 함수에 리턴값이 있던 없던 상관 없음. 클릭해도 페이지의 최상위(href의 경로)로 이동하지 않음 -->
						    <li><a tabindex="-1" href='javascript:void(0);' onclick="updateMemberGrade(${m.id},${bNum },1)">관리자로 변경</a></li>					  		
						    <li class="divider"></li>
						    <li><a tabindex="-1" href='javascript:void(0);' onclick="deleteMember(${m.id},${bNum })">삭제</a></li>
						</ul>
				<!--/end 자기자신일 경우는 메뉴참조못함 -->
				</c:if>
				<!--/end 관리자일경우만 메뉴참조가능 -->
				</c:if>
				</div>
				</c:if>
			</c:forEach>
			<!--/end 현재 이 보드에 추가된 사람의 목록을 불러오는 for문 -->
			</div>
			<!-- /end 드롭다운메뉴생성 -->
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
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
</body>
</html>