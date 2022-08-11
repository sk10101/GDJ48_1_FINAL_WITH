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
    
    td.subject {
    	border: 1px solid;
    	border-radius : 20px;
    	color:white;
    	background-color:#2962ff;
    }
    
    div#map {
    	border : 3px solid #2962ff;
    }
    /* 아래부터 모달 팝업 css */
    #banner_online {
	    height: 270px;
	    width: 350px;
	    border: 1px solid black;
	    box-shadow: 3px 3px 7px 1px grey;
	    background-color: white;
	    z-index: 9999;
	    margin-left: 36%;
	    margin-top: 6%;
	    display: none;
	    position: absolute;
	    top: 250px;
	    left: 180px;
	}
	
	#banner_online h2 {
	    text-align: left;
	    color: white;
	    font-size: 17px;
	    margin-bottom: 10px;
	    background-color: #2962ff;
	}
	
	.pop_content {
	    font-size: 13px;
	    margin-left: 20px;
	}
	
	#banner_online_how {
	    height: 78px;
	    width: 444px;
	    margin-left: 28px;
	    border: 1px solid #82bf77;
	    margin-top: 22px;
	}
	
	#banner_online_how h3 {
	    font-size: 12px;
	    margin-left: 6px;
	    margin-top: 16px;
	}
	
	#close_button {
	    float: right;
	    margin-top: -3px;
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
					<td>최소주문금액 : ${info.min_delivery}</td>
					<td>작성일 : ${info.write_date}</td>
				</tr>
				<tr>
					<td>배달료 : ${info.delivery_fee}</td>
					<td>조회수 : ${info.hit}</td>
				</tr>
				<tr>
					<td>마감시간 : ${info.deadline}</td>
					<td>인원 : ${partList.size() + 1} / ${info.member_cnt + 1}</td>
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
				<c:if test="${deliPhotoList.size()>0}">
		            <tr>
		                <td>
			                <c:forEach items="${deliPhotoList}" var="path">
									<img src="/photo/${path.newFileName}" width="500px"/>
							</c:forEach>
						</td>
		            </tr>
            	</c:if>
            	<tr>
            		<td>${info.content}</td>
            	</tr>
			</table>
			<hr> 
			<!-- 아래부터 참여현황 -->
			<table>
				<tr>
					<th><img alt="참여현황" src="../resources/images/people.png" style="width:20px; height:20px;"/>참여현황</th>
				</tr>
				<tr>
					<th>아이디</th>
					<th>성별</th>
					<th>금액</th>
					<th>연락처</th>
					<th>평가</th>
					<c:if test="${info.member_id eq 'tester'}"><th>강퇴</th></c:if>
				</tr>
				<c:if test="${partList.size() eq 0}">
					<tr><td colspan="5">참여한 회원이 없습니다.</td></tr>			
				</c:if>
				<c:forEach items="${partList}" var="part">
					<tr>
						<td>${part.member_id}</td>
						<td>${part.gender}</td>
						<td>${part.investment}</td>
						<td>${part.phone}</td>
						<td><c:if test="true"><input type="button" value="평가하기"/></c:if></td>
						<td><c:if test="${info.member_id eq 'tester'}"><input type="button" value="강퇴" onclick="location='deliBan?board_idx=${info.board_idx}&member_id=${part.member_id}'"/></c:if></td>
					</tr>
				</c:forEach>
			</table>
			<!-- 아래부터 Kakao Map API 구역 -->
			<input type="hidden" id="lat" value="${info.appoint_coords_lat}"/>
			<input type="hidden" id="lng" value="${info.appoint_coords_lng}"/>
			<div id="map" style="width:500px;height:350px;"></div>
			<c:if test="${info.recruit_end eq 0}">
				<button id="deliPop">참여신청</button><br/>
			</c:if>
			<input type="button" value="삭제" onclick="location.href='replyUpdate.go?reply_id=${reply.reply_id}&claim_id=${claim.claim_id}'"/>
			<input type="button" value="돌아가기" onclick="history.back()"/>
	   </div>
	</div>
	<!-- 아래부터 참여 신청 모달 부분 -->
	<div id ="banner_online">
        <div id="close_button" style ="cursor: pointer;"> 
            <a id="close_button">&times;</a>
        </div>
        <h2>참여신청</h2>
        <div class="pop_content">
        	<form action="applyDeli">
	           내 연락처 <input type="text" value="010-1111-1111" readonly/><br/>
	           투자 금액 <input type="text" name="investment" placeholder="최소 투자 금액 : ${info.min_fund}" /><br/>
	           <input type="hidden" name="member_id" value="test2"/>
	           <input type="hidden" name="board_idx" value="${info.board_idx}"/>
	           <input type="submit" value="보내기" style="text-align: right;"/>
        	</form>
        </div>
    </div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script type="text/javascript">
    $("#deliPop").click(function() {
        $("#banner_online").show();
    });

    $("#close_button").click(function(){
        $("#banner_online").fadeOut();
        $("#modal").fadeOut();
    });
	
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