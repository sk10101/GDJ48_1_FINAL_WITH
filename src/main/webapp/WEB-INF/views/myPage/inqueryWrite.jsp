<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./resources/js/jquery.twbsPagination.js"></script>
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
		text-align: center;
	}
	
	.myinfo th {
		background-color: #2962ff;
		color: #ffffff;
	}
	.container {
    	text-align: center;
    }
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar7.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <form action="inqueryWrite" method="POST">
		       <table class="myinfo" style="margin-left:180px;">
	            	<tr>
	            		<th>제목</th>
	            		<td><input style="width : 400px;" type="text" name="subject" placeholder="50자 이내"/></td>
	            	</tr>
	            	<tr>
	            		<th>내용</th>
	            		<td><input style="width : 400px; height: 400px;" type="text" name="inquery_content" placeholder="500자 이내"/></td>
	            	</tr>
	            </table>
	           	<input type="hidden" name="member_id" value="${sessionScope.loginId}"/>
	            <input type="submit" value="저장"/>
	            <input type="button" onclick="location.href='/inqueryList?page=1'" value="돌아가기"/>
            </form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>