var static_bNum=$('#bNum').val();
var static_memId=$('#memId').val();

/*
$('.all-activity-btn').click(function(){
	openAllActivity(static_bNum);
});*/

function bind_memberInfo_dropdown_setMember(){
	/*
	 * 사이드메뉴의 사람이름 클릭시 보여지는 회원정보 창 끄기버튼 설정
	 * .dropdown-toggle의 명확한 클래스를 적어주어야 x버튼 클릭시 토글이 제대로됨. 
	 * 이 보드의 회원 이미지 클릭시 생성되는 회원정보 드롭다운임.
	 * 
	 * 각각의 클래스는 여러가지 노드이므로 따로 바인딩해주어야함. 
	 * */
	$('.side-menu-members-close-btn').click(function(){
		var select=$(this).parents($('.dropdown.side-menu-members.open')).children('.side-menu-members-btn');
		select.dropdown('toggle');
		//$('.side-menu-members-btn').dropdown('toggle');
	});
	
	/*
	 * 드롭다운
	 * 창이 꺼지는 것을 방지함. 
	 * dropdown-menu클래스의 명확한 id를 적어주어야함.(반드시 id로 표기할것.) 
	 */
	
	$('#memberInfo-dropdown-view-content').bind('click', function (e) { e.stopPropagation() });

}
function bind_memberInfo_dropdown_activityMember(){

/*
 * 사이드메뉴의 사람이름 클릭시 보여지는 회원정보 창 끄기버튼 설정
 * .dropdown-toggle의 명확한 클래스를 적어주어야 x버튼 클릭시 토글이 제대로됨. 
 * 차례로 액티비티의 사진클릭시 생성되는 회원정보 드롭다운
 * 액티비티의 회원 이름클릭시 생성되는 회원정보 드롭다운
 * 
 * 클래스로 선언하긴하였지만, 각각의 요소가 다 다르므로 바인딩을 따로 해주어야만 현재 열려있는 창이 닫힘. 
 * 
 * */
$('.my-members-close-btn').click(function(){
	var select=$(this).parents($('.dropdown.activity-unit-my.open')).children('.my-img-wrapper');
	select.dropdown('toggle');
});
$('.activity-members-close-btn').click(function(){
	var select=$(this).parents($('.dropdown.activity-memberInfo-dropdown-view.open')).children('.activity-memberInfo-dropdown-view-btn');
	select.dropdown('toggle');
});

/*
 * 드롭다운
 * 창이 꺼지는 것을 방지함. 
 * dropdown-menu클래스의 명확한 id를 적어주어야함.(반드시 id로 표기할것.) 
 * 차례로 액티비티의 사진클릭시 생성되는 회원정보 드롭다운
 * 액티비티의 회원 이름클릭시 생성되는 회원정보 드롭다운
 * */
$('#my-dropdown-view-content').bind('click', function (e) { e.stopPropagation() });
$('#activity-memberInfo-dropdown-view-content').bind('click', function (e) { e.stopPropagation() });

}

$('.side-menu-delete-board-btn').click(function(){
	// 보드 삭제 버튼 이벤트 
	goDeletePage(static_bNum);
});

function goDeletePage(bNum) {
	var answer=confirm("선택하신 보드를 삭제하시겠습니까?");
		if(answer){ 
	        var url ='/usMemo/board/deleteBoard?bNum='+bNum;
	            window.open(url, "_self",  '');
	     }
} 

function addMemberFunc(id,bNum){
		//보드에 member를 추가 
		var answer=confirm("이 보드의 멤버로 추가하시겠습니까?");
		if(answer){ 
			 $.ajax({
		            url: '/usMemo/member/friend/add/'+static_memId+'?memId='+id+'&bNum='+bNum,
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
		
		 var url='/usMemo/member/friend/find/'+$(this).val()+'/'+static_bNum;
			 
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
			               		'<div id="friendFinding_'+val.id+'" class="row" onclick="addMemberFunc('+val.id+','+static_bNum+')">'+
				               		'<div class="col-md-2">'+
				               			'<img src="'+val.profile_image+'" class="side-menu-profile_image" />'+
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
				async:true,
				success:function(data){
					console.log(data);
					/*var ch=$('#setMember > *').length;
					if($('#setMember > *').length != data.length){
					*/
					var bNum=$("#bNum").val();
					var grade=menu_checkSessionId(data,memId);
					menu_setMemberList(data,memId,grade,bNum);
					openActivity(bNum);
					//}
				} ,
				error : function(xhr, status, error) {
				alert(error);
				}
			}); 
	}
	/**
	 * 일부분의 activity 불러오기
	 * @param bNum
	 */
	function openActivity(bNum){
		  var url='/usMemo/activity/getSomeActivity/'+bNum;
		  
			$.ajax({
				url: url,	      
				type:'post',
				dataType:'json',
				/* Jackson라이브러리의 컨텐츠 타입으로 JSON HTTP 메시지와 객체 사이의 변환을 처리 */
				contentType: 'application/json',
				success:function(data){
					console.log(data);
					setActivity(data,'someActivity');
					setAllActivityBtn();
				} ,
				error : function(xhr, status, error) {
				alert(error);
				}
			});
	}
	
	/**
	 * 모든 activity 불러오기
	 * @param bNum
	 */
	function openAllActivity(bNum){
		  var url='/usMemo/activity/getAllActivity/'+bNum;
		  
			$.ajax({
				url: url,	      
				type:'post',
				dataType:'json',
				/* Jackson라이브러리의 컨텐츠 타입으로 JSON HTTP 메시지와 객체 사이의 변환을 처리 */
				contentType: 'application/json',
				success:function(data){
					console.log(data);
					setActivity(data,'allActivity');
				} ,
				error : function(xhr, status, error) {
				alert(error);
				}
			});
	}
	
	function setAllActivityBtn(){
		var modalString='<a class="all-activity-btn" data-toggle="modal" data-target="#allActivityModal" onclick="openAllActivity('+static_bNum+')">View all activity...</a>';
		$('.side-menu-activity-content').append(modalString);
	}
	/**
	 * activity의 내용을 html에 setting하기.
	 * @param data
	 */
	function setActivity(data,type){
		var result='';
		$.each(data,function(index,val){
			result+=val.last_activity;
		});
/*		$.each(data,function(index,val){
			var format=val.format;
			result+='<div class="activity-unit">'+
						'<div class="dropdown activity-unit-my">'+
							'<div class="my-img-wrapper dropdown-toggle" data-toggle="dropdown">'+
								'<span><img id="my-img_'+val.memId+'" class="my-img" src='+val.profile_image+'><span>'+
							'</div>'+
							'<div id="my-dropdown-view-content" class="dropdown-menu" >'+
								'<div class="my-members-info">'+
									'<div class="my-members-info-wrapper">'+
										'<div class="my-members-info-img-wrapper">'+
											'<img class="my-members-info-img" src="'+val.profile_image+'">'+
										'</div>'+
										'<div class="my-members-info-text-wrapper">'+
											'<span class="my-member-name">'+val.name+'</span>'+
											'<span class="my-member-nickname">('+val.nickname+')</span>'+
											'<br><span class="my-member-email">'+val.email+'</span>'+
										'</div>'+
										'<div class="my-members-close-btn"><span class="glyphicon glyphicon-remove"></span></div>'+
									'</div>'+
								'</div>'+
							'</div>'+
						'</div>'+
						'<div class="activity-unit-contents-wrapper">';
			format=format.replace('#me#',activity_memberInfo_setting_dropdown(val));
			
			switch (val.activity_name) {
			case 'create_board':
				format=format.replace('#me#','<span class="memberInfo-dropdown-view">'+val.nickname+'</span>');
				//result+=format;
				break;
			case 'addList':
				var get_list_name=activity_getListInfo(val.value_num);
				format=format.replace('#me#','<span class="memberInfo-dropdown-view">'+val.nickname+'</span>');
				format=format.replace('#listName#','<span class="listInfo-dropdown-view">'+get_list_name+'</span>');
				//result+=format;
				break;
			case 'addCard':
				var get_list_name=activity_getListInfo(val.to_num);
				var get_card_name=activity_getCardInfo(val.value_num);
				format=format.replace('#me#','<span class="memberInfo-dropdown-view">'+val.nickname+'</span>');
				format=format.replace('#listName#','<span class="listInfo-dropdown-view">'+get_list_name+'</span>');
				format=format.replace('#cardName#',
						'<a class="cardInfo-dropdown-view"  onclick="editCard('+val.value_num+')" data-toggle="modal" data-target="#cardInfoView">'+get_card_name+'</a>'
						);
				break;
			case 'updateCardLocation':
				var get_to_list_name=activity_getListInfo(val.to_num);
				var get_from_list_name=activity_getListInfo(val.from_num);
				var get_card_name=activity_getCardInfo(val.value_num);
				format=format.replace('#me#','<span class="memberInfo-dropdown-view">'+val.nickname+'</span>');
				format=format.replace('#toListName#','<span class="listInfo-dropdown-view">'+get_to_list_name+'</span>');
				format=format.replace('#fromListName#','<span class="listInfo-dropdown-view">'+get_from_list_name+'</span>');
				format=format.replace('#cardName#',
						'<a class="cardInfo-dropdown-view"  onclick="editCard('+val.value_num+')" data-toggle="modal" data-target="#cardInfoView">'+get_card_name+'</a>'
						);
				break;
			case 'addFriend':
				var get_friend_info=activity_getFriendInfo(val.value_string);
				format=format.replace('#me#','<span class="memberInfo-dropdown-view">'+val.nickname+'</span>');
				format=format.replace('#firendName#',activity_memberInfo_setting_dropdown(get_friend_info));
				format=format.replace('#authority#','<span class="friendInfo-auth-dropdown-view">'+get_friend_info.grade+'</span>');
				break;
			}
			result+=format;
			result+='</div></div>'; //end of div, activity-unit
		});*/
		if(type=='someActivity'){$('.side-menu-activity-content').append(result);}
		else if(type='allActivity'){$('#all-activity-modal-content-wrapper').append(result);}
		bind_memberInfo_dropdown_activityMember();//이벤트 바인드
	}
	
	function activity_memberInfo_setting_dropdown(val){
	return '<div class="dropdown activity-memberInfo-dropdown-view">'+
		'<a class="activity-memberInfo-dropdown-view-btn dropdown-toggle" data-toggle="dropdown">'+
			'<span>'+val.nickname+'</span>'+
		'</a>'+
		'<div id="activity-memberInfo-dropdown-view-content" class="dropdown-menu" >'+
			'<div class="activity-members-info">'+
				'<div class="activity-members-info-wrapper">'+
					'<div class="activity-members-info-img-wrapper">'+
						'<img class="activity-members-info-img" src="'+val.profile_image+'">'+
					'</div>'+
					'<div class="activity-members-info-text-wrapper">'+
						'<span class="activity-member-name">'+val.name+'</span>'+
						'<span class="activity-member-nickname">('+val.nickname+')</span>'+
						'<br><span class="activity-member-email">'+val.email+'</span>'+
					'</div>'+
					'<div class="activity-members-close-btn"><span class="glyphicon glyphicon-remove"></span></div>'+
				'</div>'+
			'</div>'+
		'</div>'+
	'</div>';
	}

	/*function activity_getListInfo(listNum){
		  var url='/usMemo/activity/getListInfo/'+listNum;
		  var list_name;
			$.ajax({
				url: url,	      
				type:'post',
				dataType:'json',
				 Jackson라이브러리의 컨텐츠 타입으로 JSON HTTP 메시지와 객체 사이의 변환을 처리 
				contentType: 'application/json',
				async: false,
				success:function(data){
					console.log(data);
					list_name=data.name;
				} ,
				error : function(xhr, status, error) {
				alert(error);
				}
			});
			return list_name;
	}
	function activity_getCardInfo(cardNum){
		var url='/usMemo/activity/getCardInfo/'+cardNum;
		  var card_name;
			$.ajax({
				url: url,	      
				type:'post',
				dataType:'json',
				 Jackson라이브러리의 컨텐츠 타입으로 JSON HTTP 메시지와 객체 사이의 변환을 처리 
				contentType: 'application/json',
				async: false,
				success:function(data){
					console.log(data);
					card_name=data.name;
				} ,
				error : function(xhr, status, error) {
				alert(error);
				}
			});
			return card_name;
	}
	function activity_getFriendInfo(friendNum){
		var url='/usMemo/activity/getFriendInfo/'+static_bNum+'/'+friendNum;
		  var friendInfo;
			$.ajax({
				url: url,	      
				type:'post',
				dataType:'json',
				 Jackson라이브러리의 컨텐츠 타입으로 JSON HTTP 메시지와 객체 사이의 변환을 처리 
				contentType: 'application/json',
				async: false,
				success:function(data){
					console.log(data);
					friendInfo=data;
				} ,
				error : function(xhr, status, error) {
				alert(error);
				}
			});
			
			if(friendInfo.grade==1){friendInfo.grade='admin';}
			else if(friendInfo.grade==2){friendInfo.grade='member';}
			return friendInfo;
	}*/
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
			//var img_id='#profile_image'+index;
			var member_select_id='#memberInfo'+index;
			//이미지 설정함
			
			var grade_string;
			if(val.grade==1){grade_string='admin';}
			else if(val.grade==2){grade_string='normal';}
			
			$("#setMember").append(
					'<div class="dropdown side-menu-members">'+
						'<a class="side-menu-members-btn dropdown-toggle" data-toggle="dropdown">'+
							'<span><img id="profile_image'+index+'" src="'+val.profile_image+'" title="" class="side-menu-profile_image"></span>'+
						'</a>'+
						'<div id="memberInfo-dropdown-view-content" class="dropdown-menu">'+
							'<div class="side-menu-members-info">'+
								'<div class="side-menu-members-info-wrapper">'+
									'<div class="side-menu-members-info-img-wrapper">'+
										'<img class="side-menu-members-info-img" src="'+val.profile_image+'">'+
									'</div>'+
									'<div class="side-menu-members-info-text-wrapper">'+
										'<span class="side-menu-member-name">'+val.name+'</span>'+
										'<span class="side-menu-member-nickname">('+val.nickname+')</span>'+
										'<br><span class="side-menu-member-email">'+val.email+'</span>'+
									'</div>'+
									'<div class="side-menu-members-close-btn"><span class="glyphicon glyphicon-remove"></span></div>'+
								'</div>'+
								'<hr>'+
								'<div class="side-menu-change-permission-btn hover-blue">'+
									'<span>Change permissions...('+grade_string+')</span>'+
								'</div>'+
							'</div>'+
						'</div>'+
					'</div>');

			//$(img_id).attr("src",val.profile_image);
				//권한에 따라 타이틀만 변경해야함.
				//적으려는 멤버가 현재로그인한 멤버가 아닐경우
			/*	if(val.id!=sessionId){
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
					}*/
		});
		bind_memberInfo_dropdown_setMember();//이벤트 바인드
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
		$(".menu-toggle,.side-menu-header-closeBtn").click(function(e) {
			e.preventDefault();
			var memId=$("#memId").val();
			var bNum=$("#bNum").val();
			//토글클래스가 아님
			if(!$("#wrapper").hasClass('toggled')) {
			
			//화면지움
				cleanMemberListView();
				cleanFindMemberListView();
				cleanFindeMemberText();
				clean_activitys();
				
				//토글클래스일 때 
			}else if($("#wrapper").hasClass('toggled')){
			 //화면그림
				openMenu(bNum,memId);
				
			}
			$("#wrapper").toggleClass("toggled");
			$(".board-wrapper").toggleClass("is-show-menu");
			$(".surface").toggleClass("is-show-menu")

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
	
	$("#findMember-close-btn").click(function(){
		/*드롭다운의 메뉴 끄기*/
		$(".side-menu-addMember-btn").dropdown('toggle');
		/*끄기이벤트 요청시 이벤트헨들러 발생.*/
	});
	
	/*드롭다운 이벤트를 실행할땐 .dropdown을 가진 div의 선택자를 선택해야함.*/
	$(".side-menu-addMember-wrapper").on('hide.bs.dropdown',function(){
		/*드롭다운이 사라지는 이벤트가 발생하면 input상자, 찾은 친구 리스트의 값을 지워죠!*/
		clean_findMembersResults();
		
	});
	
	function clean_findMembersResults(){
		$("#findMember").val('');
		$("#findMemberResult> *").detach();
	}
	
	
	function clean_activitys(){
		$('.side-menu-activity-content>*').detach();
	}

