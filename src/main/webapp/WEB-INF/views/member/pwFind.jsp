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
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        text-decoration: none;
        list-style: none;
    }

    .main {
        max-width: 1200px;
        width: 100%;
        min-height: 100vh;
        margin: 0 auto;
        background-color: rgb(249, 249, 249);
        border-radius: 20px 20px 0 0;
    }

    div.logo {
        display: inline-block;
        position: absolute;
        transform: translate(-50%, -50%);
        left: 50%;
        top: 100px;
    }

    div.logo img {
        width: 140px;
    }

    .content {
        display: inline-block;
        max-width: 600px;
        width: 100%;
        min-height: 300px;
        margin-left: 300px;
        margin-top: 170px;
        border-radius: 20px;
        /* background-color: #f4f4f4; */
        background-color: #fff;
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    }

</style>
<body>
    <div class="main">
        <div class="logo"><a href="#"><img src="./resources/images/logo.png" alt="logo"></a></div>  
        <div class="content">
		 <!-- 여기에서 작업 시작하세요 -->
	<h3 id="title">PW 찾기</h3>
	<form action="pwFind.do" method="POST">
	<table>
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" id="id" name="id" required="required"/>
			</td>
		</tr>	
		<tr>
			<th>이메일</th>
			<td>
				<input type="email" id="id" name="email" required="required"/>
			</td>
		</tr>
			<!-- 
			<button class="FindBtn" type="button" onclick="pwFind()">PW찾기</button>
			<button class="FindBtn" type="button" onclick="location.href='./login.go'">취소</button>
			 -->
	</table>
	<button>확인</button>
	<input type="button" onclick="location.href='/'" value="돌아가기"/>
	</form>  
     </div>
    </div>
	<jsp:include page="../commons/memberFooter.jsp"/>
</body>
<script>

</script>
</html>