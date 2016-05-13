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

.list-group-item:hover{
	background-color: gray;}
/*멤버사진 가로정렬*/
.dropdown{ display:inline}

/* 사용자가 카드의 이름을 수정하는 부분 */
.textarea-card-name {
	/*사용자가 textarea 사이즈 조정 금지*/
	resize:none;
	/* 스크롤바 생성X */
	overflow-y:hidden;
	width: 90%;
	border:0;
	background:clear;
	/* height:30px; */	
	/* display:inline; */
	/* overflow: auto;  */
	/* height: $('card_Name').prop("scrollHeight"); */
	
} 

</style>
<script type="text/javascript">
</script>
</head>

<body>

	<form>
	<div id="setVar">
		<input type="hidden" id="bNum" value="${bNum }" />
		<input type="hidden" id="memId" value="${sessionScope.id }" />
				
	</div>
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
									<input type="button" value="Edit" onclick="editCard(${c.card_num})" data-toggle="modal" data-target="#cardInfoView"/>
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
							
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#menuView" onClick="openMenu(${bNum},${sessionScope.id})" >menu</button>
		<%-- <input type="button" value="Menu" onClick="openMenu(${bNum},${sessionScope.id})"/>
 --%>	
	
	
	<!-- Modal 길어서 쪼갬-->
	<div class="container">
		<div class="modal fade" id="cardInfoView" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<!-- span 안에 담기는 카드의 넘버를 cardInfoView.js로 넘겨주기 위함 -->
						<span class="hide" id="card_num"></span>
						
						<button type="button" class="close" data-dismiss="modal" onclick="clearForm(this.form)">&times;</button>
						
						<h4 class="modal-title" >
							<!-- <h2 class="card-name-edit" id="card_Name" dir="auto"></h2> -->

							<!-- 키를 누르는 순간마다 enterProcess로 값을 넘김. 엔터의 아스키코드값인 경우 사용자가 입력한 값 에이작스로 전달, heightResize:사용자 입력할떄마다 textarea 사이즈 자동조정 -->
							<textarea class="textarea-card-name" id="card_Name" maxlength="200" onkeypress="enterSaveProcess(event,this)" onkeyup="heightResize(this)"></textarea>
						</h4>

						<h6 class="modal-title" >in list <span id="list_Name"></span></h6>
					</div>
					
					<div class="modal-body">
						<p>You wrote:<br><span id="card_Date"></span></p>
						<p>카드 상세 내용 입력하는 부분, 수정</p>

						<!-- textarea의 내용 id변수에 저장 -->
						<textarea class="form-control" style="resize:none;" rows="10"  id="cardDescription" placeholder="카드상세내용을 입력해주세요."></textarea>
						</br>
						
						<button type="button" class="btn btn-primary" style="float:right;" onclick="addCardDescription(card_num,cardDescription)">&nbsp;Save&nbsp;</button>
						<button type="button" class="btn btn-default" style="float:right;margin-right:5px" onclick="clearForm(this.form)">&nbsp;Clear&nbsp;</button>
						</br>						
					
							<div class="form-group" >
								<label for="exampleInputFile" >파일 업로드</label> 
								<input type="file"	id="exampleInputFile"  >
								<p class="help-block">파일 추가, 삭제, 다운</p>
							</div>
							<button type="submit" class="btn btn-default">첨부하기</button>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearForm(this.form)">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	
	
	
	<!-- menu modal -->
	<div class="modal fade"  id="menuView" role="dialog" aria-labelledby="gridSystemModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="gridSystemModalLabel">이 보드의 멤버</h4>
        </div>
        <div class="modal-body">
          <div class="container-fluid">
          
            <div class="row">
              <div class="col-md-9">    
              <div class="panel panel-default">
		    	 <div id="setMember" class="panel-body">
					
						<!-- 드롭다운메뉴생성 -->
		    	 	<!--	<div class="dropdown">
					 	<button id="img_button" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
							<img id="profile_image" src="default"  title="default" data-toggle="popover" data-trigger="hover" 
								data-content="default" data-placement="bottom" class="img-circle" >
						 --><!-- <span class="caret"></span>
						</button> -->
							  <!-- <ul id="dropDown" class="dropdown-menu" role="menu" aria-labelledby="dLabel">
								</ul> -->
					<!--/end 현재 이 보드에 추가된 사람의 목록을 불러오는 for문 -->
					<!-- </div>-->
					<!-- /end 드롭다운메뉴생성 -->
				</div>
				</div>
            </div>
            <div class="row">
              <div class="col-md-9">
               <div class="panel panel-default">
					<div class="panel-body">
					 	<form role="form">
					 		<!-- input상자의 설정 -->
					 		<!-- <div class="col-xs-8"> -->
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
						<!-- 	</div> -->
							</form>
						</div>
					</div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" >Close</button>
          <button type="button" class="btn btn-primary">Save changes</button>
        </div>
      </div><!-- /.menu modal-content -->
    </div><!-- /.menu modal-dialog -->
  </div><!-- /.menu modal -->
  
  	</div>
  	</form>
<script src="${pageContext.request.contextPath}/js/boardMain.js"></script>
<script src="${pageContext.request.contextPath}/js/cardInfoView.js"></script>
<script src="${pageContext.request.contextPath}/js/menu.js"></script>
	
</body>
</html>
