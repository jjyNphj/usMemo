<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="boards-drawer-view" >
	<div class="boards-drawer-content">
		<div class="find-board form-group">
			<input type="text" class="form-control" id="find-board-name" placeholder="Find boards by name...">
		</div>
		<div class="board-drawer-boards">
			<div class="starred-boards">
			</div>
			<div class="all-boards">
				<div class="all-boards-header">
					<span class="glyphicon glyphicon-edit"></span> 
					<span>My Boards</span>
				</div>
				<div class="all-boards-content">
				</div>
			</div>
		</div>
		
		<div class="board-drawer-buttons">
			<a class="board-add-btn">Create new board...</a>
		</div>
	</div>
</div>