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
       	padding: 60px 50px;
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
    	table-layout: fixed;
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
	
	#main-table tr:last-child td {
		padding-bottom: 15px;
	}
	
	#main-table a {
		color: #537ef4;
	}
	
	/* 검색창 */
    option {
    	font-size: 16px;
    }
    
    .search {
    	text-align: left;
    	margin-bottom: 15px;
    }
    
    .search input[type="search"] {
    	width: 200px;
    	height: 28px;
    	padding: 10px 10px;
    	border: 1.5px solid lightgray;
    	border-radius: 7px;
    	font-size: 14px;
    }
    
    .search-img {
    	width: 30px;
    	position: relative;
    	top: 8px;
    	left: 5px;
    }
    
   	#option {
   		padding: 2px 6px;
   		border-radius: 5px;
   		text-align: center;
   	}
   	
    #main-table tbody tr td:nth-child(3) {
        white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		max-width: 150px;
    }
    
    .clear-button {
    	padding: 5px 10px;
    	border-radius: 5px;
    	border: none;
    	color: #eaeaea;
    	font-size: 14px;
    	background-color: #537ef4;
    }
    
   	/* 페이지네이션 부트스트랩 css 제거 후 직접 수정 (why? 부트스트랩 때문에 사이드바 ul li 깨짐) */
   	nav {
    	text-align: center;
    	margin-top: 60px;
    }
   	
   	#pagination {
   		display: inline-block;
   	}
   
   	#pagination li {
   		float: left;
   		/* border: 0.4px solid gray; */
   		padding: 5px 15px;
   	}
   	
   	#pagination li a {
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
		   <form action="reportList">
			   	<div class="search">
					<select id="option" name="option">
						<option value="subject" selected="selected">제목</option>
						<option value="category_id">이용서비스</option>
						<option value="report_content">신고 사유</option>
						<option value="report_admin">담당관리자 ID</option>
						<option value="처리상태">처리 상태</option>
					</select>
					<input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
					<input type="hidden" name="page" value="1"/>
					<input id="searchBtn" type="image" class="search-img" alt="search" src="../resources/images/search.png">
				</div>	
			</form>
	       <table id="main-table">
	       	<thead>
				<tr>
					<th>글번호</th>
					<th>이용서비스</th>		
					<th>게시글 제목</th>
					<th>신고자ID</th>
					<th>신고 날짜</th>
					<th>신고 사유</th>
					<th>담당관리자 ID</th>
					<th>처리 상태</th>
					<th></th>	
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="report">
				<tr>
					<td>${report.report_idx}</td>
					<td>${report.category_id}</td>
					<c:if test="${report.category_id eq '배달게시판'}"><td style="text-align: left"><a href="deliDetail?board_idx=${report.board_idx}">${report.subject}</a></td></c:if>
					<c:if test="${report.category_id eq '택시게시판'}"><td style="text-align: left"><a href="taxiDetail?board_idx=${report.board_idx}">${report.subject}</a></td></c:if>
					<c:if test="${report.category_id eq '밥게시판'}"><td style="text-align: left"><a href="mealDetail?board_idx=${report.board_idx}">${report.subject}</a></td></c:if>
					<td>${report.reporter_id}</td>
					<td>${report.report_date}</td>
					<td>${report.report_content}</td>
					<c:if test="${report.report_admin ne null}">
						<td>${report.report_admin}</td>
					</c:if>
					<c:if test="${report.report_admin eq null}">
						<td> - </td>
					</c:if>
					<c:if test="${report.status eq '처리완료'}">
						<td style="color: #537ef4;">${report.status}</td>
					</c:if>
					<c:if test="${report.status eq '미처리'}">
						<td style="color: #ef5350;">${report.status}</td>
					</c:if>
					<td><a href="reportDetail?report_idx=${report.report_idx}"><input class="clear-button" type="button" value="처리하기"/></a></td>
				</tr>
			</c:forEach>
			</tbody>
	       </table>
		    <nav arial-label="Page navigation" style="text-align:center">
		        <ul class="pagination" id="pagination"></ul>
		    </nav>
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