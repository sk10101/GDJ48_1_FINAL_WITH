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
	<script type="text/javascript" src="resources/js/jquery.twbsPagination.js"></script> <!-- 페이징 처리 -->
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
    
    
    
    #taxi-table,th,td {
    	border: 1px solid gray;
    	border-collapse: collapse;
    	padding: 2px 10px;
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
		<jsp:include page="../commons/memberSideBar2.jsp"/>
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
  			<button id="write" onclick="location.href='/recruit/Write.go'">글쓰기</button>
		    <div class="container">
		      <nav arial-label="Page navigation" style="text-align:center">
		         <ul class="pagination" id="pagination"></ul>
		      </nav>
		  	</div>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
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
         drawList(data.list);
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

function drawList(list){
   var content = '';
   list.forEach(function(taxi){
      console.log(taxi);
      content += '<tr>';
      content += '<td>'+item.idx+'</td>';
      content += '<td>'+item.subject+'</td>';
      content += '<td>'+item.user_name+'</td>';
      content += '<td>'+item.bHit+'</td>';
      content += '</tr>';
      
      /* content 에 들어갈 코드 */
      <table>
		<tr>
			<th colspan="4">${list.subject}</th>
		</tr>
		<tr>
			<th>출발지</th>
			<td>${list.appoint_place}</td>
			<th>작성자</th>
			<td>${list.member_id}</td>
		</tr>
		<tr>
			<th>도착지</th>
			<td>${list.destination}</td>
			<th>작성일</th>
			<td>${list.write_date}</td>
		</tr>
		<tr>
			<th>마감시간</th>
			<td>${list.recruit_end}</td>
			<th>조회수</th>
			<td>${list.hit}</td>
		</tr>
		<tr>
			<th>인원</th>
			<td>1/${list.member_cnt}</td>
			<td colspan="2">${list.deadline}</td>
		</tr>
	</table>
      
   });
   $('#list').empty();
   $('#list').append(content);
}
</script>
</html>