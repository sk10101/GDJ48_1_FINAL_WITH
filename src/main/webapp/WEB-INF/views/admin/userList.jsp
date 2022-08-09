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
	<jsp:include page="../commons/adminHeader.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/adminSideBar4.jsp"/>
	   <div class="content">
	   	<button onclick="location.href='userList'">일반회원</button>
	   	<button onclick="location.href='adminList'">관리자</button>  
			<form action="usersearch.do" method="get">
				<select name="opt">
					<option value="id">아이디</option>
					<option value="name">이름</option>
					<option value="university">대학교</option>
					<option value="certficate">인증여부</option>
				</select>
				<input type="text" name="keyword"/>
				<button>검색</button>
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
		<!-- <div class="container">
		    <nav arial-label="Page navigation" style="text-align:center">
		        <ul class="pagination" id="pagination"></ul>
		    </nav>
		</div> -->
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
/* var currPage = 1;

listCall(currPage);
//페이징 처리
$('#pagePerNum').on('change',function(){
     console.log("currPage: " + currPage);
  //페이지당 보여줄 수 변경시 계산된 페이지 적용이 안된다.(플러그인의 문제)
  //페이지당 보여줄 수 변경시 기존 페이지 요소를 없애고 다시 만들어 준다.
     $("#pagination").twbsPagination('destroy');
        listCall(currPage); 
});

//리스트 call 과정
function listCall(page) {
  //var id = $('#일반회원').val()
  var pagePerNum = 10;
  console.log("속성값 : " + pagePerNum);
  console.log("param page : " + page);
  $.ajax({
     type:'GET',
     url:'/mygrouplist.ajax',
     data:{
        cnt : pagePerNum,
        page : page
        //id : id
     },
     dataType:'JSON',
      success:function(data){
          console.log(data);
        drawList(data.mygrouplist);
        currPage = data.currPage;
        $("#pagination").twbsPagination({
              startPage:data.currPage,//시작 페이지
              totalPages: data.pages,//총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
               visiblePages: 5,//한번에 보여줄 페이지 수[1][2][3][4][5]
               onPageClick:function(e,page){
                   //console.log(e);//클릭한 페이지와 관련된 이벤츠 객체
                   console.log(page);//사용자가 클릭한 페이지
                   currPage = page;
                   listCall(page);
               }
        });
     },
     error:function(e) {
        console.log(e);
     }
  });
} */
</script>
</html>