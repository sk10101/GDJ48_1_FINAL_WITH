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
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar7.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <table class="myinfo" style="margin-left:180px;">
            	<tr>
            		<th>작성자</th>
            		<td>${idx}</td>
            	</tr>
            	<tr>
            		<th>제목</th>
            		<td>${list.subject}</td>
            	</tr>
            	<tr>
            		<th>작성일</th>
            		<td>${list.inquery_date}</td>
            	</tr>
            	<tr>
            		<th>처리상태</th>
            		<td>${list.status}</td>
            	</tr>
            	<tr>
            		<th>내용</th>
            		<td>${list.inquery_content}</td>
            	</tr>
            </table>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>