<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html>
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<!-- 부트스트랩 CDN -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- <meta name="generator" content="Codeply"> -->
	
	<link href="${pageContext.request.contextPath}/css/agency/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="//cdnjs.cloudflare.com/ajax/libs/animate.css/3.1.1/animate.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="//code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
    <link rel="stylesheet" href="css/landingzero/styles.css" />
    <link rel="stylesheet" href="css/landingzero/animate.css" />
    <link rel="stylesheet" href="css/agency/rotating-card.css" />
    
    <link href="${pageContext.request.contextPath}/css/agency/agency.css" rel="stylesheet">
 <%-- 	<link href="${pageContext.request.contextPath}/css/ct-paper/ct-paper.css" rel="stylesheet"/>
 --%>
    <!-- Custom Fonts (Agency)-->
    <%-- <link href="${pageContext.request.contextPath}/font/font-awesome.min.css" rel="stylesheet" type="text/css"> --%>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    
   
    <!--     Fonts and icons (ct-paper)     -->
    <!-- <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet"> -->
    <link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'>

<title>UsMemo</title>
</head>

<body id="page-top" class="index" >
    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top">
        
        <div class="col-md-2">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
          		</button>
	            <a class="navbar-brand page-scroll " href="#page-top">UsMemo</a>
            </div>
		</div>
		<div class="col-md-10">
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-left">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#team">Team</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#about">About</a>
                    </li>
                    <li>
                    	<a class="page-scroll" href="#period">Period</a>
                        
                    </li>
                    <li>
                        <a class="page-scroll" href="#portfolio">Portfolio</a>
                    </li>                    
                    <hr style="border-color:#d3d3d3">
                </ul>
                <ul class="nav navbar-nav navbar-right ">
	        		<c:if test="${sessionScope.id == null }">
	                	<li><a class="nostyle">
	                		<button class="btn btn-primary loginBtn_group" id="loginBtn" onclick="loginNaver()">Log In</button>
	                	</a></li>
					</c:if>
					<c:if test="${sessionScope.id != null }">
	                	<li><a href="javascript:void(0);" onclick="goToMyboard(${sessionScope.id })">Go to My Board</a></li>
	                </c:if>
	                <c:if test="${sessionScope.id != null }">
					    <li><a class="nostyle" href="/usMemo/index.do;">
					    	<button class="btn btn-primary loginBtn_group"  id="logoutBtn">Log Out</button>
					    </a></li>
					</c:if>
		    	</ul>
            </div>
       	</div> 
    </nav>

    <!-- Header -->
<!--     <header>
        <div class="container">
            <div class="intro-text">
                <div class="intro-lead-in">Welcome To UsMemo!</div>
                <div class="intro-heading">UsMemo와 지금 시작하세요</div>
                <a href="#services" class="page-scroll btn btn-xl">Tell Me More</a>
            </div>
        </div>
        <video autoplay="" loop="" class="fillWidth fadeIn wow collapse in" data-wow-delay="0.5s" poster="https://s3-us-west-2.amazonaws.com/coverr/poster/Traffic-blurred2.jpg" id="video-background">
            <source src="https://s3-us-west-2.amazonaws.com/coverr/mp4/Traffic-blurred2.mp4" type="video/mp4">Your browser does not support the video tag. I suggest you upgrade your browser.
        </video>
    </header> -->
    <header id="first">
        <div class="header-content">
            <div class="inner">
                <h1 class="cursive">Welcome To UsMemo!</h1>
                <!-- <h4 class="koreanfont">UsMemo와 지금 시작하세요</h4> -->
                <hr class="hrsize">
                <!-- <a href="#video-background" id="toggleVideo" data-toggle="collapse" class="btn btn-primary btn-xl">Toggle Video</a>  -->
                <a href="#video-background" data-toggle="modal" data-target="#myModal" class="btn btn-primary-fix btn-xl-size" onclick="video_controller();">
                	<span class="glyphicon glyphicon-expand"></span>&nbsp;&nbsp;Guide Video
                </a>
                <a href="#video-background" data-toggle="collapse" class="btn btn-primary-fix btn-xl-size" onclick="video_controller();">
                	<span class="glyphicon glyphicon-pause"></span>&nbsp;&nbsp;Video Stop
                </a>  
               <!--  &nbsp; &nbsp;&nbsp; -->
                <!-- <a href="#about" class="btn btn-primary btn-xl-size page-scroll">Introduce</a> -->
                <!-- <a href="#services" class="btn btn-primary btn-xl page-scroll">Get Started</a> -->
            </div>
        </div>
        <video autoplay="" loop="" class="fillWidth fadeIn wow collapse in" data-wow-delay="0.5s" poster="${pageContext.request.contextPath}/img/help.jpg" id="video-background">
            <!-- <iframe src="https://www.youtube.com/embed/sbc2yBheAbo" frameborder="0"></iframe> -->
          	<source src="img/trello_video.mp4" type="video/mp4">
            <!-- <source src="https://s3-us-west-2.amazonaws.com/coverr/mp4/Traffic-blurred2.mp4" type="video/mp4"> -->
        </video>
    </header>
    
    <!-- Modal -->
	<div id="myModal" class="modal fade" role="dialog">
		<button type="button" class="close" data-dismiss="modal"><span class="glyphicon glyphicon-remove-sign"></span></button>
	  <!-- <div class="modal-dialog"> -->
		<!-- <div class="block-container"> -->
		
	    <!-- Modal content-->
	    <!-- <div class="modal-content">
	      <div class="modal-body"> -->
	      	<!--./ HELP SECTION START -->
	        <div id="help" >
		        <div class="overlay">
		            <div class="container">
		                <div class="row text-center">
		                    <div class="col-md-12">
		                        <h2 data-wow-delay="0.3s" class="wow rollIn animated fontcolor-margin"><strong>HOW TO USE ?</strong></h2>
		                        <p class="sub-head fontcolor koreanfont">UsMemo 사이트를 이용하는 방법은 아래의 동영상을 참고하시길 바랍니다. </p>
		                    </div>
		                </div>
		                
		                    <!-- <div class="col-lg-6 col-lg-offset-1  col-md-6 col-md-offset-1"> -->		                    
	                    <div class="col-md-12">
	                        <iframe src="http://serviceapi.nmv.naver.com/flash/convertIframeTag.nhn?vid=C3C351BAE7F6442FCEAE1091C400B240351C&outKey=V12230aa8a3081c82bb853e18cecaae499f65eb33b8295f8cb32d3e18cecaae499f65&width=544&height=306" class="vedio-style wow rotateIn animated" data-wow-delay="0.4s"></iframe>
	                    </div>
							
		            </div>		
		
		           <!--  </div> -->
		        </div>
		
		    </div>
		    <!--./ HELP SECTION END -->
	      <!-- </div>
	    </div> -->
	
	  <!-- </div> -->
	</div>		
	
	
	<!-- Team Section -->
    <section id="team" class="bg-light-gray">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                	<hr class="hrcolor">
                    <h2 class="section-heading h2color">Our Amazing Team</h2>
                    <h3 class="text-muted koreanfont h3color">Team Name : Twogether</h3>
                    <hr class="hrcolor">
                    <!-- <h3 class="section-subheading text-muted koreanfont">Team Name : Twogether</h3> -->
                </div>
            </div>
            <div class="row" style="margin:20px;">&nbsp;</div>
            <div class="row">
				 <div class="col-md-2">&nbsp;</div>
		
				 <div class="col-md-4 col-sm-6" style="margin:0 20px 0 0">
		            <!-- <div class="card-container manual-flip"> -->
		            <div class="card-container">
		               <div class="card">
		                   <div class="front">
		                       <div class="cover" >
		                           <%-- <img src="${pageContext.request.contextPath}/img/team/2.jpg"/> --%>
		                       </div>
		                       <div class="user">
		                           <img class="img-circle" src="${pageContext.request.contextPath}/img/team/2.jpg"/>
		                       </div>
		                       <div class="content">
		                           <div class="main">
		                               <h3 class="name">Park Hye Jin</h3>
		                               <p class="profession">Programmer</p>
		                               <p class="text-center">"인생 좌우명"</p>
		                           </div>
		                           <div class="footer">
		                                <button class="btn btn-simple" onclick="rotateCard(this)">
		                                   <i class="fa fa-mail-forward"></i>Card Rotation
		                               </button>
		                           </div>
		                       </div>
		                   </div> <!-- end front panel -->
		                   <div class="back">
		                       <div class="header">
		                           <h5 class="motto">박 헤 진</h5>
		                       </div>
		                       <div class="content">
		                           <div class="main">
		                               <h4 class="text-center koreanfont">맡은 역할</h4>
		                               <p class="text-center koreanfont">기획,핵심 기능 개발,보드와 리스트/카드 화면 디자인을 개발 </p>
		                               <p class="text-center koreanfont">블로그주소 : 
		                       			<a class="h3color" href="http://blog.naver.com/kiela929">http://blog.naver.com/kiela929</a>
		                       		</p>
		                           </div>
		                       </div>
		                       
		                       <div class="footer">
		                       	<!-- <button class="btn btn-simple" rel="tooltip" title="Flip Card" onclick="rotateCard(this)">
		                               <i class="fa fa-reply"></i> Back
		                         </button>  -->                      
		                       	<div class="social-links text-center">
		                               <a href="#" class="twitter" style="color:#F05B42;"><i class="fa fa-twitter fa-fw"></i></a>
		                           </div>
		                           <!-- <div class="social-links text-center">
		                               <a href="#" class="facebook"><i class="fa fa-facebook fa-fw"></i></a>
		                               <a href="#" class="google"><i class="fa fa-google-plus fa-fw"></i></a>
		                               <a href="#" class="twitter"><i class="fa fa-twitter fa-fw"></i></a>
		                           </div> -->
		                       </div>
		                   </div> <!-- end back panel -->
		               </div> <!-- end card -->
		           </div> <!-- end card-container -->
		       </div> <!-- end col sm 3 -->
		       
		       <!-- <div class="col-md-1">&nbsp;</div> -->
		       
		       <div class="col-md-4 col-sm-6">
		            <!-- <div class="card-container manual-flip"> -->
		            <div class="card-container">
		               <div class="card">
		                   <div class="front">
		                       <div class="cover" >
		                           <%-- <img src="${pageContext.request.contextPath}/img/team/1.jpg"/> --%>
		                       </div>
		                       <div class="user">
		                           <img class="img-circle" src="${pageContext.request.contextPath}/img/team/1.jpg"/>
		                       </div>
		                       <div class="content">
		                           <div class="main">
		                               <h3 class="name">Jang Ji Yeon</h3>
		                               <p class="profession">Programmer</p>
		                               <p class="text-center">"인생 좌우명"</p>
		                           </div>
		                           <div class="footer">
		                                <button class="btn btn-simple" onclick="rotateCard(this)">
		                                   <i class="fa fa-mail-forward"></i>Card Rotation
		                               </button>
		                           </div>
		                       </div>
		                   </div> <!-- end front panel -->
		                   <div class="back">
		                       <div class="header">
		                           <h5 class="motto">장 지 연</h5>
		                       </div>
		                       <div class="content">
		                           <div class="main">
		                               <h4 class="text-center koreanfont">맡은 역할</h4>
		                               <p class="text-center koreanfont">기획,보조 기능 개발,메인디자인을 개발 </p>
		                               <p class="text-center koreanfont">블로그주소 : 
		                       			<a class="h3color" href="http://blog.naver.com/jang_delay">http://blog.naver.com/jang_delay</a>
		                       		</p>
		                           </div>
		                       </div>
		                       
		                       <div class="footer">
		                       	<!-- <button class="btn btn-simple" rel="tooltip" title="Flip Card" onclick="rotateCard(this)">
		                               <i class="fa fa-reply"></i> Back
		                        </button>  -->                      
		                       	<div class="social-links text-center">
		                               <a href="#" class="twitter" style="color:#F05B42;"><i class="fa fa-twitter fa-fw"></i></a>
		                           </div>
		                       </div>
		                   </div> <!-- end back panel -->
		               </div> <!-- end card -->
		           </div> <!-- end card-container -->
		       </div> <!-- end col sm 3 -->
        
            </div>
        </div>
    </section>
	
		
	<!-- Services Section -->
    <section id="about" class="bg-light-white">
        <div class="container">
        	
	        <div class="row rowcolor">
	            <div class="box">
	                <div class="col-lg-12 text-center">
	                    <hr class="hrcolor">
	                    <h2 class="section-heading h2color">About UsMemo</h2>
	                    <h3 class="text-muted koreanfont h3color">UsMemo 사이트 소개</h3>
	                    <hr class="hrcolor">
	                </div>
	                <div class="row" style="margin:20px;">&nbsp;</div>
	                <div class="col-md-6">
	                    <img class="img-responsive img-border-left" src="img/main/usmemo_image.jpg" alt="UsMemo">
	                </div>
	                <div class="col-md-6 text-muted">
	                    <p class="koreanfont h3color">UsMemo는 웹기반의 프로젝트 관리 소프트웨어입니다.</p>
	                    <p class="koreanfont h3color">보드 안에 리스트, 리스트 안에 카드가 들어가며, 카드안에 간단한 메모부터 장문의 글을 넣을 수 있습니다. 또한 다른 사용자와 카드를 공유할 수도 있습니다.</p>
	                    <p class="koreanfont h3color">순간순간 떠오르는 것을 간단하게 메모하고, 단순한 디자인을 가지고 있어 직관적으로 사용할 수 있습니다.</p>
	                    <p class="koreanfont h3color">해야할 일이나 읽어야 할 책,자신만의 버킷리스트 등 이제 친구와 당신의 생각을 교환해보세요.</p>
	                </div>            
	                <div class="clearfix"></div>
	            </div>
	            <!-- <hr class="hrcolor"> -->
	        </div>
	      
        </div>
    </section>
    
    
    <!-- About Section -->
    <section id="period" class="bg-light-gray">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                	<hr class="hrcolor">
                    <h2 class="section-heading h2color">Production Period </h2>
                    <h3 class="text-muted koreanfont h3color">UsMemo의 일정</h3>
                    <hr class="hrcolor">
                </div>
            </div>
            <div class="row" style="margin:20px;">&nbsp;</div>
            <div class="row">
                <div class="col-lg-12">
                    <ul class="timeline">
                        <li>
                            <div class="timeline-image">
                                <img class="img-circle img-responsive" src="${pageContext.request.contextPath}/img/about/1.jpg" alt="">
                            </div>
                            <div class="timeline-panel">
                                <div class="timeline-heading">
                                    <h4 class="h3color">2016-03</h4>
                                    <h4 class="subheading">Our Project Start!</h4>
                                </div>
                                <div class="timeline-body">
                                    <p class="text-muted koreanfont">웹 제작 프로젝트 주제 브레인스토밍, <br>아이디어 선별 후 벤치마킹, 
                                    <br>사용할 툴, 적용 가능한 기술 구상 <br>칠판/게시판에 붙이는 포스트잇에서 착안한 <br>간편한 메모 기능의 웹 선정</p>
                                </div>
                            </div>
                        </li>
                        <li class="timeline-inverted">
                            <div class="timeline-image">
                                <img class="img-circle img-responsive" src="${pageContext.request.contextPath}/img/about/2.jpg" alt="">
                            </div>
                            <div class="timeline-panel">
                                <div class="timeline-heading">
                                    <h4 class="h3color">2016-03</h4>
                                    <h4 class="subheading">Designs For Web Development</h4>
                                </div>
                                <div class="timeline-body">
                                    <p class="text-muted koreanfont">웹 기능 구체적 구상, <br>데이터베이스 설계도 구상, <br>대략적인 메인 화면 구상,<br>팀/프로젝트 이름 결정</p>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="timeline-image">
                                <img class="img-circle img-responsive" src="${pageContext.request.contextPath}/img/about/3.jpg" alt="">
                            </div>
                            <div class="timeline-panel">
                                <div class="timeline-heading">
                                    <h4 class="h3color">2016-04</h4>
                                    <h4 class="subheading">Period For Core Technology</h4>
                                </div>
                                <div class="timeline-body">
                                    <p class="text-muted koreanfont">Spring MVC 패턴을 이용하여 웹의 기본 틀 구현<br>Naver 로그인 API 적용 <br>핵심 기능인 리스트,카드간의 이동은 Jquery sortable을 바꾸고, DB적용은 링크드리스트 자료구조 적용</p>
                                </div>
                            </div>
                        </li>
                        <li class="timeline-inverted">
                            <div class="timeline-image">
                                <img class="img-circle img-responsive" src="${pageContext.request.contextPath}/img/about/4.jpg" alt="">
                            </div>
                            <div class="timeline-panel">
                                <div class="timeline-heading">
                                    <h4 class="h3color">2016-05</h4>
                                    <h4 class="subheading">Period For Add Function</h4>
                                </div>
                                <div class="timeline-body">
                                    <p class="text-muted koreanfont">기본 틀 안에 실질적인 기능 추가<br>보드,리스트,카드 삭제/추가/수정
                                    <br>친구찾기,친구추가(공유기능,관리자권한),활동내역<br>보드 즐겨찾기,파일첨부 등</p>
                                </div>
                            </div>
                        </li>                      
                        <li>
                            <div class="timeline-image">
                                <img class="img-circle img-responsive" src="${pageContext.request.contextPath}/img/about/3.jpg" alt="">
                            </div>
                            <div class="timeline-panel">
                                <div class="timeline-heading">
                                    <h4 class="h3color">2016-04</h4>
                                    <h4 class="subheading">Period For Core Technology</h4>
                                </div>
                                <div class="timeline-body">
                                    <p class="text-muted koreanfont">메뉴바,버튼,스크롤 등 UI 디자인 적용<br>오류 수정,테스트</p>
                                </div>
                            </div>
                        </li>
                        <li class="timeline-inverted">
                            <div class="timeline-image">
                                <h4 class="h4white">Our Story
                                    <br>is
                                    <br>Over!
                                </h4>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    
    
    
	<!-- Portfolio Grid Section -->
    <section id="portfolio" class="bg-light-white">
        <div class="container rowcolor">
            <div class="row">
                <div class="col-lg-12 text-center">
                	<hr class="hrcolor">
                    <h2 class="section-heading h2color">Portfolio</h2>
                    <h3 class="text-muted koreanfont h3color">사용한 툴과 기술</h3>
                    <hr class="hrcolor">
                    <!-- <h3 class="section-subheading text-muted koreanfont">사용한 기술</h3> -->
                </div>
            </div>
            <div class="row" style="margin:20px;">&nbsp;</div>
            <div class="row">
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal1" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="${pageContext.request.contextPath}/img/main/portfolio_eclipse.jpg" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4 class="h3color">Eclipse</h4>
                        <p class="text-muted">Developer Tool<br>&nbsp;</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal2" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="${pageContext.request.contextPath}/img/main/portfolio_oracle.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4 class="h3color">Oracle</h4>
                        <p class="text-muted">Database Management System<br>(PL/SQL support)</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal3" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="${pageContext.request.contextPath}/img/main/portfolio_tomcat.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4 class="h3color">Apache Tomcat</h4>
                        <p class="text-muted">Web Application Server<br>(WAS)</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal4" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="${pageContext.request.contextPath}/img/main/portfolio_maven.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4 class="h3color">Maven</h4>
                        <p class="text-muted">Project Management Tool<br>(library management,build function)<br>&nbsp;</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal5" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="${pageContext.request.contextPath}/img/main/portfolio_spring.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4 class="h3color">Spring MVC</h4>
                        <p class="text-muted">MVC pattern based web framework<br>&nbsp;<br>&nbsp;</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal6" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="${pageContext.request.contextPath}/img/main/portfolio_bootstrap.jpg" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4 class="h3color">Bootstrap</h4>
                        <p class="text-muted">HTML5 based open source web design framework.<br>(CSS, JavaScript, Responsive Web Design)</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal7" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="${pageContext.request.contextPath}/img/main/portfolio_jquery.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4 class="h3color">Jquery</h4>
                        <p class="text-muted">HTML5 based open source web design framework.<br>(CSS, JavaScript, Responsive Web Design)</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal8" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="${pageContext.request.contextPath}/img/main/portfolio_git.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4 class="h3color">Git</h4>
                        <p class="text-muted">HTML5 based open source web design framework.<br>(CSS, JavaScript, Responsive Web Design)</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal9" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="${pageContext.request.contextPath}/img/main/portfolio_naver.png" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4 class="h3color">Naver Login API</h4>
                        <p class="text-muted">HTML5 based open source web design framework.<br>(CSS, JavaScript, Responsive Web Design)</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Portfolio Modals -->
    <!-- Use the modals below to showcase details about your portfolio projects! -->

    <!-- Portfolio Modal 1 -->
    <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Eclipse</h2>
                            <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                            <img class="img-responsive img-centered" src="${pageContext.request.contextPath}/img/main/portfolio_eclipse.jpg" alt="">
                            <p>Use this area to describe your project. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est blanditiis dolorem culpa incidunt minus dignissimos deserunt repellat aperiam quasi sunt officia expedita beatae cupiditate, maiores repudiandae, nostrum, reiciendis facere nemo!</p>
                            <p>
                                <strong>Want these icons in this portfolio item sample?</strong>You can download 60 of them for free, courtesy of <a href="https://getdpd.com/cart/hoplink/18076?referrer=bvbo4kax5k8ogc">RoundIcons.com</a>, or you can purchase the 1500 icon set <a href="https://getdpd.com/cart/hoplink/18076?referrer=bvbo4kax5k8ogc">here</a>.</p>
                            <ul class="list-inline">
                                <li>Date: July 2014</li>
                                <li>Client: Round Icons</li>
                                <li>Category: Graphic Design</li>
                            </ul>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 2 -->
    <div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <h2>Project Heading</h2>
                            <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                            <img class="img-responsive img-centered" src="${pageContext.request.contextPath}/img/main/portfolio_oracle.png" alt="">
                            <p><a href="http://designmodo.com/startup/?u=787">Startup Framework</a> is a website builder for professionals. Startup Framework contains components and complex blocks (PSD+HTML Bootstrap themes and templates) which can easily be integrated into almost any design. All of these components are made in the same style, and can easily be integrated into projects, allowing you to create hundreds of solutions for your future projects.</p>
                            <p>You can preview Startup Framework <a href="http://designmodo.com/startup/?u=787">here</a>.</p>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 3 -->
    <div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Tomcat</h2>
                            <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                            <img class="img-responsive img-centered" src="${pageContext.request.contextPath}/img/main/portfolio_tomcat.png" alt="">
                            <p>Treehouse is a free PSD web template built by <a href="https://www.behance.net/MathavanJaya">Mathavan Jaya</a>. This is bright and spacious design perfect for people or startup companies looking to showcase their apps or other projects.</p>
                            <p>You can download the PSD template in this portfolio sample item at <a href="http://freebiesxpress.com/gallery/treehouse-free-psd-web-template/">FreebiesXpress.com</a>.</p>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 4 -->
    <div class="portfolio-modal modal fade" id="portfolioModal4" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Maven</h2>
                            <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                            <img class="img-responsive img-centered" src="${pageContext.request.contextPath}/img/main/portfolio_maven.png" alt="">
                            <p>Start Bootstrap's Agency theme is based on Golden, a free PSD website template built by <a href="https://www.behance.net/MathavanJaya">Mathavan Jaya</a>. Golden is a modern and clean one page web template that was made exclusively for Best PSD Freebies. This template has a great portfolio, timeline, and meet your team sections that can be easily modified to fit your needs.</p>
                            <p>You can download the PSD template in this portfolio sample item at <a href="http://freebiesxpress.com/gallery/golden-free-one-page-web-template/">FreebiesXpress.com</a>.</p>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 5 -->
    <div class="portfolio-modal modal fade" id="portfolioModal5" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Spring</h2>
                            <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                            <img class="img-responsive img-centered" src="${pageContext.request.contextPath}/img/main/portfolio_spring.png" alt="">
                            <p>Escape is a free PSD web template built by <a href="https://www.behance.net/MathavanJaya">Mathavan Jaya</a>. Escape is a one page web template that was designed with agencies in mind. This template is ideal for those looking for a simple one page solution to describe your business and offer your services.</p>
                            <p>You can download the PSD template in this portfolio sample item at <a href="http://freebiesxpress.com/gallery/escape-one-page-psd-web-template/">FreebiesXpress.com</a>.</p>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 6 -->
    <div class="portfolio-modal modal fade" id="portfolioModal6" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Bootstrap</h2>
                            <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                            <img class="img-responsive img-centered" src="${pageContext.request.contextPath}/img/main/portfolio_bootstrap.jpg" alt="">
                            <p>Dreams is a free PSD web template built by <a href="https://www.behance.net/MathavanJaya">Mathavan Jaya</a>. Dreams is a modern one page web template designed for almost any purpose. It’s a beautiful template that’s designed with the Bootstrap framework in mind.</p>
                            <p>You can download the PSD template in this portfolio sample item at <a href="http://freebiesxpress.com/gallery/dreams-free-one-page-web-template/">FreebiesXpress.com</a>.</p>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

	<!-- Portfolio Modal 7 -->
    <div class="portfolio-modal modal fade" id="portfolioModal7" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Jquery</h2>
                            <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                            <img class="img-responsive img-centered" src="${pageContext.request.contextPath}/img/main/portfolio_jquery.png" alt="">
                            <p>Dreams is a free PSD web template built by <a href="https://www.behance.net/MathavanJaya">Mathavan Jaya</a>. Dreams is a modern one page web template designed for almost any purpose. It’s a beautiful template that’s designed with the Bootstrap framework in mind.</p>
                            <p>You can download the PSD template in this portfolio sample item at <a href="http://freebiesxpress.com/gallery/dreams-free-one-page-web-template/">FreebiesXpress.com</a>.</p>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Portfolio Modal 8 -->
    <div class="portfolio-modal modal fade" id="portfolioModal8" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Git</h2>
                            <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                            <img class="img-responsive img-centered" src="${pageContext.request.contextPath}/img/main/portfolio_git.png"" alt="">
                            <p>Dreams is a free PSD web template built by <a href="https://www.behance.net/MathavanJaya">Mathavan Jaya</a>. Dreams is a modern one page web template designed for almost any purpose. It’s a beautiful template that’s designed with the Bootstrap framework in mind.</p>
                            <p>You can download the PSD template in this portfolio sample item at <a href="http://freebiesxpress.com/gallery/dreams-free-one-page-web-template/">FreebiesXpress.com</a>.</p>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Portfolio Modal 9 -->
    <div class="portfolio-modal modal fade" id="portfolioModal9" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-content">
            <div class="close-modal" data-dismiss="modal">
                <div class="lr">
                    <div class="rl">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="modal-body">
                            <!-- Project Details Go Here -->
                            <h2>Naver Login API</h2>
                            <p class="item-intro text-muted">Lorem ipsum dolor sit amet consectetur.</p>
                            <img class="img-responsive img-centered" src="${pageContext.request.contextPath}/img/main/portfolio_naver.png" alt="">
                            <p>Dreams is a free PSD web template built by <a href="https://www.behance.net/MathavanJaya">Mathavan Jaya</a>. Dreams is a modern one page web template designed for almost any purpose. It’s a beautiful template that’s designed with the Bootstrap framework in mind.</p>
                            <p>You can download the PSD template in this portfolio sample item at <a href="http://freebiesxpress.com/gallery/dreams-free-one-page-web-template/">FreebiesXpress.com</a>.</p>
                            <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
		
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <span class="copyright footerColor">Copyright &copy; UsMemo 2016</span>
                </div>
                <div class="col-md-4">
<!--                     <ul class="list-inline social-buttons">
                        <li><a href="#"><i class="fa fa-twitter"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-facebook"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-linkedin"></i></a>
                        </li>
                    </ul> -->
                </div>
                <div class="col-md-4">
                    <ul class="list-inline quicklinks">
                        <li><a class="footerColor" href="https://github.com/jjyNphj/usMemo">GitHub</a>
                        </li>
<!--                         <li><a href="#">Terms of Use</a>
                        </li> -->
                    </ul>
                </div>
            </div>
        </div>
    </footer>
		
		
		
	<!-- js -->

	<!-- 네이버 로그인  API 사용을 위한 CDN -->
	<script src="resources/naverLogin.js"></script>
    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/js/agency/jquery.js"></script>
<!-- 	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 -->	<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
	

    <!-- Bootstrap Core JavaScript -->
    <script src="${pageContext.request.contextPath}/js/agency/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		function generateState() {
			// CSRF 방지를 위한 state token 생성 코드
			// state token은 추후 검증을 위해 세션에 저장 되어야 합니다.
			var oDate = new Date();
			return oDate.getTime();
		}
		function saveState(state) {
			$.removeCookie("state_token");
			$.cookie("state_token", state);
		}
		var naver = NaverAuthorize({
			client_id : "h1ZMSWqDjJSY20p865Ys",
			redirect_uri : "http://127.0.0.1:8080/usMemo/login",
			client_secret : "fCKQuU8hmN"
		});

		function loginNaver() {
			var state = generateState();
			saveState(state);
			naver.login(state);
		}
		
		function goToMyboard(memId){	
			var url ='/usMemo/board/main?memId='+ memId;
        window.open(url, "_self",  '');
			
		}
	</script>

<%-- 	<script src="${pageContext.request.contextPath}/js/agency/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
	<script	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
     --%>
    <!-- Plugin JavaScript -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/agency/classie.js"></script>
    <script src="${pageContext.request.contextPath}/js/agency/cbpAnimatedHeader.js"></script>
    
    <!-- Contact Form JavaScript -->
    <script src="${pageContext.request.contextPath}/js/agency/jqBootstrapValidation.js"></script>
    <script src="${pageContext.request.contextPath}/js/agency/contact_me.js"></script>
    
    
    <!-- Custom Theme JavaScript -->
    <script src="${pageContext.request.contextPath}/js/agency/agency.js"></script>
    
    <!--  WOW Script(동영상) -->
    <script src="${pageContext.request.contextPath}/js/agency/wow.min.js"></script>
    
    <!-- 팀소개 카드 돌리기부분 -->
    <script src="${pageContext.request.contextPath}/js/agency/rotating-card.js"></script>

	<!-- 디자인 -->
	<script src="${pageContext.request.contextPath}/js/ct-paper.js"></script>
	
</body>
</html>
