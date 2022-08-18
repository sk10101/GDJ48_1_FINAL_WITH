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
	<jsp:include page="../commons/adminHeader.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/adminSideBar6.jsp"/>
	   <div class="content">
	   	<form action="update.do">
	   	<input type="hidden" name="penalty_idx" value="${params}"/>
		   	<table>
		       	<tr>
		       		<th>회원ID</th>
		       		<td>${list.member_id}</td>
		       	</tr>
		       	<tr>
		       		<th>처리 사유</th>
		       		<td>${list.penalty_reason}</td>
		       	</tr>
		       	<tr>
		       		<th>제한한 관리자ID</th>
		       		<td>${list.penalty_admin}</td>
		       	</tr>
		       	<tr>
		       		<th>제한기간</th>
		       		<td>${list.penalty_date}~${list.penalty_end}</td>
		       	</tr>
		       	<tr>
		       		<th>이용제한 취소 관리자</th>
		       		<td>${sessionScope.loginId}</td>
		       	</tr>
		       	<tr>
		       		<th>이용제한 해제</th>
		       		<td><c:if test="${list.cancel eq 0}"><input id="chkbox" type="checkbox"/>제한 해제</c:if></td>
		       	</tr>
		       	<tr>
		       		<th>해제 사유</th>
					<td><c:if test="${list.pntCancel_reason eq null}"><input type="text" name="pntCancel_reason" required/></c:if></td>
		       		<td><c:if test="${list.pntCancel_reason ne null}">${list.pntCancel_reason}</c:if></td>
		       	</tr>
		    </table>
			    <input type="button" value="돌아가기" onclick="location.href='penaltyList.go'"/>
			    <input type="submit" name="send" value="처리"/>
	    </form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
if(${list.pntCancel_reason ne null}){
	$('input[name=send]').prop('type', "hidden");
}
</script>
</html>