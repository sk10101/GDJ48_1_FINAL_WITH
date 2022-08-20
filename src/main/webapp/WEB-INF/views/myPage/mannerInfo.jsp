<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./resources/js/jquery.twbsPagination.js"></script>
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
        background-color: rgb(249, 249, 249);
        padding: 60px 100px;
    }
    /* 양수빈 CSS 작업[삭제 해도 됨] */
    .myinfo th, td {
	    border: 1px solid #000000;
	    width: 100px;
	    text-align: center;
  	}
  	.myinfo th{
  		background-color : #2962ff;
  		color:#ffffff;
  	}
  	.container {
    	text-align: center;
    }
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
		<c:choose>
			<c:when test="${sessionScope.member_class eq '일반회원' and params.boardName eq '배달게시판'}">
			   <jsp:include page="../commons/memberSideBar1.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '일반회원' and params.boardName eq '택시게시판'}">
			   <jsp:include page="../commons/memberSideBar2.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '일반회원' and params.boardName eq '밥게시판'}">
			   <jsp:include page="../commons/memberSideBar3.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자' and params.boardName eq '배달게시판'}">
				<jsp:include page="../commons/adminSideBar1.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자' and params.boardName eq '택시게시판'}">
				<jsp:include page="../commons/adminSideBar2.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자' and params.boardName eq '밥게시판'}">
				<jsp:include page="../commons/adminSideBar3.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       	<p>${params.member}님의 매너평가 점수</p>
	        <c:if test="${sessionScope.loginId ne params.member}">
	       		<input type="button" value="차단" onclick="location.href='/blockAdd?member=${params.member}&board=${params.board}'"/>
	       	</c:if>	
	     	<table class="myinfo" style="margin-left: 180px;">
				<tr>
					<th>친절함</th>
					<td><c:forEach var="i" begin="1" end="5">
							<c:if test="${params.avg_kindInt >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
							<c:if test="${params.avg_kindInt < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
						</c:forEach>		
					</td>
					<td>${params.avg_kindFloat}</td>
				</tr>
				<tr>
					<th>응답속도</th>
					<td><c:forEach var="i" begin="1" end="5">
							<c:if test="${params.avg_answerInt >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
							<c:if test="${params.avg_answerInt < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
						</c:forEach>
					</td>
					<td>${params.avg_answerFloat}</td>
				</tr>
				<tr>
					<th>시간약속</th>
					<td><c:forEach var="i" begin="1" end="5">
							<c:if test="${params.avg_timeInt >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
							<c:if test="${params.avg_timeInt < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
						</c:forEach>
					</td>
					<td>${params.avg_timeFloat}</td>
				</tr>
			</table>
			<br><br>
			<p>
				<img src="./resources/images/people.png" alt="people" style="width: 30px; margin-left: 20px;">${params.manner_cnt}
			</p>
			<c:choose>
				<c:when test="${params.boardName eq '배달게시판'}">
					<input type="button" value="확인" onclick="location.href='/deliDetail?board_idx=${params.board}'"/>
				</c:when>
				<c:when test="${params.boardName eq '택시게시판'}">
					<input type="button" value="확인" onclick="location.href='/taxiDetail?board_idx=${params.board}'"/>
				</c:when>
				<c:when test="${params.boardName eq '밥게시판'}">
					<input type="button" value="확인" onclick="location.href='/mealDetail?board_idx=${params.board}'"/>
				</c:when>
			</c:choose>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script></script>
</html>