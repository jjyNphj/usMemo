<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>


<script src="resources/naverLogin.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
<!-- ������ http://ip:8080/favicon.ico 404 Not Found ������, �ٵ� �Ʒ� ���� ���� �����������..? �Ƹ���..-->
<intercept-url pattern="/favicon.ico" access="ROLE_ANONYMOUS" />

</head>
<body>
${sessionScope.id }
<script type="text/javascript">
/* var checklogout='${checklogout}'; */
		var access_token= $.cookie("access_token");
		var refresh_token= $.cookie("refresh_token");
		var state_token= $.cookie("state_token");

var naver = NaverAuthorize({
	client_id : "h1ZMSWqDjJSY20p865Ys",
	redirect_uri : "http://192.168.0.13:8080/usMemo/loginPro",
	client_secret : "fCKQuU8hmN"
});

window.onload = function() {
/* 	console.log("üũ:",checklogout);
	if(checklogout=="Y"){ */
		deleteNaverInfo();
/* 	}
	// callback�� ���� checkLoginState()�Լ��� ȣ���Ѵ�.
	else{/* checkLoginState(); }*/ 

}
function deleteNaverInfo() {
	console.log("=====�α׾ƿ�����========================================"); 
	log("<�α׾ƿ���>",access_token,refresh_token,state_token);

	
/* 	naver.logout(tokenInfo.access_token); */
	naver.logout($.cookie("access_token"),function(data){
		var response = data._response.responseJSON;
		console.log("=====�α׾ƿ� �� �ݹ����========================================"); 
		 access_token= response.access_token;
		 refresh_token= response.refresh_token;
		 state_token=  $.cookie("state_token");
		
		log("<���̹� �α׾ƿ���>",access_token,refresh_token,state_token);
		
		$.removeCookie("state_token");
		/* $.removeCookie("refresh_token");
		$.removeCookie("access_token"); */
		
/* 		access_token= $.cookie("access_token");
		refresh_token= $.cookie("refresh_token"); */
		state_token= $.cookie("state_token");
		log("<��Ű ������>",access_token,refresh_token,state_token);
		
		
		/*���� �ְ� index�������� �ٽ� �����ֱ� */
		var url ='/usMemo/index';
   		window.open(url, "_self",  ''); 

	});
/* 	console.log("access", tokenInfo.access_token);
	console.log("refresh", tokenInfo.refresh_token); */
	//console.log("state",state_check);
/* 	checklogout='N'; */
}

function log(message, access, refresh, state ){
	console.log("==================================");
	console.log(message);
	console.log(" access_token : ",access );
	console.log(" refresh_token:",refresh );
	console.log(" state_token: ",state);
	console.log("==================================");
}
</script>

</body>
</html>
