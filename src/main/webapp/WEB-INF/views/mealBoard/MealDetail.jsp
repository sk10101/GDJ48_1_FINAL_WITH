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
<style type="text/css">
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
    
    td.subject {
    	border: 1px solid;
    	border-radius : 20px;
    	color:white;
    	background-color:#2962ff;
    }
    
    #link {
		color : black;
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
	
	.eye {
        position: absolute;
        z-index: 1;
        width: 27px;
        right: 665px;
        top: 105px;
    }
    
    .eye {
        position: absolute;
        z-index: 1;
        width: 27px;
        right: 665px;
        top: 105px;
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
	       <c:if test="${sessionScope.loginId ne null and sessionScope.member_class eq '관리자'}"><a href="superBlind?board_idx=${info.board_idx}"><img class="eye" src="./resources/images/bell.png" alt="eye"></a></c:if>
	     	<table>
	     		<tr>
	     			<td class='subject'>${info.subject}</td>
	     		</tr>
				<tr>
					<td>약속장소 : ${info.appoint_place}</td>
					<td>작성자 : ${info.member_id}</td>
				</tr>
				<tr>
					<td>마감시간 : ${info.deadline}</td>
					<td>작성일 : ${info.write_date}</td>
				</tr>
				<tr>
					<td>인원 : ${count} / ${info.member_cnt + 1}</td>
					<td>조회수 : ${info.hit}</td>
				</tr>
				<tr>
					<td>마감시간 : ${info.deadline}</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td></td>
					<c:if test="${info.recruit_end eq 0}"><td><span style="border:1px solid black; background-color:#2962ff;">모집중</span></td></c:if>
					<c:if test="${info.recruit_end eq 1}"><td><span style="border:1px solid black; background-color:red;">마감</span></td></c:if>
				</tr>
				<tr>
					<td><img alt="성별제한" src="../resources/images/gender.png" style="width:20px; height:20px;"> ${info.gender}</td>
					<!-- 신고하기위해 살짝 수정함 -제한- -->
					<c:if test="${info.member_id eq sessionScope.loginId}"><td></td></c:if>
					<c:if test="${info.member_id ne sessionScope.loginId}"><td><a id="link" href="#" onclick="reportPop()"><span style="border:1px solid black; background-color:red;">신고</span></a></td></c:if>
				</tr>
			</table>
			<hr>
			<table>
				<c:if test="${mealPhotoList.size()>0}">
		            <tr>
		                <td>
			                <c:forEach items="${mealPhotoList}" var="path">
									<img src="./photo/${path.newFileName}" width="500px"/>
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
					<c:if test="${partMemberChk > 0}"><th>연락처</th></c:if>
					<c:if test="${info.recruit_end eq 1 }">
					<c:if test="${partMemberChk > 0}"><th>평가</th></c:if>
					</c:if>
					<c:if test="${info.recruit_end eq 0 }">
					<c:if test="${info.member_id eq sessionScope.loginId}"><th>강퇴</th></c:if>
					</c:if>
				</tr>
				<%-- <c:if test="${partList.size() eq 0}">
					<tr><td colspan="5">참여한 회원이 없습니다.</td></tr>			
				</c:if> --%>
				<c:forEach items="${partMaster}" var="ptm">
					<tr>
						<td>${ptm.member_id}</td>
						<td>${ptm.gender}</td>
						<c:if test="${partMemberChk > 0}"><td>${ptm.phone}</td></c:if>
						<c:if test="${partMemberChk > 0}"><td></td></c:if>				
						<c:if test="${info.recruit_end eq 1 }">
						<c:if test="${partMemberChk > 0 and ptm.member_id ne sessionScope.loginId}"><td><input type="button" value="평가하기"/></td></c:if>
						</c:if>
						<td></td>
					</tr>
				</c:forEach>
				<c:forEach items="${partList}" var="part">
					<tr>
						<td>${part.member_id}</td>
						<td>${part.gender}</td>
						<c:if test="${partMemberChk > 0}"><td>${part.phone}</td></c:if>
						<c:if test="${info.recruit_end eq 1 }">
						<c:if test="${partMemberChk > 0 and part.member_id ne sessionScope.loginId and partMemberChk > 0}"><td><input type="button" value="평가하기" id="manner" onclick="mannrBlock()"/></td></c:if>
						</c:if>
						<c:if test="${info.recruit_end eq 0 }">
						<c:if test="${partMemberChk > 0 and info.member_id eq sessionScope.loginId}"><td><input type="button" value="강퇴" onclick="location='mealBan?board_idx=${info.board_idx}&member_id=${part.member_id}'"/></td></c:if>
						</c:if>
					</tr>
				</c:forEach>
			</table>
			<!-- 아래부터 Kakao Map API 구역 -->
			<input type="hidden" id="lat" value="${info.appoint_coords_lat}"/>
			<input type="hidden" id="lng" value="${info.appoint_coords_lng}"/>
			<div id="map" style="width:500px;height:350px;"></div>
			<c:if test="${info.recruit_end eq 0 and info.member_id ne sessionScope.loginId}">
				<button id="openModalPop">참여신청</button><br/>
			</c:if>
			<input type="button" value="삭제" onclick="location.href='mealDelete?board_idx=${info.board_idx}'"/>
			<input type="button" value="돌아가기" onclick="location.href=mealList.go'"/>
	   </div>
	</div>
	<!-- 아래부터 참여 신청 모달 부분 -->
	<div id="modal">
	</div>
	<div id ="banner_online">
        <div id="close_button" style ="cursor: pointer;"> 
            <a id="close_button">&times;</a>
        </div>
        <h2>참여신청</h2>
        <div class="pop_content">
        	<form action="mealApply">
	           내 연락처 <input type="text" name="phone" value="${phone}" readonly/><br/>
	           <input type="hidden" name="member_id" value="${sessionScope.loginId}"/>
	           <input type="hidden" name="board_idx" value="${info.board_idx}"/>
	           <input type="submit" value="보내기" style="text-align: right;"/>
        	</form>
        </div>
    </div>
	
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script type="text/javascript">
	var msg = "${msg}"
		if (msg != "") {
			alert(msg);
	}

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
	
	$(document).ready(function() {

	    $("#openModalPop").click(function() {
	        $("#banner_online").fadeIn();
	        $("#modal").fadeIn();
	    });

	    $("#close_button").click(function(){
	        $("#banner_online").fadeOut();
	        $("#modal").fadeOut();
	    });
	});	
	
	
	function mannrBlock() {
		  
		  // 토글 할 버튼 선택 (mannr)
		  const manner = document.getElementById('manner');
		  
		  // 평가 버튼 한 번 클릭시  숨기기 (display: none)
		  if(manner.style.display !== 'none') {
			  manner.style.display = 'none';
		  }
		  location.href='mannerGo?member_id=${part.member_id}&board_idx=${info.board_idx}'

		  
		}
	
	

<!-- 신고하기위해 추가함 -제한- -->
function reportPop(){
    var width = 300;
    var height = 300;
    var top = (window.innerHeight - height) / 2 + screenY;
    var left = (window.innerWidth - width) / 2 + screenX;

    var spec = 'status=no, menubar=no, toolbar=no, resizable=no';
    spec += ', width=' + width + ', height=' + height;
    spec += ', top=' + top + ', left=' + left;
	
	window.open('reportWrite.go?board_idx=${info.board_idx}','report', spec);
};

</script>
</html>