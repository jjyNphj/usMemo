<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="row header-bar">
		<div class="col-xs-12 col-sm-12 col-md-12 "> 
			 <div class="col-xs-4 col-sm-4 col-md-4 " >
							 	<!-- boards-drawer -->
				<div id="header-boardmenu" class="dropdown">
					<div class="header-btn-boardmenu dropdown-toggle" data-toggle="dropdown">
				 		<span class="header-logo-boardmenu glyphicon glyphicon-object-align-top" ></span>
				 		<span class="header-text-boardmenu">Boards</span>
				 	</div>
							<jsp:include page="board-boardDrawer.jsp"></jsp:include>
				 </div>
			 </div>
			<div class="col-xs-4 col-sm-4 col-md-4" style="text-align:center;"> 
			<a class="header-btn-home" href="#">
			 <span class="header-logo glyphicon glyphicon-object-align-top" "></span>
			 <span class="header-text" >UsMemo</span>
			 </a>
			 </div>
			<div class="col-xs-4 col-sm-4 col-md-4"  style="text-align:right;">
			 <div class="header-myInfo-wrapper dropdown">
				 <a class="header-btn-myInfo dropdown-toggle" data-toggle="dropdown">		
					 <span><img class="header-img-myInfo" src="${myInfo.profile_image }"/></span>
					 <span class="header-text-myInfo" style="color: white;">${myInfo.nickname}</span>
				 </a>
				 <div id="header-myInfo-dropdown" class="dropdown-menu">
				 	<div id="header-myInfo-dropdown-wrapper">
				 		<div class="header-myInfo-dropdown-header">
					 		<div class="header-myInfo-dropdown-header-text">
						 		${myInfo.name }( ${myInfo.nickname } )
						 		<br>
						 		${myInfo.email }
						 	</div>
					 		<span class="header-myInfo-dropdown-closeBtn glyphicon glyphicon-remove" ></span>
				 		</div>
				 			<hr>
				 		<div class="header-myInfo-dropdown-content">
				 			<div class="logout-btn hover-blue"  onclick="location.href='/usMemo/index.do'">Log Out</div>
				 		</div>
				 	</div>
				 </div>
			 </div>
			 </div>
		 </div>
	</div>
			