<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<!-- 부트스트랩 CDN -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- <script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script> -->
<script	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

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
var before=new Object();
/* = new Array();
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
	 function updateCardStop(arr,index,lNum){
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
         
    
         var cardInfoRaw;
       	 //lNum을 받음
         updateCard.afterLNum=lNum;
      
         if(arr[index-1]!=undefined){
        	 cardInfoRaw=arr[index-1].split('_');
        	 updateCard.afterPreNum=cardInfoRaw[1];
 		}  
 		else{
 			updateCard.afterPreNum=0;
 		}
 		  
 		if(arr[index+1]!=undefined){
 			cardInfoRaw=arr[index+1].split('_');
 			updateCard.afterPostNum=cardInfoRaw[1];
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
	 
	 function openMenu(bNum, memId){
		 
		  var url='/usMemo/member/friend/index?bNum='+bNum+'&memId='+memId;
		  window.open(url, "_self",  '');
	/* 	 $.ajax({
	            url: url,
	            type :'post',
	            success:function(){
	            	alert("success!");
	            	window.location.reload(); 
	            } ,
		       error :function(data,status,er) { 
		    	   alert("error: "+data+" status: "+status+" er:"+er);
		    	   console.log("error: "+data+" status: "+status+" er:"+er);
	         }
	        })  */
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
	              			
	              			<해결책>
	              				같은리스트에서 카드가 옮겨지면 stop에서 처리, 
	              				다른리스트로 카드가 옮겨지면 receive에서 처리.
	              */
	      
	            },
	           stop: function (event, ui) {
	        	   var productOrder = $(this).sortable("toArray");
		           // console.log("card stop: "+productOrder);
		            if(sameListFlag){
		            	//같은 리스트에서 카드가 옮겨졌을 때 처리.
		            	updateCardStop(productOrder,ui.item.index());}
	              updateCardChange();
		        },
			   receive: function( event, ui ) {
				/* 다른 리스트로 넘어갔을 때, 넘어간 요소를 포함한 그 리스트의 요소를 반환 */
					 var productOrder = $(this).sortable("toArray");
			         console.log("receive:"+productOrder+" index: "+productOrder[ui.item.index()]);
			         console.log("ui.item.context.parentNode.id:"+ui.item.context.parentNode.id+" ui.position : "+ui.position);
			         updateCardStop(productOrder,ui.item.index(),ui.item.context.parentNode.id);
			         sameListFlag=false;
					},
				remove: function( event, ui ) {
				/* 다른 리스트로 넘어갈때, 넘어가기 전의 리스트의 목록을 보여줌. 단, 넘어간 요소는 제거된 상태로!*/
					 var productOrder = $(this).sortable("toArray");
			       //  console.log("remove:"+productOrder+" index: "+productOrder[ui.item.index()]);
				 }, beforeStop: function( event, ui ) {console.log("item:"+ui.item.index());},
		            //change: function( event, ui ) { console.log("change: "+ui.item.index());}
	    }).disableSelection();

	});

</script>

<script>
function editCard(cNum) {
	var url='/usMemo/card/edit';
	var listAndcard = new Object();
	listAndcard.cNum = cNum;
	 
	/* JSP 상에서 서버에 데이터를 전송할 시 String 형태로 데이터를 만들어야함
		자바스크립트의 JSON.stringify 함수를 이용해서 JSON 문자열(String)로 변환(형변환) */
	var cNum = JSON.stringify(listAndcard);
	 
	console.log(cNum);
	$.ajax({
		url: url,	      
		type:'post',
		data: cNum,
		dataType:'json',
		/* Jackson라이브러리의 컨텐츠 타입으로 JSON HTTP 메시지와 객체 사이의 변환을 처리 */
		contentType: 'application/json',
		success:function(data){
			//의아한 점> CardController에서 넘어온 json 형태의 객체는 jsp에서 자동으로 자바스크립트 객체로 변환되는 것인가..? 파싱 일을 여러번 하는것 같은 느낌..
			//결론> 지워도 되네여. CardController에서 넘어오는 json 타입 자동으로 자바스크립트 객체로 변환해주는듯? 
			//    혹은 json 형태로도 자바스크립트에서는 파싱없이 데이터가 읽히는 것일지두..json은 어차피 자바스크립트에서 나온거라..? 서버에서 주고 받을때만 json형태인지 아닌지만 검증하는건가봄
			/* JSON.stringify -> 자바스크립트 값을 JSON 문자열(String)로 변환 
			   JSON.parse -> JSON 문자열(String)을 자바스크립트 객체로 변환  */
			/* var card=JSON.parse(JSON.stringify(data)); 
			   setCardInfo(card) */
			setCardInfo(data);
				       	 
			console.log(data);
		} ,
		error : function(xhr, status, error) {
		alert(error);
		}
	}) 
}  
 
 function setCardInfo(cardInfo){
	 /* ListAndCard dto의 card 정보와 list 정보를 html에서 쓰기위해 세팅하는 부분  */
	 $("#card_Name").text(cardInfo.card_name);
	 $("#list_Name").text(cardInfo.list_name);
	 
	 /* Sat Apr 30 2016 20:31:18 GMT+0900 형태로 date에 들어감 */
	 var date = new Date(cardInfo.n_date);
	 /* 2016. 4. 30. 오후 8:31:18 형태로 바꿔줌*/
	 var card_date = date.toLocaleString();
	$("#card_Date").text(card_date);

 }
</script>

<script>
 	//clear,close나 X버튼 누르면 textarea 내용 초기화 시키기.
    function clearForm(o){
        $('[type=text], select, textarea', o).val('');
    } 
</script>

</head>

<body>

	<form>
		<input type="hidden" id="bNum" value="${bNum }" />
		<ul class="list_all">
			<c:forEach var="l" items="${listList}" varStatus="index">
				<li class="list_unit" id="${l.num}">
					<h1>${l.num},${l.name}<br>${l.llink}/${l.rlink }</h1>
					<ul class="card_unit" id="${l.num }">
					-
						<c:forEach var="c" items="${cardList}">
							<c:if test="${l.num == c.lNum }">
							
								<!-- 카드수정버튼만 생성해 놓았으며, 아래의 주석 Modal에서 창뜨는 부분을 구현함. 참고>스페이스기호:&nbsp -->
								<li id="${l.num}_${c.card_num }">
									[${c.card_num }] ${c.card_name }, [${c.lNum }/${c.llink }/${c.rlink }]&nbsp;&nbsp;&nbsp;
									<input type="button" value="Edit" onclick="editCard(${c.card_num})" data-toggle="modal" data-target="#myModal"/>
								</li>
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
		<input type="button" class="addListBtn" value="add list..." />
		<div class="hide">
			<textarea rows="5" cols="30" id="listName"></textarea>
			<br> <input type="button" value="add" onclick="addList(${bNum})" />
			<input type="button" class="cancelListBtn" value="cancel" />
		</div>
		
		<input type="button" value="Menu" onClick="openMenu(${bNum},${sessionScope.id})"/>
	</form>
	
	
	<!-- Modal 길어서 쪼갬-->
	<div class="container">
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title" ><span id="card_Name" /></h4>
						<h6 class="modal-title" >in list <span id="list_Name" /></h6>
					</div>
					<div class="modal-body">
						<p>You wrote:<br><span id="card_Date"/></p>
						
						<p>카드 상세 내용 입력하는 부분, 수정</p>
						<!-- textarea의 내용 id변수에 저장해서 /createBoard 전달 -->
						<textarea class="form-control" style="resize:none;" rows="10"  id="boardComment" placeholder="카드상세내용을 입력해주세요."></textarea></br>
						<button type="button" class="btn btn-primary" style="float:right;" onclick="">&nbsp;Save&nbsp;</button>
						<button type="button" class="btn btn-default" style="float:right;margin-right:5px" onclick="clearForm(this.form)">&nbsp;Clear&nbsp;</button></br>
						
						<form>
							<div class="form-group" >
								<label for="exampleInputFile" >파일 업로드</label> 
								<input type="file"	id="exampleInputFile"  >
								<p class="help-block">파일 추가, 삭제, 다운</p>
							</div>
							<button type="submit" class="btn btn-default">첨부하기</button>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearForm(this.form)">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>
