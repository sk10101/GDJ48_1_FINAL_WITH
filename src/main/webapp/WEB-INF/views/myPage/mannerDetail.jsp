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
    
   	.myinfo {
   		width: 100%;
    	color: rgb(88, 88, 88);
    	margin: 0 auto;
    	padding: 30px 50px;
    	box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    	border-radius: 20px;
    	font-size: 16px;
    	border-collapse: collapse;
    	background-color: #fff;
	}
	
	.myinfo th,
	.myinfo td {
		padding: 10px 10px;
		text-align: center;
	}
	
	.myinfo td {
		border-top: 5px solid rgb(249, 249, 249);
	}

	.myinfo tr:first-child th {
		background-color: rgb(249, 249, 249);
		padding-top: 15px;
	}
	
	.myinfo tr:first-child th:first-child {
		border-radius: 20px 0 0 0;
	}
	
	.myinfo tr:first-child th:last-child {
		border-radius: 0 20px 0 0;
	}
	
	.myinfo tr:last-child td {
		padding-bottom: 15px;
	}
	
	
	
	/* .myinfo tr:last-child td {
		border-bottom: 0.4px solid gray;
	} */
	
	.myinfo th {
		width: 100px;
	}
	
	.myinfo img {
		position: relative;
		top: 2px;
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
			   <jsp:include page="../commons/memberSideBar4.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar4.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     	<table class="myinfo">
            	<tr>
	            	<th>친절함</th>
	            	<th>응답속도</th>
	            	<th>시간약속</th>
	            	<th>평가일</th>
            	</tr>
				<c:forEach items="${manner}" var="manner">
					<tr>
						<td>${manner.kindness}&ensp;<img src="./resources/images/star.png" alt="star" style="width: 20px;"></td>
						<td>${manner.time}&ensp;<img src="./resources/images/star.png" alt="star" style="width: 20px;"></td>
						<td>${manner.manner_score}&ensp;<img src="./resources/images/star.png" alt="star" style="width: 20px;"></td>
						<td>${manner.assess_date}&ensp;</td>
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
			location.href = "mannerDetail?page="+page;
		}
	});
</script>
</html>