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
		min-height: 100vh;
		/* background-color: #f4f4f4; */
		background-color: rgb(249, 249, 249);
		padding: 60px 100px;
	}
	
	.myinfo {
    	color: rgb(88, 88, 88);
    	margin: 0 auto;
    	padding: 30px 50px;
    	box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    	border-radius: 20px;
    	font-size: 16px;
	}
	
	.myinfo th,
	.myinfo td {
		padding: 10px 10px;
	}
	
	.myinfo input[type='text'],
	.myinfo input[type='password'] {
		padding: 3px 10px;
		border-radius: 5px;
		border: 0.4px solid gray;
		font-size: 16px;
	}
	
	.btu {
		background-color: #537ef4;
		color: #eaeaea;
		border-radius: 5px;
		border: none;
		padding: 7px 20px;
		font-size: 16px;
		margin: 0 10px;
	}

</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <c:choose>
			<c:when test="${sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar4.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar4.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     <form action="mbUpdate.do" method="POST" enctype="multipart/form-data">
	     <table class="myinfo">
            	<tr>
            		<th>ID</th>
            		<td>${mblist.member_id}</td>
            	</tr>
            	<tr>
            		<th>PW</th>
            		<td><input id="pw1" type="password" required/> &nbsp;&nbsp;&nbsp; ※ 8 ~ 15자 입력, 비밀번호 수정시에만 작성</td>
            	</tr>
            	<tr>
            		<th>PW 확인</th>
            		<td><input id="member_pw" name="member_pw" type="password" required/><p id=result></p></td>
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
            		<td><input id="university_idx" name="university_idx" type="button" style="width:100px; height:30px;" value="대학교 찾기"/></td>
            	</tr>
            	<tr>
            		<th>인증서</th>
            		<td><input id="photo_idx" name="photo_idx" type="file"/></td>
            	</tr>
            	<tr>
            		<th>연락처</th>
            		<td><input type="text" id="phone" name="phone" value="${mblist.phone}" required/> &nbsp;&nbsp;&nbsp; ※ '-'를 포함해서 입력</td>
            	</tr>
            	<tr>
            		<th>이메일</th>
            		<td>${mblist.email}</td>
            	</tr>
            	<tr>
            		<th>회원탈퇴 신청</th>
            		<td><input id="hide" name="hide" type="checkbox" value="1"/>&emsp;
            		※ 체크하신 후 수정버튼을 누르시면 탈퇴신청이 접수됩니다.
					(탈퇴 시 with 서비스를 이용하실 수 없으며 해당 아이디로 재 가입이 불가능 합니다.)
            		</td>
            	</tr>
            	<tr>
            		<td colspan="2" style="text-align: right; padding-top: 40px;">
            			<button class="btu">변경</button>
            			<input class="btu" type="button" value="돌아가기" onclick="location.href='/myInfo'"/>
            		</td>
            	</tr>
            </table>
            </form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
$('#member_pw').keyup(function(){
    var pass1 = $("#pw1").val();
    var pass2 = $("#member_pw").val();
	
    if(pass1 != "" || pass2 != ""){
        if(pass1 == pass2){
            $("#result").html('※일치');
            $("#result").css('color','blue');
        }else{
            $("#result").html('※불일치');
            $("#result").css('color','red');
        }
    }
})
</script>
</html>