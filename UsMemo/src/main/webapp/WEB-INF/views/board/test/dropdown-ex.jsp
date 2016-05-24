<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	 <link href="${pageContext.request.contextPath}/css/board/bootstrap.css" rel="stylesheet">
<style type="text/css">
body {
    background:#f0f0f0;
}
.nav {
    left:50%;
    margin-left:-150px;
    top:50px;
    position:absolute;
}
.nav>li>a:hover, .nav>li>a:focus, .nav .open>a, .nav .open>a:hover, .nav .open>a:focus {
    background:#fff;
}
.dropdown {
    background:#fff;
    border:1px solid #ccc;
    border-radius:4px;
    width:300px;    
}
.dropdown-menu>li>a {
    color:#428bca;
}
.dropdown ul.dropdown-menu {
    border-radius:4px;
    box-shadow:none;
    margin-top:20px;
    width:300px;
}
.dropdown ul.dropdown-menu:before {
    content: "";
    border-bottom: 10px solid #fff;
    border-right: 10px solid transparent;
    border-left: 10px solid transparent;
    position: absolute;
    top: -10px;
    right: 16px;
    z-index: 10;
}
.dropdown ul.dropdown-menu:after {
    content: "";
    border-bottom: 12px solid #ccc;
    border-right: 12px solid transparent;
    border-left: 12px solid transparent;
    position: absolute;
    top: -12px;
    right: 14px;
    z-index: 9;
}

</style>
</head>
<body>
        <div class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Iasmani Pinazo <!-- <span class="glyphicon glyphicon-user pull-right"></span> --></a>
          <div class="dropdown-menu">
            <div><a href="#">Account Settings <span class="glyphicon glyphicon-cog pull-right"></span></a></div>
            <div class="divider"></div>
            <div><a href="#">User stats <span class="glyphicon glyphicon-stats pull-right"></span></a></div>
            <div class="divider"></div>
            <div><a href="#">Messages <span class="badge pull-right"> 42 </span></a></div>
            <div class="divider"></div>
            <div><a href="#">Favourites Snippets <span class="glyphicon glyphicon-heart pull-right"></span></a></div>
            <div class="divider"></div>
            <div><a href="#">Sign Out <span class="glyphicon glyphicon-log-out pull-right"></span></a></div>
          </div>
        </div>
      
      	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/js/board/bootstrap.js"></script>
</body>
</html>