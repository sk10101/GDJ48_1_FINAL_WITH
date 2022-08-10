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
    
    #gender {
    	width: 30px;
    }
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar2.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <table>
	       		<tr>
	       			<input type="hidden" name="${list.board_idx}"/>
	       			<th>${list.subject}</th>
	       		</tr>
	       		<tr>
	       			<th>출발지 : </th>
	       			<td>${list.appoint_place}</td>
	       			<th>작성자 : </th>
	       			<td>${list.member_id}</td>
	       		</tr>
	       		<tr>
	       			<th>도착지 : </th>
	       			<td>${list.destination}</td>
	       			<th>작성일 : </th>
	       			<td>${list.write_date}</td>
	       		</tr>
	       		<tr>
	       			<th>마감시간 : </th>
	       			<td>${list.deadline}</td>
	       			<th>조회수 : </th>
	       			<td>${list.hit}</td>
	       		</tr>
	       		<tr>
	       			<th>인원 : </th>
	       			<td>${count} / ${list.member_cnt}</td>
	       		</tr>
	       		<tr>
					<c:if test="${list.recruit_end eq 0}">
						<td colspan="4" style="text-align: right">
							<span style="padding: 3px 10px; border-radius: 5px; background-color: #2962ff">모집중</span>
						</td>
					</c:if>
					<c:if test="${list.recruit_end eq 1}">
						<td colspan="4" style="text-align: right">
							<span style="padding: 3px 10px; border-radius: 5px; background-color: #e53935">마감</span>
						</td>
					</c:if>
	       		</tr>
	       		<tr>
	       			<th>
	       				<img id="gender" src="./resources/images/gender.png" alt="gender"/> ${list.gender}
	       			</th>
	       			<td colspan="3" style="text-align: right"><input type="button" value="신고" onclick="location.href='/report?idx=${list.board_idx}'"/></td>
	       		</tr>
	       </table>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>