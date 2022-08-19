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
		min-height: 100vh;
        background-color: rgb(249, 249, 249);
        padding: 60px 100px;
    }
    
    /* 양수빈 CSS 작업[삭제 해도 됨] */
	.myinfo th, td {
		border: 1px solid #000000;
		padding: 8px;
		text-align: center;
	}
	
	.myinfo th {
		background-color: #2962ff;
		color: #ffffff;
	}
	.container {
    	text-align: center;
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
	       <!-- 여기에서 작업 시작하세요 -->
	     <table class="myinfo" style="margin-left:180px;">
            	<tr>
            		<th>차단 대상 ID</th>
            		<th>차단 해제</th>
            	</tr>
            	<c:forEach items="${name}" var="name">
					<tr>
						<td>${name.block_member}</td>
						<td><input type="button" onclick="location.href='/blockDelete?name=${name.block_member}'" value="해제" style="width: 100px; color : #ffffff; background-color: #2962ff;"/></td>
					</tr>
				</c:forEach>
            </table>
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
			location.href = "blockUserList?page="+page;
		}
	});
</script>
</html>