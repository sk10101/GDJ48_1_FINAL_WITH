<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="favicon" href="./resources/images/with_favicon.ico">
<title>With</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
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

.content-top {
	display: inline-block;
	width: 100%;
	min-height: 300px;
}

.content-top .collage {
	position: absolute;
	left: 50%;
	top: 150px;
	color: #fff;
	font-size: 25px;
	padding: 10px 30px;
	background-color: #2962ff;
	border-radius: 10px;
}

.content-wrap {
	max-width: 1200px;
	width: 100%;
	margin: 0 auto;
}

.content-top .score {
	color: rgb(103, 103, 103);
	font-size: 18px;
	text-align: center;
	font-weight: bold;
}

.content-top .star {
	display: inline-block;
	1margin-left: 436.578px;
	margin-top: 15px;
	transition: all 0.3s ease;
}

.content-top .star a img {
	width: 30px;
}

.content-top .star:hover {
	transform: scale(1.1);
}

/* 양수빈 CSS 작업[삭제 해도 됨] */
.myinfo th, td {
	border: 1px solid #000000;
	padding: 8px;
}

.myinfo th {
	background-color: #2962ff;
	color: #ffffff;
}

hr {
	color: #C6C6C6;
	margin-left: 100px;
	width: 800px;
}

.content p {
	color: rgb(103, 103, 103);
	font-size: 18px;
	text-align: center;
	font-weight: bold;
}

button {
	margin-left: 800px;
	width: 100px;
	height: 30px;
}

.star {
	position: relative;
	font-size: 2rem;
	color: #ddd;
}

.star input {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	opacity: 0;
	cursor: pointer;
}

.star span {
	width: 0;
	position: absolute;
	left: 0;
	color: yellow;
	overflow: hidden;
	pointer-events: none;
}
</style>
<body>
	<jsp:include page="../commons/header.jsp" />
	<div class="content-wrap">
		<c:choose>
			<c:when test="${sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar4.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar4.jsp"/>
			</c:when>
		</c:choose>
		<div class="content">
			<!-- 여기에서 작업 시작하세요 -->
			<div class="content-top">
				<span class="collage">${mblist.university_idx}</span> <br>
				<br><br><br><br><br><br>
				<p class="score">내 평점</p>
				<div class="star" style="margin-left : 420px;">
                    <td>
                    	<c:forEach var="i" begin="1" end="5">
							<c:if test="${mblist.avg_allAvg >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
							<c:if test="${mblist.avg_allAvg < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
						</c:forEach>
					</td>
                </div>
				<br><br>
				<p class="score">${mblist.avg_allAvg}</p>
			</div>
			<table class="myinfo" style="margin-left: 180px;">
				<tr>
					<th>친절함</th>
					<td><c:forEach var="i" begin="1" end="5">
							<c:if test="${mblist.avg_kindInt >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
							<c:if test="${mblist.avg_kindInt < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
						</c:forEach>		
					</td>
					<td>${mblist.avg_kindFloat}</td>
				</tr>
				<tr>
					<th>응답속도</th>
					<td><c:forEach var="i" begin="1" end="5">
							<c:if test="${mblist.avg_answerInt >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
							<c:if test="${mblist.avg_answerInt < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
						</c:forEach>
					</td>
					<td>${mblist.avg_answerFloat}</td>
				</tr>
				<tr>
					<th>시간약속</th>
					<td><c:forEach var="i" begin="1" end="5">
							<c:if test="${mblist.avg_timeInt >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
							<c:if test="${mblist.avg_timeInt < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
						</c:forEach>
					</td>
					<td>${mblist.avg_timeFloat}</td>
				</tr>
			</table>
			<br><br>
			<p>
				<a href="/mannerDetail.go">
				<img src="./resources/images/people.png" alt="people"
					style="width: 30px; margin-left: 20px;">${mblist.manner_cnt}
				</a>
			</p>
			<br><br><hr><br><br>
			<p>내정보</p>
				<br><br>
            
			<form action="/mbUpdate.go" method="POST">
            <table class="myinfo" style="margin-left:180px;">
            	<tr>
            		<th>ID</th>
            		<td>${mblist.member_id}</td>
            	</tr>
            	<tr>
            		<th>이름</th>
            		<td>${mblist.name}</td>
            	</tr>
            	<tr>
            		<th>성별</th>
            		<td>${mblist.gender}</td>
            	</tr>
            	<tr>
            		<th>대학교</th>
            		<td>${mblist.university_idx}</td>
            	</tr>
            	<tr>
            		<th>연락처</th>
            		<td>${mblist.phone}</td>
            	</tr>
            	<tr>
            		<th>이메일</th>
            		<td>${mblist.email}</td>
            	</tr>
            </table>
            <br><br>
            <!-- <button onclick="location.href='/mbUpdate.go'">수정</button> --><button>수정</button>
			</form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp" />
</body>
<script>
const drawStar = (target) => {
    document.querySelector(`.star span`).style.width = `${target.value * 10}%`;
  }
</script>
</html>