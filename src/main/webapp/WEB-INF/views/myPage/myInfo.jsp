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
		width: 100%;
		margin: 0 auto;
		color: rgb(88, 88, 88);
	}
	
    #main-table .collage {
        color: #fff;
        font-size: 25px;
        padding: 10px 30px;
        /* background-color: #2962ff; */
        background-image: linear-gradient(#2962ff, #2f9df7);
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
        border-radius: 10px;
        font-weight: normal;
    }
    
    #main-table tr:first-child th {
		padding-bottom: 30px;
	}
    
    #main-table th,
    #main-table td {
    	padding: 15px 10px;
    }
    
    #main-table td {
    	font-size: 16px;
    }
    
    #main-table th a {
    	color: rgb(88, 88, 88);
    }
    
    #mod-button {
   		margin-top: 20px;
		background-color: #537ef4;
		color: #eaeaea;
		border-radius: 5px;
		border: none;
		padding: 10px 20px;
		font-size: 16px;
    }
    
    #bottom-table {
		width: 70%;	
		margin: 0 auto;
		color: rgb(88, 88, 88);
		box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
		padding: 10px 20px;
		border-radius: 15px;
    }
    
    #bottom-table th,
    #bottom-table td {
    	padding: 15px 10px;
    }
    
    #bottom-table td {
    	font-size: 16px;
    }
    

/* .content-top {
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
} */
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
				<table id="main-table">
					<tr>
						<th colspan="3">
							<span class="collage">${mblist.university_idx}</span>
						</th>
					</tr>
					<tr>		
						<th class="score" colspan="3" style="padding-bottom: 0; font-size: 18px;">내 평점</th>
					</tr>
					<tr>	
	                    <th colspan="3">
							<div class="star">	
		                    	<c:forEach var="i" begin="1" end="5">
									<c:if test="${mblist.avg_allAvg >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
									<c:if test="${mblist.avg_allAvg < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
								</c:forEach>
			                </div>
						</th>
		            </tr>
		            <tr>
		            	<th class="score" colspan="3" style="padding-top: 0; padding-bottom: 60px; font-size: 18px;">${mblist.avg_allAvg}</th>
		            </tr>    
					<tr>
						<th style="text-align: right; width: 100px;">친절함</th>
						<th style="width: 100px;">
							<c:forEach var="i" begin="1" end="5">
								<c:if test="${mblist.avg_kindInt >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
								<c:if test="${mblist.avg_kindInt < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
							</c:forEach>		
						</th>	
						<td>${mblist.avg_kindFloat}</td>
					</tr>
					<tr>
						<th style="text-align: right; width: 100px;">응답속도</th>
						<th>
							<c:forEach var="i" begin="1" end="5">
								<c:if test="${mblist.avg_answerInt >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
								<c:if test="${mblist.avg_answerInt < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
							</c:forEach>
						</th>
						<td style="width: 100px;">${mblist.avg_answerFloat}</td>
					</tr>
					<tr>
						<th style="text-align: right; width: 100px;">시간약속</th>
						<th>
							<c:forEach var="i" begin="1" end="5">
								<c:if test="${mblist.avg_timeInt >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
								<c:if test="${mblist.avg_timeInt < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
							</c:forEach>
						</th>
						<td>${mblist.avg_timeFloat}</td>
					</tr>
					<c:if test="${mblist.manner_cnt > 0}">
						<tr>
							<th colspan="3">
								<a href="/mannerDetail.go">
									<img src="./resources/images/people.png" alt="people" style="position:relative; width: 30px; top: 8px; right: 10px;"> ${mblist.manner_cnt}
								</a>
							</th>
						</tr>
					</c:if>
					<c:if test="${mblist.manner_cnt eq 0}">
						<tr>
							<td colspan="3" style="text-align: center; color: #ef5350;">아직까지 받은 평가가 없습니다.</td>
						</tr>
					</c:if>
					<tr>
						<td colspan="3" style="padding: 50px 0;"><hr></td>
					</tr>
					<tr>
						<th colspan="3" style="font-size: 18px; padding-bottom: 50px;">내정보</th>
					</tr>
					</table>
					
					<table id="bottom-table">
					<form action="/mbUpdate.go" method="POST">
	            	<tr>
	            		<th>ID</th>
	            		<td colspan="2">${mblist.member_id}</td>
	            	</tr>
	            	<tr>
	            		<th>이름</th>
	            		<td colspan="2">${mblist.name}</td>
	            	</tr>
	            	<tr>
	            		<th>성별</th>
	            		<td colspan="2">${mblist.gender}</td>
	            	</tr>
	            	<tr>
	            		<th>대학교</th>
	            		<td colspan="2">${mblist.university_idx}</td>
	            	</tr>
	            	<tr>
	            		<th>연락처</th>
	            		<td colspan="2">${mblist.phone}</td>
	            	</tr>
	            	<tr>
	            		<th>이메일</th>
	            		<td colspan="2">${mblist.email}</td>
	            	</tr>
	            	<tr>
	            		<td colspan="3" style="text-align: right;"><!-- <button onclick="location.href='/mbUpdate.go'">수정</button> --><button id="mod-button">수정</button></td>
	            	</tr>
					</form>
					</table>
	   	</div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}
const drawStar = (target) => {
    document.querySelector(`.star span`).style.width = `${target.value * 10}%`;
  }
</script>
</html>