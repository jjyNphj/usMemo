/*
 * 보드의 추가, 삭제, 수정 등 보드의 셋팅에 관련한 js
 * */

function goBoard(bNum,name){
/*    var answer=confirm("선택하신 보드를 보러 가시겠습니까?");
        if(answer){ */
        	var id=$("#memId").val();
            var url ='/usMemo/board/index/'+id+'?bNum='+bNum;
                window.open(url, "_self",  '');
        /* } */  
    }

function deleteBoard(bNum,name){
	console.log(bNum);
	var answer=confirm("보드의 하위 내용도 전부 사라집니다. 정말로 삭제 하시겠습니까?");
	if(answer){ 
		 /*lnum과 sessionid로 card에 정보 넣기*/
		 /* var u='#boardContents'+bNum.value;
		 var name=name; */
		 var url='/usMemo/board/deleteBoard?bNum='+bNum.value+'&name='+name.value;
		  $.ajax({
	       url: url,	      
	       type:'post',
	       
	       success:function(){	       
	       	alert("보드가 삭제되었습니다.");
	       	window.location.reload();
	       } ,
	      error : function(xhr, status, error) {
	          alert(error);
	    }
	   })
	}
}
function createBoard(memId) {
	//아래 보드추가 textarea안의 id값 = boardComment -> 사용자가 입력한 보드이름 내용 불러오기
	var name=$("#boardComment").val();
	var url='/usMemo/board/createBoard?name='+name+'&memId='+memId.value;
	$.ajax({
	       url: url,	      
	       type:'post',
	       
	       success:function(){	       
	       	alert("보드가 추가되었습니다.");
	       	window.location.reload();
	       } ,
	      error : function(xhr, status, error) {
	          alert(error);
	    }
	   })
}

//clear,close나 X버튼 누르면 textarea 내용 초기화 시키기.
function clearForm(o){
    $('textarea#cardDescription, textarea#boardComment', o).val('');
} 

$('.member-boards-star').click(function(){
	//보드리스트에 있는 보드들의 즐겨찾기를 클릭할 시 발생하는 이벤트
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
	location.reload();
});

