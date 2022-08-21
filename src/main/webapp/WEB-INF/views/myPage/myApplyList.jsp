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
	
	#top-table {
		margin-bottom: 30px;
		color: rgb(88, 88, 88);
		font-size: 16px;
	}
	
	#top-table th {
		padding: 6px 20px;
		font-weight: normal;
		transition: all 0.3s ease;
	}
	
	#top-table th:last-child {
		border-radius: 10px;
		background-color: #537ef4;
		color: #eaeaea;
	}
	
	#top-table th:first-child {
		border-radius: 10px;
		border: 0.4px solid gray;
		color: rgb(88, 88, 88);
	}
	
	#top-table th:first-child:hover {
		font-weight: bold;
		transform: scale(1.02);
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
	
	#main-table a {
		color: #537ef4;
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
	
	/* 검색창 */
    option {
    	font-size: 16px;
    }
    
    .search {
    	text-align: left;
    	margin-bottom: 15px;
    }
    
    .search form input[type="search"] {
    	width: 200px;
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
    
   	#option {
   		padding: 4px 6px;
   		border-radius: 5px;
   		text-align: center;
   	}
   	
    .common-button {
    	padding: 5px 10px;
    	border-radius: 5px;
    	border: none;
    	color: #eaeaea;
    	font-size: 14px;
    }
    
    .button {
    	opacity: 0;
    	width: 0;
    	height: 0;
    }
    
    .del-button {
    	background-color: #ff6f00;
    }
    
    .end-button {
    	background-color: #537ef4;
    }
    
    #main-table tr:last-child td:nth-child(3) {
        white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		max-width: 200px;
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
	       <!-- 여기에서 작업 시작하세요 -->
	     <form action="myapplylist.go" method="get">
				<table id="top-table">
					<tr>
						<th>
							<label><input class="button" type="radio" name="member" onclick="window.location.href='/mygList.go';" value="내가 만든 모임">내가 만든 모임</label>
						</th>
						<th></th>
						<th>
							<label><input class="button" type="radio" name="member" value="내가 참여한 모임" checked="checked">내가 신청한 모임</label>
						</th>
					</tr>
				</table>
			</form>
			
			<div class="search">
				<form action="myApplyList">
						<select id="option" name="option">
							<option value="제목">제목</option>
							<option value="이용 서비스">이용 서비스</option>
							<option value="마감상태">마감상태</option>
							<option value="신청상태">신청상태</option>
						</select> 
						<input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
				   		<input type="hidden" name="page" value="1"/>
	           			<input id="searchBtn" type="image" class="search-img" alt="search" src="../resources/images/search.png">
				</form>
			</div>
			
			<table id="main-table">
				<thead>
					<tr>
						<th>글번호</th>
						<th>이용 서비스</th>
						<th>제목</th>
						<th>본인 투자금액</th>
						<th>신청시간</th>
						<th>신청상태</th>
						<th>마감상태</th>
						<th></th>
					</tr>
				</thead>
				<c:forEach items="${myApplyList}" var="his">
					<tbody class="myApplyList">
							<tr>
								<td>${his.board_idx}</td>
								<td>${his.category_id}</td>
								<td style="text-align: left;"><a href="detail.go?board_idx=${his.board_idx}&category_id=${his.category_id}">${his.subject}</a></td>
								<c:if test="${his.investment eq ''}"><td>-</td></c:if>
								<c:if test="${his.investment ne ''}"><td>${his.investment}</td></c:if>
								<td>${his.apply_date}</td>
								<c:if test="${his.status eq '대기중'}"><td>대기중</td></c:if>
								<c:if test="${his.status eq '수락'}"><td style="color: #537ef4;">수락</td></c:if>
								<c:if test="${his.status eq '거절'}"><td style="color: #ef5350;">거절</td></c:if>
								<c:if test="${his.status eq '취소'}"><td style="color: #ef5350;">취소</td></c:if>
								<c:if test="${his.recruit_end eq 0}"><td style="color: #537ef4;"><span>모집중</span></td></c:if>
								<c:if test="${his.recruit_end eq 1}"><td style="color: #ef5350;"><span>마감</span></td></c:if>
								<c:if test="${his.recruit_end eq 0}"><td><input type="button" class="common-button end-button" value="취소" onclick="location.href='applyCancle?apply_idx=${his.apply_idx}&board_idx=${his.board_idx}&status=2'" /></td></c:if>
								<c:if test="${his.recruit_end eq 1}"><td><input type="button" class="common-button del-button" value="삭제" onclick="location.href='applyDelete?apply_idx=${his.apply_idx}&board_idx=${his.board_idx}'" /></td></c:if>
							</tr>
					</tbody>
				</c:forEach>

			</table>
            <nav arial-label="Page navigation" style="text-align:center">
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
			location.href = "myApplyList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
	}
});

</script>
</html>