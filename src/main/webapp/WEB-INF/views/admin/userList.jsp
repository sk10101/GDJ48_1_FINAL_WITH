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
			<form action="userList">
			   	<button onclick="location.href='userList.go'" name="member_class" value="일반회원">일반회원</button>
			   	<button onclick="location.href='userList.go'" name="member_class" value="관리자">관리자</button>  
				<select id="option" name="option">
					<option value="id">아이디</option>
					<option value="name">이름</option>
					<option value="university">대학교</option>
					<option value="certficate">인증여부</option>
				</select>
				<input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
				<input type="hidden" name="page" value="1"/>
				<button id="searchBtn">검색</button>
			</form>
		<table>
			<thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>		
					<th>대학교</th>
					<th>성별</th>
					<th>인증여부</th>	
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="user">
				<tr>
					<td><a href="userDetail?member_id=${user.member_id}">${user.member_id}</a></td>
					<td>${user.name}</td>
					<td>${user.university_name}</td>
					<td>${user.gender}</td>
					<td><c:if test="${user.certficate_chk eq 0}">N</c:if></td>
					<td><c:if test="${user.certficate_chk eq 1}">Y</c:if></td>
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
		location.href = "userList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
		
	}
});

</script>
</html>