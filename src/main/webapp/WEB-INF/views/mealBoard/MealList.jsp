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
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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
    
    a {
    	text-decoration : none;
    	color : black;
    }
    
     .mealList {
	   	margin: 0 auto;
	   	margin-top: 40px;
	   	border-radius: 20px;
	   	width: 600px;
	   	background-color: #537ef4;
	   	box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
	   	background-image: linear-gradient(#537ef4, #2196f3);
	   	transition: all 0.3s ease;
    }
    
    .mealList:hover {
        transform: scale(1.03);
    }
    
    .mealList th, td {
    	color: #eaeaea;
    	padding: 5px 15px;
    	font-size: 14px;
    }
    
    .mealList tr:first-child > th {
    	padding-top: 15px;
    	padding-bottom: 15px;
    	font-size: 16px;
    	text-align: left;
    }
    
    .mealList tr:last-child th {
    	padding-bottom: 15px;
    }
    
    .mealList tr:last-child td:last-child {
    	text-align: right;
    	padding-bottom: 15px;
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
    
    
   	#option {
   		padding: 4px 10px;
   		border-radius: 5px;
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
			   <jsp:include page="../commons/memberSideBar3.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar3.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <div class="search">
		       <form action="deliList">
			       <select id="option" name="option">
						<option value="제목">제목</option>
						<option value="약속장소">약속장소</option>
						<option value="작성자">작성자</option>
				   </select>
				   <input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
				   <input type="hidden" name="page" value="1"/>
				   <input id="searchBtn" type="image" class="search-img" alt="search" src="../resources/images/search.png">		
			   </form>
		   </div>	   
	       <input type="button" value="글쓰기" class="write-button" onclick="location.href='MealWrite.go'"/>
					<c:forEach items="${mealList}" var="meal">
				     	<table class="mealList" onClick="location='mealDetail?board_idx=${meal.board_idx}'">
							<tr>
								<th colspan="2">${meal.subject}</th>
							</tr>
							<tr>
								<td>약속장소 : ${meal.appoint_place}</td>
								<td>작성자 : ${meal.member_id}</td>
							</tr>
							<tr>
								<td>마감시간 : ${meal.deadline}</td>
								<td>작성일 : ${meal.write_date}</td>
							</tr>
							<tr>
								<td>인원 : ${meal.partNo} / ${meal.member_cnt}</td>
								<td>조회수 : ${meal.hit}</td>
							</tr>
							<tr>
							<td></td>
							<c:if test="${meal.recruit_end eq 0}"><td><span style="padding: 3px 10px; border-radius: 5px; background-color: #2962ff">모집중</span></td></c:if>
							<c:if test="${meal.recruit_end eq 1}"><td><span style="padding: 3px 10px; border-radius: 5px; background-color: #ef5350;">마감</span></td></c:if>
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
			location.href = "mealList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
			
		}
	});
</script>
</html>