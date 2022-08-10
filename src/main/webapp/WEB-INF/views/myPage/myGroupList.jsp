<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<!-- 페이징 처리 -->
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

.container {
	position: relative;
	right: 100px;
}
</style>
<body>
	<%-- <jsp:include page="../commons/header.jsp" /> --%>
	<div class="content-wrap">
		<%-- <jsp:include page="../commons/memberSideBar5.jsp" /> --%>
		<div class="content">
			<!-- 여기에서 작업 시작하세요 -->
			<form action="mygrouplist.go" method="get">
				<table>
					<tr>
						<th><input type="radio" name="member" value="내가 만든 모임"
							checked="checked">내가 만든 모임</th>
						<td><input type="radio" name="member"
							onclick="window.location.href='/myApplyList.go';"
							value="내가 참여한 모임">내가 참여한 모임</td>
						<td>
					</tr>
				</table>
			</form>
			
			${msg}
			<form action="mygroupsearch.do" method="get">
				<fieldset>
					<select name="opt">
						<option value="subject">제목</option>
						<option value="category">이용 서비스</option>
						<option value="status">상태</option>
					</select> <input type="text" name="keyword" placeholder="검색어를 입력 하세요" />
					<button>검색</button>
				</fieldset>
			</form>

			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>이용 서비스</th>
						<th>제목</th>
						<th>작성일</th>
						<th>신청자 수</th>
						<th>상태</th>
						<th></th>
					</tr>

				</thead>
				<tbody>
					<c:forEach items="${mygList}" var="his">
						<tr>
							<td>${his.board_idx}</td>
							<td>${his.category_id}</td>
							<td><a href="detail.go?board_idx=${his.board_idx}&category_id=${his.category_id}'">${his.subject}</a></td>
							<td>${his.write_date}</td>
							<td>${his.member_id}</td>
							<c:if test="${his.recruit_end eq 0}"><td><span style="border:1px solid black; background-color:#2962ff;">모집중</span></td></c:if>
							<c:if test="${his.recruit_end eq 1}"><td><span style="border:1px solid black; background-color:red;">마감</span></td></c:if>
						</tr>
					</c:forEach>
				</tbody>

			</table>
			<!-- <input id="button3" type="button" onclick="close()" value="마감" />
			<div class="container">
               <nav arial-label="Page navigation" style="text-align:center">
               <ul class="pagination" id="pagination"></ul>
				</nav>
			</div> -->
		</div>
	</div>
	<%-- <jsp:include page="../commons/footer.jsp" /> --%>
</body>
<script>
	/*var msg = "${msg}";

	if (msg != "") {
		alert(msg);
	}
	 */
	 

	 /*
	 var currPage = 1;
	 
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
	}
	
	function drawList(mygrouplist) {
		var content = '';
		mygrouplist.forEach(function(item){
			var date = new Date(item.write_date);
			console.log("아이템 : "+item);
			content += '<tr>';
			content += '<td>'+item.board_idx+'</td>';
			content += '<td>'+item.category_id+'</td>';
			content += '<td><a href="detail.go?board_idx='+item.board_idx+'&category_id='+item.category_id+'">'+item.subject+'</a></td>';
			content += '<td>'+date.toLocaleDateString("ko-KR").replace(/\.$/, '')+'</td>';
			content += '<td>'+item.member_id+'</td>';
			if (item.recruit_end == 0) {
				content += '<td>'+"모집중"+'</td>';
			}else{
				content += '<td>'+"마감"+'</td>';
			}
			content += '</tr>';
		});
		$('#mygrouplist').empty();
	    $('#mygrouplist').append(content);
	}
*/
	
	
	
	
	/* $('#all').click(function(){
	
	 var $chk = $('input[type="checkbox"]');	//체크박스를 모두 가져옴
	
	 if($(this).is(":checked")){
	 $chk.prop("checked",true);	
	 }else{
	 $chk.prop("checked",false);
	 }
	
	 });



	 function boardHisdel(){
	 var idx = "${sessionScope.loginId}";
	 var chkarr=[];
	 //check 된 체크박스의 값을 가져온다.
	 $('#list input[type="checkbox"]:checked').each(function(idx,item){
	 chkarr.push($(this).val());
	 });
	
	 console.log(chkarr);
	
	 //체크된 박스들 아작스로 컨트롤에 보내기
	 $.ajax({
	 type:'get',
	 url:'/boardHisdel.ajax',
	 data:{boarddelList:chkarr,
	 idx : idx,	
	 },
	 dataType:'JSON',
	 success:function(data){
	 console.log(data);
	 if(data.login){
	 location.href='/boardHistory.go';
	 listCall(currPage);
	 alert(data.msg);
	 }else{
	 alert("로그인이 필요한 서비스 입니다.");
	
	 }
	 },
	 error:function(e){
	 console.log(e);
	 }
	 });
	
	 } */
</script>
</html>