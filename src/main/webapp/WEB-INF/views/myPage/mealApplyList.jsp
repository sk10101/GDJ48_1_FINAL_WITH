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
		color: #eaeaea;
		font-size: 18px;
		width: 50%;
		position: relative;
	}
	
	#top-table th {
		padding: 6px 20px;
		font-weight: normal;
		background-color: #537ef4;
		border-radius: 10px;
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
	
	#main-table tbody:last-child tr td {
		padding-bottom: 15px;
	}
	
	#main-table a {
		color: #537ef4;
	}
	
	.common-button {
    	padding: 5px 10px;
    	border-radius: 5px;
    	border: none;
    	color: #eaeaea;
    	font-size: 14px;
	}
	
	.yes-button {
		background-color: #537ef4;
	}
	
	.no-button {
		background-color: #ff6f00;
	}
    
    
   	/* ?????????????????? ??????????????? css ?????? ??? ?????? ?????? (why? ??????????????? ????????? ???????????? ul li ??????) */
   	nav {
    	text-align: center;
    	margin-top: 60px;
    }
   	
   	#mealpagination {
   		display: inline-block;
   	}
   
   	#mealpagination li {
   		float: left;
   		/* border: 0.4px solid gray; */
   		padding: 5px 15px;
   	}
   	
   	#mealpagination li a {
   		color: rgb(88, 88, 88);
   		font-size: 16px;
   	}
    
</style>
<body>
<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	<c:choose>
			<c:when test="${sessionScope.member_class eq '????????????'}">
			   <jsp:include page="../commons/memberSideBar5.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '?????????'}">
				<jsp:include page="../commons/adminSideBar5.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- ???????????? ?????? ??????????????? -->
	     <table id="top-table">
			<tr>
				<th>
					<img style="position: absolute; left: -20px; top: -40px; width: 65px; filter: drop-shadow(5px 5px 5px rgba(100, 100, 111, 0.4));"  src="./resources/images/3Dmeal.png" alt="3Dmeal">${info.subject}
				</th>
			</tr>
		</table>
		
<!-- 		<form action="taxiApplyList"> -->
<!-- 				<select id="option" name="option"> -->
<!-- 					<option value="??????">??????</option> -->
<!-- 					<option value="?????????">?????????</option> -->
<!-- 				</select>  -->
<!-- 				<input id="word" type="search" placeholder="???????????? ???????????????" name="word" value=""/> -->
<!-- 		   		<input type="hidden" name="page" value="1"/> -->
<!--           			<button id="searchBtn">??????</button> -->
<!-- 		</form> -->
     
     	<table id="main-table">
				<thead>
					<tr>
						<th>?????????ID</th>
						<th>?????? 14?????? ?????? ?????????</th>
						<th>????????????</th>
						<th>????????????</th>
						<th colspan="2">?????? / ??????</th>
						<!-- <td>??????/??????</td> -->
					</tr>
				</thead>
				
				<c:forEach items="${mealApplyList}" var="apply">
				
				<tbody class="mealApplyList">
						<tr>
							<td>${apply.member_id}</td>
							<c:choose>
							<c:when test="${apply.penalty_idx > 0}">
								<td style="color: #ef5350;"><img style="position: relative; top: 3px; right: 3px; width: 20px;" src="./resources/images/warning.png" alt="warning"> ${apply.penalty_idx}</td>
							</c:when>
							<c:otherwise>
								<td>${apply.penalty_idx}</td>
							</c:otherwise>
						</c:choose>
							<td>${apply.apply_date}</td> 
							<td>
								<c:forEach var="i" begin="1" end="5">
				                     <c:if test="${apply.avg_allAvg >= i}"><img src="./resources/images/star.png" alt="star" style="width: 20px; position: relative; top: 3px;"></c:if>
				                     <c:if test="${apply.avg_allAvg < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 20px; position: relative; top: 3px;"></c:if>
              				    </c:forEach>
							</td>
								<td><input class="common-button yes-button" type="button" value="??????" onclick="location.href='mealApplyUpdate?apply_idx=${apply.apply_idx}&board_idx=${apply.board_idx}&category_id=${apply.category_id}&member_cnt=${apply.member_cnt}&status=1&member_id=${apply.member_id}'" /></td>
								<td><input  class="common-button no-button" type="button" value="??????" onclick="location.href='mealApplyUpdate?apply_idx=${apply.apply_idx}&member_cnt=${apply.member_cnt}&member_id=${apply.member_id}&board_idx=${apply.board_idx}&category_id=${apply.category_id}&status=0'" /></td>
							</tr>
				</tbody>
				</c:forEach>
			</table>
            <nav arial-label="Page navigation" style="text-align:center">
          		<ul class="mealpagination" id="mealpagination"></ul>
			</nav>
	   </div>
	</div>
<jsp:include page="../commons/footer.jsp"/>
</body>
<script type="text/javascript">
	var page = 1; // ?????? ????????? ??????
	
	// ?????? ?????? ???????????? ??? ??? ??? ?????????
	$('#searchBtn').on('click',function(){	
		
		$("#mealpagination").twbsPagination('destroy');
	});
	
// ??????????????? ????????? ????????? ??????
	$("#mealpagination").twbsPagination({
		startPage:${map.page}, //?????? ????????? (page)
		totalPages:${map.pages}, //??? ?????????(?????? ????????? ??? / ??? ???????????? ????????? ????????? ???) (pages)
		visiblePages: 5, //??? ?????? ????????? ????????? ???
		initiateStartPageClick: false,
		onPageClick:function(e,page){
			//console.log(e); //????????? ???????????? ????????? ????????? ??????
			console.log(page); //???????????? ????????? ?????????
			// ????????? ??????????????? ???????????? ????????? ?????? ?????? session ??? ????????????
			location.href = "mealApplyList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}";
	}
});

</script>
</html>