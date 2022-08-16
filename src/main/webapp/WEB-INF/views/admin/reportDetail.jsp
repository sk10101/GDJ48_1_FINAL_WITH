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
	   	<form action="reportcom" method="get">
			<table>
			<input type="hidden" id="member_id" name="member_id" value="${info.member_id}"/>
			<input type="hidden" id="report_idx" name="report_idx" value="${info.report_idx}"/>
		       	<tr>
		       		<th>회원ID</th>
		       		<td>${info.member_id}</td>
		       	</tr>
		       	<tr>
		       		<th>이용서비스</th>
		       		<td>${info.category_id}</td>
		       	</tr>
		       	<tr>
		       		<th>글번호</th>
		       		<td>${info.board_idx}</td>
		       	</tr>
		       	<tr>
		       		<th>제목</th>
		       		<td>${info.subject}</td>
		       	</tr>
		       	<tr>
		       		<th>신고사유</th>
		       		<td>${info.report_content}</td>
		       	</tr>
		       	<tr>
		       		<th>처리한 관리자ID</th>
		       		<td>${info.report_admin}</td>
		       	</tr>
		       	<tr>
		       		<th>처리날짜</th>
		       		<td>${penaltyinfo.penalty_date}</td>
		       	</tr>
		       	<tr>
		       		<th>처리사유</th>
		       		<c:if test="${info.report_reason eq null}"><td><input type="text" id="report_reason" name="report_reason"/></td></c:if>
		       		<c:if test="${info.report_reason ne null}"><td>${info.report_reason}</td></c:if>
		       	</tr>
		       	<tr>
		       		<th>처리상태</th>
		       		<c:if test="${info.status eq '처리완료'}"><td>${info.status}</td></c:if>
		       		<c:if test="${info.status ne '처리완료'}">
			       		<td>
			       			<select name="status" id="status" onchange="selectBoxChange(this.value);">
		                   		<option value="미처리" selected="selected">미처리</option>
		                   		<option value="처리완료">처리완료</option>
		              		</select>
	               		</td>
               		</c:if>
		       	</tr>
		       	<tr>
		       		<th>제한종료날짜</th>
		       		<c:if test="${penaltyinfo.penalty_end eq null}"><td><input type="date" id="penalty_end" name="penalty_end"/></td></c:if>
		       		<c:if test="${penaltyinfo.penalty_end ne null}"><td>${penaltyinfo.penalty_end}</td></c:if>
		       	</tr>
	       </table>
		       <input type="button" value="돌아가기" onclick="location.href='reportList.go'"/>
		       <input type="submit" value="처리"/>
	       </form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>