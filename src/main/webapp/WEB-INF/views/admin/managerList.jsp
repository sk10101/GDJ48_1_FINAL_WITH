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
		padding: 6px 15px;
		font-weight: normal;
	}
	
    .button {
    	padding: 5px 20px;
    	border-radius: 5px;
    	border: none;
    	font-size: 14px;
    }
    
    .right-button {
    	background-color: #537ef4;
    	color: #eaeaea;
    }
    
    .left-button {
   		background-color: rgb(249, 249, 249);
    	padding: 4px 20px;
    	border-radius: 5px;
    	border: 0.4px solid gray;
    	color: rgb(88, 88, 88); 
    	font-size: 14px; 
    	transition: all 0.3s ease;
    }
    
    .left-button:hover {
    	font-weight:500;
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
	
	/* ????????? */
    option {
    	font-size: 16px;
    }
    
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
    
   	#option {
   		padding: 2px 6px;
   		border-radius: 5px;
   		text-align: center;
   	}
   	
   	/* ?????????????????? ??????????????? css ?????? ??? ?????? ?????? (why? ??????????????? ????????? ???????????? ul li ??????) */
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
			<c:when test="${sessionScope.member_class eq '????????????'}">
			   <jsp:include page="../commons/memberSideBar4.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '?????????'}">
				<jsp:include page="../commons/adminSideBar4.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
			<form action="userList">
				<table id="top-table">
					<tr>
						<th><button class="button left-button" onclick="location.href='userList.go'" name="member_class" value="????????????">????????????</button></th>
				    	<th><button class="button right-button" onclick="location.href='userList.go'" name="member_class" value="?????????">?????????</button></th>
				    </tr>
				</table>
				<div class="search">	
					<input id="word" type="search" placeholder="???????????? ???????????????" name="word" value=""/>
					<input type="hidden" name="page" value="1"/>
					<input type="hidden" name="option" value="id"/>
					<input type="hidden" name="member_class" value="?????????"/>
					<input id="searchBtn" type="image" class="search-img" alt="search" src="../resources/images/search.png">
				</div>	
			</form>
			<table id="main-table">
				<thead>
					<tr>
						<th>????????? ?????????</th>
						<th>??????</th>		
						<th>?????????</th>
						<th>??????</th>	
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${list}" var="admin">
					<tr>
						<td>${admin.member_id}</td>
						<td>${admin.name}</td>
						<td>${admin.phone}</td>
						<td>${admin.gender}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		    <nav arial-label="Page navigation" style="text-align:center">
		        <ul class="pagination" id="pagination"></ul>
		    </nav>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script type="text/javascript">
var page = 1; // ?????? ????????? ??????

//?????? ?????? ???????????? ??? ??? ??? ?????????
$('#searchBtn').on('click',function(){
	
	$("#pagination").twbsPagination('destroy');
});

//??????????????? ????????? ????????? ??????
$("#pagination").twbsPagination({
	startPage:${map.page}, //?????? ????????? (page)
	totalPages:${map.pages}, //??? ?????????(?????? ????????? ??? / ??? ???????????? ????????? ????????? ???) (pages)
	visiblePages: 5, //??? ?????? ????????? ????????? ???
	initiateStartPageClick: false,
	onPageClick:function(e,page){
		//console.log(e); //????????? ???????????? ????????? ????????? ??????
		console.log(page); //???????????? ????????? ?????????
		// ????????? ??????????????? ???????????? ????????? ?????? ?????? session ??? ????????????
		location.href = "userList?page="+page+"&option="+"${sessionScope.option}"+"&word="+"${sessionScope.word}"+"&member_class="+"${sessionScope.member_class}";
	}
});

</script>
</html>