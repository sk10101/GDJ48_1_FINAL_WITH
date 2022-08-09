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
    /* 양수빈 CSS 작업[삭제 해도 됨] */
    .myinfo th, td {
	    border: 1px solid #000000;
	    padding: 8px;
  	}
  	.myinfo th{
  		background-color : #2962ff;
  		color:#ffffff;
  	}
  	.myinfo td{
  		padding-right:400px;
  	}
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar4.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     	<table class="myinfo" style="margin-left:180px;">
            	<thead>
	            	<tr>
	            		<th>친절함</th>
	            		<th>응답속도</th>
	            		<th>시간약속</th>
	            		<th>평가일</th>
	            	</tr>
            	</thead>
            	<tbody id="list">
            	
            	</tbody>
            </table>
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

function listCall(){
   
   var pagePerNum = 5;
   console.log("param page : " +page);
   $.ajax({
      type:'GET',
      url:'mannerlist.ajax',
      data:{
         cnt : pagePerNum,
         page : page
         },
      dataType:'JSON',
      success:function(data){
         console.log(data);
         drawList(data.list);
         currPage = data.currPage;
         //불러오기가 성공되면 플러그인을 이용해 페이징 처리
         $("#pagination").twbsPagination({
           startPage: data.currPage,//시작 페이지
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
      error:function(e){
         console.log(e);//
      }
   });
}

function drawList(list){
    var content = '';
    list.forEach(function(item){
       var date = new Date(item.qna_date); 
       console.log(item);
       content += '<tr>';
       content += '<td>'+item.+'</td>';
       content += '<td><a href="qnadetail.go?qna_idx='+item.qna_idx+'">'+item.qna_title+'</a></td>';
       content += '<td>'+item.mb_id+'</td>';
       content += '<td>'+date.toLocaleDateString("ko-KR")+'</td>';
       <!--if(item.qna_answer_chk == false ){
          content += '<td>'+"미답변"+'</td>';      
       }else {content += '<td>'+"답변완료"+'</td>';   
       }-->
       content += '</tr>';
    });
    $('#list').empty();
    $('#list').append(content);
 }
</script>
</html>