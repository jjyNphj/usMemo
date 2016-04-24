<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<!-- ��Ʈ��Ʈ�� ����� ���� CDN -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<title>UsMemo.index</title>

<!-- ���̹� �α���  API ����� ���� CDN -->
<c:if test="${sessionScope.id == null }">
<script src="resources/naverLogin.js"></script>
</c:if>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
<!-- ������ http://ip:8080/favicon.ico 404 Not Found ������, �ٵ� �Ʒ� ���� ���� �����������..? �Ƹ���..-->
<intercept-url pattern="/favicon.ico" access="ROLE_ANONYMOUS" />
</head>

<body>
	<div id="area" class="container">
		<center>
			<h1>UsMemo ����ȭ��</h1>
		</center>
		
		����������: ${sessionScope.id}

		<c:if test="${sessionScope.id == null }">
			<button id="loginBtn" onclick='loginNaver()'>���̹��� �α����ϱ�</button>
		</c:if>

		<c:if test="${sessionScope.id != null }">
			<div><button id="logoutBtn" onclick="location.href='/usMemo/index.do'">�α׾ƿ�</button></div>
			
			<div>
				<form action="/usMemo/board/main">
					<input type="hidden" name="memId" value=${sessionScope.id } />
					<button type="submit">�� ���� ���� </button>
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
							<h4 class="modal-title">���� �����ϱ�</h4>
						</div>
						<div class="modal-body">
							<p>�����̸��� �����ּ���</p>
							<form action="/usMemo/board/createBoard" role="form">
								<div class="form-group">
									<!-- textarea�� ���� name������ �����ؼ� /createBoard ���� -->
									<textarea name="name" class="form-control" rows="5" id="comment" placeholder="������ �̸��� �Է����ּ���."></textarea>

								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									<input type="hidden" name="memId" value=${sessionScope.id } />
									<!-- submit ������ form�� ���� action �ּҷ� �Ѿ. -->
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
			// CSRF ������ ���� state token ���� �ڵ�
			// state token�� ���� ������ ���� ���ǿ� ���� �Ǿ�� �մϴ�.
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
