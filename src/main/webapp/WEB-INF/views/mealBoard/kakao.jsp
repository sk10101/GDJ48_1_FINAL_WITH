<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>약속장소 상세위치</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=303e3eb3eab9c15e38c80a5c6f8d0caf&libraries=services"></script>
<style>
    .search-img {
    	width: 30px;
    	position: relative;
    	top: 8px;
    	left: 5px;
    }
    
    #kakao-table {
    	margin: 0 auto;
    }
    
    #kakao-table tr:first-child th {
		padding-bottom: 15px;
	}
	
    #kakao-table tr:first-child th input:first-child {
		width: 200px;
		border-radius: 5px;
		border: 0.4px solid gray;
		padding: 3px 10px;
	}
	
	#kakao-table tr:last-child th {
		padding-top: 15px;
	}
	
	#kakao-table tr:last-child th input {
		padding: 5px 20px;
		background-color: #537ef4;
		border-radius: 5px;
		border: none;
		color: #eaeaea;
	}
</style>
</head>
<body>
		<table id="kakao-table">
			<tr>
				<th>
					<input type="text" id="search" placeholder="장소를 입력하세요"/>
					<!-- <input type="button" value="검색" onclick="search()"> --> 
					<input id="searchBtn" type="image" class="search-img" alt="search" src="../resources/images/search.png" onclick="search()"/>
				</th>
			</tr>
		<form action="getCoord" id="getCoord">
			<tr>
				<th>
					<input type="hidden" id="lat" name="lat" value=""/>
					<input type="hidden" id="lng" name="lng" value=""/>
					<div id="mealMap" style="width:90vw; height:75vh;"></div>
				</th>		
			</tr>
			<tr>
				<th>
					<input type="submit" value="확인" id="close_button"/>
				</th>
			</tr>		
		</table>
		</form>
<script>
	
	var loginId = "${sessionScope.loginId}";
	var lat;
	var lng;
	
	// 로그인한 아이디의 대학교 주소를 가져온다
	$.ajax({
		type:'get',
		url:'mealMarker.ajax',
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

	var mapContainer = document.getElementById('mealMap'); // 지도를 표시할 div
	
	// 주소-좌표 변환 객체를 생성합니다 (초기 위치를 본인의 대학교로 잡기 위함)
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	function startMap(univAddr) {
		geocoder.addressSearch(univAddr, function(result, status) {
	
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
	
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});    
	}
	
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
	
	function search(){
		// 키워드로 장소를 검색합니다
		searchMap($("#search").val()) 
	
	}

	
	function searchMap(mapKeyword) {
		
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 
	
		// 키워드로 장소를 검색합니다
		ps.keywordSearch(mapKeyword, placesSearchCB); 
	
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
	
	// 좌표 객체 초기화
	var marker = new kakao.maps.Marker({
		// position: new kakao.maps.LatLng(37.45975, 126.95109), // 마커의 좌표(기본 디폴트 값 설정필요)
	    map: map // 마커를 표시할 지도 객체
	});
	
	// 클릭한 위치의 좌표를 가져오고 마커를 찍어주는 함수
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng;
	    
	    // DB 에 담기위해 경도 위도를 반환 한다. (Number 형식)
	    lat = latlng.getLat();
	    lng = latlng.getLng();
	    console.log(lat.toString(),lng.toString()); // (yyy xxx) 형식
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    
	    // 마커 위치를 찍은 곳으로 지도의 중심을 이동 (이건 쓸지 말지 고려해봐야 할듯...)
	    // map.setCenter(latlng);
	    
	    // 위도 경도를 위의 input 에 입력
	    $("#lat").val(lat);
	    $("#lng").val(lng);
	});
	
	$("#close_button").click(function(){
		$('#getCoord').submit();
		setTimeout(function() { 
			window.close();
		 }, 5);
    });
	
</script>
</body>
</html>