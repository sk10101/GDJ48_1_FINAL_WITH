<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"> -->
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
    
    .myinfo {
    	color: rgb(88, 88, 88);
    	margin: 0 auto;
    	padding: 30px 50px;
    	box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
    	border-radius: 20px;
    }
    
    .myinfo th,
    .myinfo td {
    	padding: 15px 15px;
    }
    
    .myinfo td {
    	font-size: 18px;
    }
    
   	.bottom-button {
   		margin-top: 40px;
		background-color: #537ef4;
		color: #eaeaea;
		border-radius: 5px;
		border: none;
		padding: 10px 20px;
		font-size: 14px;
	}
	
	#black {
		padding: 5px 20px;
		background-color: #ff6f00;
		color: #eaeaea;
		border: none;
		border-radius: 5px;
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
	     	<table class="myinfo">
	     		<tr>
	     			<td>	     	
				        <c:if test="${sessionScope.loginId ne params.member}">
				       		<input id="black" type="button" value="차단" onclick="location.href='/blockAdd?member=${params.member}&board=${params.board}'"/>
				       	</c:if>	
				    </td>
				</tr>       	
	     		<tr>
		       		<th colspan="3"><h2 style="margin-bottom: 40px;">${params.member}님의 매너평가 점수</h2></th>
		       	</tr>	
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
				<c:if test="${params.manner_cnt > 0}">
				<tr>
					<th colspan="3">
						<img src="./resources/images/people.png" alt="people" style="position:relative; width: 30px; top: 8px; right: 10px;"> ${params.manner_cnt}		
					</th>
				</tr>
				</c:if>
				<c:if test="${params.manner_cnt eq 0}">
					<tr>
						<td colspan="3" style="text-align: center; color: #ef5350;">아직까지 받은 평가가 없습니다.</td>
					</tr>
				</c:if>
				<tr>
					<th colspan="3">
						<c:choose>
							<c:when test="${params.boardName eq '배달게시판'}">
								<input class="bottom-button" type="button" value="돌아가기" onclick="location.href='/deliDetail?board_idx=${params.board}'"/>
							</c:when>
							<c:when test="${params.boardName eq '택시게시판'}">
								<input class="bottom-button" type="button" value="돌아가기" onclick="location.href='/taxiDetail?board_idx=${params.board}'"/>
							</c:when>
							<c:when test="${params.boardName eq '밥게시판'}">
								<input class="bottom-button" type="button" value="돌아가기" onclick="location.href='/mealDetail?board_idx=${params.board}'"/>
							</c:when>
						</c:choose>
					</th>	
				</tr>
			</table>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script></script>
</html>