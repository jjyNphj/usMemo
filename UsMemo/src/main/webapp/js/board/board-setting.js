/*
 * 보드의 추가, 삭제, 수정 등 보드의 셋팅에 관련한 js
 * */

function goBoard(bNum,name){
/*    var answer=confirm("선택하신 보드를 보러 가시겠습니까?");
        if(answer){ */
        	var id=$("#memId").val();
            var url ='/usMemo/board/index/'+id+'?bNum='+bNum+'&name='+name;
                window.open(url, "_self",  '');
        /* } */  
    }
/* function goDeletePage(bNum,name) {
	var answer=confirm("선택하신 보드를 삭제하시겠습니까?");
		if(answer){ 
	        var url ='/usMemo/board/deleteBoard?bNum='+ bNum.value+'&name='+name.value;
	            window.open(url, "_self",  '');
	     }
} */
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
	       	alert("보드가 삭제 되었습니다.");
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
	       	alert("보드가 추가 되었습니다.");
	       	window.location.reload();
	       } ,
	      error : function(xhr, status, error) {
	          alert(error);
	    }
	   })
}