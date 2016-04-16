<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<title>Insert title here</title>

<style type="text/css">
  .list_all{ overflow:auto;}
  .list_unit{ float:left;}
  .hide{display: none;}
</style>

<script type="text/javascript">
	/* 	function goPage(bNum, name) {
	 var answer = confirm("선택하신 도서를 대출목록에서 삭제하시겠습니까?");
	 if (answer) {
	 var url = '/usMemo/board/index?bNum=' + bNum.value + '&name='
	 + name.value;
	 window.open(url, "_self", '');
	 }
	 }
	 */
	 
	// html dom 이 다 로딩된 후 실행된다.
	    $(document).ready(function(){
	        // .addCardBtn 클래스 중 아무거나 클릭했을 때 
	        $(".addCardBtn").click(function(){
	            // 현재 버튼의 옆의 태그중 div 태그에 hide 클래스 태그를 넣던지 빼던지 한다.
	            $(this).next(".hide").toggleClass("hide");
	            $(this).hide();
	        });
	        
	        //카드 추가버튼클릭 후 취소 버튼 클릭했을 때
	        $(".cancelCardBtn").click(function(){
	            //cancel 클릭했을 때 입력창 감추기! 
	            $(this).parents("div").toggleClass("hide");
	            //원래 버튼인 add card... 버튼 보이기 
	           $(this).parents("div").prev(":button").show();
	        });
	        
	        
	    });
	 
	 function addCardButton(){
		 
	 }
	 function addListButton(){
		 
	 }
	 function addCard(lNum){
		 /*lnum과 sessionid로 card에 정보 넣기*/
	 }
	 function addList(bNum){
		 /*bNum으로 location 맨 마지막으로 설정 후 list에 추가 */
	 }
	 
</script>
<script>
	$(function() {
		/*
		1) 리스트의 갯수만큼 동적 생성해야함.
		2) 리스트간 카드 넘기기  */
		$(".list_all").sortable();
		$(".list_all").disableSelection();

		$(".card_unit").sortable();
		$(".card_unit").disableSelection();

		$("#CardType0").sortable();
		$("#CardType0").disableSelection();
		$("#CardType1").sortable();
		$("#CardType1").disableSelection();
		$("#CardType2").sortable();
		$("#CardType2").disableSelection();

	});
</script>
</head>
<body>

	<form>
	<ul class="list_all">
			<c:forEach var="l" items="${listList}">
			<li class="list_unit">
					<h1>${l.num},${l.name},${l.location}</h1>
							<ul class="card_unit">
					<c:forEach var="c" items="${cardList}">
						<c:if test="${l.num == c.card_lNum }">
							<li>[${c.card_num }] ${c.card_name }, [${c.card_lNum }/${c.card_location }]</li><br>
						</c:if>
					</c:forEach>
							</ul>
						
								<input type="button" class="addCardBtn" value="add card..."/>
							
								<div class="hide">
									<textarea rows="5" cols="30" name="cardContents"></textarea><br>
									<input type="button" value="add" onclick="addCard(${l.num})"/>
									<input type="button" class="cancelCardBtn" value="cancel"/>
								</div>
							
							
				</br>
			</li>
			</c:forEach>
			
			<input type="button" class="addListBtn" value="add list..."/>
					<div class="hide">
						<textarea rows="5" cols="30" name="listContents"></textarea>
						<input type="button" value="add" onclick="addList(${bNum})"/>
						<input type="button" value="cancel" />
					</div>
	</ul>
	</form>
</body>
</html>