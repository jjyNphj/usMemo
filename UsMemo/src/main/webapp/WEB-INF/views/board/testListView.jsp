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
 	<link href="${pageContext.request.contextPath}/css/ct-paper.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/bootstrap-horizon.css" rel="stylesheet"/>
   
    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'>

<title>Your Board</title>

<style type="text/css">
 html, body { height: 100%; overflow:hidden }
   #wrap {
		height:100%;  background-color:yellow; border:3px red solid; z-index: 1000;}
 #container #page-content-wrapper{
		height:100%;}
</style>

</head>
<body>
        <div id="wrap">
            <!-- Head Start-->
            <div id="header"><!-- UPnavbar -->
 <div id="navbar">
    
    <!-- navbar-fixed-top 속성이 상단고정임. -->
        <nav id="navId" class="navbar navbar-ct-danger navbar-fixed-top" role="navigation">
    
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
    
    </div><!--  end UPnavbar --> </div>
            <!-- Head End-->
            <!-- Body Start-->
            <div id="container">
                <div class="contents-box">
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
            <!-- <div class="container-fluid"> -->
			<div class="row row-horizon"> 
		<form>
            
		<input type="hidden" id="bNum" value="${bNum }" />
		<input type="hidden" id="memId" value="${sessionScope.id }" />
				
		<div class="list_all">
			<c:forEach var="l" items="${listList}" varStatus="index">
					
				<div class="list_unit" id="${l.num}">
						<h1>${l.name}</h1>
					<div class="card_all" id="${l.num }">
					-
						<c:forEach var="c" items="${cardList}">
							<c:if test="${l.num == c.lNum }">
							
								<!-- 카드수정버튼만 생성해 놓았으며, 아래의 주석 Modal에서 창뜨는 부분을 구현함. 참고>스페이스기호:&nbsp -->
								<div class="card_unit" id="${l.num}_${c.card_num }" >
									${c.card_name }
									<input type="button" value="Edit" onclick="editCard(${c.card_num})" data-toggle="modal" data-target="#cardInfoView"/>
								</div>
							</c:if>
						</c:forEach>
					</div> <%-- <input type="button" class="addCardBtn" value="add card..." />

					<div class="hide">
						<textarea rows="5" cols="30" id="cardName${l.num}"></textarea>
						<br> <input type="button" value="add" onclick="addCard(${l.num},cardName${l.num})" /> 
						<input type="button" class="cancelCardBtn" value="cancel" />
					</div> --%>
					</div>
			</c:forEach>


		</div>
		
		<input type="button" class="addListBtn" value="add list..." />
		<div class="hide">
			<textarea rows="5" cols="30" id="listName"></textarea>
			<br> <input type="button" value="add" onclick="addList(${bNum})" />
			<input type="button" class="cancelListBtn" value="cancel" />
		</div>
		
		<%-- <input type="button" value="Menu" onClick="openMenu(${bNum},${sessionScope.id})"/>
 --%>	
                 
	</form>
	
	<!-- </div> -->

	</div>
	</div>
	<!-- /#page Content -->
	</div>
    <!-- /#wrapper -->
                </div>
            </div>
            <!-- Body End-->
            <!-- Footer Start-->
         <!--    <div id="footer">Footer</div> -->
            <!-- Footer End-->
        </div>
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
