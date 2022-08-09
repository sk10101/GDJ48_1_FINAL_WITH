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
</style>
<body>
	<jsp:include page="../commons/adminHeader.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/adminSideBar4.jsp"/>
	   <div class="content">
	    <button onclick="location.href='userList'">일반회원</button>
	   	<button onclick="location.href='adminList'">관리자</button>
				<form action="search.do" method="post">
					<input type="text" name="name" value="관리자ID"/>
					<button>검색</button>
				</form>
		<table>
			<thead>
				<tr>
					<th>관리자 아이디</th>
					<th>이름</th>		
					<th>연락처</th>
					<th>성별</th>	
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="admin">
				<tr>
					<td>${admin.member_id}</td>
					<td>${admin.name}</td>
					<td>${admin.phone}</td>
					<td>${admin.gender}</td>
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