<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 부트스트랩 CDN -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	 <link href="${pageContext.request.contextPath}/css/board/bootstrap.css" rel="stylesheet">

	<!-- 	board의 전반적인 css파일 -->
	<link href="${pageContext.request.contextPath}/css/board/board-drawer.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/common/board-common.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/custom/custom-myBoard.css" rel="stylesheet">
	
	<title>my Boards</title>
</head>

<body>
	<input type="hidden" id="memId" value="${sessionScope.id}" />
<!-- surface: 화면에 보이는부분 -->
<div class="surface">
	<div id="header">
		<jsp:include page="board/board-header.jsp"></jsp:include>				
	</div><!-- end header -->
			
	<div id="content" class="myBoard-content">
	<div class="member-boards-view">
		<div class="member-boards-starred">
			<div class="member-boards-starred-header">
				<span class="member-boards-starred-header-icon glyphicon glyphicon-star"></span>
				<span class="member-boards-starred-header-text">Starred Boards</span>
			</div>
			<div class="member-boards-starred-content">
				<c:forEach var="list" items="${Board}" varStatus="i">
					<c:if test="${list.star=='Y' }">
						<div class="member-boards-wrapper">
							<span class="member-boards-title-background" style="background-color: ${list.background_color}" onclick="goBoard(${list.bNum},'${list.name}')"></span>
							<div class="member-boards-title-wrapper">
								<a class="member-boards-link" onclick="goBoard(${list.bNum},'${list.name}')">
									<span class="member-boards-title-text">${list.name }</span>
								</a>
								<span id="member-boards-star_${list.bNum }" class="member-boards-star glyphicon glyphicon-star"></span>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div class="member-boards-myBoards">
			<div class="member-boards-myBoards-header">
				<span class="member-boards-myBoards-header-icon glyphicon glyphicon-user"></span>
				<span class="member-boards-myBoards-header-text">My Boards</span>
			</div>
			<div class="member-boards-myBoards-content">
				<c:forEach var="list" items="${Board}" varStatus="i">
				<div class="member-boards-wrapper">
					<span class="member-boards-title-background" style="background-color: ${list.background_color}" onclick="goBoard(${list.bNum},'${list.name}')"></span>
						<div class="member-boards-title-wrapper">
							<a class="member-boards-link" onclick="goBoard(${list.bNum},'${list.name}')">
								<span class="member-boards-title-text">${list.name }</span>
							</a>
							<c:if test="${list.star=='Y' }"> <span id="member-boards-star_${list.bNum }" class="member-boards-star glyphicon glyphicon-star"></span></c:if>
							<c:if test="${list.star=='N' }"> <span id="member-boards-star_${list.bNum }" class="member-boards-star glyphicon glyphicon-star-empty"></span></c:if>
						</div>
				</div>
				</c:forEach>
	<!-- 보드 추가 부분 -->
		<div class="add-board-wrapper dropdown">
			<!-- <div id="add-board"> -->
				<div class="add-board-background dropdown-toggle" data-toggle="dropdown">
					<div class="add-board-wrapper-background">
						<div class="add-board-text">
							board create
						</div>
					</div>
				</div>
		<!-- 	</div> -->
<!-- 			<button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
				  board create   <span class="caret"></span>
			</button> -->
			
			<div class="dropdown-menu addboard-btn">
			<div class="modal-body">
				<p>Create Board</p>
				
				<form role="form">
					<div class="form-group">
						<!-- textarea의 내용 id변수에 저장해서 /createBoard 전달 -->
						<textarea class="form-control" rows="3" cols="30" id="boardComment" placeholder="보드이름을 입력해주세요."></textarea>
					</div>
					
					<div class="modal-footer">
						<input type="hidden" name="memId" value=${sessionScope.id } />
						<!-- submit 누르면 form에 적힌 action 주소로 넘어감. -->
						<!-- <button type="submit" class="btn btn-primary">Submit</button> -->
						<button type="button" class="btn btn-primary" onclick="createBoard(memId)">Submit</button>
						<button type="button" class="btn btn-default" data-toggle="dropdown" onclick="clearForm(this.form)">Close</button>
					</div>
				</form>
			</div>			
			</div>
		</div>
			</div>
		</div>
	</div>
	</div>
</div>

<%-- 	<form>
		<input type="hidden" id="memId" value="${sessionScope.id}" />
		<!-- 현재 memId에 연결된 Board의 bNum들  뷰에 보여주기-->
		<c:forEach var="list" items="${Board}" varStatus="i">
			<!-- Board.java의 변수 bNum,name? var="변수이름",items="반복데이터가 있는 아이템(리스트or배열)", --> 
			<!-- varStatus="반복 상태값 지닌 변수" value="출력될 값" varStatus인덱스 종류 i.index=0부터 시작, i.count=1부터 시작 -->
			<input type="hidden" name=bNum${i.index} value="${list.bNum}" />
			<input type="hidden" name=name${i.index} value="${list.name}" />

			<h1>${list.bNum}, ${list.name} </h1>
			<input type="button" value="보러가기" onclick="goBoard(${list.bNum},'${list.name}')" />
			<input type="button" value="삭제하기" class="deleteBoardBtn" onclick="deleteBoard(bNum${i.index},name${i.index })" />
			<input type="button" value="삭제하기" onclick="goDeletePage(bNum${i.index},name${i.index })" />
			</br>
		</c:forEach>
	</form> --%>
	
	
	<!-- js -->
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/js/board/bootstrap.js"></script>
	
	
	<script src="${pageContext.request.contextPath}/js/board/board-setting.js"></script>
	<script src="${pageContext.request.contextPath}/js/board/board-drawer.js"></script>
	
</body>
</html>