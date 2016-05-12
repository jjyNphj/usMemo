var bNum=$("#bNum").val();

function addMemberFunc(id,bNum){
		//보드에 member를 추가 
		var answer=confirm("이 보드의 멤버로 추가하시겠습니까?");
		if(answer){ 
			 $.ajax({
		            url: '/usMemo/member/friend/add?memId='+id+'&bNum='+bNum,
		            type :'post',
		            success:function(){
		            	var memId=$("#memId").val();
		            	cleanMemberListView();
		            	cleanFindMemberListView(id);
		            	openMenu(bNum, memId);
		            	
		            	
		            } ,
			       error :function(data,status,er) { 
			    	   alert("error: "+data+" status: "+status+" er:"+er);
			    	   console.log("error: "+data+" status: "+status+" er:"+er);
		         }
		        }); 
		 }
	}
	
	function updateMemberGrade(id,bNum,grade){
	/*	var url= '/usMemo/member/friend/update?memId='+id+'&bNum='+bNum+'&grade='+grade;
		window.open(url, "updateMemberGrade");
		*/
	 $.ajax({
	            url: '/usMemo/member/friend/update?memId='+id+'&bNum='+bNum+'&grade='+grade,
	            type :'post',
	            success:function(){
//	            	alert("success!");
	            	///window.location.reload();
	            	var memId=$("#memId").val();
	            	cleanMemberListView();
	            	openMenu(bNum, memId);
	            	cleanFindeMemberText();
	            } ,
		       error :function(data,status,er) { 
		    	   alert("error: "+data+" status: "+status+" er:"+er);
		    	   console.log("error: "+data+" status: "+status+" er:"+er);
	         }
	        }); 
	}
	
	function deleteMember(id,bNum){
		
		 $.ajax({
	            url: '/usMemo/member/friend/delete?memId='+id+'&bNum='+bNum,
	            type :'post',
	            success:function(){
	            	var memId=$("#memId").val();
	            	cleanMemberListView();
	            	openMenu(bNum, memId);
	            } ,
		       error :function(data,status,er) { 
		    	   alert("error: "+data+" status: "+status+" er:"+er);
		    	   console.log("error: "+data+" status: "+status+" er:"+er);
	         }
	        }); 
	}
	

	$("#findMember").keyup(function(){
		
		 var url='/usMemo/member/friend/find/'+$(this).val()+'/'+bNum;
			 
			  $.ajax({
		            url: url,
		            type:'post',
		            datatype: 'json',
		            success:function(data){
		               	console.log(data);
		               	var result='';
		               	$.each(data,function(index,val){
		               		result+=
		               		'<br>'+
		               		'<a class="list-group-item">'+
			               		'<div id="friendFinding_'+val.id+'" class="row" onclick="addMemberFunc('+val.id+','+bNum+')">'+
				               		'<div class="col-md-2">'+
				               			'<img src="'+val.profile_image+'" class="img-rounded" />'+
				               		'</div>'+
				               		'<div class="col-md-4">'+
				               			'<span>'+val.name+'<br>('+val.nickname+')<br>'+val.email+'</span>'+
				               		'</div>'+
			               		'</div>'+
		               		'</a>';
		               	});
		               		$("#findMemberResult").html(result);
		               	
		            } ,
			       error : function(xhr, status, error) {
		              console.log(error);
		         }
		        }) 
		});
	var check=true;
	
	function openMenu(bNum, memId){
		 
		  var url='/usMemo/member/friend/index';
		  
			var menuInfo = new Object();
			menuInfo.bNum = bNum;
			menuInfo.memId = memId;
			/* JSP 상에서 서버에 데이터를 전송할 시 String 형태로 데이터를 만들어야함
				자바스크립트의 JSON.stringify 함수를 이용해서 JSON 문자열(String)로 변환(형변환) */
			
			console.log(JSON.stringify(menuInfo));
			
			$.ajax({
				url: url,	      
				type:'post',
				data: JSON.stringify(menuInfo),
				dataType:'json',
				/* Jackson라이브러리의 컨텐츠 타입으로 JSON HTTP 메시지와 객체 사이의 변환을 처리 */
				contentType: 'application/json',
				success:function(data){
					console.log(data);
					/*var ch=$('#setMember > *').length;
					if($('#setMember > *').length != data.length){
					*/
					var bNum=$("#bNum").val();
					var grade=menu_checkSessionId(data,memId);
					menu_setMemberList(data,memId,grade,bNum);
					//}
				} ,
				error : function(xhr, status, error) {
				alert(error);
				}
			}) 
	}

	/**
	 * 현재 멤버리스트에서 로그인한 사용자의 grade를 얻어오기
	 * @param data
	 */
	function menu_checkSessionId(data,sessionId){
		var sessionGrade='';
		$.each(data,function(index,val){
			if(val.id==sessionId){
				sessionGrade=val.grade;
			}
		});
		
		/*$("#setVar").html('<input type="hidden" id="sessionGrade" value="'+sessionGrade+'"/>');
		*/return sessionGrade;
	}
	
	
	function menu_setMemberList(data,sessionId,grade,bNum){
		$.each(data,function(index,val){
			var img_id='#profile_image'+index;
			var ul_id='#ul'+index;
			//이미지 설정함
			$("#setMember").append(
					'<div class="dropdown">'+
						'<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">'+
							'<img id="profile_image'+index+'" data-toggle="popover" data-trigger="hover" title="" data-content="" data-placement="bottom" class="img-circle" width="80px" height="80px">'+
						'<span class="caret"></span>'+
						'</button>'+
						'<ul id="ul'+index+'" class="dropdown-menu" role="menu" aria-labelledby="dLabel">'+
						'</ul>'+
					'</div>');
			$(img_id).attr("src",val.profile_image);
			$(img_id).attr("data-content",val.email);
				//권한에 따라 타이틀만 변경해야함.
				//적으려는 멤버가 현재로그인한 멤버가 아닐경우
				if(val.id!=sessionId){
					//관리자일경우 
					if(val.grade==1){$(img_id).attr("title",val.name+'(admin)');}
					else if(val.grade==2){$(img_id).attr("title",val.name+'(member)');}
				}
				//자신의 프로필을 적는경우
				else if(val.id==sessionId){
						$(img_id).attr("title",'it s me!');
					}
				
				if(grade==1){
				//드롭메뉴 만들기 
					if(val.id!=sessionId){
						//지금 그리려는 프로필이 관리자일경우 등급변경을 일반멤버로
						if(val.grade==1){
							$(ul_id).append('<li><a tabindex="-1" href="javascript:void(0);" onclick="updateMemberGrade('+val.id+','+bNum+',2)">일반멤버로 변경</a></li>');					  		
							
						}
						//지금 그리려는 프로필이 일반멤버일경우 등급변경을 관리자로 
						else if(val.grade==2){
							$(ul_id).append('<li><a tabindex="-1" href="javascript:void(0);" onclick="updateMemberGrade('+val.id+','+bNum+',1)">관리자로 변경</a></li>');					  		
							
						}
						$(ul_id).append('<li class="divider"></li><li><a tabindex="-1" href="javascript:void(0);" onclick="deleteMember('+val.id+','+bNum+')">삭제</a></li>');
					}
					else if(val.id==sessionId){
					//자기자신일땐 드롭메뉴지우자.
						$(ul_id).detach();
					}
					}
		});
	}
	
	
	/**
	 * 모달창의 멤버리스트 내용 지우기 
	 */
		function cleanMemberListView(){
			$('#setMember>*').detach();
	}
		/**
		 * 친구찾기의 리스트 지우기 
		 */
		function cleanFindMemberListView(id){
			$('#friendFinding_'+id).parent().detach();
			/*$('#findMemberResult>*').detach();*/
		}
		function cleanFindeMemberText(){
			$('#findMember').val('');
		}
		//이벤트: 모달 창 끄면 
		/*$('#menuView').on('hidden.bs.modal',function(){
			cleanMemberListView();
			cleanFindMemberListView();
			cleanFindeMemberText();
			
		})*/

		// 슬라이드바 클릭시
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			
			//토글클래스가 아님
			if(!$("#wrapper").hasClass('toggled')) {
			
			//화면지움
				cleanMemberListView();
				cleanFindMemberListView();
				cleanFindeMemberText();
				
				//토글클래스일 때 
			}else if($("#wrapper").hasClass('toggled')){
			 //화면그림
				openMenu($("#bNum").val(),$("#memId").val());
			}
			$("#wrapper").toggleClass("toggled");

		});
	
		
	/*
	 * 버튼설정
	 * 
	 * */
	$('[data-toggle="popover"]').popover();   
	$(".addMemberBtn").click(function(){
	    // 현재 버튼의 옆의 태그중 div 태그에 hide 클래스 태그를 넣던지 빼던지 한다.
	    $(this).next(".hide").toggleClass("hide");
	    $(this).hide();
	});
	
	$(".cancelAddMemberBtn").click(function(){
		//cancel 클릭하면 기존에 적었던 정보 지우기
		$("#findMember").val('');
	    //cancel 클릭했을 때 입력창 감추기! 
	/*     $(this).parents("div").toggleClass("hide"); */
		$("#findOption").toggleClass("hide");
	    //원래 버튼인 add card... 버튼 보이기 
	   $(this).parents("div").prev(":button").show();
	});
	
	