<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style></style>
</head>
<body>
	<!-- file 은 post 방식으로 보내야만 한다. + post 와 enctype 은 업로드에서 필수 -->
	<form action="upload" method="post" enctype="multipart/form-data"> <!-- 바이너리 파일을 명시하기 위해 enctype = multipart 사용 -->
		<input type="file" name="file" onchange="fileUpload()"/>
	</form>
</body>

<script>

	function fileUpload(){
		$("form").submit();
	}
	
	var path = "${path}";
	if(path != ""){
		var content = '<a href="#" id="${path}" onclick="del(this)">';
		content += '<img src="'+path+'" height="250"/>';
		content += '</a>';
		opener.document.getElementById("editable").innerHTML += content;
		self.close();
	}

</script>
</html>