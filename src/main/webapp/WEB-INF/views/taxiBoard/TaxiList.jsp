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
	<script type="text/javascript" src="./resources/js/jquery.twbsPagination.js"></script> <!-- 페이징 처리 -->
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
    
    #table-wrap {
        max-width: 1040px;
        width: 100%;
    }
    
    .taxiList {
    	margin: 0 auto;
    	margin-top: 40px;
    	border-radius: 20px;
    	width: 600px;
    	background-color: #537ef4;
    	box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
    	background-image: linear-gradient(#537ef4, #2196f3);
    	transition: all 0.3s ease;
    }
    
    .taxiList:hover {
        transform: scale(1.03);
    }
    
    .taxiList th, td {
    	color: #eaeaea;
    	padding: 3px 15px;
    	font-size: 14px;
    }
    
    .taxiList tr:first-child > th {
    	padding-top: 15px;
    	padding-bottom: 15px;
    	font-size: 16px;
    }
    
    .taxiList tr:last-child th {
    	padding-bottom: 15px;
    }
    
    .taxiList tr:last-child td:last-child {
    	text-align: right;
    }
  
</style>
<body>
	<%-- <jsp:include page="../commons/header.jsp"/> --%>
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
		<%-- <jsp:include page="../commons/memberSideBar2.jsp"/> --%>
		<!-- 
		<c:choose>
			<c:when test="회원등급이 일반회원일때">
			   <jsp:include page="../commons/memberSideBar2.jsp"/>
			</c:when>
			<c:when test="회원등급이 관리자일때">
				<jsp:include page="../commons/adminSideBar2.jsp"/>
			</c:when>
		</c:choose>
		 -->
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <div id="table-wrap">
	       
	       </div>
  			<button id="write" onclick="location.href='/taxiWrite'">글쓰기</button>
		    <div class="container">
		      <nav arial-label="Page navigation" style="text-align:center;">
		         <ul class="pagination" id="pagination"></ul>
		      </nav>
		  	</div>
	   </div>
	</div>
	<%-- <jsp:include page="../commons/footer.jsp"/> --%>
</body>
<script>
var currPage = 1;

listCall(currPage);

function listCall(page){
   
   var pagePerNum = 10;
   
   $.ajax({
      type:'GET',
      url:'taxiList.ajax',
      data:{
         cnt : pagePerNum,
         page : currPage
         },
      dataType:'JSON',
      success:function(data){
         console.log(data);
         drawList(data.taxiList);
         currPage = data.currPage;
         
         //불러오기가 성공되면 플러그인을 이용해 페이징 처리
         $("#pagination").twbsPagination({
           startPage:data.currPage,//시작 페이지
           totalPages:data.pages,//총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
            visiblePages:5,//한번에 보여줄 페이지 수[1][2][3][4][5]
            onPageClick:function(e,page){
               //console.log(e);//클릭한 페이지와 관련된 이벤츠 객체
               console.log(page);//사용자가 클릭한 페이지
               currPage = page;
               listCall(page);
            }
         });
         
      },
      error:function(e){
         console.log(e);
      }
   });
}

function drawList(taxiList){
   var content = '';
   taxiList.forEach(function(taxi){
	  
	  // 작성일(타임스탬프)을 날짜 형식으로 변환 
      var date = new Date(taxi.write_date);
      var yyyy = date.getFullYear();
      var mm = date.getMonth() + 1;
      var dd = date.getDate();
      
   	  // 마감시간(타임스탬프)을 날짜 및 시간 형식으로 변환 (해결중)
      var date1 = new Date(taxi.deadline);
      var yyyy1 = date1.getFullYear();
      var mm1 = date1.getMonth() + 1;
      var dd1 = date1.getDate();
      var hh1 = date1.getHours();
      var mm1 = date1.getMinutes();
      var ss1 = date1.getSeconds();
      
      var write_date = yyyy + "-" + mm + "-" + dd;
      var deadline = yyyy1 + "-" + mm1 + "-" + dd1 + " " + hh1 + ":" + mm1 + ":" + ss1;
      
	   
      console.log(taxi);
      content += '<table class="taxiList">';
      content += '<tr>';
      content += '<th colspan="4">'+taxi.subject+'</th>';
      content += '</tr>';
      content += '<tr>';
      content += '<th>출발지</th>';
      content += '<td>'+taxi.appoint_place+'</td>';
      content += '<th>작성자</th>';
      content += '<td>'+taxi.member_id+'</td>';
      content += '</tr>';
      content += '<tr>';
      content += '<th>도착지</th>';
      content += '<td>'+taxi.destination+'</td>';
      content += '<th>작성일</th>';
      content += '<td>'+write_date+'</td>';
      content += '</tr>';
      content += '<tr>';
      content += '<th>마감시간</th>';
      content += '<td>'+deadline+'</td>';
      content += '<th>조회수</th>';
      content += '<td>'+taxi.hit+'</td>';
      content += '</tr>';
      content += '<tr>';
      content += '<th>인원</th>';
      content += '<td>현재인원 / '+(taxi.member_cnt + 1)+'</td>';
      if (taxi.recruit_end == 0) {
    	  content += '<td colspan="2"><span style="padding: 5px 10px; background-color: #2962ff; border-radius: 5px;">모집중</span></td>';  
      } else {
    	  content += '<td colspan="2"><span style="padding: 5px 10px; background-color: #f44336; border-radius: 5px;">마감</span></td>';
      }
      content += '</tr>';
      content += '</table>';
   });
   
   $('#table-wrap').empty();
   $('#table-wrap').append(content);
}
</script>
</html>