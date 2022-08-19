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
            <h2>비밀번호 재설정</h2><br>
     <form action="newPw" id="test" method="POST">
		<table>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="hidden" name="id" id="id" value="${id}"/>
					<input type="password" name="pw" id="pw" required="required"/>
				</td>
			</tr>	
			<tr>
				<th>비밀번호확인</th>
				<td>
					<p><input type="password" name="pw1" id="pw1" required="required"/><font id="chkNotice" size="2"></font></p>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><br>
					<button class="FindBtn" type="button" onclick="save(); return false;">수정</button>
					<button class="FindBtn" type="button" onclick="location.href='/'" >돌아가기</button>
				</td>
			</tr>
		</table>
	</form>
     	</div>
    	</div>
	<jsp:include page="../commons/memberFooter.jsp"/>
</body>
<script>
//비밀번호 일치 불일치 여부 확인후 내용띄우기
$(function(){
    $('#pw1').keyup(function(){
		
        if($('#pw').val() == $('#pw1').val()){
        	$("#chkNotice").html(' ※일치');
            $("#chkNotice").css('color','blue');
        } else{
          $("#chkNotice").html(' ※불일치');
          $("#chkNotice").css('color','red');
        }
    });
});


function save() {
	   if ($("#pw").val() != $("#pw1").val()) {
		      alert("비밀번호가 일치하지 않습니다.");
		      $("#pw2").focus();
		    
		      return false;
		      }
	    if (confirm("수정하시겠습니까?")) {
		    
	 	   $("#test").submit();
	 	    
	 	      return false;
	 	      }
}
</script>
</html>