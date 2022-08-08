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
    
    table, td {
    	border : 1px solid black;
    }
    
    a {
    	text-decoration : none;
    	color : black;
    }
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<!--
	<c:choose>
		<c:when test="회원등급이 일반회원일때">
		   	<jsp:include page="../commons/header.jsp"/>
		</c:when>
		<c:when test="회원등급이 관리자일때">
			<jsp:include page="../commons/adminHeader.jsp"/>
		</c:when>
	</c:choose>
	  -->	
	<div class="content-wrap">
	<jsp:include page="../commons/memberSideBar1.jsp"/>
	<!-- 
	<c:choose>
		<c:when test="회원등급이 일반회원일때">
		   <jsp:include page="../commons/memberSideBar1.jsp"/>
		</c:when>
		<c:when test="회원등급이 관리자일때">
			<jsp:include page="../commons/adminSideBar1.jsp"/>
		</c:when>
	</c:choose>
	 -->
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <button onclick="location.href='write.go'">글쓰기</button>
	     	<table class="bbs">
			<c:if test="${list.size() eq 0}">
				<tr><td colspan="5">등록된 글이 없습니다.</td></tr>			
			</c:if>
			<c:forEach items="${deliList}" var="bbs">
				<tr>
					<td colspan="2"><a href="deliDetail?board_idx=${bbs.board_idx}">${bbs.subject}</a></td>
				</tr>
				<tr>
					<td>약속장소 : ${bbs.appoint_place}</td>
					<td>작성자 : ${bbs.member_id}</td>
				</tr>
				<tr>
					<td>모인금액 : (모은금액) / ${bbs.min_delivery}</td>
					<td>작성일 : ${bbs.write_date}</td>
				</tr>
				<tr>
					<td>마감시간 : ${bbs.deadline}</td>
					<td>조회수 : ${bbs.hit}</td>
				</tr>
				<tr>
					<td>인원 : (현재 인원) / ${bbs.member_cnt}</td>
					<c:if test="${bbs.recruit_end eq 0}"><td><span style="border:1px solid black; background-color:#2962ff;">모집중</span></td></c:if>
					<c:if test="${bbs.recruit_end eq 1}"><td><span style="border:1px solid black; background-color:red;">마감</span></td></c:if>
				</tr>
			</c:forEach>
			</table>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>

</script>
</html>