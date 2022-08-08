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
    
    td.subject {
    	border: 1px solid;
    	border-radius : 20px;
    	color:white;
    	background-color:#2962ff;
    }
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar1.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     	<table>
	     		<tr>
	     			<td class='subject'>${info.subject}</td>
	     		</tr>
				<tr>
					<td>약속장소 : ${info.appoint_place}</td>
					<td>작성자 : ${info.member_id}</td>
				</tr>
				<tr>
					<td>모인금액 : (모은금액) / ${info.min_delivery}</td>
					<td>작성일 : ${info.write_date}</td>
				</tr>
				<tr>
					<td>배달료 : ${info.delivery_fee}</td>
					<td>조회수 : ${info.hit}</td>
				</tr>
				<tr>
					<td>마감시간 : ${info.deadline}</td>
					<td>인원 : (현재 인원) / ${info.member_cnt}</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td>인당 최소비용 : ${info.min_fund}</td>
					<c:if test="${info.recruit_end eq 0}"><td><span style="border:1px solid black; background-color:#2962ff;">모집중</span></td></c:if>
					<c:if test="${info.recruit_end eq 1}"><td><span style="border:1px solid black; background-color:red;">마감</span></td></c:if>
				</tr>
				<tr>
					<td><img alt="성별제한" src="../resources/images/gender.png" style="width:20px; height:20px;"> ${info.gender}</td>
					<td><span style="border:1px solid black; background-color:red;">신고</span></td>
				</tr>
			</table>
			<hr>
			<table>
				
				<tr>
					<td>이미지 추가해야함${info.content}</td>
				</tr>
			</table>
			<hr> 
			<!-- 아래부터 참여현황 -->
			<table>
				<tr>
					<th><img alt="참여현황" src="../resources/images/people.png" style="width:20px; height:20px;">참여현황</th>
				</tr>
				<tr>
					<th>아이디</th>
					<th>성별</th>
					<th>금액</th>
					<th>연락처</th>
					<th>평가</th>
					<c:if test="${info.member_id eq 'tester'}"><th>강퇴</th></c:if>
				</tr>
			</table>
			<!-- 아래부터 Kakao Map API 구역 -->
			<div id="map" style="width:500px;height:350px;"></div>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
	
	var lat = '${}'; // 위도
	var lng = '${}'; // 경도
	
	//지도를 그리기 위한 옵션 설정
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.45975, 126.95109), // 지도의 중심좌표
	        level: 3, // 지도의 확대 레벨
	        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도의 종류
	    };
</script>
</html>