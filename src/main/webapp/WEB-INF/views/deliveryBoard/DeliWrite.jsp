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
							<input type="radio" name="gender" value="남자만" checked="checked"/>남자만
							<input type="radio" name="gender" value="여자만"/>여자만
							<input type="radio" name="gender" value="상관없음"/>상관없음
						</td>
					</tr>
					<tr>
						<th>수령장소</th>
						<td>
							<input type="text" name="appoint_place"/>
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
							<select name="deadline">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
							</select> 시간
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
			<!-- 상세위치 설정 부분-->
			<p>상세위치를 마커로 표시해주세요.</p>
			<!-- Kakao Map API 부분 -->
			<div id="deliMap" style="width:500px;height:350px;"></div>
	      				
			
			

	   </div>
</div>
</body>
<script type="text/javascript">
	var loginId = 'tester';
	
	// 로그인한 아이디의 대학교 주소를 가져온다
	$.ajax({
		type:'get',
		url:'detailMarker.ajax',
		data:{
			loginId:loginId				
		},
		dataType:'json',
		success:function(data){
			console.log(data.university_addr);
			searchMap(data.university_addr);
			
		},
		error:function(e){
			console.log(e)
		}
	});
	
	var mapContainer = document.getElementById('deliMap'); // 지도를 표시할 div 
	var mapOption = {
	        center: new kakao.maps.LatLng(37.45975, 126.95109), // 지도의 중심좌표
	        level: 3, // 지도의 확대 레벨
	        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도의 종류
	    };

	// 지도 생성
  	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	// 지도에 확대 축소 컨트롤을 생성한다
	var zoomControl = new kakao.maps.ZoomControl();

	// 지도의 우측에 확대 축소 컨트롤을 추가한다
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	// 좌표 객체 초기화
	var marker = null;
	
	// 지도에 마커를 생성하고 표시한다
	var marker = new kakao.maps.Marker({
	    position: new kakao.maps.LatLng(37.45975, 126.95109), // 마커의 좌표(기본 디폴트 값 설정필요)
	    map: map // 마커를 표시할 지도 객체
	});
	
	// 클릭한 위치의 좌표를 가져오고 마커를 찍어주는 함수
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng;
	    
	    // DB 에 담기위해 경도 위도를 반환 한다. (Number 형식)
	    var lat = latlng.getLat();
	    var lng = latlng.getLng();
	    console.log(lat.toString(),lng.toString()); // (yyy xxx) 형식
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    
	    // 마커 위치를 찍은 곳으로 지도의 중심을 이동 (이건 쓸지 말지 고려해봐야 할듯...)
	    map.setCenter(latlng);
	});
		
	function searchMap (university_addr) {
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 
	
		// 키워드로 장소를 검색합니다
		ps.keywordSearch(university_addr, placesSearchCB); 
	
		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
	
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();
	
		        for (var i=0; i<data.length; i++) {
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       
	
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		} 
		
	}
</script>
<jsp:include page="../commons/footer.jsp"/>
</html>