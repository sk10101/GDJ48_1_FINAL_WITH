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
	     <table>
			<tr>
				<th>제목 : </th>
				<td>${info.subject}</td>
			</tr>
		</table>
     	<table>
				<thead>
					<tr>
						<th>신청자ID</th>
						<th>투자금액</th>
						<th>최근 14일간 받은 패널티</th>
						<th>신청시간</th>
						<th>매너점수</th>
						<th colspan="2">
							<td>수락/거절</td>
						</th>
					</tr>
				</thead>
				
				<c:forEach items="${deliApplyList}" var="apply">
				
				<tbody class="deliApplyList">
						<tr>
							<td>${apply.member_id}</td>
							<td>${apply.investment}</td>
							<td>${apply.penalty_idx}</td>
							<td>${apply.apply_date}</td> 
							<td>
								<c:forEach var="i" begin="1" end="5">
				                     <c:if test="${apply.avg_allAvg >= i}"><img src="./resources/images/star.png" alt="star" style="width: 15px;"></c:if>
				                     <c:if test="${apply.avg_allAvg < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 15px;"></c:if>
              				    </c:forEach>
							</td>
								<td><input type="button" value="수락" onclick="location.href='applyUpdate?apply_idx=${apply.apply_idx}&board_idx=${apply.board_idx}&category_id=${apply.category_id}&member_cnt=${apply.member_cnt}&status=1&member_id=${apply.member_id}'" /></td>
								<td><input type="button" value="거절" onclick="location.href='applyUpdate?apply_idx=${apply.apply_idx}&board_idx=${apply.board_idx}&category_id=${apply.category_id}&status=0'" /></td>
							</tr>
				</tbody>
				</c:forEach>
			</table>
			<p>${manner.avg_allAvg}</p>
	     	<div class="container">
               <nav arial-label="Page navigation" style="text-align:center">
               		<ul class="delipagination" id="delipagination"></ul>
				</nav>
			</div>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script type="text/javascript">
var msg = "${msg}";

if(msg != "") {
	alert(msg);
}

var page = 1; // 초기 페이지 번호

// 검색 버튼 클릭했을 때 한 번 초기화
$('#searchBtn').on('click',function(){	
	
	$("#delipagination").twbsPagination('destroy');
});

//플러그인을 이용해 페이징 처리
$("#delipagination").twbsPagination({
	startPage:${map.page}, //시작 페이지 (page)
	totalPages:${map.pages}, //총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수) (pages)
	visiblePages: 5, //한 번에 보여줄 페이지 수
	initiateStartPageClick: false,
	onPageClick:function(e,page){
		//console.log(e); //클릭한 페이지와 관련된 이벤트 객체
		console.log(page); //사용자가 클릭한 페이지
		// 페이지 이동시에도 데이터를 가지고 있기 위해 session 을 활용한다
		location.href = "deliApplyList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
}
});

</script>
</html>