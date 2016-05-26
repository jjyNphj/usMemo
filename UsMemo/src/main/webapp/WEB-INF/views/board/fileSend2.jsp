<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- jQuery import -->
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<!-- jQuery Form Plugin import -->
<script src="js/jquery.form.min.js"></script>
<!-- jQuery MultiFile Plugin import -->
<script src="js/jQuery.MultiFile.min.js"></script>

<script>
$(document).ready(function(){
	
	//use jQuery MultiFile Plugin 
	$('#multiform input[name=photo]').MultiFile({
		max: 3, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
		accept: 'jpg|png|gif', //허용할 확장자(지정하지 않으면 모든 확장자 허용)
		maxfile: 1024, //각 파일 최대 업로드 크기
		maxsize: 3024,  //전체 파일 최대 업로드 크기
		STRING: { //Multi-lingual support : 메시지 수정 가능
		    remove : "제거", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
		    duplicate : "$file 은 이미 선택된 파일입니다.", 
		    denied : "$ext 는(은) 업로드 할수 없는 파일확장자입니다.",
		     selected:'$file 을 선택했습니다.', 
		    toomuch: "업로드할 수 있는 최대크기를 초과하였습니다.($size)", 
		    toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
		    toobig: "$file 은 크기가 매우 큽니다. (max $size)"
		},
		list:"#afile3-list" //파일목록을 출력할 요소 지정가능
	});
});
</script>
</head>
<body>
<h3>jQuery ajax fileupload (ajax 파일업로드)</h3>
<form name="multiform" id="multiform" action="FileUploadServlet"
                                      method="POST" enctype="multipart/form-data">
	
	title: <input type="text" name="title"  value=""/> <br/>
	description :<input type="text" name="description"  value="" /> <br/>
	
	<!-- 다중 파일업로드  -->
	photo : <input type="file" class="afile3"  name="photo" />
 	<div id="afile3-list" style="border:2px solid #c9c9c9;min-height:50px"></div> 
	
	<input type="submit" id="btnSubmit" value="전송"/><br/>
</form>	

<div id="result"></div>


<script>

/*jQuery form 플러그인을 사용하여 폼데이터를 ajax로 전송*/

var downGroupCnt =0; //다운로드그룹 개수카운트

$(function(){
    
	//폼전송 : 해당폼의 submit 이벤트가 발생했을경우 실행  
    $('#multiform').ajaxForm({
       cache: false,
       dataType:"json",
       //보내기전 validation check가 필요할경우
       beforeSubmit: function (data, frm, opt) {
	       //console.log(data);
           alert("전송전!!");
           return true;
       },
       //submit이후의 처리
       success: function(data, statusText){
    	   
    	   alert("전송성공!!");
           console.log(data); //응답받은 데이터 콘솔로 출력         
           
           output(data); //받은 정보를 화면 출력하는 함수 호출
       },
       //ajax error
       error: function(e){
           alert("에러발생!!");
           console.log(e);
       }                               
	});
});

//전달받은 정보를 가지고 화면에 보기 좋게 출력
function output(data) {
	//업로드한 파일을 다운로드할수있도록 화면 구성
	$("#result").append("<h3>("+(++downGroupCnt)+") 다운로드</h3>");
    $("#result").append("제목:"+data.title+"<br/>");
    $("#result").append("설명:"+data.description+"<br/>");
  
    if(data.photo){
        $("#result").append("포토:<br/>");           
        $.each(data.photo, function(index, item){
     	   var link = "FileDownload?f="+item.uploadedFileName+"&of="+item.fileName;
     	   $("#result").append("<a href='"+ link +"' download>"+item.fileName+"</a>");
            $("#result").append("<br/>");	               
        });
    }           
	 /*
 	if(data.file){
        var link = "FileDownload?f="+data.file.uploadedFileName+"&of="+data.file.fileName;
        $("#result").append("파일 :<a href='"+ link +"' download>"+data.file.fileName+"</a>");
        $("#result").append("<br/>");
    } */
    
    $('#multiform')[0].reset(); //폼 초기화(리셋); 
    $('#multiform input:file').MultiFile('reset'); //멀티파일 초기화        
}
</script>
</body>
</html>