/*board의 상단 메뉴*/

/*boardmenu의 보드목록 불러오는 이벤트, 즐겨찾기클릭의 중복을 막기 위해 바꿈. */
$('#header-boardmenu').on('show.bs.dropdown',function(){
	get_myAllBoard();
});
$('#header-boardmenu').on('hide.bs.dropdown',function(){
	clean_allBoards();
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
         } ,
	       error :function(data,status,er) { 
	    	   alert("error: "+data+" status: "+status+" er:"+er);
	    	   console.log("error: "+data+" status: "+status+" er:"+er);
      }
     }); 
}
function set_allBoards(data){
	$.each(data,function(index,val){
		 $(".all-boards-content").append(
				 '<div class="all-boards-wrapper">'+
				 '<a class="board-title-link" href="#">'+
				 '<span id="allBoardName_'+val.bNum+'">'+val.name+'</span>'+
				 '</div>'+
				 '</a>');
	});
}

function clean_allBoards(){
	$('.all-boards-content>*').detach();
}

