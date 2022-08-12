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
			<th class="col1">비밀번호</th>
			<td class="FindCol2">
				<input type="password" name="userPw"  id = "id"  placeholder="변경할 비밀번호"/>
			</td>
		</tr>	
		<tr>
			<th class="col1">비밀번호확인</th>
			<td class="FindCol2">
				<input type="password" name="pwChk" id ="PasswordChk" placeholder="변경할 비밀번호" />
			</td>
		</tr>
	</table>
		<div class="FindBtn-area">
			<button class="FindBtn" type="button" onclick="pwUpdate()">수정</button>
			<button class="FindBtn" type="button" onclick="location.href='./login.go'">취소</button>
		</div>           
      </div>
    </div>
	<jsp:include page="../commons/memberFooter.jsp"/>
</body>
<script>
var userId =""; // 비밀번호 변경화면으로 바뀌었을때 아이디값이 필요

$("#pwUpdate").click(function(){
	  if($( "input[name='userPw']").val()=="" ||  pwdCheck == 0 ){//비밀번호 입력 확인
			alert("비밀 번호를 확인 해 주세요");
			$("input[name='userPw']").focus();//포커스 이동
		}else if($("input[name='pwChk']").val()!=$("input[name='userPw']").val() || pwdCheck == 0 ){//비밀번호가 서로 일치하는지 확인
			alert("비밀번호 일치 확인 해주세요");
			$("input[name='pwChk']").focus();//포커스 이동
		}else{
	  $.ajax({
		  url: "./newPw",
		  type: "post",
		  dataType: "json",
		  data: {
			 "pw": $("input[name='userPw']").val(), 
			 "id" : userId
		  },
		  success:function(d){
			  if(d.success){
				  alert("비밀번호 변경이 완료되었습니다.");
				  location.href="./";
			  }else{
				  alert("비밀번호 변경 실패");
			  }
		  }  
	  });
	}
});


</script>
</html>