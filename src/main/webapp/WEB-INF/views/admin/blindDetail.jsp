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
	
	input[type='text'] {
		width: 100%;
	}
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
		<c:choose>
			<c:when test="${sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar7.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar8.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     <form method="post" action="/blind/updateList">
	     <input type="hidden" name="board_idx" id="board_idx" value="${info.board_idx}">
	     	<table id="main-table">
	     		<tr>
		     		<th>블라인드 사유</th>
		     		<td>${info.blind_reason}</td>
	     		</tr>
	     		<tr>
		     		<th>블라인드 해제 관리자</th>
		     		<c:if test="${info.blindCancel_id ne null}">
		     			<td>${info.blindCancel_id}</td>
		     		</c:if>	
		     		<c:if test="${info.blindCancel_id eq null}">
		     			<td> - </td>
		     		</c:if>	
	     		</tr>
	     		<tr>
		     		<th>블라인드 해제</th>  <!-- db에 저장된 cancel 값이 1이면 체크로 보이게하고,0이면 체크박스 체크 안되어있게하기-->
		     		<td>
		     			<input type="checkbox" name="cancel" id="cancel" value="1" <c:if test="${info.cancel==1}">checked</c:if>>
		     		</td>
	     		</tr>
	     		<tr>
		     		<th>해제 사유</th>
		     		<td>
		     			<input type="text" name="blindCancel_reason" id="blindCancel_reason" value="${info.blindCancel_reason}" required="required"/>
		     		</td>
	     		</tr>
	     		<tr>
	     			<th colspan="2" style="padding-top: 50px;">
				     	<input class="btu" type="submit" value="해제">
				     	<input class="btu" type="button" value="돌아가기" onclick="location.href='blindListGo'"/>
			     	</th>
	     		</tr>
	     	</table>
	     </form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>