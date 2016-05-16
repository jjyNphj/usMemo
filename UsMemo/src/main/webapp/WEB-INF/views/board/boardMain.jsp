<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<!-- 부트스트랩 CDN -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	 <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">

	 
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

<title>Your Board</title>


</head>
<body>
<div class="content">
<div id="header">
<!-- UPnavbar -->
 <div id="navbar">
    
    <!-- navbar-fixed-top 속성이 상단고정임. -->
        <nav id="navId" class="navbar nav-color-red navbar-fixed-top" role="navigation">
    
          <div class="container-fluid">
    
            <div class="navbar-header">
    
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
    
                <span class="sr-only">Toggle navigation</span>
    
                <span class="icon-bar"></span>
    
                <span class="icon-bar"></span>
    
                <span class="icon-bar"></span>
    
              </button>
    
              <a class="navbar-brand" href="#">Brand</a>
    
            </div>
    
    
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    
              <ul class="nav navbar-nav">
    
                <li><a href="#">Work in progress...</a></li>
    
                <li class="active"><a href="#">Link</a></li>
    
             
                <li class="dropdown">
    
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
    
                  <ul class="dropdown-menu">
    
                    <li><a href="#">Action</a></li>
    
                    <li><a href="#">Another action</a></li>
    
                    <li><a href="#">Something else here</a></li>
    
                    <li class="divider"></li>
    
                    <li><a href="#">Separated link</a></li>
    
                    <li class="divider"></li>
    
                    <li><a href="#">One more separated link</a></li>
    
                  </ul>
    
                </li>
                   <li><button type="button" id="menu-toggle" class="btn btn-warning">menu</button></li>
    
    
              </ul>
    
            </div><!-- /.navbar-collapse -->
    
          </div><!-- /.container-fluid -->
    
        </nav>
    
    </div><!--  end UPnavbar --> 
    </div><!-- end header -->
    <div id="section">
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
        </div>
        <!-- /#sidebar-wrapper -->

	
	   <!-- Page Content -->
        <div id="page-content-wrapper">
           <div class="container-fluid">
			<div class="row row-horizon">
            <form>
				<input type="hidden" id="bNum" value="${bNum }" />
				<input type="hidden" id="memId" value="${sessionScope.id }" />
			</form>
		<ul class="list_all">
			<div id="te">
				<c:forEach var="l" items="${listList}" varStatus="index">
						
					<li class="list_unit" id="${l.num}"> <!-- style= "background-color: yellow;"> -->
	     		 <div class="list_unit_view"> <!-- style= "background-color: blue;"> --> 
	     		 	<div class="list_unit_name" > <!--  style="background-color: red;"> --><h6><%-- ${l.num } / --%> ${l.name}</h6></div>
						<ul class="card_all" id="${l.num }">
							<c:forEach var="c" items="${cardList}">
								<c:if test="${l.num == c.lNum }">
								
									<!-- 카드수정버튼만 생성해 놓았으며, 아래의 주석 Modal에서 창뜨는 부분을 구현함. 참고>스페이스기호:&nbsp -->
									<li class="card_unit" id="${l.num}_${c.card_num }" >
									<div class="card_unit_view" onclick="editCard(${c.card_num})" data-toggle="modal" data-target="#cardInfoView"> <!-- class="col-md-8" --> 
										<div class="card_unit_name"><!--  style="background-color: green;"> --><%-- ${c.card_num }/ --%>${c.card_name }</div>
									</div>
									</li>
								</c:if>
							</c:forEach>
							<li id="addCardLI">
							   <button class="addCardBtn btn btn-primary btn-simple" >add card...</button>
								<div  class="addCard_group hide"> 
									<div class="form-group"><!-- textarea 폼의 디자인 div -->
									<textarea class="form-control" placeholder="Here, add Card's name" rows="5" id="cardName${l.num}" style="resize: none;"></textarea>
									</div>
								<button class="btn btn-primary" onclick="addCard(${l.num},cardName${l.num})" >add</button>
								<button class="cancelCardBtn btn btn-primary" >cancel</button>
								</div>
						</li>
						</ul>
						 </div> 
					</li>
				</c:forEach>
	
			<li class="list_unit" id="addListLI" >
				<button class="addListBtn btn btn-primary btn-simple" >add list...</button>
					<div class="addList_group hide"> 
						<div class="addList_textarea form-group"><!-- textarea 폼의 디자인 div -->
						<textarea class="form-control" placeholder="Here, add List name" rows="5" cols="30" id="listName_textarea" style="resize: none;"></textarea>
						</div><span id="byteInfo_group"><span id="byteInfo">0</span>/100Byte</span><br>
						<button id="addListFuncBtn" class="btn btn-primary" onclick="addList(${bNum})" >add</button>
						<button class="cancelListBtn btn btn-primary" >cancel</button>
					</div>
			</li>
		</div>
		</ul>
		
		
		<%-- <input type="button" value="Menu" onClick="openMenu(${bNum},${sessionScope.id})"/>
 --%>	
                 
	</div>
	</div> 

	</div>
	<!-- /#page Content -->
	</div>
    <!-- /#wrapper -->
    </div>
    <!-- end section -->
	</div>
	<!-- /.content -->
	<!-- Modal -->
	
	
	<!-- cardInfo Modal -->
		<div class="modal fade" id="cardInfoView" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title" ><span id="card_Name"></span></h4>
						<h6 class="modal-title" >in list <span id="list_Name"></span></h6>
						<!-- <h6 class="modal-title"><span id="card_Content"></span></h6> -->
					</div>
					<div class="modal-body">
						<p>You wrote:<br><span id="card_Date"></span></p>
						
						<!-- span 안에 담기는 카드의 넘버를 cardInfoView.js로 넘겨주기 위함 -->
						<p><span class="hide" id="card_num"></span>카드 상세 내용 입력하는 부분, 수정</p>
						
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
	<!-- /#cardInfo Modal -->
	
		<!-- js -->
	
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

	<script src="${pageContext.request.contextPath}/js/boardMain.js"></script>
	<script src="${pageContext.request.contextPath}/js/cardInfoView.js"></script>
	<script src="${pageContext.request.contextPath}/js/menu.js"></script>
	<!-- 디자인 -->
	<script src="${pageContext.request.contextPath}/js/ct-paper.js"></script>

</body>
</html>
