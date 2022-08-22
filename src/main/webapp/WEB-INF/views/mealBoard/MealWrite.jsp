<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<link rel="stylesheet" type="text/css" href="./resources/css/jquery.datetimepicker.css">
	<title>With</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="./resources/js/jquery.datetimepicker.full.min.js"></script>
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
    	color: rgb(88, 88, 88);
    	padding: 10px 10px;
    }
    
    #subject {
    	width: 80%;
    }
    
    textarea {
	    width: 100%;
	    height: 120px;
	    border-radius: 5px;
	    padding: 3px 5px;
	    resize: none;
  	}
    
    input[type="text"] {
    	border-radius: 5px;
    	padding: 3px 5px;
    	border: 1px solid gray;
    }
    
    .map-button {
   		padding: 3px 20px;
   		border-radius: 5px;
   		border: 0.4px solid rgb(88, 88, 88);
   		color: rgb(88, 88, 88);
   }
   
   .bottom-button {
   		margin: 10px 20px;
   		padding: 5px 20px;
   		border-radius: 5px;
   		border: none;
   		background-color: #537ef4;
   		color: #eaeaea;
   }
   
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
		<c:choose>
			<c:when test="${sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar3.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar3.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	    	 <form action="MealWrite.do" method="post" enctype="multipart/form-data">
				<table id="writeTable">
					<tr>
						<th>제목</th>
						<td><input id="subject" type="text" name="subject" placeholder="30자 이내" maxlength="30" required/></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea name="content" placeholder="500자 이내" maxlength="333" required></textarea></td>
					</tr>
					<tr>
					<tr>
						<th>성별</th>
						<td>
					      <label><input type="radio" name="gender" value="남자만"/> 남자만</label>
					      <label><input type="radio" name="gender" value="여자만"/> 여자만</label>
					      <label><input type="radio" name="gender" value="상관없음" checked/> 상관없음</label>
						</td>
					</tr>
					<tr>
						<th>약속장소</th>
						<td><input type="text" id="pInput" name="appoint_place" maxlength="66" required/>
						<input class="map-button" type="button" value="상세위치" onclick="showPopup()">
					</tr>
					<tr>
						<th>사진</th>
						<td><input type="file" name="photos" multiple="multiple"/></td>
					</tr>
					<tr>
						<th>모집인원</th>
						<td>
							<select name="member_cnt">
								<option value="1" selected>1</option>
								<option value="2">2</option>
								<option value="3">3</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>마감시간</th>
						<td>
							<input id="datetimepicker" type="text" name="deadline" required/>
						</td>
					</tr>
					<tr>
						<th colspan="2">
							<input class="bottom-button" type="submit" value="등록"/>
							<input class="bottom-button" type="button" value="돌아가기" onclick="history.back()"/>
						</th>
					</tr>
				</table>
			</form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
 function showPopup(){
    var width = 750;
    var height = 580;
    var top = (window.innerHeight - height) / 2 + screenY;
    var left = (window.innerWidth - width) / 2 + screenX;

    var spec = 'status=no, menubar=no, toolbar=no, resizable=no';
    spec += ', width=' + width + ', height=' + height;
    spec += ', top=' + top + ', left=' + left;
	 
    window.open("mealkakao.go","kakao map", spec);
} 
 
 /* 타임피커 관련 스크립트 */
	$('#datetimepicker').datetimepicker({
		format: 'Y-m-d H:i',
		lang: 'kr',
		mask:true,
		minDate:'-1970/01/01',
		maxDate:'+1970/01/07',
	 	allowTimes:[
		  '00:00', '00:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00',
		  '05:30', '06:00', '06:30', '07:00', '07:30', '08:00', '08:30', '09:00', '09:30', '10:00', '10:30',
		  '11:00', '11:30', '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00',
		  '16:30', '17:00', '17:30', '18:00', '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30',
		  '22:00', '22:30', '23:00', '23:30'
		]	  
	});

</script>
</html>