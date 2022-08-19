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
	       <table>
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
				<td>
				<c:if test="${file ne null}">
				<img src="./resources/certificate/${file}" width="500px"/>
				</c:if>
				</td>
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
				<td><c:if test="${dto.hide eq 0}">X</c:if></td>
				<td><c:if test="${dto.hide eq 1}">O</c:if></td>
			</tr>
		</table>
		<c:choose>
		<c:when test="${dto.certficate_chk eq 0}"><input type="submit" value="인증완료"></c:when>
		<c:when test="${dto.certficate_chk eq 1}"><input type="hidden"></c:when>
		</c:choose>
		<input type="button" onclick="location.href='userList.go'" value="돌아가기"/>
		</form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
		
	
</script>
</html>