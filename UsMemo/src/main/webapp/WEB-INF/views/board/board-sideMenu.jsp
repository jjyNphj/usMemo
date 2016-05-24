<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<div id="wrapper" class="toggled">

	<!-- Sidebar -->
	<div id="sidebar-wrapper" class="side-menu-container">
		<div class="side-menu-header">
			<div class="side-menu-header-wrapper">
				<span class="side-menu-header-text">Menu</span>
				<span class="side-menu-header-closeBtn glyphicon glyphicon-remove" title="Close the board menu."></span>
			</div>
			<hr>
		</div>
		<div class="side-menu-content">
			<div id="setMember">
			</div>
			 <div class="dropdown">
			    <a class="dropdown-toggle" data-toggle="dropdown">Add Members...
			    <span class="glyphicon glyphicon-user"></span>
			    </a>
			    <div id="findOption" class="dropdown-menu">
			      <form role="form">
					<label for="pwd">친구검색</label> 
					<input type="text" class="form-control" id="findMember"	placeholder="이름, 닉네임, email 등으로 검색해보세요."> 
					<span class="help-block">당신의 보드에 팀멤버를 등록하세요. 쉽게 공유할 수 있습니다. </span>
					
					<div id="findMemberResult" class="list-group">
					</div>
				</form>
			    </div>
  			</div>
		</div>
		<!-- 		                </li>
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
		            </ul>  -->
	</div>
	<!-- /#sidebar-wrapper -->
</div>
<!-- /.wrapper -->