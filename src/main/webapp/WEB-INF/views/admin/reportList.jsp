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
	<jsp:include page="../commons/adminHeader.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/adminSideBar5.jsp"/>
	   <div class="content">
		   <form action="reportList">
				<select id="option" name="option">
					<option value="subject" selected="selected">제목</option>
					<option value="category_id">이용서비스</option>
					<option value="report_content">신고사유</option>
					<option value="report_admin">담당관리자ID</option>
					<option value="처리상태">처리상태</option>
				</select>
				<input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
				<input type="hidden" name="page" value="1"/>
				<button id="searchBtn">검색</button>
			</form>
	       <table>
	       	<thead>
				<tr>
					<th>글번호</th>
					<th>이용서비스</th>		
					<th>신고게시글 제목</th>
					<th>신고자ID</th>
					<th>신고 날짜</th>
					<th>신고 사유</th>
					<th>담당관리자 ID</th>
					<th>처리상태</th>
					<th>처리</th>	
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="report">
				<tr>
					<td>${report.report_idx}</td>
					<td>${report.category_id}</td>
					<td><c:if test="${report.category_id eq '배달게시판'}"><a href="deliDetail?board_idx=${report.board_idx}">${report.subject}</a></c:if></td>
					<td><c:if test="${report.category_id eq '택시게시판'}"><a href="taxiDetail?board_idx=${report.board_idx}">${report.subject}</a></c:if></td>
					<td><c:if test="${report.category_id eq '밥게시판'}"><a href="mealDetail?board_idx=${report.board_idx}">${report.subject}</a></c:if></td>
					<td>${report.reporter_id}</td>
					<td>${report.report_date}</td>
					<td>${report.report_content}</td>
					<td>${report.report_admin}</td>
					<td>${report.status}</td>
					<td><a href="reportDetail?report_idx=${report.report_idx}"><input type="button" value="처리하기"/></a></td>
				</tr>
			</c:forEach>
			</tbody>
	       </table>
	       <div class="container">
		    <nav arial-label="Page navigation" style="text-align:center">
		        <ul class="pagination" id="pagination"></ul>
		    </nav>
		</div>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
var page = 1; // 초기 페이지 번호

//검색 버튼 클릭했을 때 한 번 초기화
$('#searchBtn').on('click',function(){
	
	$("#pagination").twbsPagination('destroy');
});

//플러그인을 이용해 페이징 처리
$("#pagination").twbsPagination({
	startPage:${map.page}, //시작 페이지 (page)
	totalPages:${map.pages}, //총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수) (pages)
	visiblePages: 5, //한 번에 보여줄 페이지 수
	initiateStartPageClick: false,
	onPageClick:function(e,page){
		//console.log(e); //클릭한 페이지와 관련된 이벤트 객체
		console.log(page); //사용자가 클릭한 페이지
		// 페이지 이동시에도 데이터를 가지고 있기 위해 session 을 활용한다
		location.href = "reportList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
		
	}
});
</script>
</html>