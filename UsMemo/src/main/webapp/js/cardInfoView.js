/***
 * 
 * 카드의 정보창과 관련한 js
 * 
 */
/*$(document).ready(function(){
	$("#card_Name").mousedown(function(){
		$('#card_Name').detach();
		$('#card_Name_attach').append(
				'<textarea class="textarea-card-name" id="card_Name" cols=45 rows=1 onkeypress="enterProcess(event, this)"></textarea>'
		);
	});
});*/

/*function fileUpload(card_num) {
	var num = document.getElementById('card_num').innerHTML;
	console.log(num);
	var url='/usMemo/card/fileUploadAjax?num='+num;
	$("form").ajaxSubmit({
//		dataType : "json",
		url : url,

		success : function() {
			console.log(data);
			console.log($(this).serialize());
			alert(data.result);
			alert(num);
		},
		error : function(xhr, status, error) {
			alert("요청 처리 중 오류가 발생하였습니다.");
		}
	});
}*/
$(document).ready(function() {
		$("input[type=submit]").bind("click", function() {
			var num = document.getElementById('card_num').innerHTML;
			console.log(num);
			var file_data=$('#exampleInputFile').val();
			console.log(file_data);
			$('#formUpload').ajaxSubmit({
		        beforeSerialize: function() {
		        	/*$("#uploadFile_card_num").attr("name",num);*/
		        	$("#uploadFile_card_num").attr("value",num);
		        	console.log("처리전");
		        },
				success : function(data) {
					/*alert(data.result);*/
					console.log(data);
					
					//$("#card_fileName").append(setCardInfo.getCardFileName());
					//$("#card_fileName").append(setCardInfo.getCardFileName);
					//setCardInfo.getCardFileName();
					//output(data); //받은 정보를 화면 출력하는 함수 호출
				},
				error : function(error) {
					alert("요청 처리 중 오류가 발생하였습니다.");
				}
			});
			return false;
		});
	});

//전달받은 정보를 가지고 화면에 보기 좋게 출력
function output(data) {
	//업로드한 파일을 다운로드할수있도록 화면 구성
    if(data.file1){
        $("#card_fileName").append("첨부된 파일:<br/>");           
        $.each(data.file1, function(index, item){
        	var link = "fileDown?fileName="+$("#card_fileName");
     	  /* var link = "fileListShow?f="+item.uploadedFileName+"&of="+item.fileName;*/
     	  /*<a href='rest/controller/get/"+index+"'>Click</a>*/
     	   $("#card_fileName").append("<a href='"+ link +"' download>"+$("#card_fileName")+"</a>");
           $("#card_fileName").append("<br/>");	               
        });
    }           
	 /*
 	if(data.file){
        var link = "FileDownload?f="+data.file.uploadedFileName+"&of="+data.file.fileName;
        $("#result").append("파일 :<a href='"+ link +"' download>"+data.file.fileName+"</a>");
        $("#result").append("<br/>");
    } */
    
    //$('#multiform')[0].reset(); //폼 초기화(리셋); 
    //$('#multiform input:file').MultiFile('reset'); //멀티파일 초기화        
}

function heightResize(obj) {
	//textarea에 입력된 크기만큼 세로 길이 조정
	obj.style.height = "1px";
	obj.style.height = (10+obj.scrollHeight)+"px";
	/*$("#card_Name").attr('rows',''); */
//	cardHeight = obj.style.height;
//	console.log(cardHeight);
}

function enterSaveProcess(e) {
	/*
	 * boardMain에서 키가 눌릴때마다 키코드를 찾음
	 * keyCode가 0이면  which 리턴, 엔터의 키코드 13이므로 엔터 치는 순간 if문으로 넘어감
	 * keyCode와 which는 ie,firefox 브라우저의 차이떄문에...?
	 * */
    var code = (e.keyCode ? e.keyCode : e.which);
    if (code == 13) { //Enter keycode
    	//value는 현재 이벤트가 일어난 textarea의 id의 값(사용자가 입력한 내용)을 가져옴
        var name = document.getElementById('card_Name').value;
        //innerHTML은 전체 html 소스에서 card_num이라는 id를 가진 태그 안의 내용을 가져옴
        var num = document.getElementById('card_num').innerHTML;
        //이벤트(엔터) 사용을 금지하는 함수. 엔터 눌러도 포커스가 다음줄로 넘어가지 않도록 하기 위함.
        e.preventDefault();
        //엔터 친후 textarea에서 커서 제거하기
        document.getElementById('card_Name').blur();

        var url='/usMemo/card/edit/CardName?num='+num+'&name='+name;
    	$.ajax({
    		url: url,
    		type:'post',
    		success:function(){
    			alert("CardName edit!");
    			
    			console.log(name);
    			console.log(num);    		
    		} ,
    		error : function(xhr, status, error) {
    			alert(error);
    		}
    	})
       
    }
}

function editCard(cNum) {
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
		} ,
		error : function(xhr, status, error) {
		alert(error);
		}
	});/*.done(function( data ) {			
		var card_name_y = document.getElementById("card_Name");
		heightResize(card_name_y);
		 var card_name_y = document.getElementById("card_Name");
		 var y_height = card_name_y.scrollHeight;
		 console.log(y_height);
		 $(".textarea-card-name").css("height",y_height+"px");
			 })*/
}

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
			alert("CardContent add!");
		} ,
		error : function(xhr, status, error) {
			alert(error);
		}
	})
}

function setCardInfo(cardInfo){
	 //this.cardFileName = cardInfo.attach;
	 /* ListAndCard dto의 card 정보와 list 정보를 html에서 쓰기위해 세팅하는 부분  */
	 $("#card_Name").val(cardInfo.card_name);
	 $("#list_Name").text(cardInfo.list_name);
	 $("#card_num").text(cardInfo.card_num);
	 
	 $("#card_fileName").append(cardInfo.attach);
	 var link = "/usMemo/card/fileDown?fileName="+cardInfo.attach;
	 $("#card_fileName").html("<br><a href='"+ link +"'>"+cardInfo.attach+" download </a>");
	 /*var link = "fileDown?fileName="+$("#card_fileName");
	 $("#card_fileName").html("<a href='"+ link +"'>"+$("#card_fileName")+" download </a>");*/
	 
	 
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
 
/*setCardInfo.prototype.getCardFileName = function() {
	return this.cardFileName;
}*/
//setCardInfo.prototype.getCardFileName = this.cardInfo.attach;
