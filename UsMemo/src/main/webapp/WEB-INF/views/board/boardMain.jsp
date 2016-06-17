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
	<link href="${pageContext.request.contextPath}/css/common/board-common.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/custom/custom-boardMain.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/board-canvas.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/scrollbar.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/board/board-drawer.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/board/board-side-menu.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap-submenu.css" rel="stylesheet">
<title>Your Board</title>

</head>
<body>

<!-- surface: 화면에 보이는부분 -->
<div class="surface">
<div id="header">
	<jsp:include page="board-header.jsp"></jsp:include>				
</div><!-- end header -->
		<div id="content">
			
			<div class="board-wrapper">
				<div id="board-main-content">
					<div id="board-header">
						<div id="board-header-wrap" class="row" >
							<div class="col-xs-12 col-sm-12 col-md-12" >
								 <div class="col-xs-8 col-sm-8 col-md-8"  style="text-align:left; color: white;">
								 <a class="board-header-barnd">
									 	<span id="board-header-brand-text">${bName }</span>
									 	<c:if test="${star eq 'Y' }"><span id="board-header-starred" class="glyphicon glyphicon-star"></span></c:if>
									 	<c:if test="${star eq 'N' }"><span id="board-header-starred" class="glyphicon glyphicon-star-empty"></span></c:if>
								 </a> 
								 </div>
								 <div class="col-xs-4 col-sm-4 col-md-4"  style="text-align:right; color: white;"> 
								 	<a class="board-header-btn-menu">
									 <span id="board-header-btn-menu-text" class="menu-toggle">Show Menu</span>
									 </a>
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
															<textarea class="list-name" id="list-name-text_${l.num }"  onkeypress="enterSaveListNameProcess(event,this)" onkeyup="heightResize(this)">
															${l.name}</textarea>
															<span class="delete-list-btn glyphicon glyphicon-trash" onclick="deleteListInfo(${l.num})">
															</span>
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
														</div>
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
										</c:forEach>

										<div class="no-include-sortable" id="addListLI">
											<div class="list_unit_view no-include-sortable">
												<button class="addListBtn btn btn-primary btn-simple">add
													list...</button>
												<div class="addList_group no-include-sortable hide">
													<div class="addList_textarea no-include-sortable form-group">
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
				<div id="side-menu">
					<jsp:include page="board-sideMenu.jsp" flush="flase"/>
				</div><!-- /.board-menu -->
	</div><!-- /.board-wrapper -->
	</div><!-- /.content  -->
	</div><!-- /.surface: 화면에 보이는 부분  -->
	
	<!-- Modal -->
	<div class="modal-cardInfoView">
		<jsp:include page="board-cardInfo.jsp"></jsp:include>
	</div>
	<div class="modal-allActivity">
		<jsp:include page="board-allActivity.jsp"></jsp:include>
	</div>

	
		<!-- js -->
	
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/3.51/jquery.form.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/js/board/bootstrap.js"></script>
	<script src="${pageContext.request.contextPath}/js/board/jquery.autogrowtextarea.js"></script>
	<script src="${pageContext.request.contextPath}/js/boardMain.js"></script>
	<script src="${pageContext.request.contextPath}/js/cardInfoView.js"></script>
	<script src="${pageContext.request.contextPath}/js/side-menu.js"></script>
	<script src="${pageContext.request.contextPath}/js/board/board-drawer.js"></script>
	<script src="${pageContext.request.contextPath}/js/board/board-setting.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap-submenu.js"></script>
	<!-- 디자인 -->
	<script src="${pageContext.request.contextPath}/js/ct-paper.js"></script>

</body>
</html>
