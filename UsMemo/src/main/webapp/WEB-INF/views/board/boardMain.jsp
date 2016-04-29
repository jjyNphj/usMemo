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
.list_all {
	overflow: auto;
}

.list_unit {
	float: left;
}

.hide {
	display: none;
}
</style>

<script type="text/javascript">

//json 만드려고 객체 생성
var updateList =new Object();
var updateCard =new Object();
var sameListFlag=true;
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
	//자바스크립트의 onload와 비슷한 기능. html이 뿌려지고 나서 ready안의 이벤트들이 동작
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
	
	 //현재 사용자가 리스트 중 한개를 집은 상태
	 function updateListStart(arr,index){
	 arr= jQuery.grep(arr, function(value) {
		  return value != "";
		});
	 //배열상에 공백을 없애기 
/* 		console.log("item:"+arr);
		 console.log("start: "+arr[index]);
		 console.log("start index: "+index);
		 console.log("start with: "+arr[index-1]+" / "+arr[index+1]);
 */
		//옮기기 전 앞에 있는 노드를 빈 오브젝트에 넣음
		if(arr[index-1]!=undefined){
			updateList.beforePreNum=arr[index-1];
		}
		else{
			//앞노드가 없으면 0으로 넣어줌
			updateList.beforePreNum=0;
		}
		//옮기기 전 뒤에 있는 노드를 빈 오브젝트에 넣음
		if(arr[index+1]!=undefined){
			updateList.beforePostNum=arr[index+1];
		  }
		else {
			updateList.beforePostNum=0;
		}
		 //옮기려고 하는 노드 빈 오브젝트에 넣음
		 updateList.currentNum=arr[index];
		
	 }
	 function updateCardStart(arr,index){
		 	    //1) 옮기기 전 리스트 번호, 옮긴 후 리스트 번호
		 		//2) 옮기기 전 리스트의 앞뒤 
		 		//3) 옮긴 후의 앞뒤 
		 var cardInfoRaw;
/* 		 arr= jQuery.grep(arr, function(value) {
			  return value != "";
			}); */
		 //배열상에 공백을 없애기 
		 	console.log("item:"+arr);
			 console.log("start: "+arr[index]);
			 console.log("start index: "+index);
			 console.log("start with: "+arr[index-1]+" / "+arr[index+1]);

			 cardInfoRaw=arr[index].split("_");
			 
			 //드래그하는 카드의 listNum을 의미.
			 updateCard.beforeLNum=cardInfoRaw[0];
			 //드래그하는 카드의 cardNum을 의미.
		 	 updateCard.currentNum=cardInfoRaw[1];
			 
			if(arr[index-1]!=undefined){
				cardInfoRaw=arr[index-1].split("_");
				updateCard.beforePreNum=cardInfoRaw[1];
			}
			else{
				updateCard.beforePreNum=0;
			}
			  
			if(arr[index+1]!=undefined){
				cardInfoRaw=arr[index+1].split("_");
				updateCard.beforePostNum=cardInfoRaw[1];
			  }
			else {
				updateCard.beforePostNum=0;
			}
			
			
		 }
	 /* 집었던 리스트를 놓는 순간 */
	 function updateListStop(arr,index){
		 arr= jQuery.grep(arr, function(value) {
  			  return value != "";
  			});
  		 //배열상에 공백을 없애기 
     /*     console.log("update: "+arr[index]);
         console.log("update index: "+index);
         console.log("update with: "+arr[index-1]+" / "+arr[index+1]);
          */
         //옮긴 후 앞에 있는 노드를 빈 오브젝트에 넣기 
         if(arr[index-1]!=undefined){
        	 updateList.afterPreNum=arr[index-1];
 		}  
 		else{
 			 updateList.afterPreNum=0;
 		}
       	//옮긴 후 뒤에 있는 노드를 빈 오브젝트에 넣기 
 		if(arr[index+1]!=undefined){
 			updateList.afterPostNum=arr[index+1];
 		  }
 		else {
 			updateList.afterPostNum=0;
 		}
 		
	 }
	 function updateCardStop(arr,index){
		    //1) 옮기기 전 리스트 번호, 옮긴 후 리스트 번호
	 		//2) 옮기기 전 리스트의 앞뒤 
	 		//3) 옮긴 후의 앞뒤 
	 		//var cardInfoRaw;
/* 		 arr= jQuery.grep(arr, function(value) {
  			  return value != "";
  			}); */
  		 //배열상에 공백을 없애기 
          console.log("update: "+arr.length);
         console.log("update index: "+index);
         console.log("update with: "+arr[index-1]+" / "+arr[index+1]);
         
    
         var cardInfoRaw=arr[index].split('_');
         updateCard.afterLNum=cardInfoRaw[0];
      
         if(arr[index-1]!=undefined){
        	 cardInfoRaw=arr[index-1].split('_');
        	 updateCard.afterPreNum=cardInfoRaw[1];
        	 //lNum을 받음
             updateCard.afterLNum=cardInfoRaw[0];
            
 		}  
 		else{
 			updateCard.afterPreNum=0;
 		}
 		  
 		if(arr[index+1]!=undefined){
 			cardInfoRaw=arr[index+1].split('_');
 			updateCard.afterPostNum=cardInfoRaw[1];
 			//lNum을 받음.
            updateCard.afterLNum=cardInfoRaw[0];
 		  }
 		else {
 			updateCard.afterPostNum=0;
 		}
 		
	 }
	 function updateListChange(){
		 //json타입으로 변환
		 var listLocation=JSON.stringify(updateList);
		 console.log("List update JSON결과: "+listLocation);
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
	 
	 function updateCardChange(){
		 //json타입으로 변환
		 var cardLocation=JSON.stringify(updateCard);
		 console.log("card의 결과 JSON정보: "+cardLocation);
		  var url='/usMemo/card/update/location';
		 
		 $.ajax({
	            url: url,
	            type :'post',
	            data: cardLocation,
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
	              console.log("List update : "+productOrder);
	              updateListStop(productOrder,ui.item.index());
	            //  listChangeLocation(productOrder);
	              updateListChange();
	            },
	            beforeStop: function( event, ui ) {console.log("item:"+ui.item.index());},
	            change: function( event, ui ) { console.log("change: "+ui.item.index());}
	            
		});
		$(".list_all").disableSelection();

		$(".card_unit").sortable({
			  /*발생순서 : item-start-change-beforeStop-update-(remove-receive-update)-deactivate-stop */
		      connectWith: ".card_unit",
			  start: function (event, ui) {  
				  var productOrder = $(this).sortable("toArray");
				  updateCardStart(productOrder,ui.item.index());
		        },
		      update: function(event, ui) {    
	               var productOrder = $(this).sortable("toArray");
	              console.log("card Update: "+productOrder);
	              /*update: 다른리스트로 옮겨지거나 자기 자신에게서 옮겨지는 즉, 카드가 성공적으로 움직이면 무조건 실행됨.
	              			문제는 자신의 리스트 안에서 카드가 움직일때는 update에서만 카드의 처리가 이루어짐. 
	              			즉, 다른리스트로 가면 receive로 처리하면 되지만, 같은리스트면 update에서만 가능함. 
	              			
	              	if 1) A-2개 , B는 상관 x
	              			A에서 B로 옮기면 A에는 값이 1개만 존재. 
	              			그렇게 되면 첫번째 update가 실행될때는 옮기기 전 리스트의 상황이 찍힘.
	              			그러면 A에 남은 1개의 카드만 productOrder에 있음. ui.item.index()는 디폴트인듯한 1이 남음.
	              			여기서 오류가 발생. 
	              			updateCardStop 함수로 넘어갈때 array형식이 아닌 그냥 값으로 넘어가니깐, productOrder[ui.item.index()]값이 없다!!
	              			그러니 split 함수에서 에러가 남. 
	              			한개의 값만 배열에 존재할 경우 arr[0]을 참조해야하는데 현재 넘어가는 어레이에는 arr[1]로 넘어가게 되니 당연히 값을 못찾지.
	              	if 2) A-1개 B는 상관X
	              			이때도 마찬가지. 
	              			다른 리스트로 넘어가게 된다면 A에는 아무값도 없으니 당연히 오류가 난다. 
	              			
	              			그렇다면
	              			<해결책>
	              			update가 실행될때 값이 1개만 존재하거나 혹은 0개만 존재할 경우는 다른리스트로 카드가 넘어갔을때 뿐임. 
	              			자기자신의 리스트에서 움직임이 일어난다면 최소 2개의 카드가 존재해야 할 것이고, 그때는 문제가 되지 않음. productOrder이 배열로 인식할테니깐.
	              			그러므로 productOrder이 0이거나 1이면 updateCardStop 함수를 확실하게 다른 리스트로 넘어갔을 때 실행시켜주기 위해서
	              			receive 옵션에서 실행시키자. 
	              */
	               if(productOrder.length > 1){
	              updateCardStop(productOrder,ui.item.index());
	              } 
	            },
	           stop: function (event, ui) {
	              updateCardChange();
		        },
			   receive: function( event, ui ) {
				/* 다른 리스트로 넘어갔을 때, 넘어간 요소를 포함한 그 리스트의 요소를 반환 */
					 var productOrder = $(this).sortable("toArray");
			         console.log("receive:"+productOrder+" index: "+productOrder[ui.item.index()]);
			         updateCardStop(productOrder,ui.item.index());
			         sameListFlag=false;
					},
				remove: function( event, ui ) {
				/* 다른 리스트로 넘어갈때, 넘어가기 전의 리스트의 목록을 보여줌. 단, 넘어간 요소는 제거된 상태로!*/
					 var productOrder = $(this).sortable("toArray");
			         console.log("remove:"+productOrder+" index: "+productOrder[ui.item.index()]);
				 }
	    }).disableSelection();

	});

</script>
</head>

<body>

	<form>
		<input type="hidden" id="bNum" value="${bNum }" />
		<ul class="list_all">
			<c:forEach var="l" items="${listList}" varStatus="index">
				<li class="list_unit" id="${l.num}">
					<h1>${l.num},${l.name}<br>${l.llink}/${l.rlink }</h1>

					<ul class="card_unit">
						<c:forEach var="c" items="${cardList}">
							<c:if test="${l.num == c.lNum }">
								<li id="${l.num}_${c.card_num }">[${c.card_num }]
									${c.card_name }, [${c.lNum }/${c.llink }/${c.rlink }]</li>
							</c:if>
						</c:forEach>
					</ul> <input type="button" class="addCardBtn" value="add card..." />

					<div class="hide">
						<textarea rows="5" cols="30" id="cardName${l.num}"></textarea>
						<br> <input type="button" value="add"
							onclick="addCard(${l.num},cardName${l.num})" /> <input
							type="button" class="cancelCardBtn" value="cancel" />
					</div>
				</li>
			</c:forEach>


		</ul>
		<input type="button" class="addListBtn" value="add list..." />
		<div class="hide">
			<textarea rows="5" cols="30" id="listName"></textarea>
			<br> <input type="button" value="add" onclick="addList(${bNum})" />
			<input type="button" class="cancelListBtn" value="cancel" />
		</div>
	</form>

</body>
</html>
