/***
 * 
 * 카드의 정보창과 관련한 js
 * 
 */
//파일 첨부 누를 순간 파일 이름과 cNum 카드 컨트롤러로 넘기기
$(document).ready(function() {
	//파일 첨부 누르는 순간 처리하는 부분
	$("input[type=submit]").bind("click", function() {

		var num = document.getElementById('card_num').innerHTML;
		console.log(num);
		var file_data=$('#exampleInputFile').val();
		console.log(file_data);

		$('#formUpload').ajaxSubmit({
			beforeSerialize: function() {
				$("#uploadFile_card_num").attr("value",num);
				console.log("처리전");
			},
			success : function(data) {
				/*alert(data.result);*/
				//console.log(data);
				output(data); //받은 정보를 화면 출력하는 함수 호출
			},
			error : function(error) {
				alert("요청 처리 중 오류가 발생하였습니다. 화면을 새로고침 합니다.");
				//오류나고 나서 다시 파일 첨부하려고 하면 계속 오류난 상태이므로 새로고침 해줘야함.
				location.reload();
			}
		});
		return false;
	});

	//카드 수정창에서 카드 이름쓰는 부분에서 포커스가 벗어나면 카드이름 저장하는 부분
	$("textarea#card_Name").blur(function()
		{
			var name = document.getElementById('card_Name').value;
			var num = document.getElementById('card_num').innerHTML;
			var url='/usMemo/card/edit/CardName?num='+num+'&name='+name;
	
			$.ajax({
				url: url,
				type:'post',
				success:function(){
					//alert("CardName edit!");
	
					//innerHTML은 전체 html 소스에서 card_lnum이라는 id를 가진 태그 안의 내용을 가져옴
					//setCardInfo()부분에서 id값 넣어줌. board-cardInfo.jsp 부분에 뿌려줌.
					var lnum = document.getElementById('card_lnum').innerHTML;
					//lnum과 cnum 조합해서 card_unit id 값 만들어 주기.
					var card_unit_id = lnum + '_' + num;
	
					console.log("lnum:"+lnum + " card_name:" + name + " card_num:" + num + " card_unit_id:" + card_unit_id);		
	
					//카드 이름 뜨는 부분 태그의 클래스 찾아서, 자식의 자식 div 태그의 card_unit_name 클래스의 내용을 바꾼 카드 이름으로 바꿔치기 하기.
					$('div.card_unit#'+card_unit_id + '> div > div.card_unit_name').html(name);
				} ,
				error : function(xhr, status, error) {
					alert(error);
				}
			})
		});
	
	
	$('#cardInfoView').on('shown.bs.modal',function(){
		
		var textarea_arr=$('h4>textarea.textarea-card-name');
		for(var i=0;i<textarea_arr.length;i++){
			heightResize(textarea_arr[i]);
		}
	});
	$('#cardInfoView').on('hidden.bs.modal',function(){
				
		//allActivity에서 넘어온 cardInfoView라면 다시 allActivity 모달창 열어주기
		if($('#allActivityModal').hasClass('in')){
			$('#allActivityModal').css("display","block");
		}
		$('#exampleInputFile').val('');
		
	});
});

//전달받은 파일첨부 이름을  화면에 보기 좋게 출력
function output(data) {
	//업로드한 파일을 다운로드할수있도록 화면 구성
    if(data.attach){
        $("#card_fileName").html("<br>첨부된 파일:<br>");
        
        var link = "/usMemo/card/fileDown?fileName=" + data.attach;
        
     	$("#card_fileName").append("<br><a href='"+ link +"'>"+data.attach+" download </a>");
        $("#card_fileName").append("<br>");	               
    }              
}

function heightResize(obj) {
	//textarea에 입력된 크기만큼 세로 길이 조정
	obj.style.height = "1px";
	obj.style.height = (10+obj.scrollHeight)+"px";
}

//카드 이름 수정시 엔터치면 바로 이름 저장 되는 부분
function enterSaveProcess(e) {
	/*
	 * boardMain에서 키가 눌릴때마다 키코드를 찾음
	 * keyCode가 0이면  which 리턴, 엔터의 키코드 13이므로 엔터 치는 순간 if문으로 넘어감
	 * keyCode와 which는 ie,firefox 브라우저의 차이떄문에...?
	 * */
	
    var code = (e.keyCode ? e.keyCode : e.which);
    if (code == 13 ) { //Enter keycode
    	
    	//value는 현재 이벤트가 일어난 textarea의 id의 값(사용자가 입력한 내용)을 가져옴
        var name = document.getElementById('card_Name').value;
        //innerHTML은 전체 html 소스에서 card_num이라는 id를 가진 태그 안의 내용을 가져옴
        //setCardInfo()부분에서 id값 넣어줌. board-cardInfo.jsp 부분에 뿌려줌.
        var num = document.getElementById('card_num').innerHTML;
        
        //이벤트(엔터) 사용을 금지하는 함수. 엔터 눌러도 포커스가 다음줄로 넘어가지 않도록 하기 위함.
        e.preventDefault();
        //엔터 친후 textarea에서 커서 제거하기
        document.getElementById('card_Name').blur();

/*        var url='/usMemo/card/edit/CardName?num='+num+'&name='+name;
    	$.ajax({
    		url: url,
    		type:'post',
    		success:function(){
    			alert("CardName edit!");
    			
    			//innerHTML은 전체 html 소스에서 card_lnum이라는 id를 가진 태그 안의 내용을 가져옴
    			//setCardInfo()부분에서 id값 넣어줌. board-cardInfo.jsp 부분에 뿌려줌.
    			var lnum = document.getElementById('card_lnum').innerHTML;
    			//lnum과 cnum 조합해서 card_unit의 id 값 만들어 주기.
    			var card_unit_id = lnum + '_' + num;
    			
    	        console.log("lnum:"+lnum + " card_name:" + name + " card_num:" + num + " card_unit_id:" + card_unit_id);		
    	        
    			//카드 이름 뜨는 부분 태그의 클래스 찾아서, 자식의 자식 div 태그의 card_unit_name 클래스의 내용을 바꾼 카드 이름으로 바꿔치기 하기.
    			$('div.card_unit#'+card_unit_id + '> div > div.card_unit_name').html(name);
    		} ,
    		error : function(xhr, status, error) {
    			alert(error);
    		}
    	})*/
       
    }
}

//카드 수정창 뜨는 부분(해당 num에 따른 listAndCard에 있는 데이터 값 다 가져오기)
function editCard(cNum) {
	
		//만일 allActivity에서 연결된것이라면 설정 바꾸기
	if($('#allActivityModal').hasClass('in')){
		$('#allActivityModal').css("display","none");
	}
	var url='/usMemo/card/edit';
	var listAndcard = new Object();
	listAndcard.cNum = cNum;
	 
	/* JSP 상에서 서버에 데이터를 전송할 시 String 형태로 데이터를 만들어야함
		자바스크립트의 JSON.stringify 함수를 이용해서 JSON 문자열(String)로 변환(형변환) */
	var cNum = JSON.stringify(listAndcard);
	 
	console.log(cNum);
	$.ajax({
		url: url,	      
		type:'post',
		data: cNum,
		dataType:'json',
		/* Jackson라이브러리의 컨텐츠 타입으로 JSON HTTP 메시지와 객체 사이의 변환을 처리 */
		contentType: 'application/json',
		async: false,
		success:function(data){
			//의아한 점> CardController에서 넘어온 json 형태의 객체는 jsp에서 자동으로 자바스크립트 객체로 변환되는 것인가..? 파싱 일을 여러번 하는것 같은 느낌..
			//결론> 지워도 되네여. CardController에서 넘어오는 json 타입 자동으로 자바스크립트 객체로 변환해주는듯? 
			//    혹은 json 형태로도 자바스크립트에서는 파싱없이 데이터가 읽히는 것일지두..json은 어차피 자바스크립트에서 나온거라..? 서버에서 주고 받을때만 json형태인지 아닌지만 검증하는건가봄
			/* JSON.stringify -> 자바스크립트 값을 JSON 문자열(String)로 변환 
			   JSON.parse -> JSON 문자열(String)을 자바스크립트 객체로 변환  */
			/* var card=JSON.parse(JSON.stringify(data)); 
			   setCardInfo(card) */
			setCardInfo(data);
			
		   /* $('#card_Name').autoGrow();*/
			console.log(data);
		},
/*		complete:function(){
			var textarea_arr=$('h4>textarea.textarea-card-name');
			for(var i=0;i<textarea_arr.length;i++){
				heightResize(textarea_arr[i]);
			}
		},*/
		error : function(xhr, status, error) {
		alert(error);
		}
	});
}

//카드 세부정보 저장하는 부분
function addCardDescription(card_num,cardDescription){
	/*
	 * <span id="card_num"> 내용 </span>
	 * span 안의 내용을 가져오려면 아래와 같이 하면 된다. 참고로 꼭 span이 아니어도 됨. 어떤 id 값이든 가능
	 * document.getElementById('아이디').innerHTML  
	 * innerHTML : 해당 id 태그 안의 내용을 가져오거나 설정
	 * */
	var num = document.getElementById('card_num').innerHTML;
	console.log(num);
	//textarea에 기입한 내용 가져오기
	var content = cardDescription.value;
	if(content != null) {
		//조건문으로 체크 안해주면 replace 할게 없다고 오류남
		content = content.replace(/\n/g,'<br>');
		content = content.replace(/\r/g,'<br>');
	}
	console.log(content);
	
	var url='/usMemo/card/add/CardContent?num='+num+'&content='+content;
	$.ajax({
		url: url,

		type:'post',
		success:function(){
			//alert("CardContent add!");
		} ,
		error : function(xhr, status, error) {
			alert(error);
		}
	})
}

//카드 삭제 버튼 누르면 데이터 삭제되는 부분
function deleteCardInfo() {
	
	var deleteChoice = window.confirm('정말로 이 카드 정보를 삭제하시겠습니까?');	
	
	if(deleteChoice) {
		var num = document.getElementById('card_num').innerHTML;
		var bNum= static_bNum;
		var memId= static_memId;
		var lNum= document.getElementById('card_lnum').innerHTML;
		var url='/usMemo/card/delete/CardInfo/'+bNum+'/'+num+'/'+memId+'/'+lNum;

		$.ajax({
			url: url,
			type:'post',

			success:function(){
				alert("삭제되었습니다.");
				//innerHTML은 전체 html 소스에서 card_lnum이라는 id를 가진 태그 안의 내용을 가져옴
				//setCardInfo()부분에서 id값 넣어줌. board-cardInfo.jsp 부분에 뿌려줌.
				var lnum = document.getElementById('card_lnum').innerHTML;
				//lnum과 cnum 조합해서 card_unit의 id 값 만들어 주기.
				var card_unit_id = lnum + '_' + num;

				console.log("lnum:"+lnum + " card_name:" + name + " card_num:" + num + " card_unit_id:" + card_unit_id);		

				//$()안에있는 조건에 해당하는 태그를 포함한 하위 요소, 이벤트, 데이터 모두 제거
				var origin_card=$('div.card_unit#'+card_unit_id);
				origin_card.remove();
			} ,
			error : function(xhr, status, error) {
				alert(error);
			}
		})
	} 
}

//listAndCard에 있는 데이터 뿌려주는 부분
function setCardInfo(cardInfo){
	 /* ListAndCard dto의 card 정보와 list 정보를 html에서 쓰기위해 세팅하는 부분  */
	 $("#card_Name").val(cardInfo.card_name);
	 $("#list_Name").text(cardInfo.list_name);
	 $("#card_num").text(cardInfo.card_num);
	 $('#card_lnum').text(cardInfo.lNum);
	 
	 //카드 수정창 뜨는 동시에 해당 파일 첨부 다운로드 이름 붙여주기
	 $("#card_fileName").html("<br>첨부된 파일:<br>");
	 //다운로드를 위한 링크
	 var link = "/usMemo/card/fileDown?fileName=" + cardInfo.attach;
	 //파일 첨부에 아무것도 안들어가있으면 아무 값도 넣어주지 말기
	 if( cardInfo.attach != null) {
		 $("#card_fileName").append("<br><a href='"+ link +"'>"+cardInfo.attach+" download </a>");
	 } else {
		 $("#card_fileName").append("<br>");
	 }	 
	 
	 if(cardInfo.content != null) {
		 //조건문으로 체크 안해주면 replace 할게 없다고 오류남
	 	var cardDescription = cardInfo.content.replace(/\<br>/g,'\n');
	 	$("#cardDescription").val(cardDescription);
	 	console.log(cardDescription);
 	} else {
 		$("#cardDescription").val(cardInfo.content);
 		console.log(cardInfo.content);
 	}	 
	 
	 /* Sat Apr 30 2016 20:31:18 GMT+0900 형태로 date에 들어감 */
	 var date = new Date(cardInfo.n_date);
	 /* 2016. 4. 30. 오후 8:31:18 형태로 바꿔줌*/
	 var card_date = date.toLocaleString();
	$("#card_Date").text(card_date);

		
 }
 