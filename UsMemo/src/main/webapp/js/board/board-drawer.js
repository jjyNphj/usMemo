/*board의 상단 메뉴*/

/*boardmenu의 보드목록 불러오는 이벤트, 즐겨찾기클릭의 중복을 막기 위해 바꿈. */
$('#header-boardmenu').on('show.bs.dropdown',function(){
	get_myAllBoard();
});
$('#header-boardmenu').on('hide.bs.dropdown',function(){
	clean_allBoards();
	clean_starredBoards();
});

	
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
				 	'<span class="drawer-boardsList-title-background"></span>'+
					'<span class="drawer-boardsList-title-fade"></span>'+
					 '<a class="drawer-boardsList-title-link" href="#">'+
						 '<span class="drawer-boardsList-title-link-thumbnail"></span>'+
						 '<span class="drawer-boardsList-title-details">'+
						 '<span id="allBoardName_'+val.bNum+'" class="drawer-boardsList-name" >'+val.name+'</span>'+
						 '<span id="drawer-boardsList-title-star" class="glyphicon '+starred_boards_vlaue+'"></span>'+
						 '</span>'+
					 '</a>'+
				 '</div>');
	});
}
function set_starredBoards(data){
	var result;
	$.each(data,function(index,val){
		
		if(val.star == 'Y'){
	
		$('.starred-boards-content').append(
				
				'<div class="starrd-boards-wrapper">'+
					'<span class="drawer-boardsList-title-background"></span>'+
					'<span class="drawer-boardsList-title-fade"></span>'+
					'<a class="drawer-boardsList-title-link" href="#">'+
						'<span class="drawer-boardsList-title-link-thumbnail"></span>'+
						'<span class="drawer-boardsList-title-details">'+
						'<span id="allBoardName_'+val.bNum+'" class="drawer-boardsList-name" >'+val.name+'</span>'+
						'<span id="drawer-boardsList-title-star" class="glyphicon glyphicon-star"></span>'+
						'</span>'+
					'</a>'+
					'</div>'
				
			);
		}
	});
}

function clean_allBoards(){
	$('.all-boards-content>*').detach();
}
function clean_starredBoards(){
	$('.starred-boards-content>*').detach();
}

