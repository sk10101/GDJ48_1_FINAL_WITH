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
        min-height: 680px;
        /* background-color: #f4f4f4; */
        background-color: rgb(249, 249, 249);
        padding: 60px 100px;
    }
    
    .taxiList {
    	margin: 0 auto;
    	margin-top: 40px;
    	border-radius: 20px;
    	width: 600px;
    	background-color: #537ef4;
    	box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
    	background-image: linear-gradient(#537ef4, #2196f3);
    	transition: all 0.3s ease;
    }
    
    .taxiList:hover {
        transform: scale(1.03);
    }
    
    .taxiList th, td {
    	color: #eaeaea;
    	padding: 3px 15px;
    	font-size: 14px;
    }
    
    .taxiList tr:first-child > th {
    	padding-top: 15px;
    	padding-bottom: 15px;
    	font-size: 16px;
    }
    
    .taxiList tr:last-child th {
    	padding-bottom: 15px;
    }
    
    .taxiList tr:last-child td:last-child {
    	text-align: right;
    }
    
    option {
    	font-size: 16px;
    }
    
    .search {
    	text-align: center;
    	margin-bottom: 60px;
    }
    
    .search form input[type="search"] {
    	width: 400px;
    	height: 30px;
    	padding: 10px 10px;
    	border: 1.5px solid lightgray;
    	border-radius: 7px;
    	font-size: 16px;
    }
    
    .search-img {
    	width: 30px;
    	position: relative;
    	top: 8px;
    	left: 5px;
    }
    
    .write-button {
    	padding: 2px 10px;
    	border-radius: 5px;
    	border: none;
    	background-color: #2962ff;
    	color: #eaeaea;
    	font-size: 16px;
    	margin-left: 130px;
    }
    
    nav {
    	text-align: center;
    	margin-top: 40px;
    }
  
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<!--
	<c:choose>
		<c:when test="회원등급이 일반회원일때">
		   	<jsp:include page="../commons/header.jsp"/>
		</c:when>
		<c:when test="회원등급이 관리자일때">
			<jsp:include page="../commons/adminHeader.jsp"/>
		</c:when>
	</c:choose>
	  -->	
	<div class="content-wrap">
		<jsp:include page="../commons/memberSideBar2.jsp"/>
		<!-- 
		<c:choose>
			<c:when test="회원등급이 일반회원일때">
			   <jsp:include page="../commons/memberSideBar2.jsp"/>
			</c:when>
			<c:when test="회원등급이 관리자일때">
				<jsp:include page="../commons/adminSideBar2.jsp"/>
			</c:when>
		</c:choose>
		 -->
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <div class="search">
		       <form action="/taxiList">
			       <select id="option" name="option">
						<option value="제목">제목</option>
						<option value="출발지">출발지</option>
						<option value="도착지">도착지</option>
						<option value="작성자">작성자</option>
				   </select>
				   <input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
				   <input type="hidden" name="page" value="1"/>
				   <input id="searchBtn" type="image" class="search-img" alt="search" src="../resources/images/search.png">
			   </form>
		   </div>
	       <input type="button" class="write-button" value="글쓰기" onclick="location.href='/taxiWrite'"/>
		   <c:forEach items="${taxiList}" var="list">
	   			<table class="taxiList" onClick="location='/taxiDetail?board_idx=${list.board_idx}'">
					<tr>
						<th colspan="4">${list.subject}</th>
	 				</tr>
					<tr>
						<th>출발지 : </th>
						<td>${list.appoint_place}</td>
						<th>작성자 : </th>
						<td>${list.member_id}</td>
					</tr>
					<tr>
						<th>도착지 : </th>
						<td>${list.destination}</td>
						<th>작성일 : </th>
						<td>${list.write_date}</td>
					</tr>
					<tr>
						<th>마감시간 : </th>
						<td>${list.deadline}</td>
						<th>조회수 : </th>
						<td>${list.hit}</td>
					</tr>
					<tr>
						<th>인원 : </th>
						<td>${list.partNo} / ${list.member_cnt}</td>
						<c:if test="${list.recruit_end eq 0}">
							<td colspan="2">
								<span style="padding: 3px 10px; border-radius: 5px; background-color: #2962ff">모집중</span>
							</td>
						</c:if>
						<c:if test="${list.recruit_end eq 1}">
							<td colspan="2">
								<span style="padding: 3px 10px; border-radius: 5px; background-color: #e53935">마감</span>
							</td>
						</c:if>
					</tr>
				</table>
			</c:forEach>
			<nav aria-label="Page navigation">
				<ul class="pagination" id="pagination"></ul>
			</nav>
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
	var word = $('#word').val();
	var option = $('#option').val();
	
	// 검색 버튼 클릭했을 때 한 번 초기화
	$('#searchBtn').on('click',function(){	
		word = $('#word').val();
		option = $('#option').val();
		console.log("검색옵션 / 검색어 "+word + " / " + option);
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
			location.href = "taxiList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
			
		}
	});
</script>
</html>