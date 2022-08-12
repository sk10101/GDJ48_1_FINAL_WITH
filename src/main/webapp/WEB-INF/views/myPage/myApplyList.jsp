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
	<%-- <jsp:include page="../commons/header.jsp"/> --%>
	<div class="content-wrap">
	 <%--   <jsp:include page="../commons/memberSideBar5.jsp"/> --%>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     <form action="mygrouplist.go" method="get">
				<table>
					<tr>
						<th><input type="radio" name="member" onclick="window.location.href='/mygList.go';"
						value="내가 만든 모임">내가 만든 모임</th>
						<td><input type="radio" name="member" value="내가 참여한 모임" checked="checked">내가 참여한 모임</td>
						<td>
					</tr>
				</table>
			</form>
			
			<form action="myApplyList">
					<select id="option" name="option">
						<option value="제목">제목</option>
						<option value="이용 서비스">이용 서비스</option>
						<option value="마감상태">마감상태</option>
						<option value="신청상태">신청상태</option>
					</select> 
					<input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
			   <input type="hidden" name="page" value="1"/>
           			<button id="searchBtn">검색</button>
			</form>
			
			<table>
				<thead>
					<tr>
						<th>글번호</th>
						<th>이용 서비스</th>
						<th>제목</th>
						<th>본인 투자금액</th>
						<th>신청시간</th>
						<th>신청상태</th>
						<th>마감상태</th>
					</tr>

				</thead>
				<c:forEach items="${myApplyList}" var="his">
					<tbody class="myApplyList">
							<tr>
								<td>${his.board_idx}</td>
								<td>${his.category_id}</td>
								<td><a href="detail.go?board_idx=${his.board_idx}&category_id=${his.category_id}">${his.subject}</a></td>
								<c:if test="${his.investment eq ''}"><td>-</td></c:if>
								<c:if test="${his.investment ne ''}"><td>${his.investment}</td></c:if>
								<td>${his.apply_date}</td>
								<c:if test="${his.status eq '대기중'}"><td>대기중</td></c:if>
								<c:if test="${his.status eq '수락'}"><td>수락</td></c:if>
								<c:if test="${his.status eq '거절'}"><td>거절</td></c:if>
								<c:if test="${his.status eq '취소'}"><td>취소</td></c:if>
								<c:if test="${his.recruit_end eq 0}"><td><span style="border:1px solid black; background-color:#2962ff;">모집중</span></td></c:if>
								<c:if test="${his.recruit_end eq 1}"><td><span style="border:1px solid black; background-color:red;">마감</span></td></c:if>
							</tr>
					</tbody>
				</c:forEach>

			</table>
			<div class="container">
               <nav arial-label="Page navigation" style="text-align:center">
               		<ul class="pagination" id="pagination"></ul>
				</nav>
			</div>
	   </div>
	</div>
	<%-- <jsp:include page="../commons/footer.jsp"/> --%>
</body>
<script type="text/javascript">
	var page = 1; // 초기 페이지 번호
	
	// 검색 버튼 클릭했을 때 한 번 초기화
	$('#searchBtn').on('click',function(){	
		
		$("#pagination").twbsPagination('destroy');
	});
	
// 플러그인을 이용해 페이징 처리
	$("#pagination").twbsPagination({
		startPage:${map.page}, //시작 페이지 (page)
		totalPages:${map.pages}, //총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수) (pages)
		visiblePages: 5, //한 번에 보여줄 페이지 수
		initiateStartPageClick: false,
		onPageClick:function(e,page){
			//console.log(e); //클릭한 페이지와 관련된 이벤트 객체
			console.log(page); //사용자가 클릭한 페이지
			// 페이지 이동시에도 데이터를 가지고 있기 위해 session 을 활용한다
			location.href = "myApplyList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
	}
});

</script>
</html>