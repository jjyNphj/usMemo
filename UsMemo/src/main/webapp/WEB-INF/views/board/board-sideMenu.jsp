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
			 <div class="side-menu-addMember-wrapper dropdown">
			 	<div class="side-menu-addMember-btn dropdown-toggle" data-toggle="dropdown">
				    <span class="glyphicon glyphicon-user"></span>
				    <span class="side-menu-addMember-text">Add Members...
			    </span>
			    </div>
			    <div id="findOption" class="dropdown-menu">
			      <form role="form">
					<label for="pwd">친구검색</label> 
					<span id="findMember-close-btn" class="glyphicon glyphicon-remove"></span>
					<input type="text" class="find-member form-control" id="findMember"  onkeypress="enterSave(event,this)" placeholder="이름, 닉네임, email 등으로 검색해보세요."> 
					<div class="help-block">당신의 보드에 팀멤버를 등록하세요. 쉽게 공유할 수 있습니다. </div>
					
					<div id="findMemberResult" class="list-group">
					</div>
				</form>
			    </div>
  			</div>
  			<hr>
  				<div class="side-menu-option-menu">
		  			<div id="side-menu-delete-board-wrapper">
		  				<div class="side-menu-delete-board-btn">
		  					<span class="glyphicon glyphicon-trash"></span>
		  					<span>delete Board...</span>
		  				</div>
		  			</div>
		  			<div id="side-menu-change-color-wrapper" class="dropdown">
		  				<div class="side-menu-change-color-btn dropdown-toggle" data-toggle="dropdown">
		  					<span class="glyphicon glyphicon-cog"></span>
		  					<span>Change Background</span>
		  				</div>
		  				<div class="dropdown-menu">
		  					<div class="background-color-list">
		  						<div class="background-color-list-header">
		  							<span class="background-color-list-header-text">Change Background</span>
		  							<span class="background-color-list-close-btn glyphicon glyphicon-remove"></span>
		  						</div>
		  						<hr>
		  						<div class="background-color-list-select">
				  						<div id="color-list-blue" class="color-list-item"></div>
				  						<div id="color-list-orange" class="color-list-item"></div>
				  						<div id="color-list-green" class="color-list-item"></div>
				  						<div id="color-list-red" class="color-list-item"></div>
				  						<div id="color-list-purple" class="color-list-item"></div>
				  						<div id="color-list-pink" class="color-list-item"></div>
				  						<div id="color-list-lightGreen" class="color-list-item"></div>
				  						<div id="color-list-sykBlue" class="color-list-item"></div>
				  						<div id="color-list-gray" class="color-list-item"></div>
		  						</div>
		  					</div>
		  				</div>
		  			</div>
	  			</div>
  			<hr>
  			<div class="side-menu-activity-wrapper">
  				<div class="side-menu-activity-header">
  					<span class="side-menu-activity-header-text">Activity</span>
  				</div>
  				<div class="side-menu-activity-content">
  				
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