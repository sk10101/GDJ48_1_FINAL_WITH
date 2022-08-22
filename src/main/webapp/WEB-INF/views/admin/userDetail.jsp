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
    
   	#main-table {
   		min-width: 600px;
    	color: rgb(88, 88, 88);
    	margin: 0 auto;
    	padding: 30px 50px;
    	box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    	border-radius: 20px;
    	font-size: 16px;
	}
	
	#main-table th,
	#main-table td {
		padding: 15px 10px;
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
	   	<form action="pass?member_id=${dto.member_id}" method="post">
	       <table id="main-table">
			<tr>
				<th>회원 ID</th>
				<td>${dto.member_id}</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${dto.name}</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>${dto.gender}</td>
			</tr>
			<tr>
				<th>대학교</th>
				<td>${dto.university_name}</td>
			</tr>
			<tr>
				<th>사진</th>
				<c:if test="${file ne null}">
					<td>
						<img src="./resources/certificate/${file}" width="400px"/>
					</td>
				</c:if>
				<c:if test="${file eq null}">
					<td style="color: #ef5350;">업로드된 사진이 없습니다.</td>
				</c:if>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${dto.email}</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>${dto.phone}</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td>${dto.reg_date}</td>
			</tr>
			<tr>
				<th>회원상태</th>
				<td>${dto.member_status}</td>
			</tr>
			<tr>
				<th>탈퇴처리여부</th>
				<c:if test="${dto.hide eq 0}">
					<td>
						<img src="./resources/images/no.png" alt="no" style="position: relative; top: 3px; width: 18px;">
					</td>
				</c:if>
				<c:if test="${dto.hide eq 1}">
					<td>
						<img src="./resources/images/yes.png" alt="yes" style="position: relative; top: 3px; width: 25px;">
					</td>
				</c:if>
			</tr>
			<tr>
				<th colspan="2" style="padding-top: 50px;">
					<c:choose>
					<c:when test="${dto.certficate_chk eq 0}"><input class="btu" type="submit" value="인증완료"></c:when>
					<c:when test="${dto.certficate_chk eq 1}"><input class="btu" type="hidden"></c:when>
					</c:choose>
					<input class="btu" type="button" onclick="location.href='userList.go'" value="돌아가기"/>
				</th>
			</tr>
		</table>
		</form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
		
	
</script>
</html>