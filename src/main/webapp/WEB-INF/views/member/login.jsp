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
        max-width: 400px;
        width: 100%;
        min-height: 500px;
        margin-left: 400px;
        margin-top: 170px;
        border-radius: 20px;
        /* background-color: #f4f4f4; */
        background-color: #fff;
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    }

	/* 입력창 */
	.inputText {
		box-sizing: border-box;
		width: 300px;
		padding: 10px;
		margin: 5px 0px;
		border: medium solid #FFBF00;
		border-radius: 5px;
	}
	
	/* 확인 메시지 */
	#msg {
		margin: 0 5px 5px 5px;
		font-size: 13px;
		text-align: left;
		color: #ff1616;
	}
	
	/* 로그인 버튼 */
	#login {
		box-sizing: border-box;
		width: 300px;
		padding: 10px;
		margin: 5px 0px;
		border: none;
		border-radius: 5px;
		background: #FFBF00;
		color: #FFFFFF;
		font-size: 16px;
		font-weight: bold;
		cursor: pointer;
	}
	
	/* 아이디/비밀번호 찾기 */
	#idPw a {
		float: left;
		margin: 5px;
		color: black;
		font-size: 13px;
		text-decoration: none;
	}
	#idPw a:hover {
		text-decoration: underline;
	}
	
	/* 회원가입 */
	#join a {
		float: right;
		margin: 5px;
		color: black;
		font-size: 13px;
		text-decoration: none;
	}
	#join a:hover {
		text-decoration: underline;
	}
</style>
<body>
    <div class="main">
        <div class="logo"><a href="#"><img src="/resources/images/logo.png" alt="logo"></a></div>  
        <div class="content">
            <!-- 여기에서 작업 시작하세요 -->    
	<form action="login.do" method="post">
		<table>
			<tr>
				<th>ID</th>
				<td><input type="text" name="id"/></td>  
			</tr>
			<tr>
				<th>PW</th>
				<td><input type="password" name="pw"/></td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="로그인">
					<input type="button" value="회원가입" onclick="location.href='./join'"/>
				</th>
			</tr>
		</table>
	</form>   
				<div class="text-center">
				<div id="idfind"><a href="idFind">아이디 찾기</a></div>
				<div id="pwfind"><a href="pwFind">비밀번호 찾기</a></div>
<!-- 				<h3 class="mb-3">다른 계정으로 로그인</h3>

				<div class="d-flex justify-content-center">
				
					네이버
					<div id="naverIdLogin" class="p-2"></div>
	
					카카오
					<a id="kakao-login-btn"></a>
					<a class="p-2" href="https://kauth.kakao.com/oauth/authorize?client_id=b8239aad28fc4b4100b8f469df9c704f&redirect_uri=http://localhost:8080/kakaoLogin&response_type=code">
						<img src="/resources/images/kakao_login_large_narrow.png" style="height:60px">
					</a>
				</div>       --> 
        </div>
    </div>
    </div>
	<jsp:include page="../commons/memberFooter.jsp"/>
</body>
<script>
	var pwmsg = ${pwmsg};
		if(pwmsg==true){
			alert("비밀번호 변경에 성공하셨습니다.");
			}else{
			alert("비밀번호 변경에 실패하셨습니다.");
		}
		
	var msg = '${msg}';
	if (msg != "") {
			alert(msg);
	}
</script>
</html>