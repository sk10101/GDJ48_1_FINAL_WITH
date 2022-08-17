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
	   <jsp:include page="../commons/adminSideBar6.jsp"/>
	   <div class="content">
	   	<form action="penaltyList">
	   		<input type="search" id="word" name="word" placeholder="아이디를 입력하세요" value=""/>
	   		<input type="hidden" name="page" value="1"/>
	   		<button id="searchBtn">검색</button>
	   	</form>
	       <table>
		       <thead>
			        <tr>
			        	<th>회원ID</th>
			        	<th>이용제한날짜</th>
			        	<th>이용제한 해제날짜</th>
			        	<th>제한한 관리자ID</th>
			        	<th>취소 여부</th>
			        </tr>
		        </thead>
		        <tbody>
			        <c:forEach items="${penalty}" var="penalty">
			        	<tr>
			        		<td><a href="penaltydetail?penalty_idx=${penalty.penalty_idx}">${penalty.member_id}</a></td>
			        		<td>${penalty.penalty_date}</td>
			        		<td>${penalty.penalty_end}</td>
			        		<td>${penalty.penalty_admin}</td>
			        		<td><c:if test="${penalty.cancel eq '0'}">N</c:if></td>
			        		<td><c:if test="${penalty.cancel eq '1'}">Y</c:if></td>
			        	</tr>
			        </c:forEach>
		        </tbody>
	       </table>    
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
		location.href = "penaltyList?page="+page+"+"&word="+"${sessionScope.word}";
		
	}
});
</script>
</html>
