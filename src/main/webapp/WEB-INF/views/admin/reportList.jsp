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
	   <jsp:include page="../commons/adminSideBar5.jsp"/>
	   <div class="content">
	       <table>
	       	<thead>
				<tr>
					<th>글번호</th>
					<th>이용서비스</th>		
					<th>신고게시글 제목</th>
					<th>신고자ID</th>
					<th>신고 날짜</th>
					<th>신고 사유</th>
					<th>담당관리자 ID</th>
					<th>처리상태</th>	
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="report">
				<tr>
					<td><a href="reportDetail?member_id=${report.report_idx}">${report.report_idx}</a></td>
					<td>${report.category_id}</td>
					<td>${report.subject}</td>
					<td>${report.reporter_id}</td>
					<td>${report.report_date}</td>
					<td>${report.report_content}</td>
					<td>${report.report_admin}</td>
					<td><c:if test="${report.status eq 1}">Y</c:if></td>
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