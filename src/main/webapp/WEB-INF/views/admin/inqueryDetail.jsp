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
	
	.manegerinfo th, td {
		border: 1px solid #000000;
		padding: 8px;
		text-align: center;
	}
	
	.manegerinfo td{
		width: 300px;
	}
	
	.manegerinfo th {
		background-color: #2962ff;
		color: #ffffff;
	}
	.container {
    	text-align: center;
    }
</style>
<body>
	<jsp:include page="../commons/adminHeader.jsp"/>
	<div class="content-wrap">
	   <c:choose>
			<c:when test="${sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar7.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar7.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     	<table class="myinfo" style="margin-left:180px;">
	            	<tr>
	            		<th>작성자</th>
	            		<td>${map.member_id}</td>
	            	</tr>
	            	<tr>
	            		<th>제목</th>
	            		<td>${map.subject}</td>
	            	</tr>
	            	<tr>
	            		<th>작성일</th>
	            		<td>${map.inquery_date}</td>
	            	</tr>
	            	<tr>
	            		<th>내용</th>
	            		<td>${map.inquery_content}</td>
	            	</tr>
	        </table>
	        <br><br><br>
	        <form action="adminInqueryUpdate" method="POST">
	        	<table class="myinfo" style="margin-left:180px;">
	            	<tr>
	            		<th>처리한 관리자</th>
	            		<td>
	            			<input type="hidden" name="inquery_idx" value="${page}"/>
	            			<input type="text" name="inquery_admin" value="${sessionScope.loginId}" readonly/>
	            		</td>
	            	</tr>
	            	<tr>
	            		<th>답변내용</th>
	            		<td><input type="text" name="answer_content" placeholder="150자 이내" style="width : 300px; height : 300px;"/></td>
	            	</tr>
	            	<tr>
	            		<th>작성일</th>
	            		<td><input type="date" name="date"/></td>
	            	</tr>
	            	<tr>
	            		<th>처리상태</th>
	            		<td>
	            			<select name="status" size="1">
								<option value="미처리">미처리</option>
								<option value="처리중">처리중</option>
								<option value="처리완료">처리완료</option>
							</select>
	            		</td>
	            	</tr>
	        	</table>
	        	<input type="button" value="돌아가기" onclick="location.href='/admininqueryList.go'"/>
	        	<input type="submit" value="답변하기"/>
	        </form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>