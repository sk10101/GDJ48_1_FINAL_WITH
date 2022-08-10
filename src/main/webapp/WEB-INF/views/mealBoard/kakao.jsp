<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style></style>
</head>
<body>
<!-- 지도를 표시할 div 입니다 -->
<input type="hidden" id="lat" value="${info.appoint_coords_lat}"/>
<input type="hidden" id="lng" value="${info.appoint_coords_lng}"/>
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=502f29438dec8c47b28f94e6dff67dc4"></script>

<script>
var lat = $("#lat").val(); // 위도
var lng = $("#lng").val(); // 경도

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 

//지도에 확대 축소 컨트롤을 생성한다
var zoomControl = new kakao.maps.ZoomControl();

//지도에 마커를 생성하고 표시한다
var marker = new kakao.maps.Marker({
    position: new kakao.maps.LatLng(lat, lng), // 마커의 좌표(기본 디폴트 값 설정필요)
    map: map // 마커를 표시할 지도 객체
});
</script>
</body>
</html>