<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<!-- 부트스트랩 CDN -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- <script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script> -->
<script	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<title>Insert title here</title>

<style type="text/css">
.list_all {	overflow: auto;}
.list_unit { float: left;}
.hide {	display: none;}
</style>

</head>

<body>

	<form>
		<input type="hidden" id="bNum" value="${bNum }" />
		<input type="hidden" id="memId" value="${sessionScope.id }" />
		<ul class="list_all">
			<c:forEach var="l" items="${listList}" varStatus="index">
				<li class="list_unit" id="${l.num}">
					<h1>${l.num},${l.name}<br>${l.llink}/${l.rlink }</h1>
					<ul class="card_unit" id="${l.num }">
					-
						<c:forEach var="c" items="${cardList}">
							<c:if test="${l.num == c.lNum }">
							
								<!-- 카드수정버튼만 생성해 놓았으며, 아래의 주석 Modal에서 창뜨는 부분을 구현함. 참고>스페이스기호:&nbsp -->
								<li id="${l.num}_${c.card_num }">
									[${c.card_num }] ${c.card_name }, [${c.lNum }/${c.llink }/${c.rlink }]&nbsp;&nbsp;&nbsp;
									<input type="button" value="Edit" onclick="editCard(${c.card_num})" data-toggle="modal" data-target="#myModal"/>
								</li>
							</c:if>
						</c:forEach>
					</ul> <input type="button" class="addCardBtn" value="add card..." />

					<div class="hide">
						<textarea rows="5" cols="30" id="cardName${l.num}"></textarea>
						<br> <input type="button" value="add" onclick="addCard(${l.num},cardName${l.num})" /> 
						<input type="button" class="cancelCardBtn" value="cancel" />
					</div>
				</li>
			</c:forEach>


		</ul>
		<input type="button" class="addListBtn" value="add list..." />
		<div class="hide">
			<textarea rows="5" cols="30" id="listName"></textarea>
			<br> <input type="button" value="add" onclick="addList(${bNum})" />
			<input type="button" class="cancelListBtn" value="cancel" />
		</div>
		
		<input type="button" value="Menu" onClick="openMenu(${bNum},${sessionScope.id})"/>
	</form>
	
	
	<!-- Modal 길어서 쪼갬-->
	<div class="container">
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title" ><span id="card_Name" /></h4>
						<h6 class="modal-title" >in list <span id="list_Name" /></h6>
					</div>
					<div class="modal-body">
						<p>You wrote:<br><span id="card_Date"/></p>
						
						<p>카드 상세 내용 입력하는 부분, 수정</p>
						<!-- textarea의 내용 id변수에 저장해서 /createBoard 전달 -->
						<textarea class="form-control" style="resize:none;" rows="10"  id="boardComment" placeholder="카드상세내용을 입력해주세요."></textarea></br>
						<button type="button" class="btn btn-primary" style="float:right;" onclick="">&nbsp;Save&nbsp;</button>
						<button type="button" class="btn btn-default" style="float:right;margin-right:5px" onclick="clearForm(this.form)">&nbsp;Clear&nbsp;</button></br>
						
						<form>
							<div class="form-group" >
								<label for="exampleInputFile" >파일 업로드</label> 
								<input type="file"	id="exampleInputFile"  >
								<p class="help-block">파일 추가, 삭제, 다운</p>
							</div>
							<button type="submit" class="btn btn-default">첨부하기</button>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearForm(this.form)">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="${pageContext.request.contextPath}/js/boardMain.js"></script>
<script src="${pageContext.request.contextPath}/js/cardInfoView.js"></script>
	
</body>
</html>
