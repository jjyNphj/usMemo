//json 만드려고 객체 생성
var updateList =new Object();
var updateCard =new Object();
var sameListFlag=true;
var before=new Object();
	 
widthResize($('.board-name')[0]);
		$(document).ready(function() { //보드가 열릴때 기본 설정들임. 로딩이 느린 이유 때문에 ready에 넣은 것임.

				 //보드색 설정
				var boardColor= $('#boardColor').val();
				$('body, #board-header-wrap,.member-boards-background,.add-board-background,.drawer-boardsList-title-background,.drawer-boardsList-title-link-thumbnail')
				.css("background-color",boardColor);
				//리스트네임의 textarea height 조정
				var textarea_arr=$('h6>textarea.list-name');
				for(var i=0;i<textarea_arr.length;i++){
					heightResize(textarea_arr[i]);
				}
			
		});
		/*
		 * body영역 설정
		 * */

			/**
			 * nav 고정영역만큼 body영역의 위치고정
			 */
			resizeBodyByNav();
			function resizeBodyByNav(){
				
				/*  $(".navbar").outerHeight(); 
				 *  엘리먼트의 padding 포함한 높이 구하기
				 *  $(".navbar").outerHeight(true);
				 *  엘리먼트의 margin 포함한 높이 구하기  
				 */
				var navSize=$("#navId").outerHeight(true);
				$(".list_all").css('padding-top',navSize+'px');
				$(".list_all").css('padding-bottom',navSize+'px');
				//리스트 중에서 맨 끝에가 화면상으로 딱 붙어있으므로 오른쪽 패딩만큼 패딩을 줌.
				var list_all_padding=$(".list_all").css("padding-left");
				$(".list_all").css("padding-right",list_all_padding);
				//리스트추가 버튼을 리스트 하나의 크기만큼 너비를 줌 
				var list_unit_width=$(".list_unit").css("width");
				$(".addListBtn").css("width",list_unit_width);
				
			}
			
			
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
	            $(this).parent().toggleClass("hide");
	            //원래 버튼인 add card... 버튼 보이기 
	           $(this).parents("div").prev(":button").show();
	           $(this).parent().children("div").children("textarea").val('');
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
	            $(this).parent().toggleClass("hide");
	            //원래 버튼인 add card... 버튼 보이기 
	           $(this).parents("div").prev(":button").show();
	           //입력창 지우기
	           $("#listName_textarea").val('');
	        });

	        $("textarea").keyup(function(){
	        	/*fnChkByte(obj, maxByte){*/
	        	var maxByte=100;
	        	var str = $(this).val();
	        	var str_len = str.length;

	        	var rbyte = 0;
	        	var rlen = 0;
	        	var one_char = "";
	        	var str2 = "";

	        	for(var i=0; i<str_len; i++){
	        	one_char = str.charAt(i);
	        	if(escape(one_char).length > 4){
	        	    rbyte += 2;                                         //한글2Byte
	        	}else{
	        	    rbyte++;                                            //영문 등 나머지 1Byte
	        	}

	        	if(rbyte <= maxByte){
	        	    rlen = i+1;                                          //return할 문자열 갯수
	        	}
	        	}

	        	if(rbyte > maxByte){
	        	    alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	        	    str2 = str.substr(0,rlen);                                  //문자열 자르기
	        	    $(this).val(str2);
	        	    //글자수를 넘었으므로 입력창의 스타일을 바꿔준다.
	        	    $(this).parent("div").removeClass("has-success");
	        	    $(this).parent("div").addClass("has-error has-feedback");
	        	    //fnChkByte(obj, maxByte);
	        	}else{
	        	    $("#byteInfo").text(rbyte);
	        	    //입력창의 스타일을 바꿔줌 
	        	    $(this).parent("div").removeClass("has-error has-feedback");
	        	    $(this).parent("div").addClass("has-success");

	        	}
	        	});

	 function addCard(lNum,nameNum){
		 /*lnum과 sessionid로 card에 정보 넣기*/
		 var u='#listContents'+lNum;
		 //console.log(u);
		 var name=nameNum.value;
		 var memId=$("#memId").val();
		 var bNum=$('#bNum').val();
		 var url='/usMemo/card/add/'+bNum+'?lNum='+lNum+'&name='+name+'&memId='+memId;
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
		 var listName=$("#listName_textarea").val();
		 var memId=$('#memId').val();
		 var url='/usMemo/list/add/'+memId+'?bNum='+bNum+'&name='+listName;
		 
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
	 function updateListStart(inputArr,moveItemId){
		 var arr=new Array();
		 var index;
		 
		 inputArr= jQuery.grep(inputArr, function(value) {
		  return value != "";
		});
	 //1) arr에서 카드의 id는 제외시키기
		 $.each(inputArr,function(inx,value){
			 if(value.indexOf("_")==-1){
				 //리스트의 id가 제대로 들어있는경우임.
				 arr.push(value);
			 }
		 });
	 //2) 정리된 arr에서 moveItemId와 같은것을 찾아서 index로 만들기 
		 $.each(arr,function(inx,value){
			 if(value==moveItemId){
				 //현재 id와 같은것을 찾음.index를 가지고와야함.
				 index=inx;
			 }
		 });
	 //배열상에 공백을 없애기 
		/*console.log("item:"+arr);
		 console.log("start: "+arr[index]);
		 console.log("start index: "+index);
		 console.log("start with: "+arr[index-1]+" / "+arr[index+1]);*/

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
	 function updateListStop(inputArr,moveItemId){
		 var arr=new Array();
		 var index;
		 
		 inputArr= jQuery.grep(inputArr, function(value) {
		  return value != "";
		});
	 //1) arr에서 카드의 id는 제외시키기
		 $.each(inputArr,function(inx,value){
			 if(value.indexOf("_")==-1){
				 //리스트의 id가 제대로 들어있는경우임.
				 arr.push(value);
			 }
		 });
	 //2) 정리된 arr에서 moveItemId와 같은것을 찾아서 index로 만들기 
		 $.each(arr,function(inx,value){
			 if(value==moveItemId){
				 //현재 id와 같은것을 찾음.index를 가지고와야함.
				 index=inx;
			 }
		 });
  		 //배열상에 공백을 없애기 
		 console.log("--------------------------");
         console.log("update: "+arr[index]);
         console.log("update index: "+index);
         console.log("update with: "+arr[index-1]+" / "+arr[index+1]);
         
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
         console.log("update with: "+arr[index-1]+"/"+arr[index] +" / "+arr[index+1]);
         
    
         var cardInfoRaw;
       	 //lNum을 받음
         updateCard.afterLNum=lNum;
      
         if(arr.length==1){
        	 //카드없는 리스트에 카드를 넘길때 
        	 updateCard.afterPreNum=0;
        	 updateCard.afterPostNum=0;
         }
         else{
        	 //카드 있는 리스트에 카드를 넘길때 
		         if(arr[index-1]!=undefined){
		        	 //옮긴 후의 카드의 앞에 카드가 있을때
		        	 cardInfoRaw=arr[index-1].split('_');
		        	 updateCard.afterPreNum=cardInfoRaw[1];
		 		}  
		 		else{//리스트에 카드를 맨 앞자리로 옮겼을 때 
		 			updateCard.afterPreNum=0;
		 		}
		 		  
		 		if(arr[index+1]!=undefined){
		 			cardInfoRaw=arr[index+1].split('_');
		 			updateCard.afterPostNum=cardInfoRaw[1];
		 		  }
		 		else {//리스트에 카드를 맨 뒷자리로 옮겼을 때 
		 			updateCard.afterPostNum=0;
		 		}
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
	            	//alert("success!");
	            	//window.location.reload();
	            } ,
		       error :function(data,status,er) { 
		    	   alert("error: "+data+" status: "+status+" er:"+er);
		    	   console.log("error: "+data+" status: "+status+" er:"+er);
	         }
	        }) 
	 }
	 
	 function updateCardChange(){
		 updateCard.memId=$('#memId').val();
		 updateCard.bNum=$('#bNum').val();
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
	            	//alert("success!");
	            	//window.location.reload();
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
			/*axis:"x",*/
/*			cancel: "#addListLI" 입력을 못하게 막음,*/
			items: ".list_unit, div:not(.no-include-sortable,.card_all,.card_unit)"/*"div:not(#addListLI,#addCardLI,.card_unit)"*/,
			/*움직이는 대상에서 제외*/
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
				  console.log("item:"+productOrder);
					updateListStart(productOrder,ui.item[0].id);
				  
		        },
		        stop: function (event, ui) {
		        	 var productOrder = $(this).sortable("toArray");
		    		
		        },
			update: function(event, ui) {    
	               var productOrder = $(this).sortable("toArray");
	              console.log("List update : "+productOrder);
	              updateListStop(productOrder,ui.item[0].id);
	            //  listChangeLocation(productOrder);
	              updateListChange();
	            },
	            beforeStop: function( event, ui ) {console.log("item:"+ui.item.index());},
	            change: function( event, ui ) { console.log("change: "+ui.item[0].id);}
	            
		}).disableSelection();

		$(".card_all").sortable({
			  /*발생순서 : item-start-change-beforeStop-update-(remove-receive-update)-deactivate-stop */
		      connectWith: ".card_all",
	/*	      cancel: "#addCardLI" addbtn은 움직일 수 없게 설정,*/
		      items: ".card_unit, div:not(.no-include-sortable)",
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

    
    $("#board-header-starred").click(function(){
    	if($(this).hasClass("glyphicon glyphicon-star-empty")){
    		//즐겨찾기로 해줘야함.
    		$(this).removeClass("glyphicon glyphicon-star-empty");
    		$(this).addClass("glyphicon glyphicon-star");
    		updateStarBoard('Y',static_bNum,static_memId);
    	}else if(!$(this).hasClass("glyphicon glyphicon-star-empty")){
    		$(this).removeClass("glyphicon glyphicon-star");
    		$(this).addClass("glyphicon glyphicon-star-empty");
    		updateStarBoard('N');
    	}
    });

    
    //리스트 삭제시 하위의 카드까지 모두 삭제
    function deleteListInfo(num){
    	var deleteChoice = window.confirm('정말로 이 리스트를 삭제하시겠습니까?(하위 카드 내용도 전부 삭제 됩니다.)');	
    	
    	if(deleteChoice) {
    		var url='/usMemo/list/delete/ListInfo?num='+num;

    		$.ajax({
    			url: url,
    			type:'post',

    			success:function(){
    				alert("리스트와 카드 정보 삭제!");

    				console.log("num:"+num);		

    				//$()안에있는 조건에 해당하는 태그를 포함한 하위 요소, 이벤트, 데이터 모두 제거
    				$('div.list_unit#'+num).remove();
    			} ,
    			error : function(xhr, status, error) {
    				alert(error);
    			}
    		})
    	} 
    }
    function widthResize(obj) {
    	//textarea에 입력된 크기만큼 세로 길이 조정
    	obj.style.width = "1px";
    	obj.style.width = (10+obj.scrollWidth)+"px";
    }
  //이름 수정시 엔터치면 바로 이름 저장 되는 부분
    function enterSave(e,thisElement) {
    	/*
    	 * boardMain에서 키가 눌릴때마다 키코드를 찾음
    	 * keyCode가 0이면  which 리턴, 엔터의 키코드 13이므로 엔터 치는 순간 if문으로 넘어감
    	 * keyCode와 which는 ie,firefox 브라우저의 차이떄문에...?
    	 * */
    	
        var code = (e.keyCode ? e.keyCode : e.which);
        if (code == 13 ) { //Enter keycode
        	
            e.preventDefault();
            //엔터 친후 textarea에서 커서 제거하기
           /* var className=thisElement.className;
            var type=thisElement.type;
            $(type+'.'+className).blur();*/
            thisElement.blur();
            var className=thisElement.className;
            if ($(thisElement).hasClass("list-name")){
            editListName(thisElement);	
            }else if($(thisElement).hasClass("board-name")){
            	editBoardName(thisElement);
            }else if($(thisElement).hasClass("find-member")){
            	findMember(thisElement.value);
            }
           
            

        }
    }
    
	//카드 수정창에서 카드 이름쓰는 부분에서 포커스가 벗어나면 카드이름 저장하는 부분
	$("textarea.list-name").blur(function()
		{editListName(this);		});
	
	$("input.board-name").blur(function()
				{editBoardName(this);
			});

	
	function editListName(thisElement){
		  var listId = thisElement.id;
          listId=listId.split('_');
         
          var num=listId[1];
          var name=thisElement.value;

          var url='/usMemo/list/edit/listName?num='+num+'&name='+name;
	
			$.ajax({
				url: url,
				type:'post',
				success:function(){
				} ,
				error : function(xhr, status, error) {
					alert(error);
				}
			})
			
	}
	
	function editBoardName(thisElement){
		 var boardId = thisElement.id;
		  boardId=boardId.split('_');
        
         var num=boardId[1];
         var name=thisElement.value;

         var url='/usMemo/board/edit/boardName?bNum='+num+'&name='+name;
	
			$.ajax({
				url: url,
				type:'post',
				success:function(){
				} ,
				error : function(xhr, status, error) {
					alert(error);
				}
			})
	}

	 
