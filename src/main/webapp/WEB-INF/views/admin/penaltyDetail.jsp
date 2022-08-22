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
        padding: 60px 100px;
    }
    
   	#main-table {
   		min-width: 600px;
    	color: rgb(88, 88, 88);
    	margin: 0 auto;
    	padding: 30px 50px;
    	box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    	border-radius: 20px;
    	font-size: 16px;
	}
	
	#main-table th,
	#main-table td {
		padding: 15px 10px;
	}
	
	.btu {
		background-color: #537ef4;
		color: #eaeaea;
		border-radius: 5px;
		border: none;
		padding: 7px 20px;
		font-size: 16px;
		margin: 0 10px;
	}
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
		<c:choose>
			<c:when test="${sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar6.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar6.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	   	<form action="update.do">
	   	<input type="hidden" name="penalty_idx" value="${params}"/>
		   	<table id="main-table">
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
		       		<td><input id="chkbox" type="checkbox" <c:if test="${list.cancel eq 1}">checked</c:if>> 제한 해제</td>
		       	</tr>
		       	<tr>
		       		<th>해제 사유</th>
					<c:if test="${list.pntCancel_reason eq null}"><td><input type="text" name="pntCancel_reason" required/></td></c:if>
		       		<c:if test="${list.pntCancel_reason ne null}"><td>${list.pntCancel_reason}</td></c:if>
		       	</tr>
		       	<tr>
		       		<th colspan="2" style="padding-top: 50px;">
					    <input class="btu" type="button" value="돌아가기" onclick="location.href='penaltyList.go'"/>
					    <input class="btu" type="submit" name="send" value="처리"/>
		       		</th>
		       	</tr>
		    </table>
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