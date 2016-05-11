//json 만드려고 객체 생성
var updateList =new Object();
var updateCard =new Object();
var sameListFlag=true;
var before=new Object();
	 
/*
 * 버튼설정
 * */

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

	        
	 function addCard(lNum,nameNum){
		 /*lnum과 sessionid로 card에 정보 넣기*/
		 var u='#listContents'+lNum;
		 //console.log(u);
		 var name=nameNum.value;
		 var memId=$("#memId").val();
		 var url='/usMemo/card/add?lNum='+lNum+'&name='+name+'&memId='+memId;
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
		            	updateCardStop(productOrder,ui.item.index(),ui.item.context.parentNode.id);}
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

 	//clear,close나 X버튼 누르면 textarea 내용 초기화 시키기.
    function clearForm(o){
        $('[type=text], select, textarea', o).val('');
    } 
    
    
	 
	 

