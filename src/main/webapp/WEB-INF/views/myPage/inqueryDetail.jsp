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
		text-align: center;
	}
	
	.myinfo th {
		background-color: #2962ff;
		color: #ffffff;
	}
	.managerinfo th, td {
		border: 1px solid #000000;
		padding: 8px;
		text-align: center;
	}
	
	.managerinfo th {
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
	       <table class="myinfo" style="margin-left:180px;">
            	<tr>
            		<th>작성자</th>
            		<td>${map.member_id}</td>
            	</tr>
            	<tr>
            		<th>제목</th>
            		<td>
            		<c:choose>
				         <c:when test="${map.status eq '미처리'}">
				        	<input style="width : 300px;" type="text" value="${map.subject}"/>
				         </c:when>
				         <c:otherwise>
				    		<input type="text" value="${map.subject}" readonly/>
				         </c:otherwise>
				      </c:choose>
            		</td>
            	</tr>
            	<tr>
            		<th>작성일</th>
            		<td>${map.inquery_date}</td>
            	</tr>
            	<tr>
            		<th>처리상태</th>
            		<td>${map.status}</td>
            	</tr>
            	<tr>
            		<th>내용</th>
            		<td>
            			<c:choose>
				         <c:when test="${map.status eq '미처리'}">
				        	<input style="width : 300px; height : 200px;" type="text" value="${map.inquery_content}"/>
				         </c:when>
				         <c:otherwise>
				    		<input style="width : 300px; height : 200px;" type="text" value="${map.inquery_content}" readonly/>
				         </c:otherwise>
				      </c:choose>	
            		</td>
            	</tr>
            </table>
            <br><br><br><br><br>
            <table class="manegerinfo" style="margin-left:180px;">
            	<tr>
            		<th>관리자</th>
            		<td>${map.member_id}</td>
            	</tr>
            	<tr>
            		<th>작성일</th>
            		<td>
            		<c:choose>
				         <c:when test="${map.status eq '미처리'}">
				        	<input style="width : 300px;" type="text" value="${map.subject}"/>
				         </c:when>
				         <c:otherwise>
				    		<input type="text" value="${map.subject}" readonly/>
				         </c:otherwise>
				      </c:choose>
            		</td>
            	</tr>
            	<tr>
            		<th>작성일</th>
            		<td>${map.inquery_date}</td>
            	</tr>
            	<tr>
            		<th>처리상태</th>
            		<td>${map.status}</td>
            	</tr>
            </table>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>