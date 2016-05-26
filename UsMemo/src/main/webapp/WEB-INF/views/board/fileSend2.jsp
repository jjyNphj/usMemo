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
		max: 3, //���ε� �ִ� ���� ���� (�������� ������ ���Ѵ�)
		accept: 'jpg|png|gif', //����� Ȯ����(�������� ������ ��� Ȯ���� ���)
		maxfile: 1024, //�� ���� �ִ� ���ε� ũ��
		maxsize: 3024,  //��ü ���� �ִ� ���ε� ũ��
		STRING: { //Multi-lingual support : �޽��� ���� ����
		    remove : "����", //�߰��� ���� ���� ����, �̹��±׸� ����ϸ� �̹�����밡��
		    duplicate : "$file �� �̹� ���õ� �����Դϴ�.", 
		    denied : "$ext ��(��) ���ε� �Ҽ� ���� ����Ȯ�����Դϴ�.",
		     selected:'$file �� �����߽��ϴ�.', 
		    toomuch: "���ε��� �� �ִ� �ִ�ũ�⸦ �ʰ��Ͽ����ϴ�.($size)", 
		    toomany: "���ε��� �� �ִ� �ִ� ������ $max�� �Դϴ�.",
		    toobig: "$file �� ũ�Ⱑ �ſ� Ů�ϴ�. (max $size)"
		},
		list:"#afile3-list" //���ϸ���� ����� ��� ��������
	});
});
</script>
</head>
<body>
<h3>jQuery ajax fileupload (ajax ���Ͼ��ε�)</h3>
<form name="multiform" id="multiform" action="FileUploadServlet"
                                      method="POST" enctype="multipart/form-data">
	
	title: <input type="text" name="title"  value=""/> <br/>
	description :<input type="text" name="description"  value="" /> <br/>
	
	<!-- ���� ���Ͼ��ε�  -->
	photo : <input type="file" class="afile3"  name="photo" />
 	<div id="afile3-list" style="border:2px solid #c9c9c9;min-height:50px"></div> 
	
	<input type="submit" id="btnSubmit" value="����"/><br/>
</form>	

<div id="result"></div>


<script>

/*jQuery form �÷������� ����Ͽ� �������͸� ajax�� ����*/

var downGroupCnt =0; //�ٿ�ε�׷� ����ī��Ʈ

$(function(){
    
	//������ : �ش����� submit �̺�Ʈ�� �߻�������� ����  
    $('#multiform').ajaxForm({
       cache: false,
       dataType:"json",
       //�������� validation check�� �ʿ��Ұ��
       beforeSubmit: function (data, frm, opt) {
	       //console.log(data);
           alert("������!!");
           return true;
       },
       //submit������ ó��
       success: function(data, statusText){
    	   
    	   alert("���ۼ���!!");
           console.log(data); //������� ������ �ַܼ� ���         
           
           output(data); //���� ������ ȭ�� ����ϴ� �Լ� ȣ��
       },
       //ajax error
       error: function(e){
           alert("�����߻�!!");
           console.log(e);
       }                               
	});
});

//���޹��� ������ ������ ȭ�鿡 ���� ���� ���
function output(data) {
	//���ε��� ������ �ٿ�ε��Ҽ��ֵ��� ȭ�� ����
	$("#result").append("<h3>("+(++downGroupCnt)+") �ٿ�ε�</h3>");
    $("#result").append("����:"+data.title+"<br/>");
    $("#result").append("����:"+data.description+"<br/>");
  
    if(data.photo){
        $("#result").append("����:<br/>");           
        $.each(data.photo, function(index, item){
     	   var link = "FileDownload?f="+item.uploadedFileName+"&of="+item.fileName;
     	   $("#result").append("<a href='"+ link +"' download>"+item.fileName+"</a>");
            $("#result").append("<br/>");	               
        });
    }           
	 /*
 	if(data.file){
        var link = "FileDownload?f="+data.file.uploadedFileName+"&of="+data.file.fileName;
        $("#result").append("���� :<a href='"+ link +"' download>"+data.file.fileName+"</a>");
        $("#result").append("<br/>");
    } */
    
    $('#multiform')[0].reset(); //�� �ʱ�ȭ(����); 
    $('#multiform input:file').MultiFile('reset'); //��Ƽ���� �ʱ�ȭ        
}
</script>
</body>
</html>