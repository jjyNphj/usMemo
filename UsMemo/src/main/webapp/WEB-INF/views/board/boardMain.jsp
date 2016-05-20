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

	 
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/simple-sidebar.css" rel="stylesheet">
 	<link href="${pageContext.request.contextPath}/css/ct-paper/ct-paper.css" rel="stylesheet"/>
<%--  	<link href="${pageContext.request.contextPath}/css/gsdk-base.css" rel="stylesheet"/> --%>
    <link href="${pageContext.request.contextPath}/css/bootstrap-horizon.css" rel="stylesheet"/>
   
    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'>

<!-- 	board의 전반적인 css파일 -->
	<link href="${pageContext.request.contextPath}/css/board.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/board-canvas.css" rel="stylesheet">

<title>Your Board</title>

</head>
<body>
<!-- surface: 화면에 보이는부분 -->
<div class="surface">
<div id="header">
<div class="container">
	<div class="row header-bar">
		<div class="col-xs-12 col-sm-12 col-md-12 "  style="background-color: black;"> 
			 <div class="col-xs-4 col-sm-4 col-md-4 "  style="text-align:left;background-color: green;"> 
			 <span class="header-logo-boardmenu" style="color: white;">보드이동메뉴넣기</span>
			 </div>
			<div class="col-xs-4 col-sm-4 col-md-4" style="text-align:center;background-color: yellow;"> 
			 <span class="header-logo" style="color: white;">로고넣기</span>
			 </div>
			<div class="col-xs-4 col-sm-4 col-md-4"  style="text-align:right;background-color: blue;">
			<span class="header-logo-myinfo" style="color: white;"> 내정보넣기</span>
			 </div>
		 </div>
	</div>
</div>
							
</div><!-- end header -->
		<div id="content">
			
			<div class="board-wrapper">
				<div id="board-main-content">
					<div id="board-header" class="container">
						<div id="board-header-wrap" class="row"style="background-color: orange;" >
							<div class="col-xs-12 col-sm-12 col-md-12" >
								 <div class="col-xs-8 col-sm-8 col-md-8"  style="text-align:left;background-color: green;">
									 <div class="col-md-6"  style="background-color: yellow;">  
									 	<span id="board-header-brand-text">${bName }</span>
									 </div>
									 <div class="col-xs-6 col-sm-6 col-md-6"  style="background-color: blue;">
									 	<span class="glyphicon glyphicon-star-empty"></span> 
									 </div>
								 </div>
								 <div class="col-xs-4 col-sm-4 col-md-4"  style="text-align:right;background-color: blue;"> 
									 <span id="board-header-brand-text" class="menu-toggle">menu</span>
								 </div>
					
				 			</div>
						</div>
				</div>

					<!-- board-canvas -->
					<div id="board-canvas">
						<!-- <div id="board" > -->
							<!-- <div class="row row-horizon"> -->
								<form>
									<input type="hidden" id="bNum" value="${bNum }" /> <input
										type="hidden" id="memId" value="${sessionScope.id }" />
								</form>
								<div id="list-wrapper">
								<div class="list_all">
								<!-- 	<div> -->
										<c:forEach var="l" items="${listList}" varStatus="index">

											<div class="list_unit" id="${l.num}">
												<!-- style= "background-color: yellow;"> -->
												<div class="list_unit_view no-include-sortable" >
													<!-- style= "background-color: blue;"> -->
													<div class="list_unit_name no-include-sortable">
														<!--  style="background-color: red;"> -->
														<h6>
														<%-- 	${l.num } /  --%>
															${l.name}
														</h6>
													</div>
													<div class="card_all" id="${l.num }">
														<c:forEach var="c" items="${cardList}">
															<c:if test="${l.num == c.lNum }">

																<!-- 카드수정버튼만 생성해 놓았으며, 아래의 주석 Modal에서 창뜨는 부분을 구현함. 참고>스페이스기호:&nbsp -->
																<div class="card_unit" id="${l.num}_${c.card_num }">
																	<div class="card_unit_view no-include-sortable"
																		onclick="editCard(${c.card_num})" data-toggle="modal"
																		data-target="#cardInfoView">
																		<!-- class="col-md-8" -->
																		<div class="card_unit_name no-include-sortable">
																			<!--  style="background-color: green;"> -->
																			<%--  ${c.card_num }/ --%>${c.card_name }</div>
																	</div>
																</div>
															</c:if>
														</c:forEach>
														<div class="no-include-sortable" id="addCardLI">
															<button class="addCardBtn btn btn-primary btn-simple">add
																card...</button>
															<div class="addCard_group no-include-sortable hide">
																<div class="form-group no-include-sortable">
																	<!-- textarea 폼의 디자인 div -->
																	<textarea class="form-control"
																		placeholder="Here, add Card's name" rows="5"
																		id="cardName${l.num}" style="resize: none;"></textarea>
																</div>
																<button class="btn btn-primary"
																	onclick="addCard(${l.num},cardName${l.num})">add</button>
																<button class="cancelCardBtn btn btn-primary">cancel</button>
															</div>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>

										<div id="addListLI">
											<button class="addListBtn btn btn-primary btn-simple">add
												list...</button>
											<div class="addList_group hide">
												<div class="addList_textarea form-group">
													<!-- textarea 폼의 디자인 div -->
													<textarea class="form-control"
														placeholder="Here, add List name" rows="5" cols="30"
														id="listName_textarea" style="resize: none;"></textarea>
												</div>
												<span id="byteInfo_group"><span id="byteInfo">0</span>/100Byte</span><br>
												<button id="addListFuncBtn" class="btn btn-primary"
													onclick="addList(${bNum})">add</button>
												<button class="cancelListBtn btn btn-primary">cancel</button>
											</div>
										</div>
								<!-- 	</div> -->
								</div>
</div>

								<%-- <input type="button" value="Menu" onClick="openMenu(${bNum},${sessionScope.id})"/>
 --%>

						<!-- 	</div> -->
					<!-- 	</div> -->

				</div><!-- /.board-canvas -->
				</div><!-- /.board-main-content -->
				<div id="board-menu">
					<div id="wrapper" class="toggled" >
		
		        <!-- Sidebar -->
		        <div id="sidebar-wrapper">
		           <ul class="sidebar-nav">
		                <li class="sidebar-brand">
		                    <a>Menu</a>
		                </li>
		                   <li>
		            <div class="container-fluid">
		          
		            <div class="row">
		              <div class="span12">    
		              <div class="panel panel-default">
				    	 <div id="setMember" class="panel-body"></div>
						</div>
		            </div>
		             <div class="row">
		     		 <div class="span12">
		               <div class="panel panel-default">
							<div class="panel-body">
							 	<form role="form">
							 		<!-- input상자의 설정 -->
							 		<!-- <div class="col-xs-8"> -->
									<!-- <input type="button" class="addMemberBtn" value="addMembers..."> -->
									<div id="findOption"><!--  class="hide" -->
										<label for="pwd">친구검색</label>
										<input type="text" class="form-control" id="findMember" placeholder="이름, 닉네임, email 등으로 검색해보세요.">
										<span class="help-block">당신의 보드에 팀멤버를 등록하세요. 쉽게 공유할 수 있습니다. </span>
										<div id="findMemberResult" class="list-group"></div>
										<!-- <br> <input type="button" value="specialLink생성"/> 
										<br><input type="button" class="cancelAddMemberBtn" value="cancel" /> -->
									</div>
									<!-- /end input상자의 설정-->
								<!-- 	</div> -->
									</form>
								</div>
							</div>
		              </div>
		            </div>
		            <!-- /#안쪽row -->
		         </div>
		         <!-- /#바깥row -->
		        </div>
		                </li>
		                <li class="basic-li">
		                    <a href="#">Overview</a>
		                </li>
		                <li class="basic-li">
		                    <a href="#">Events</a>
		                </li>
		                <li class="basic-li">
		                    <a href="#">About</a>
		                </li>
		                <li class="basic-li">
		                    <a href="#">Services</a>
		                </li>
		                <li class="basic-li">
		                    <a href="#">Contact</a>
		                </li>
		            </ul>  
		        </div><!-- /#sidebar-wrapper -->
			</div><!-- /.wrapper -->
		</div><!-- /.board-menu -->
	</div><!-- /.board-wrapper -->
	</div><!-- /.content  -->
	</div><!-- /.surface: 화면에 보이는 부분  -->
	<!-- Modal -->
	<!-- CardInfo Modal-->
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
                     <textarea class="textarea-card-name" id="card_Name" maxlength="200" onkeypress="enterSaveProcess(event,this)" onkeyup="heightResize(this)" ></textarea>
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
                        <input type="file"   id="exampleInputFile"  >
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
	<!-- /#cardInfo Modal -->

	
		<!-- js -->
	
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/js/board/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/js/board/jquery.autogrowtextarea.js"></script>
	<script src="${pageContext.request.contextPath}/js/boardMain.js"></script>
	<script src="${pageContext.request.contextPath}/js/cardInfoView.js"></script>
	<script src="${pageContext.request.contextPath}/js/menu.js"></script>
	<!-- 디자인 -->
	<script src="${pageContext.request.contextPath}/js/ct-paper.js"></script>

</body>
</html>
