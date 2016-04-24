<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<!-- 부트스트랩 사용을 위한 CDN -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<title>UsMemo.index</title>

<!-- 네이버 로그인  API 사용을 위한 CDN -->
<c:if test="${sessionScope.id == null }">
<script src="resources/naverLogin.js"></script>
</c:if>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
<!-- 없으면 http://ip:8080/favicon.ico 404 Not Found 오류남, 근데 아래 사용시 보안 허술해질수도..? 아마도..-->
<intercept-url pattern="/favicon.ico" access="ROLE_ANONYMOUS" />
</head>

<body>
	<div id="area" class="container">
		<center>
			<h1>UsMemo 메인화면</h1>
		</center>
		
		세션적었음: ${sessionScope.id}

		<c:if test="${sessionScope.id == null }">
			<button id="loginBtn" onclick='loginNaver()'>네이버로 로그인하기</button>
		</c:if>

		<c:if test="${sessionScope.id != null }">
			<div><button id="logoutBtn" onclick="location.href='/usMemo/index.do'">로그아웃</button></div>
			
			<div>
				<form action="/usMemo/board/main">
					<input type="hidden" name="memId" value=${sessionScope.id } />
					<button type="submit">내 보드 보기 </button>
				</form>
			</div>
	
			<!-- Bootstrap Modal Button-->
			<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Board Create</button>

			<!-- Bootstrap Modal Start -->
			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog">

					<!--Bootstrap Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">보드 생성하기</h4>
						</div>
						<div class="modal-body">
							<p>보드이름을 적어주세요</p>
							<form action="/usMemo/board/createBoard" role="form">
								<div class="form-group">
									<!-- textarea의 내용 name변수에 저장해서 /createBoard 전달 -->
									<textarea name="name" class="form-control" rows="5" id="comment" placeholder="보드의 이름을 입력해주세요."></textarea>

								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									<input type="hidden" name="memId" value=${sessionScope.id } />
									<!-- submit 누르면 form에 적힌 action 주소로 넘어감. -->
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>
							</form>
							
						</div>
					</div>

				</div>
			</div><!-- bootstrap Modal End -->

		</c:if>	

	</div>
	<c:if test="${sessionScope.id == null }">
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
			redirect_uri : "http://192.168.0.15:8080/usMemo/login",
			client_secret : "fCKQuU8hmN"
		});

		function loginNaver() {
			var state = generateState();
			saveState(state);
			naver.login(state);
		}
	</script>
	</c:if>
</body>
</html>
