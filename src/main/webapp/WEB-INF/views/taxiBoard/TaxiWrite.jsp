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
    
    #writeTable {
    	border-radius: 20px;
    	padding: 20px;
    	margin: 0 auto;
    	margin-top: 60px;
    	margin-bottom: 60px;
    	width: 600px;
    	box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
    }
    
    #writeTable th,td {
    	color: gray;
    	padding: 10px 10px;
    }
    
    input[type="text"] {
    	border-radius: 5px;
    	padding: 3px 5px;
    	border: 1px solid gray;
    }
    
    input[type="button"] {
   		padding: 2px 20px;
   		border-radius: 5px;
   		border: none;
   		background-color: #2962ff;
   		color: #eaeaea;
   }
   
   #editable{
		width: 99%;
		height: 150px;
		border: 1px solid gray;
		border-radius: 10px;
		margin: 5px;
		overflow: auto;
		padding : 5px;
		text-align: left;
	}
    

</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar2.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <form action="/taxiWrite" method="post">
		       <table id="writeTable">
		       		<tr>
		       			<th>제목</th>
		       			<td><input type="text" name="subject" placeholder="30자 이내" maxlength="30" required/></td>
		       		</tr>
		       		<tr>
		       			<th>내용</th>
	   					<td>
							<!-- html 태그를 인식 하기 위해 div 사용 (type="text"나 textarea 는 html 을 그냥 글자취급) -->
							<div id="editable" contenteditable="true"></div>
							<!-- 하지만 div 는 서버에 값을 전송 할 수 없다. -->
							<!-- 결국엔 div 의 내용을 input 에 담아 서버에 전송할 예정 -->
							<input type="hidden" name="content" id="content"/>
						</td>
		       		</tr>
		       		<tr>
	  			    	<th>교육분야</th> <!-- recruit 테이블의 recruit_field 에 값을 insert 해줘야함 -->
		    			<td colspan="3">
					      <label><input type="radio" name="gender" value="남자"/> 남자만</label>
					      <label><input type="radio" name="gender" value="여자"/> 여자만</label>
					      <label><input type="radio" name="gender" value="상관없음" checked/> 상관없음</label>
		    			</td>
				    </tr>
				    <tr>
		       			<th>출발지</th>
		       			<td>
			       			<input type="text" name="appoint_place" maxlength="66" required/>
			       			<input type="button" value="상세위치" onclick=""/>
		       			</td>
		       		</tr>
				    <tr>
		       			<th>도착지</th>
		       			<td><input type="text" name="appoint_place" maxlength="66" required/></td>
		       		</tr>
		   			<tr>
		   				<th>사진</th>
						<td colspan="2">
							<input type="button" value="파일 업로드" onclick="fileUp()"/>					
						</td>
					</tr>
		       		<tr>
		       			<th>모집인원</th>
		       			<td>
			       			<select name='member_cnt'>
								  <option value='1' selected>1</option>
								  <option value='2'>2</option>
								  <option value='3'>3</option>
							</select>
						</td>
		       		</tr>
	   				<tr>
		   				<th>마감시간</th>
						<td>
							<input type="datetime-local" name="deadline" required/>					
						</td>
					</tr>
			        <tr>
			            <th colspan="2">
			               <input type="button" value="등록" onclick="save()"/>
			               <input type="button" value="돌아가기" onclick="location.href='/taxiList'"/>
			            </th>
			        </tr>  
		       </table>
		       
	       </form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
function save(){
	$('#content a').removeAttr('onclick');
	$('#content').val($('#editable').html());
	$('form').submit();
}


function fileUp(){
	window.open('taxiUploadForm','','width=400, height=100');
}

function del(elem){
	console.log(elem);
	// id 에서 삭제할 파일명을 추출
	var id = $(elem).attr("id")
	var fileName = id.substring(id.lastIndexOf("/")+1);
	console.log(fileName);
	//해당 파일 삭제 요청
	$.ajax({
		url:'fileDelete',
		type:'get',
		data:{'fileName':fileName},
		dataType:'json',
		success:function(data){
			console.log(data);
			// a 태그를 포함한 img 태그를 삭제
			$(elem).remove();
		},
		error:function(e){
			console.log(e);
		}
	});
}
</script>
</html>