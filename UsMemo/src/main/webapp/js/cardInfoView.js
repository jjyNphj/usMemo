/***
 * 
 * 카드의 정보창과 관련한 js
 * 
 */
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
				       	 
			console.log(data);
		} ,
		error : function(xhr, status, error) {
		alert(error);
		}
	}) 
}

function addCardDescription(card_num,cardDescription){
	/*
	 * <span id="card_num"> 내용 </span>
	 * span 안의 내용을 가져오려면 아래와 같이 하면 된다. 참고로 꼭 span이 아니어도 됨. 어떤 id 값이든 가능
	 * document.getElementById('아이디').innerHTML  
	 * */
	var num = document.getElementById('card_num').innerHTML;
	console.log(num);
	//textarea에 기입한 내용 가져오기
	var content = cardDescription.value;
	
	content = content.replace(/\n/g,'<br>');
	content = content.replace(/\r/g,'<br>');
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
	 /* ListAndCard dto의 card 정보와 list 정보를 html에서 쓰기위해 세팅하는 부분  */
	 $("#card_Name").text(cardInfo.card_name);
	 $("#list_Name").text(cardInfo.list_name);
	 $("#card_num").text(cardInfo.card_num);
	 
	 var cardDescription = cardInfo.content.replace(/\<br>/g,'\n');
	 $("#cardDescription").val(cardDescription);
	 console.log(cardInfo.content);
	 
	 /* Sat Apr 30 2016 20:31:18 GMT+0900 형태로 date에 들어감 */
	 var date = new Date(cardInfo.n_date);
	 /* 2016. 4. 30. 오후 8:31:18 형태로 바꿔줌*/
	 var card_date = date.toLocaleString();
	$("#card_Date").text(card_date);

 }