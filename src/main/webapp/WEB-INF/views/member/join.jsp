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
        min-height: 500px;
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
        <div class="logo"><a href="#"><img src="/resources/images/logo.png" alt="logo"></a></div>  
        <div class="content">
            <!-- 여기에서 작업 시작하세요 -->
	<h3>회원가입 페이지</h3>
	<form action="join.do" method="post"> <!-- 회원가입은 노출될수있으므로 post로. -->
		<table>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="member_id"/></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="member_pw"/></td> <!--   어떤 패스워드넣었는지 확인하려고 text 타입으로.. -->
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name"/></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
				<label><input name="gender" type="radio" checked value="남자">남</label>
                <input id="female" name="gender" type="radio" value="여자"><label for="female">여</label>
				</td>
			</tr>
			<tr>
				<th>대학교</th>
				<td><input type="text" name="university_idx"/></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td><input type="text" name="phone"/></td>
			</tr>
			<tr>
				<th>EMAIL</th>
				<td><input type="text" name="email"/></td>
			</tr>
		
<!-- 			<tr>
			 <th>프로필 사진 등록</th>
             <td><input name="file" type="file"  name=multiple></td>		
             </tr>	 -->
			<tr>
				<th colspan="2">
					<input type="submit" value="회원가입"/>
				</th>
			</tr>
		</table>
	</form>
        </div>
    </div>
	<jsp:include page="../commons/memberFooter.jsp"/>
</body>
</html>