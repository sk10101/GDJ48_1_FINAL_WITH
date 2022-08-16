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
	   <jsp:include page="../commons/adminSideBar8.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     <form method="post" action="/blind/updateList">
	     <input type="hidden" name="board_idx" id="board_idx" value="${info.board_idx}">
	     	<table>
	     		<tr>
	     		<td>블라인드 사유 : </td>
	     		<td>${info.blind_reason}</td>
	     		</tr>
	     		<tr>
	     		<td> 블라인드 해제 관리자 : </td>
	     		<td>${info.blindCancel_id}</td>
	     		</tr>
	     		<tr>
	     		<td> 블라인드 해제 : </td>
	     		<td><input type="checkbox" name="cancel" id="cancel" value="1" <c:if test="${info.cancel==1}">checked</c:if>></td>
	     		</tr>
	     		<tr>
	     		<td>해제 사유 : </td>
	     		<td><input name="blindCancel_reason" id="blindCancel_reason" value="${info.blindCancel_reason}" ></td>
	     		</tr>
	     	</table>
	     	<input type="submit" value="해제">
	     	<input type="button" value="돌아가기" onclick="location.href='blindListGo'"/>
	     </form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>