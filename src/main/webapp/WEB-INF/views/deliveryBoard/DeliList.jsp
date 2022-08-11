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
    }
    
    a {
    	text-decoration : none;
    	color : black;
    }
    
     .deliList {
	   	margin: 0 auto;
	   	margin-top: 40px;
	   	border-radius: 20px;
	   	width: 600px;
	   	background-color: #537ef4;
	   	box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
	   	background-image: linear-gradient(#537ef4, #2196f3);
	   	transition: all 0.3s ease;
    }
    
    .deliList:hover {
        transform: scale(1.03);
    }
    
    .deliList th, td {
    	color: #eaeaea;
    	padding: 3px 15px;
    	font-size: 14px;
    }
    
    .deliList tr:first-child > th {
    	padding-top: 15px;
    	padding-bottom: 15px;
    	font-size: 16px;
    }
    
    .deliList tr:last-child th {
    	padding-bottom: 15px;
    }
    
    .deliList tr:last-child td:last-child {
    	text-align: right;
    }
    
    .container {
    	text-align: center;
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
	<jsp:include page="../commons/memberSideBar1.jsp"/>
	<!-- 
	<c:choose>
		<c:when test="회원등급이 일반회원일때">
		   <jsp:include page="../commons/memberSideBar1.jsp"/>
		</c:when>
		<c:when test="회원등급이 관리자일때">
			<jsp:include page="../commons/adminSideBar1.jsp"/>
		</c:when>
	</c:choose>
	 -->
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <form action="deliList">
		       <select id="option" name="option">
					<option value="제목">제목</option>
					<option value="약속장소">약속장소</option>
					<option value="작성자">작성자</option>
			   </select>
			   <input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
			   <input type="hidden" name="page" value="1"/>
			   <button id="searchBtn">검색</button>		
		   </form>
	       <input type="button" value="글쓰기" onclick="location.href='write.go'"/>
					<c:forEach items="${deliList}" var="bbs">
				     	<table class="deliList" onClick="location='deliDetail?board_idx=${bbs.board_idx}'">
							<tr>
								<td colspan="2">${bbs.subject}</td>
							</tr>
							<tr>
								<td>약속장소 : ${bbs.appoint_place}</td>
								<td>작성자 : ${bbs.member_id}</td>
							</tr>
							<tr>
								<td>모인금액 : (모은금액) / ${bbs.min_delivery}</td>
								<td>작성일 : ${bbs.write_date}</td>
							</tr>
							<tr>
								<td>마감시간 : ${bbs.deadline}</td>
								<td>조회수 : ${bbs.hit}</td>
							</tr>
							<tr>
								<td>인원 : (현재 인원) / ${bbs.member_cnt}</td>
								<c:if test="${bbs.recruit_end eq 0}"><td><span style="border:1px solid black; background-color:#2962ff;">모집중</span></td></c:if>
								<c:if test="${bbs.recruit_end eq 1}"><td><span style="border:1px solid black; background-color:red;">마감</span></td></c:if>
							</tr>
						</table>
					</c:forEach>
				<div class="container">
					<nav aria-label="Page navigation">
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
			location.href = "deliList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
			
		}
	});
</script>
</html>