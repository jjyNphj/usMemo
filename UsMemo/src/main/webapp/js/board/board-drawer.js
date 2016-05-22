/*board의 상단 메뉴*/

$(".header-logo-boardmenu").click(function(){
		$("#boards-drawer").toggleClass("hide");
		if(!$("#boards-drawer").hasClass("hide")){
			get_myAllBoard();
		}
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
				 '<span id="allBoardName_'+val.bNum+'">'+val.name+'</span>'+
				 '</div>');
	});
}

