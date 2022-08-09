<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<!--
	<c:choose>
		<c:when test="회원등급이 일반회원일때">
		   	<jsp:include page="../commons/header.jsp"/>
		</c:when>
		<c:when test="회원등급이 관리자일때">
			<jsp:include page="../commons/adminHeader.jsp"/>
		</c:when>
	</c:choose>
	  -->	
	<div class="content-wrap">
	<jsp:include page="../commons/memberSideBar3.jsp"/>
	<!-- 
	<c:choose>
		<c:when test="회원등급이 일반회원일때">
		   <jsp:include page="../commons/memberSideBar1.jsp"/>
		</c:when>
		<c:when test="회원등급이 관리자일때">
			<jsp:include page="../commons/adminSideBar1.jsp"/>
		</c:when>
	</c:choose>
	 -->
	   <div class="content">
	       <button onclick="location.href='MealWrite.go'">글 쓰기</button> 
	<table>
		<thead>
			<tr>
				<th>글번호</th>
				<th>작성자</th>		
				<th>카테코리 이름</th>
				<th>조회수</th>
				<th>작성일</th>	
				<th>제목</th>
				<th>마감시간</th>
				<th>약속장소</th>
				<th>모집인원</th>
				<th>마감여부</th>
				<th>삭제여부</th>	
			</tr>
		</thead>
		<tbody>
		<c:if test="${list.size() == 0}">
			<tr><td colspan="6">등록된 글이 없습니다.</td></tr>
		</c:if>
		<c:forEach items="${list}" var="meal">
			<tr>
				<td>${meal.board_idx}</td>
				<td>${meal.member_id}</td>
				<td>${meal.category_id}</td>
				<td>${meal.hit}</td>
				<td>${meal.write_date}</td>
				<td><a href="detail?board_idx=${meal.board_idx}">${meal.subject}</a></td>
				<td>${meal.deadline}</td>
				<td>${meal.appoint_place}</td>
				<td>${meal.	member_cnt}</td>
				<td><c:if test="${meal.recruit_end eq 0}">모집중</c:if></td>
				<td><c:if test="${meal.recruit_end eq 1}">마감</c:if></td>
				<td><a href="delete.do?board_idx=${meal.board_idx}">삭제</a></td>
			</tr>
		
		</c:forEach>
		</tbody>
	</table>
	       
	     
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>