<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-1.10.2.min.js"></script>
<script src="/js/jquery.form.js"></script>
<script>
	$(document).ready(function() {
		$("input[type=submit]").bind("click", function() {
			
			$("form").ajaxSubmit({
//				dataType : "json",
				success : function(data) {
					alert(data.result);
				},
				error : function(error) {
					alert("요청 처리 중 오류가 발생하였습니다.");
				}
			});
			return false;
		});
	});
</script>
</head>

<body>
<p>${result}</p>
	<form action="fileUploadAjax" method="post" enctype="multipart/form-data">
		파일첨부 1 : <input type="file" name="file1" />
		<br />
		파일첨부 2 : <input type="file" name="file2" />
		<br />
		파일첨부 3 : <input type="file" name="file3" />
		<br />
		<input type="submit" value="upload" />
	</form>
</body>
</html>