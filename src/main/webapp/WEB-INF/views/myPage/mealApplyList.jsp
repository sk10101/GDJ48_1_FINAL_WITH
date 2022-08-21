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
<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script>
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
    
   	#top-table {
		margin-bottom: 30px;
		color: #eaeaea;
		font-size: 18px;
		width: 50%;
	}
	
	#top-table th {
		padding: 6px 20px;
		font-weight: normal;
		background-color: #537ef4;
		border-radius: 10px;
		text-align: left;
	}
	
	#main-table {
  		width: 100%;
    	color: rgb(88, 88, 88);
    	margin: 0 auto;
    	padding: 30px 50px;
    	box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    	border-radius: 20px;
    	font-size: 16px;
    	border-collapse: collapse;
    	background-color: #fff;
    	/* table-layout: fixed; */
	}
	
	#main-table th,
	#main-table td {
		padding: 10px 10px;
		text-align: center;
	}
	
	#main-table td {
		border-top: 5px solid rgb(249, 249, 249);
	}

	#main-table tr:first-child th {
		background-color: rgb(249, 249, 249);
		padding-top: 15px;
	}
	
	#main-table tr:first-child th:first-child {
		border-radius: 20px 0 0 0;
	}
	
	#main-table tr:first-child th:last-child {
		border-radius: 0 20px 0 0;
	}
	
	#main-table a {
		color: #537ef4;
	}
	
	.common-button {
    	padding: 5px 10px;
    	border-radius: 5px;
    	border: none;
    	color: #eaeaea;
    	font-size: 14px;
	}
	
	.yes-button {
		background-color: #537ef4;
	}
	
	.no-button {
		background-color: #ff6f00;
	}
    
    
   	/* 페이지네이션 부트스트랩 css 제거 후 직접 수정 (why? 부트스트랩 때문에 사이드바 ul li 깨짐) */
   	nav {
    	text-align: center;
    	margin-top: 60px;
    }
   	
   	#mealpagination {
   		display: inline-block;
   	}
   
   	#mealpagination li {
   		float: left;
   		/* border: 0.4px solid gray; */
   		padding: 5px 15px;
   	}
   	
   	#mealpagination li a {
   		color: rgb(88, 88, 88);
   		font-size: 16px;
   	}
    
</style>
<body>
<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	<c:choose>
			<c:when test="${sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar5.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar5.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     <table id="top-table">
			<tr>
				<th>[밥게시판] 제목</th>
			</tr>
		</table>
		
<!-- 		<form action="taxiApplyList"> -->
<!-- 				<select id="option" name="option"> -->
<!-- 					<option value="제목">제목</option> -->
<!-- 					<option value="아이디">아이디</option> -->
<!-- 				</select>  -->
<!-- 				<input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/> -->
<!-- 		   		<input type="hidden" name="page" value="1"/> -->
<!--           			<button id="searchBtn">검색</button> -->
<!-- 		</form> -->
     
     	<table id="main-table">
				<thead>
					<tr>
						<th>신청자ID</th>
						<th>최근 14일간 받은 패널티</th>
						<th>신청시간</th>
						<th>매너점수</th>
						<th colspan="2">수락 / 거절</th>
						<!-- <td>수락/거절</td> -->
					</tr>
				</thead>
				
				<c:forEach items="${mealApplyList}" var="apply">
				
				<tbody class="mealApplyList">
					<tr>
						<td>${apply.member_id}</td>
						<c:choose>
							<c:when test="${apply.penalty_idx > 0}">
								<td style="color: #ef5350;"><img style="position: relative; top: 3px; right: 3px; width: 20px;" src="./resources/images/warning.png" alt="warning"> ${apply.penalty_idx}</td>
							</c:when>
							<c:otherwise>
								<td>${apply.penalty_idx}</td>
							</c:otherwise>
						</c:choose>
						<td>${apply.apply_date}</td> 
						<td>
							<c:forEach var="i" begin="1" end="5">
		                     <c:if test="${apply.avg_allAvg >= i}"><img src="./resources/images/star.png" alt="star" style="width: 20px;"></c:if>
		                     <c:if test="${apply.avg_allAvg < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 20px;"></c:if>
           				    </c:forEach>
						</td>
						<td><input class="common-button yes-button" type="button" value="수락" onclick="location.href='mealApplyUpdate?apply_idx=${apply.apply_idx}&board_idx=${apply.board_idx}&category_id=${apply.category_id}&status=1&member_id=${apply.member_id}'" /></td>
						<td><input class="common-button no-button" type="button" value="거절" onclick="location.href='mealApplyUpdate?apply_idx=${apply.apply_idx}&board_idx=${apply.board_idx}&category_id=${apply.category_id}&status=0'" /></td>
					</tr>
				</tbody>
				</c:forEach>
			</table>
            <nav arial-label="Page navigation" style="text-align:center">
          		<ul class="mealpagination" id="mealpagination"></ul>
			</nav>
	   </div>
	</div>
<jsp:include page="../commons/footer.jsp"/>
</body>
<script type="text/javascript">
	var page = 1; // 초기 페이지 번호
	
	// 검색 버튼 클릭했을 때 한 번 초기화
	$('#searchBtn').on('click',function(){	
		
		$("#mealpagination").twbsPagination('destroy');
	});
	
// 플러그인을 이용해 페이징 처리
	$("#mealpagination").twbsPagination({
		startPage:${map.page}, //시작 페이지 (page)
		totalPages:${map.pages}, //총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수) (pages)
		visiblePages: 5, //한 번에 보여줄 페이지 수
		initiateStartPageClick: false,
		onPageClick:function(e,page){
			//console.log(e); //클릭한 페이지와 관련된 이벤트 객체
			console.log(page); //사용자가 클릭한 페이지
			// 페이지 이동시에도 데이터를 가지고 있기 위해 session 을 활용한다
			location.href = "mealApplyList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
	}
});

</script>
</html>