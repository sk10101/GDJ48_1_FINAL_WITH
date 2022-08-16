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
        min-height: 680px;
        /* background-color: #f4f4f4; */
        background-color: rgb(249, 249, 249);
    }
</style>
<body>
<%-- 	<jsp:include page="../commons/header.jsp"/> --%>
	<div class="content-wrap">
<%-- 	   <jsp:include page="../commons/memberSideBar5.jsp"/> --%>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     
	     <table>
			<tr>
				<th><input type="text" value="제목 : [택시] 제목">내가 제목 : [택시] 제목 모임</th>
				<td>
			</tr>
		</table>
		
		<form action="taxiApplyList">
				<select id="option" name="option">
					<option value="제목">제목</option>
					<option value="아이디">아이디</option>
				</select> 
				<input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
		   		<input type="hidden" name="page" value="1"/>
          			<button id="searchBtn">검색</button>
		</form>
     
     	<table>
				<thead>
					<tr>
						<th>신청자ID</th>
						<th>최근 14일간 받은 패널티</th>
						<th>신청시간</th>
						<th>매너점수</th>
						<th>수락/거절</th>
					</tr>
				</thead>
				
				<c:forEach items="${taxiApplyList}" var="apply">
				
				<tbody class="taxiApplyList">
						<tr>
							<td>${apply.member_id}</td>
							<td>${apply.penalty_idx}</td>
							<td>${apply.apply_date}</td> 
							<td>${apply.manner_score}</td> 
							<c:if test="${apply.status eq '수락'}"><td><span style="border:1px solid black; background-color:#2962ff;">수락</span></td></c:if>
							<c:if test="${apply.status eq '거절'}"><td><span style="border:1px solid black; background-color:red;">거절</span></td></c:if>
						</tr>
				</tbody>
				</c:forEach>

			</table>
	     	<div class="container">
               <nav arial-label="Page navigation" style="text-align:center">
               		<ul class="taxipagination" id="taxipagination"></ul>
				</nav>
			</div>
	     
	     
	     
	   </div>
	</div>
<%-- 	<jsp:include page="../commons/footer.jsp"/> --%>
</body>
<script type="text/javascript">
	var page = 1; // 초기 페이지 번호
	
	// 검색 버튼 클릭했을 때 한 번 초기화
	$('#searchBtn').on('click',function(){	
		
		$("#taxipagination").twbsPagination('destroy');
	});
	
// 플러그인을 이용해 페이징 처리
	$("#taxipagination").twbsPagination({
		startPage:${map.page}, //시작 페이지 (page)
		totalPages:${map.pages}, //총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수) (pages)
		visiblePages: 5, //한 번에 보여줄 페이지 수
		initiateStartPageClick: false,
		onPageClick:function(e,page){
			//console.log(e); //클릭한 페이지와 관련된 이벤트 객체
			console.log(page); //사용자가 클릭한 페이지
			// 페이지 이동시에도 데이터를 가지고 있기 위해 session 을 활용한다
			location.href = "taxiApplyList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
	}
});
</script>
</html>