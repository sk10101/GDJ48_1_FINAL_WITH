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
	
	#main-table tr:last-child td {
		padding-bottom: 15px;
	}
	
	#main-table a {
		color: #537ef4;
	}
	
	/* 검색창 */
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
			   <jsp:include page="../commons/memberSideBar6.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar6.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	   	<form action="penaltyList">
	   		<div class="search">
		   		<input type="search" id="word" name="word" placeholder="아이디를 입력하세요" value=""/>
		   		<input type="hidden" name="page" value="1"/>
		   		<input id="searchBtn" type="image" class="search-img" alt="search" src="../resources/images/search.png">
	   		</div>
	   	</form>
	       <table id="main-table">
		       <thead>
			        <tr>
			        	<th>회원ID</th>
			        	<!-- <th>이용 제한 날짜</th>
			        	<th>이용 제한 해제 날짜</th> -->
			        	<th>이용 제한일</th>
			        	<th>제한한 관리자 ID</th>
			        	<th>취소 여부</th>
			        </tr>
		        </thead>
		        <tbody>
			        <c:forEach items="${penalty}" var="penalty">
			        	<tr>
			        		<td><a href="penaltydetail?penalty_idx=${penalty.penalty_idx}">${penalty.member_id}</a></td>
			        		<td>${penalty.penalty_date} &nbsp; ~ &nbsp; ${penalty.penalty_end}</td>
			        		<%-- <td>${penalty.penalty_end}</td> --%>
			        		<td>${penalty.penalty_admin}</td>
			        		<%-- <c:choose>
			        			<c:when test="${penalty.cancel eq '0'}"><td>N</td></c:when>
			        			<c:when test="${penalty.cancel eq '1'}"><td>Y</td></c:when>
			        		</c:choose> --%>
							<c:if test="${penalty.cancel eq '0'}">
								<td>
									<img src="./resources/images/no.png" alt="no" style="position: relative; top: 2px; width: 18px;">
								</td>
							</c:if>
							<c:if test="${penalty.cancel eq '1'}">
								<td>
									<img src="./resources/images/yes.png" alt="yes" style="position: relative; top: 2px; width: 25px;">
								</td>
							</c:if>
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
		location.href = "penaltyList?page="+page+"&word="+"${sessionScope.word}";

	}
});
</script>
</html>
