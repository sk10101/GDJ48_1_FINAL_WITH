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
        min-height: 680px;
        /* background-color: #f4f4f4; */
        background-color: rgb(249, 249, 249);
    }
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar1.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	   		<form action="write" method="POST" enctype="multipart/form-data">
				<table>
					<tr>
						<th>제목</th>
						<td><input type="text" name="subject" placeholder="30자 이내"/></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><input type="text" name="content" placeholder="500자 이내"/></td>
					</tr>
					<tr>
						<th>성별</th>
						<td>
							<input type="radio" name="gender" value="남자만"/>남자만
							<input type="radio" name="gender" value="여자만"/>여자만
							<input type="radio" name="gender" value="상관없음" checked="checked"/>상관없음
						</td>
					</tr>
					<tr>
						<th>수령장소</th>
						<td>
							<input type="text" name="appoint_place"/>
							<input type="button" value="상세위치" onclick="showPopup()">
						</td>
					</tr>
					<tr>
						<th>사진</th>
						<td><input type="file" name="photos" multiple="multiple"/></td>
					</tr>
					<tr>
						<th>모집인원</th>
						<td>
							<select name="member_cnt">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>모집시간</th>
						<td>
							<input id="datetimepicker" type="text" name="deadline" required/>
						</td>
					</tr>
					<tr>
						<th>최소주문금액</th>
						<td><input type="text" name="min_delivery"/>원</td>
					</tr>
					<tr>
						<th>인당 최소<br>투자금액</th>
						<td><input type="text" name="min_fund"/>원</td>
					</tr>
					<tr>
						<th>배달료</th>
						<td><input type="text" name="delivery_fee"/>원</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="등록"/>
							<input type="button" value="돌아가기" onclick="history.back()"/>
						</td>
					</tr>
				</table>
			</form>

	   </div>
</div>
</body>
<script type="text/javascript">
	function showPopup(){
	    window.open("deliKakao.go","팝업 테스트","width=1000, height=1000, top=10, left=10");
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
<jsp:include page="../commons/footer.jsp"/>
</html>