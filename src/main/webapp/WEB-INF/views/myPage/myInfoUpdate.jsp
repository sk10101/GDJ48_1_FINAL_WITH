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
    .content-wrap {
    	max-width: 1200px;
    	width: 100%;
    	margin: 0 auto;
    }

    .content {
        display: inline-block;
        margin-left: 160px;
        margin-top: 100px;
        max-width: 1040px;
        width: 100%;
        min-height: 680px;
        /* background-color: #f4f4f4; */
        background-color: rgb(249, 249, 249);
    }
    
    /* 양수빈 CSS 작업[삭제 해도 됨] */
    .myinfo th, td {
	    border: 1px solid #000000;
	    padding: 8px;
  	}
  	.myinfo th{
  		background-color : #2962ff;
  		color:#ffffff;
  	}
  	.myinfo td{
  		padding-right:400px;
  		width:710px;
  	}
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar4.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     <table class="myinfo" style="margin-left:120px; margin-top:40px;">
            	<tr>
            		<th>ID</th>
            		<td>${mblist.member_id}</td>
            	</tr>
            	<tr>
            		<th>PW</th>
            		<td>
	            		<input name="pw1" type="text" required="required"/>
	            		<br>※ 4자리 이상, 비밀번호 수정시에만 작성
            		</td>
            	</tr>
            	<tr>
            		<th>PW확인</th>
            		<td><input name="pw2" type="text" required="required"/></td>
            	</tr>
            	<tr>
            		<th>이름</th>
            		<td>${mblist.name}</td>
            	</tr>
            	<tr>
            		<th>성별</th>
            		<td>${mblist.gender}</td>
            	</tr>
            	<tr>
            		<th>대학교</th>
            		<td><input type="text" required="required"/><button>대학교 찾기</button></td>
            	</tr>
            	<tr>
            		<th>사진</th>
            		<td>파일 업로드</td>
            	</tr>
            	<tr>
            		<th>연락처</th>
            		<td><input type="text" value="${mblist.phone}" required="required"/></td>
            	</tr>
            	<tr>
            		<th>이메일</th>
            		<td>${mblist.email}</td>
            	</tr>
            	<tr>
            		<th>회원탈퇴 신청</th>
            		<td style="width:700px;"><button></button>&emsp;
            		※ 체크하신 후 수정버튼을 누르시면 탈퇴신청이 접수됩니다.
					(탈퇴 시  with 서비스를 이용하실 수 없으며 해당 아이디로 재 가입이 불가능 합니다.)
            		</td>
            	</tr>
            </table>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
$('.joinInput').keyup(function(){
    var pass1 = $("#pw1").val();
    var pass2 = $("#pw2").val();

    if(pass1 != "" || pass2 != ""){
        if(pass1 == pass2){
            $("#checkPw").html('일치');
            $("#checkPw").attr('color','blue');
        }else{
            $("#checkPw").html('불일치');
            $("#checkPw").attr('color','red');
        }
    }
})
</script>
</html>