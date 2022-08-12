<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar5.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     
	     <table>
			<tr>
				<th><input type="text" value="제목 : [배달] 제목">내가 제목 : [배달] 제목 모임</th>
				<td>
			</tr>
		</table>
		
		<form action="deliApplyList">
				<select id="option" name="option">
					<option value="제목">제목</option>
					<option value="아이디">아이디</option>
				</select> 
				<input id="word" type="search" placeholder="검색어를 입력하세요" name="word" value=""/>
		   		<input type="hidden" name="page" value="1"/>
          			<button id="searchBtn">검색</button>
		</form>
     
     	<table>
				<thead>
					<tr>
						<th>신청자ID</th>
						<th>투자금액</th>
						<th>최근 14일간 받은 패널티</th>
						<th>신청기간</th>
						<th>매너점수</th>
						<th>수락/거절</th>
						<th></th>
					</tr>
				</thead>
				
				<c:forEach items="${deliApplyList}" var="his">
				
				<tbody class="deliApplyList">
						<tr>
							<td>${his.member_id}</td>
							<td>${his.investment}</td>
							<td><a href="detail.go?board_idx=${his.board_idx}&category_id=${his.category_id}">${his.subject}</a></td>
							<td>${his.apply_date}</td> 
							<td>${his.manner_ score}</td> 
							<c:if test="${his.status eq '수락'}"><td><span style="border:1px solid black; background-color:#2962ff;">수락</span></td></c:if>
							<c:if test="${his.status eq '거절'}"><td><span style="border:1px solid black; background-color:red;">거절</span></td></c:if>
						</tr>
				</tbody>
				</c:forEach>

			</table>
	     
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>