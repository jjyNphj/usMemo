var static_bNum=$('#bNum').val();
var static_memId=$('#memId').val();
/*board의 상단 메뉴*/

/*boardmenu의 보드목록 불러오는 이벤트, 즐겨찾기클릭의 중복을 막기 위해 바꿈. */
$('#header-boardmenu').on('show.bs.dropdown',function(){
	get_myAllBoard();
});
$('#header-boardmenu').on('hide.bs.dropdown',function(){
	clean_allBoards();
	clean_starredBoards();
});

/* 내정보보기 의 내용을 클릭할때 dropdown의 특성상 창이 꺼지는 것을 방지.*/
$('#header-myInfo-dropdown').bind('click', function (e) { e.stopPropagation() });

$('.header-myInfo-dropdown-closeBtn').click(function(){
	$('.header-btn-myInfo').dropdown('toggle');
});


/*보드보기 메뉴의 드롭다운 설정.*/
$('.boards-drawer-view').bind('click', function (e) { e.stopPropagation() });

function initDrawerBoard(){
$('.drawer-boardsList-title-star').click(function(){
	//보드보기 메뉴에 있는 보드들의 즐겨찾기를 클릭할 시 발생하는 이벤트
	var bNumId= $(this).attr('id');
	var bNum=bNumId.split('_');
	bNum=bNum[1];
	
	if($(this).hasClass("glyphicon glyphicon-star-empty")){
		//즐겨찾기로 해줘야함.
		$(this).removeClass("glyphicon glyphicon-star-empty");
		$(this).addClass("glyphicon glyphicon-star");
		updateStarBoard('Y',bNum,static_memId);
	}else if(!$(this).hasClass("glyphicon glyphicon-star-empty")){
		$(this).removeClass("glyphicon glyphicon-star");
		$(this).addClass("glyphicon glyphicon-star-empty");
		updateStarBoard('N',bNum,static_memId);
	}
	
	$('.header-btn-boardmenu').dropdown('toggle');
	$('.header-btn-boardmenu').dropdown('toggle');
});
}
function get_myAllBoard(){
	
	var memId=$("#memId").val();
	
	 $.ajax({
         url: '/usMemo/board/allBoards/'+memId,
         type :'post',
         dataType:'json',
			/* Jackson라이브러리의 컨텐츠 타입으로 JSON HTTP 메시지와 객체 사이의 변환을 처리 */
			contentType: 'application/json',
         success:function(data){
        	set_allBoards(data);
        	set_starredBoards(data);
        	initDrawerBoard(); //동적으로 생성된 보드리스트에 있는 즐겨찾기 버튼 이벤트 리스너 달기 
         } ,
	       error :function(data,status,er) { 
	    	   alert("error: "+data+" status: "+status+" er:"+er);
	    	   console.log("error: "+data+" status: "+status+" er:"+er);
      }
     }); 
}
function set_allBoards(data){
	$.each(data,function(index,val){
		var starred_boards_vlaue;
		if(val.star == 'Y') starred_boards_vlaue='glyphicon-star'; 
		else if(val.star=='N') starred_boards_vlaue='glyphicon-star-empty'; 
		 $(".all-boards-content").append(
				 '<div class="all-boards-wrapper">'+
				 	'<span class="drawer-boardsList-title-background" style="background-color:'+val.background_color+'"></span>'+
					'<span class="drawer-boardsList-title-fade"></span>'+
						'<div class="drawer-boardsList-title-wrapper">'+
							 '<a class="drawer-boardsList-title-link" onclick="goBoard('+val.bNum+','+'\''+val.name+'\''+')">'+
								 '<span class="drawer-boardsList-title-link-thumbnail" style="background-color:'+val.background_color+'"></span>'+
								 '<span class="drawer-boardsList-title-details">'+
								 '<div id="allBoardName_'+val.bNum+'" class="drawer-boardsList-name" >'+val.name+'</div>'+
							 '</a>'+
							 '<span id="drawer-boardsList-star_'+val.bNum+'" class="drawer-boardsList-title-star glyphicon '+starred_boards_vlaue+'"></span>'+
							 '</span>'+
						 '</div>'+
				 '</div>');
	});

}
function set_starredBoards(data){
	var result;
	$.each(data,function(index,val){
		
		if(val.star == 'Y'){
	
		$('.starred-boards-content').append(
				
				'<div class="starrd-boards-wrapper">'+
					'<span class="drawer-boardsList-title-background" style="background-color:'+val.background_color+'"></span>'+
					'<span class="drawer-boardsList-title-fade"></span>'+
						'<div class="drawer-boardsList-title-wrapper">'+
							 '<a class="drawer-boardsList-title-link" onclick="goBoard('+val.bNum+','+'\''+val.name+'\''+')">'+
							 	'<span class="drawer-boardsList-title-link-thumbnail" style="background-color:'+val.background_color+'"></span>'+
								'<span class="drawer-boardsList-title-details">'+
								'<div id="allBoardName_'+val.bNum+'" class="drawer-boardsList-name" >'+val.name+'</div>'+
							'</a>'+
							'<span id="drawer-boardsList-star_'+val.bNum+'" class="drawer-boardsList-title-star glyphicon glyphicon-star"></span>'+
							'</span>'+
						'</div>'+
					'</div>'
				
			);
		}
	});
	//initDrawerBoard();
}

function updateStarBoard(star,bNum,memId){
	/*var bNum=$('#bNum').val();
	var memId=$('#memId').val();*/
	
	var url='/usMemo/member/updateStar?bNum='+bNum+'&memId='+memId+'&star='+star;
	 $.ajax({
            url: url,
            type :'post',
            success:function(){
            } ,
	       error :function(data,status,er) { 
	    	   alert("error: "+data+" status: "+status+" er:"+er);
	    	   console.log("error: "+data+" status: "+status+" er:"+er);
         }
	 });
	
}
function clean_allBoards(){
	$('.all-boards-content>*').detach();
}
function clean_starredBoards(){
	$('.starred-boards-content>*').detach();
}

