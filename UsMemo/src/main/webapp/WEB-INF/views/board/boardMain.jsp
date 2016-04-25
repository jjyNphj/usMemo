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

var updateList =new Object();
/* = new Array();
var before=new Object();
var after=new Object();
var current=new Object(); */
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
	        
	        // .addListBtn 클래스 중 아무거나 클릭했을 때 
	        $(".addListBtn").click(function(){
	            // 현재 버튼의 옆의 태그중 div 태그에 hide 클래스 태그를 넣던지 빼던지 한다.
	            $(this).next(".hide").toggleClass("hide");
	            $(this).hide();
	        });
	        
	        //카드 추가버튼클릭 후 취소 버튼 클릭했을 때
	        $(".cancelListBtn").click(function(){
	            //cancel 클릭했을 때 입력창 감추기! 
	            $(this).parents("div").toggleClass("hide");
	            //원래 버튼인 add card... 버튼 보이기 
	           $(this).parents("div").prev(":button").show();
	        });
	    });
	 
	 function addCard(lNum,nameNum){
		 /*lnum과 sessionid로 card에 정보 넣기*/
		 var u='#listContents'+lNum;
		 var name=nameNum.value;
		 var url='/usMemo/card/add?lNum='+lNum+'&name='+name+'&memId='+${sessionScope.id};
		  $.ajax({
            url: url,
           
            type:'post',
            success:function(){
            
            	alert("happy!");
            	window.location.reload();
            } ,
	       error : function(xhr, status, error) {
               alert(error);
         }
        })
	 }
	 function addList(bNum){
		 /*bNum으로 location 맨 마지막으로 설정 후 list에 추가 */
		 var listName=$("#listName").val();
		 var url='/usMemo/list/add?bNum='+bNum+'&name='+listName;
		 
		  $.ajax({
	            url: url,
	            type:'post',
	            success:function(){
	               	alert("success");
	            	window.location.reload();
	            } ,
		       error : function(xhr, status, error) {
	               alert(error);
	         }
	        })
			
	 }
	/*  function listChangeLocation(arr){
		 html의 구조상 빈값 두개가 고정으로 계속 들어감, 임시방편으로 배열에서 그 값은 제외
		 var resultArr=new Array();

		 arr= jQuery.grep(arr, function(value) {
			  return value != "";
			});
		 //배열상에 공백을 없애기 
		 
		 console.log(arr);
		 
		 $.each(arr, function(index, listObj) { 
			 배열의 반복문
		 
			 var listInfoRaw = listObj.split('_');
			 
			 if (index != listInfoRaw[0]) {//listInfoRaw[0]은 location, listInfoRaw[1]은 listNum의미.
				 
				var listInfo = new Object();				 
				listInfo.num=listInfoRaw[1];
			 	listInfo.location=index+1;
				console.log("num="+listInfoRaw[1]+" location="+listInfoRaw[0]);
				
		 		listInfo.bNum=$("#bNum").val();//그냥적어둠.나중에 언제쓸지 몰라서
				resultArr.push(listInfo);
			 }
			});
		 
 		 var temp=resultArr[0].location;
		 resultArr[0].location=resultArr[1].location;
		 resultArr[1].location=temp;
		
		 string을 json타입으로 변환 
		 var listLocation=JSON.stringify(resultArr);
		 var url='/usMemo/list/update/location';
		 
		 console.log(listLocation);
 		 
		 $.ajax({
	            url: url,
	            type :'post',
	            data:listLocation,
	            contentType: 'application/json',
	            success:function(){
	            	alert("success!");
	            	window.location.reload();
	            } ,
		       error :function(data,status,er) { 
		    	   alert("error: "+data+" status: "+status+" er:"+er);
		    	   console.log("error: "+data+" status: "+status+" er:"+er);
	         }
	        }) 
	 } */
	 function updateListStart(arr,index){
	 arr= jQuery.grep(arr, function(value) {
		  return value != "";
		});
	 //배열상에 공백을 없애기 
		console.log("item:"+arr);
		 console.log("start: "+arr[index]);
		 console.log("start index: "+index);
		 console.log("start with: "+arr[index-1]+" / "+arr[index+1]);

		/*  var beforePreItem_raw=arr[index-1];
		 var beforePostItem_raw=arr[index+1];
		  */
		if(arr[index-1]!=undefined){
			updateList.beforePreNum=arr[index-1];
		}
		else{
			updateList.beforePreNum=0;
		}
		  
		if(arr[index+1]!=undefined){
			updateList.beforePostNum=arr[index+1];
		  }
		else {
			updateList.beforePostNum=0;
		}
		 
		 updateList.currentNum=arr[index];
		
	 }
	 function updateListStop(arr,index){
		 arr= jQuery.grep(arr, function(value) {
  			  return value != "";
  			});
  		 //배열상에 공백을 없애기 
         console.log("stop: "+arr[index]);
         console.log("stop index: "+index);
         console.log("stop with: "+arr[index-1]+" / "+arr[index+1]);
         
         if(arr[index-1]!=undefined){
        	 updateList.afterPreNum=arr[index-1];
 		}
 		else{
 			 updateList.afterPreNum=0;
 		}
 		  
 		if(arr[index+1]!=undefined){
 			updateList.afterPostNum=arr[index+1];
 		  }
 		else {
 			updateList.afterPostNum=0;
 		}
 		
	 }
	 function updateListChange(){
		 var listLocation=JSON.stringify(updateList);
		 console.log("결과: "+listLocation);
		 var url='/usMemo/list/update/location';
		 
		 $.ajax({
	            url: url,
	            type :'post',
	            data:listLocation,
	            contentType: 'application/json',
	            success:function(){
	            	alert("success!");
	            	window.location.reload();
	            } ,
		       error :function(data,status,er) { 
		    	   alert("error: "+data+" status: "+status+" er:"+er);
		    	   console.log("error: "+data+" status: "+status+" er:"+er);
	         }
	        }) 
	 }
</script>

<script>

	$(function() {
		/*
		1) 리스트의 갯수만큼 동적 생성해야함.
		2) 리스트간 카드 넘기기  */
		$(".list_all").sortable({
			axis:"x",
			item:function(event, ui) {    
	               var productOrder = $(this).sortable("toArray");
		              console.log("item:"+productOrder);
		              }
			,
			position:function(event, ui) {    
	            var productOrder = $(this).sortable("toArray");
	            console.log("position: "+productOrder);
	            }
			,
			originalPosition:function(event, ui) {    
			    var productOrder = $(this).sortable("toArray");
			    console.log("originalPosition:"+ui.item.index());
			    }
			,
			  start: function (event, ui) {  
				  var productOrder = $(this).sortable("toArray");
					updateListStart(productOrder,ui.item.index());
				  
		        },
		        stop: function (event, ui) {
		        	 var productOrder = $(this).sortable("toArray");
		    		
		        },
			update: function(event, ui) {    
	               var productOrder = $(this).sortable("toArray");
	              console.log("위치: "+productOrder);updateListStop(productOrder,ui.item.index());
	            //  listChangeLocation(productOrder);
	              updateListChange();
	            },
	            beforeStop: function( event, ui ) {console.log("item:"+ui.item.index());},
	            change: function( event, ui ) { console.log("change: "+ui.item.index());}
	            
		});
		$(".list_all").disableSelection();

		$(".card_unit").sortable({
		      connectWith: ".card_unit",
		      update: function(event, ui) {    
	               var productOrder = $(this).sortable("toArray");
	              console.log(productOrder);
	            }
	    }).disableSelection();

	});
</script>
</head>

<body>

	<form>
	<input type="hidden" id="bNum" value="${bNum }"/>
		<ul class="list_all">
			<c:forEach var="l" items="${listList}" varStatus="index">
				<li class="list_unit" id="${l.num}">
					<h1>${l.num},${l.name}<br>${l.llink}/${l.rlink }</h1>
					<ul class="card_unit">
						<c:forEach var="c" items="${cardList}">
							<c:if test="${l.num == c.card_lNum }">
								<li id="${l.num}/${c.card_location }">[${c.card_num }] ${c.card_name }, [${c.card_lNum }/${c.card_location }]</li>
							</c:if>
						</c:forEach>
					</ul> <input type="button" class="addCardBtn" value="add card..." />

					<div class="hide">
						<textarea rows="5" cols="30" id="cardName${l.num}"></textarea>
						<br> <input type="button" value="add" onclick="addCard(${l.num},cardName${l.num})" /> 
						<input type="button" class="cancelCardBtn" value="cancel" />
					</div>
				</li>
			</c:forEach>
			
					
	</ul>
			<input type="button" class="addListBtn" value="add list..."/>
					<div class="hide">
						<textarea rows="5" cols="30" id="listName"></textarea><br>
						<input type="button" value="add" onclick="addList(${bNum})"/>
						<input type="button" class="cancelListBtn" value="cancel" />
					</div>
	</form>
	
</body>
</html>