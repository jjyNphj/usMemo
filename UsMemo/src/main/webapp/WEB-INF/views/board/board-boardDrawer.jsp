<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="boards-drawer-view dropdown-menu" >
	<div class="boards-drawer-content">
		<div class="find-board form-group">
			<input type="text" class="form-control" id="find-board-name" placeholder="Find boards by name...">
		</div>
		<div class="board-drawer-boards">
			<div class="starred-boards">
				<div class="starred-boards-header">
					<span class="glyphicon glyphicon-star"></span>
					<span>Starred Boards</span>
				</div>
				<div class="starred-boards-content">
				</div>
			</div>
			<div class="all-boards">
				<div class="all-boards-header">
					<span class="glyphicon glyphicon-object-align-top"></span> 
					<span>My Boards</span>
				</div>
				<div class="all-boards-content">
				</div>
			</div>
		</div>
		
		<div id="board-drawer-newBoard">
			<div class="new-board-btn">
				<span class="new-board-btn-text">Create new board...</span>
			</div>
			<div id="new-board-content " class="dropdown-menu">
			<div class=" form-group">
				<div class="new-board-header">Create Board
				</div>
				<div class="new-board-form-title">
				 	<label for="exampleInputName2">title</label>
    				<input type="text" class="form-control" id="new-board-title" placeholder="">	
				</div>
				<div class="new-board-btn-submit">
				</div>
				</div>
			</div>
		</div>
	</div>
</div>