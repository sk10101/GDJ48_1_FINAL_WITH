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
	
	.myinfo th {
		background-color: #2962ff;
		color: #ffffff;
	}
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar6.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     <table class="myinfo" style="margin-left:180px;">
            	<tr>
            		<th>차단 대상 ID</th>
            		<th>차단 해제</th>
            	</tr>
            	<tr>
            	
            	</tr>
            </table>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>