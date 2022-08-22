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
	
    #main-table tr td:first-child {
        white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		max-width: 200px;
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
			   <jsp:include page="../commons/memberSideBar7.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar7.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     	 <form action="adminInQueryList">
	     	 	<div class="search">
				   <input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
				   <input type="hidden" name="page" value="1"/>
				   <input id="searchBtn" type="image" class="search-img" alt="search" src="../resources/images/search.png">		
				</div>
		   </form>
	     <table id="main-table">
            	<tr>
            		<th>제목</th>
            		<th>작성자</th>
            		<th>작성일</th>
            		<th>처리한 관리자</th>
            		<th>처리상태</th>
            	</tr>
            	<c:forEach items="${name}" var="name">
						<tr>
							<td style="text-align: left; padding: 10px 20px;"><a href="/adminInqueryDetail.go?idx=${name.inquery_idx}">${name.subject}</a></td>							
							<td>${name.member_id}</td>						
							<td><fmt:formatDate pattern="yyyy-MM-dd KK:mm" value="${name.inquery_date}"/></td>
							<c:if test="${name.inquery_admin eq '배정중'}">
								<td> - </td>
							</c:if>
							<c:if test="${name.inquery_admin ne '배정중'}">
								<td>${name.inquery_admin}</td>
							</c:if>	
							<c:if test="${name.status eq '처리완료'}">
								<td style="color: #537ef4;">${name.status}</td>
							</c:if>
							<c:if test="${name.status eq '처리중'}">
								<td style="color: #ff6f00;">${name.status}</td>
							</c:if>
							<c:if test="${name.status eq '미처리'}">
								<td style="color: #ef5350;">${name.status}</td>
							</c:if>
						</tr>
				</c:forEach>
            </table>
			<nav aria-label="Page navigation">
				<ul class="pagination" id="pagination"></ul>
			</nav>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script type="text/javascript">

	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	var page = 1; // 초기 페이지 번호	
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
			location.href = "adminInQueryList?page="+page;
		}
	});
</script>
</html>