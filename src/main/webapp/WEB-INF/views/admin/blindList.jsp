<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
		<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"> -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./resources/js/jquery.twbsPagination.js"></script>
	<script>
	var msg = '${msg}';
	if (msg != "") {
		alert(msg);
	}
	</script>
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
    
     .blindList {
	   	margin: 0 auto;
	   	margin-top: 40px;
	   	border-radius: 20px;
	   	width: 600px;
	   	background-color: #537ef4;
	   	box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
	   	background-image: linear-gradient(#537ef4, #2196f3);
	   	transition: all 0.3s ease;
    }
    
    .blindList:hover {
        transform: scale(1.03);
    }
    
    .blindList th, td {
    	color: #eaeaea;
    	padding: 3px 15px;
    	font-size: 14px;
    }
    
    .blindList tr:first-child > td {
    	padding-top: 15px;
    }
    
    .blindList tr:last-child td {
    	padding: 10px 10px;
    }
    
    .blindList tr:last-child td:last-child {
    	text-align: right;
    }
    
   	.btn {
	  background-color: #2962ff;
	  border: none;
	  color: #eaeaea;
	  padding: 5px 10px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 14px;
	  margin: 4px 2px;
	  cursor: pointer;
	  border-radius: 10px;
	}
	
	.right-btn {
	  background-color: #ef5350;
	}
	
    option {
    	text-align: center;
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
    }
    
    .search-img {
    	width: 30px;
    	position: relative;
    	top: 8px;
    	left: 5px;
    }
    
   	#option {
   		padding: 3px 10px;
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
			   <jsp:include page="../commons/memberSideBar7.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar8.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <div class="search">
	         <form action="blindList">
		       <select id="option" name="option">
					<option value="아이디">아이디</option>
					<option value="이용서비스">이용서비스</option>
			   </select>
			   <input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
			   <input type="hidden" name="page" value="1"/>
			   <input id="searchBtn" type="image" class="search-img" alt="search" src="../resources/images/search.png">		
		   </form>
		  </div> 
					<c:forEach items="${blindList}" var="bbs">
				     	<table class="blindList">
				     		<tr>
								<td>글번호 &nbsp;:&nbsp; ${bbs.board_idx}</td>
							</tr>		
							<tr>
								<td>이용서비스 &nbsp;:&nbsp; ${bbs.category_id}</td>
							</tr>				     	
							<tr>
								<td colspan="2">제목 &nbsp;:&nbsp; ${bbs.subject}</td>
								<td>작성자ID &nbsp;:&nbsp; ${bbs.member_id}</td>
							</tr>
							<tr>
								<td>블라인드사유 &nbsp;:&nbsp; ${bbs.blind_reason}</td>
								<td colspan="2">블라인드날짜 &nbsp;:&nbsp; <fmt:formatDate pattern="yyyy-MM-dd" value="${bbs.blind_date}"/></td>
							</tr>							
							<tr>
								
							</tr>
						<!--  	<tr>
								<td>작성일:${bbs.write_date}</td>
							</tr>  -->
							<tr>
							<td colspan="3">
								<button class="btn" 
								<c:if test="${bbs.category_id eq '배달게시판'}">
									onClick="location='deliDetail?board_idx=${bbs.board_idx}'"
								</c:if>
								<c:if test="${bbs.category_id eq '택시게시판'}">
									onClick="location='/taxiDetail?board_idx=${bbs.board_idx}'"
								</c:if>
								<c:if test="${bbs.category_id eq '밥게시판'}">
									onClick="location='mealDetail?board_idx=${bbs.board_idx}'"
								</c:if>
								>상세보기
								</button>
								<button class="btn right-btn" onClick="location='blindDetail?board_idx=${bbs.board_idx}'">블라인드 해제</button>
							</td>
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
			location.href = "blindList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
		}
	});
</script>
</html>