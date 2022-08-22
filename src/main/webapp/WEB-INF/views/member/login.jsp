<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	var msg = '${msg}';
	if (msg != "") {
		alert(msg);
	}
	</script>
</head>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        text-decoration: none;
        list-style: none;
        font-family: 'Noto Sans KR', sans-serif;
    }

    .main {
        max-width: 1200px;
        width: 100%;
        min-height: 100vh;
        margin: 0 auto;
        background-color: rgb(249, 249, 249);
        border-radius: 20px 20px 0 0;
  		overflow: hidden;
    }

    div.logo {
        display: inline-block;
        position: absolute;
        transform: translate(-50%, -50%);
        left: 50%;
        top: 100px;
    }
    
    @keyframes fadeInDown {
        from {
            opacity: 0;
            transform: translate3d(0, -100%, 0);
        }
        to {
            opacity: 1;
            transform: translateZ(0);
        }
    }

    div.logo img {
        width: 140px;
        animation: fadeInDown 1s;
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translate3d(0, 100%, 0);
        }
        to {
            opacity: 1;
            transform: translateZ(0);
        }
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
        animation: fadeInUp 1s;
    }

	/* 입력창 */
	.inputText {
	}
	
	/* 확인 메시지 */
	#msg {
		margin: 0 5px 5px 5px;
		font-size: 13px;
		text-align: left;
		color: #ff1616;
	}
	
	#main-table {
		margin: 0 auto;
		margin-top: 50px;
		color: rgb(64, 64, 64);
	}
	
	#main-table th, #main-table td {
		padding: 10px 10px; 
	}
	
	input[type='text'], input[type='password'] {
		padding: 3px 10px;
		border-radius: 5px;
		border: 0.3px solid gray;
	}
	
	#sub-table {
		margin: 0 auto;
		margin-top: 30px;
		text-align: center;
	}
	
	#sub-table td {
		padding-top: 5px;
	}
	
	/* 로그인 버튼, 회원가입 버튼 */
	.main-button {
		margin: 10px 10px;	
	} 
	
	/* 로그인 버튼 */
	#login {
		padding: 5px 10px;
		border: none;
		background-color: #537ef4;
		color: #eaeaea;
		border-radius: 5px;
		transition: all 0.3s ease;
	}
	
	#login:hover {
		background-color: #004ecb;
		transform: scale(1.05);
	}
	
	/* 회원가입 */
	#join {
		padding: 5px 10px;
		border: none;
		background-color: #537ef4;
		color: #eaeaea;
		border-radius: 5px;
		transition: all 0.3s ease;
	}
	
	#join:hover {
		background-color: #004ecb;
		transform: scale(1.05);
	}
	
	/* 아이디/비밀번호 찾기 */
	#idpwfind a {
		color: rgb(64, 64, 64);
		font-size: 14px;
	}

</style>
<body>
    <div class="main">
        <div class="logo"><a href="#"><img src="/resources/images/logo.png" alt="logo"></a></div>  
        <div class="content">
            <!-- 여기에서 작업 시작하세요 -->    
	<form action="login.do" method="post">
		<table id="main-table">
			<tr>
				<th>ID</th>
				<td><input type="text" name="id" required="required"/></td>  
			</tr>
			<tr>
				<th>PW</th>
				<td><input type="password" name="pw" required="required"/></td>
			</tr>
			<tr>
				<th colspan="2">
					<input class="main-button" id="login" type="submit" value="로그인">
					<input class="main-button" id="join" type="button" value="회원가입" onclick="location.href='./join'"/>
				</th>
			</tr>
		</table>
	</form>   
	<table id="sub-table">
		<tr> 
			<td id="idpwfind"><a href="idFind">아이디 찾기</a> &nbsp; | &nbsp; <a href="pwFind">비밀번호 찾기</a></td>
		</tr>
	</table>
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
	<jsp:include page="../commons/memberFooter.jsp"/>
</body>
<script>
	var pwmsg = ${pwmsg};
		if(pwmsg==true){
			alert("비밀번호 변경에 성공하셨습니다.");
			}else{
			alert("비밀번호 변경에 실패하셨습니다.");
		}
</script>
</html>