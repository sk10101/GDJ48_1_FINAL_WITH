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
	<table class="idFindTable">
		<tr>
			<th class="col1">아이디</th>
			<td class="FindCol2">
				<input type="text" id = "id"/>
			</td>
		</tr>	
		<tr>
			<th class="col1">이메일</th>
			<td class="FindCol2">
				<input type="email" id = "email"/>
			</td>
		</tr>
	</table>
		<div class="FindBtn-area">
			<button class="FindBtn" type="button" onclick="pwFind()">PW찾기</button>
			<button class="FindBtn" type="button" onclick="location.href='./login.go'">취소</button>
		</div>           
      </div>
    </div>
	<jsp:include page="../commons/memberFooter.jsp"/>
</body>
<script>
function pwFind(){
	var id =$("#id").val()	
	var email =$("#email").val()
	 if(id== ""|| id == null){
         alert("아이디를 입력해주세요");
         $("#id").focus();
         return false;
      }
	 if(email== ""|| email == null){
         alert("이메일을 입력해주세요");
         $("#email").focus();
         return false;
      }
	
	$.ajax({
		type:'get',
		url:'pwFind.ajax',
		data:{
			id :id,
			email :email},
		dataType:'text',
		success:function(data){			
			if(data){
				alert("비밀번호 수정 페이지로 이동합니다.");
				 location.href="../newPw"
			}else{
				alert("회원님의 정보를 찾을수 없습니다.");				
			}
		},
		error:function(e){
			console.log(e);
		}			
	});
}



</script>
</html>