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
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=303e3eb3eab9c15e38c80a5c6f8d0caf&libraries=services"></script>
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
        padding: 60px 100px;
    }
    
    table {
    	width: 100%;
    }
    
    table,th,td {
    	border: 1px solid black;
    }
    
    #gender {
    	width: 30px;
    }
    
    #people {
    	width: 30px;
    }
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar2.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <table>
	       		<tr>
	       			<input type="hidden" name="${list.board_idx}"/>
	       			<th>${list.subject}</th>
	       		</tr>
	       		<tr>
	       			<th>출발지 : </th>
	       			<td>${list.appoint_place}</td>
	       			<th>작성자 : </th>
	       			<td>${list.member_id}</td>
	       		</tr>
	       		<tr>
	       			<th>도착지 : </th>
	       			<td>${list.destination}</td>
	       			<th>작성일 : </th>
	       			<td>${list.write_date}</td>
	       		</tr>
	       		<tr>
	       			<th>마감시간 : </th>
	       			<td>${list.deadline}</td>
	       			<th>조회수 : </th>
	       			<td>${list.hit}</td>
	       		</tr>
	       		<tr>
	       			<th>인원 : </th>
   					<td>${count} / ${list.member_cnt}</td>
	       		</tr>
	       		<tr>
					<c:if test="${list.recruit_end eq 0}">
						<td colspan="4" style="text-align: right">
							<span style="padding: 3px 10px; border-radius: 5px; background-color: #2962ff">모집중</span>
						</td>
					</c:if>
					<c:if test="${list.recruit_end eq 1}">
						<td colspan="4" style="text-align: right">
							<span style="padding: 3px 10px; border-radius: 5px; background-color: #e53935">마감</span>
						</td>
					</c:if>
	       		</tr>
	       		<tr>
	       			<th>
	       				<img id="gender" src="./resources/images/gender.png" alt="gender"/> ${list.gender}
	       			</th>
	       			<td colspan="3" style="text-align: right"><input type="button" value="신고" onclick="location.href='/report?idx=${list.board_idx}'"/></td>
	       		</tr>
	       		<tr>
	       			<td colspan="4"><hr/></td>
	       		<tr>
				<c:if test="${taxiPhotoList.size()>0}">
		            <tr>
		                <td>
			                <c:forEach items="${photo}" var="path">
									<img src="./resources/photo/${path.newFileName}" width="500px"/>
							</c:forEach>
						</td>
		            </tr>
            	</c:if>
	       		<tr>
	       			<td colspan="4">${list.content}</td>
	       		</tr>
	       </table>
	       <table>
	       		<tr>
	       			<th><img id="people" src="./resources/images/people.png" alt="people"/> 참여현황</th>
	       		</tr>
	       		<tr>
		       		<c:forEach items="${pt}" var="pt">
			       			<td>${pt.member_id}</td>
			       			<td>${pt.gender}</td>
			       			<td>${pt.phone}</td>
			       			<td><input type="button" class="manner" value="평가하기" onclick="location.href='mannerDo'"/></td>
		       		</c:forEach>
	       		</tr>
	       </table>
	       <table>
	       		<tr>
	       			<td>
						<!-- 아래부터 Kakao Map API 구역 -->
						<input type="hidden" id="lat" value="${list.appoint_coords_lat}"/>
						<input type="hidden" id="lng" value="${list.appoint_coords_lng}"/>
						<div id="map" style="width:500px;height:350px;"></div>	       			
	       			</td>
	       		</tr>
	       		<tr>
	       			<td>
						<input type="button" value="참여신청" onclick="location.href=''"/>
					</td>
	       		</tr>
	       		<tr>
	       			<td>
		       			<input type="button" value="삭제" onclick="location.href=''"/>
						<input type="button" value="돌아가기" onclick="history.back()"/>
					</td>
	       		</tr>
	       </table>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
	var lat = $("#lat").val(); // 위도
	var lng = $("#lng").val(); // 경도
	
	console.log(lat,lng);
	//지도를 그리기 위한 옵션 설정
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
	        level: 3, // 지도의 확대 레벨
	        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도의 종류
	    };
	
	// 지도 생성
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	// 지도에 확대 축소 컨트롤을 생성한다
	var zoomControl = new kakao.maps.ZoomControl();
	
	// 지도의 우측에 확대 축소 컨트롤을 추가한다
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	// 지도에 마커를 생성하고 표시한다
	var marker = new kakao.maps.Marker({
	    position: new kakao.maps.LatLng(lat, lng), // 마커의 좌표(기본 디폴트 값 설정필요)
	    map: map // 마커를 표시할 지도 객체
	});

</script>
</html>