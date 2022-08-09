<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    
    table, td {
    	border : 1px solid black;
    	border-radius: 10px;
    	text-align: center;
    }
    
    a {
    	text-decoration : none;
    	color : blue;
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
	<jsp:include page="../commons/memberSideBar3.jsp"/>
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
	<div class="container">
         <nav aria-label="Page navigation" style="text-align:center">
               <ul class="pagination" id="pagination"></ul>               
         </nav>
   </div>
   		<select class="selectBtn" id="pagePerNum">
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="15" selected="selected">15</option>
			<option value="20">20</option>
    	</select>
    	<select id="option" name="option">
               <option value="제목">제목</option>
               <option value="약속장소">약속장소</option>
               <option value="아이디">아이디</option>
           </select>
           
           <input class="Search" id="word" type="search" placeholder="검색" name="word" value=""/>
     	<input class="SearchDo" id="searchBtn" type="button" onclick="searchList(currPage)" value="검색"/>
           <br>
           <br>
      		<button onclick="location.href='MealWrite.go'">글 쓰기</button> 
		
		<table class="meal" id="meal_table">
			<!--  
			<c:if test="${list.size() == 0}">
				<tr><td colspan="6">등록된 글이 없습니다.</td></tr>
			</c:if>
			<c:forEach items="${list}" var="meal">
				<tr>
					<td colspan="2"><a href="MealDetail?board_idx=${meal.board_idx}">제목 : ${meal.subject}</a></td>
				</tr>
				<tr>
					<td>약속장소 : ${meal.appoint_place}</td>
					<td>작성자 : ${meal.member_id}</td>
				</tr>
				<tr>
					<td>마감시간 : ${meal.deadline}</td>
					<td>작성일 : ${meal.write_date}</td>
				</tr>
				<tr>
					<td>인원 : (현재 인원) / ${meal.member_cnt}</td>
					<td>조회수 : ${meal.hit}</td>
				</tr>
				<tr>
					<td></td>
					<c:if test="${meal.recruit_end eq 0}"><td><span style="border:1px solid black; background-color:#2962ff;">모집중</span></td></c:if>
					<c:if test="${meal.recruit_end eq 1}"><td><span style="border:1px solid black; background-color:red;">마감</span></td></c:if>
				</tr>
		</c:forEach> -->
		<tbody id="mealList">
	       
		</tbody>
		</table>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
	// 현재 페이지 정보를 변수에 담는디.
	var currPage=1;
    listCall(currPage);
    
  	//게시물 갯수 선택 요소에 이벤트 걸어줌 - 갯수 변경 -> change 이벤트
    $('#pagePerNum').on('change',function(){ //pagePerNum 에 change가 일어나게 되면
    	var word = $('#word').val();
    	console.log(word);
    	console.log("currPage : " +currPage);		
    	// 페이지당 보여줄 수 변경 시 계산된 페이지 적용이 안된다. (플러그인의 문제)
    	// 페이지당 보여줄 수 변경 시 기존 페이징 요소를 없애고 다시 만들어 준다.
    	$("#pagination").twbsPagination('destroy');
    	if(word==null || word==""){
    		listCall(currPage);
    	} else {
    		searchList(currPage)
    	}
    });
       
	$('#searchBtn').on('click',function(){	
		$("#pagination").twbsPagination('destroy');
		searchList(currPage);
	});
	
function listCall(page){	
        
        var pagePerNum = $('#pagePerNum').val();
        console.log("param page : "+page);
        $.ajax({
            type:'GET',
            url:'mealList.ajax',
            data:{
            	cnt : pagePerNum,
				page : page,
				//mb_id : mb_id,
				//mb_class : mb_class
            },
            dataType:'json',
            success:function(data){
                console.log(data);
                drawList(data.mealList);
                currPage = data.currPage;
                
                //불러오기가 성공되면 플러그인을 이용해 페이징 처리
                $("#pagination").twbsPagination({
                    startPage:data.currPage, //시작 페이지
                    totalPages:data.pages, //총 페이지(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
                    visiblePages:10, //한 번에 보여줄 페이지 수 [1][2][3][4][5]
                    onPageClick:function(e,page){
                        //console.log(e); //클릭한 페이지와 관련된 이벤트 객체
                        console.log(page); //사용자가 클릭한 페이지
                        //currPage = page;
                        listCall(page);
                    }
                });
                
                
            },
            error:function(e){
                console.log(e);
            }
        });
    }
    
function drawList(mealList){
    var content = '';
    mealList.forEach(function(meal){
        // console.log(dto);
        //if(meal.category_id == "식사") {
            content += '<tr>';
            content += '<td colspan="2"><a href="MealDetail?board_idx='+${meal.board_idx}'">'+제목 +':'+ ${meal.subject}'</a></td>';
            content += '</tr>';
            content += '<tr>';
            content += '<td>'+약속장소 +':'+ ${meal.appoint_place}+'</td>';
            content += '<td>'+작성자 +':'+ ${meal.member_id}+'</td>';
            content += '</tr>';
            content += '<tr>';
            content += '<td>'+마감시간 +':'+ ${meal.deadline}+'</td>';
            content += '<td>'+작성일 +':'+ ${meal.write_date}+'</td>';
            content += '</tr>';
            content += '<tr>';
            content += '<td>'+인원 +':'+ (현재 인원) +'/'+ ${meal.member_cnt}+'</td>';
            content += '<td>'+조회수 +':'+ ${meal.hit}+'</td>';
            content += '</tr>';
            content += '<tr>';
            content += '<td></td>'
            if(meal.recruit_end == "0"){
            	content += '<td>모집중</td>';
            }else {
            	content += '<td>마감</td>';
            }
            content += '</tr>'; 
        //}
   		});
    $('#mealList').empty();
    $('#mealList').append(content); 
    //tbody에 뿌려줌
    
    function searchList(page){
    	var word = $('#word').val();
    	var option = $('#option').val();
    	var pagePerNum = $('#pagePerNum').val();
    	console.log(word);
    	
    	$.ajax({
    		type: 'GET',
    		url: 'mealList.ajax',
    		data:{
    			cnt : pagePerNum,
				page : page,
				word : word,
				option : option
				//mb_id : mb_id,
				//mb_class : mb_class
    		},
    		dataType:'JSON',
    		success: function(data){
    			// 테이블 초기화
    			$("#mealList").empty();
    			drawList(data.mealList);
    			console.log(data);
    			currPage = 1;
    			// 불러오기를 성공하면 플러그인을 이용해 페이징 처리를 한다.
    			$("#pagination").twbsPagination({
    				startPage: 1, // 시작 페이지
    				totalPages: data.pages, // 총 페이지 수(전체 게시물 수 / 한 페이지에 보여줄 게시물 수)
    				visiblePages: 5, // 한 번에 보여줄 페이지 수 ( ex)[1],[2],[3],[4],[5] ...)
    				onPageClick: function(e, page) {
    					console.log(page); // 사용자가 클릭한 페이지
    					currPage = page;
    					searchList(page);
    				}
    			})
    		},
    		error:function(e){
    			console.log(e);
    		}
    	});	
    }
    
	
</script>
</html>