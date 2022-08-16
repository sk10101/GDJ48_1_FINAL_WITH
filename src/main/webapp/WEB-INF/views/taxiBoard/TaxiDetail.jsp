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
    
    #main-table {
    	width: 100%;
    	box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
    	border-radius: 20px;
    }
    
    #main-table th,td {
    	border: none;
    	padding: 7px 10px;
    }
    
    #gender {
    	width: 30px;
    }
    
    #people {
    	width: 30px;
    }
    
    #subject {
    	padding: 15px 15px;
    	color: #eaeaea;
    	border-radius: 10px;
    	background-color: #537ef4;
    	font-size: 20px;
    	margin-bottom: 30px;
    }
    
    #report {
    	border: none; 
    	font-size: 14px; 
    	padding: 3px 10px; 
    	border-radius: 5px; 
    	background-color: #e53935; 
    	color: #eaeaea;
    }
    
    #report-img {
    	width: 30px;
    	position: relative;
    	top: 8px;
    }
    
    .ptList {
    	text-align: center;
    }
    
    
    
    
    /* 참여신청 모달 */
    #banner_online {
	    height: 270px;
	    width: 350px;
	    border: 1px solid black;
	    box-shadow: 3px 3px 7px 1px grey;
	    background-color: white;
	    z-index: 9999;
	    left: 540px;
	    top: 30%;
	    display: none;
	    position: fixed;
	}
	
	#banner_online h2 {
	    text-align: center;
	    font-size: 17px;
	    margin-bottom: 10px;
	}
	
	.pop_content {
	    font-size: 13px;
	    margin-left: 20px;
	}
	
	#close_button {
	    float: right;
	    margin-top: -3px;
	}
	
	#modal {
	  position:fixed;
	  width:100%;
	  height:100%;
	  background:rgba(0, 0, 0, 0.5);
	  top: 0;
	  left: 0;
	  z-index: 99;
	  display: none;
	}
	
	#link {
		color : black;

	#crown {
		width: 20px;
	}
	
	.eye {
        position: absolute;
        z-index: 1;
        width: 27px;
        right: 665px;
        top: 105px;
    }
    
    .star {
    	width: 30px;
    }
    
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar2.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <c:if test="${sessionScope.loginId ne null and sessionScope.member_class eq '관리자'}"><a href="superBlind?board_idx=${list.board_idx}"><img class="eye" src="./resources/images/bell.png" alt="eye"></a></c:if>
	       <!-- 참여신청 모달팝업창 -->
 	       <form action="taxiApplyDo" method="post">
			   <div id= "modal"> 
			   </div>
			   <div id="banner_online">
			      <div id="close_button" style ="cursor: pointer;"> 
			            <a id="close_button">&times;</a>
			      </div>
			      <h2>참여신청</h2>
			      <div class="pop_content">
			          <table>
			          	<tr>
			          		<th>내 연락처 :</th>
			          		<td><input type="hidden" name="gender" value="${list.gender}"/></td>
			          		<td><input type="hidden" name="board_idx" value="${list.board_idx}"/></td>
			          		<td><input type="hidden" name="member_id" value="${list.member_id}"/></td>
			          		<td><input type="text" name="phone" value="${phone}" readonly/></td>
			          	</tr>
			          	<tr>
			          		<th><input type="submit" value="보내기"></th>
			          	</tr>
			          </table>
			      </div>
			   </div>
		   </form>
		   <!--참여신청 모달팝업 끝 -->
		   
	       
	       <p id="subject">${list.subject}</p>
	       <table id="main-table">
	       		<tr>
	       			<%-- <input type="hidden" name="board_idx" value="${list.board_idx}"/> --%>
	       			<%-- <th colspan="4" style="font-size: 20px; background-color: #537ef4;">${list.subject}</th> --%>
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
							<span style="padding: 3px 10px; border-radius: 5px; background-color: #2962ff; color: #eaeaea;">모집중</span>
						</td>
					</c:if>
					<c:if test="${list.recruit_end eq 1}">
						<td colspan="4" style="text-align: right">
							<span style="padding: 3px 10px; border-radius: 5px; background-color: #e53935; color: #eaeaea;">마감</span>
						</td>
					</c:if>
	       		</tr>
	       		<tr>
	       			<th>
	       				<img id="gender" src="./resources/images/gender.png" alt="gender"/> ${list.gender}
	       			</th>
	       			<td colspan="3" style="text-align: right;">
	       				<img id="report-img" src="./resources/images/report.png" alt="report"/>
	       				<!-- 신고하기위해 살짝 수정함 -제한- -->
	       				<input id="report" type="button" value="신고" onclick="reportPop()"/>
	       			</td>
	       		</tr>
	       		<tr>
	       			<td colspan="4"><br/><br/><hr/><br/><br/></td>
	       		<tr>
				<c:if test="${photo.size()>0}">
		            <tr>
		                <td colspan="4" style="text-align: center">
			                <c:forEach items="${photo}" var="path">
									<img src="./resources/photo/${path.newFileName}" width="500px"/>
							</c:forEach>
						</td>
		            </tr>
            	</c:if>
	       		<tr>
	       			<td colspan="4" style="padding: 40px 30px;">${list.content}</td>
	       		</tr>
	       		<tr>
	       			<th colspan="4"><img id="people" src="./resources/images/people.png" alt="people"/> 참여현황</th>
	       		</tr>
	       		<c:forEach items="${pt}" var="pt">
		       		<tr>
	       				<th class="ptList">
	       					<!-- 참여자와 방장의 아이디가 같으면 왕관 아이콘을 붙여준다. -->
	       					<c:if test="${pt.member_id eq list.member_id}">
	       						<img id="crown" src="./resources/images/crown.png" alt="crown"/>
	       					</c:if>
	       					${pt.member_id}
	       				</th>
		       			<td class="ptList">${pt.gender}</td>
		       			<!-- 현재 로그인한 아이디가 이 방의 참여인원으로 있다면 연락처를 보여준다. -->
		       			<c:if test="${chkPt > 0}">
		       				<td class="ptList">${pt.phone}</td>
		       			</c:if>	
		       			<!-- 내 아이디가 참여인원에 들어가 있어야 평가하기가 보여야 한다. -->
		       			<!-- 마감된 글에서만 평가하기가 보여야 한다. -->
		       			<!-- 한번 평가했다면 버튼은 사라져야한다. (해야할 것) -->
       					<c:if test="${chkPt > 0 and list.recruit_end == 1}">
		       				<td class="ptList">
		       					<input type="button" value="평가하기" onclick="location.href='/mannerGo?member_id=${pt.member_id}&board_idx=${list.board_idx}'" <c:if test="${pt.member_id eq sessionScope.loginId or pt.chkManner > 0}">hidden</c:if>/>
		       				</td>
	       				</c:if>
	       				<!-- 강퇴 열 방장빼고는 아예 못보게 한다. -->
	       				<c:if test="${list.member_id eq sessionScope.loginId and list.recruit_end == 0}">
		       				<td class="ptList">
		       					<input type="button" class="elim" value="강퇴" onclick="location.href='/elimDo?board_idx=${list.board_idx}&member_id=${pt.member_id}'" <c:if test="${pt.member_id eq list.member_id}">hidden</c:if>/>
      						</td>
		       			</c:if>
		       		</tr>	
	       		</c:forEach>
	       		<tr>
	       			<td colspan="4">
						<!-- 아래부터 Kakao Map API 구역 -->
						<input type="hidden" id="lat" value="${list.appoint_coords_lat}"/>
						<input type="hidden" id="lng" value="${list.appoint_coords_lng}"/>
						<div id="map" style="width:700px; height:350px; margin: 0 auto;"></div>	       			
	       			</td>
	       		</tr>
	       		<tr>
	       			<td colspan="4" style="text-align: center">
	       				<!--  모집중 and 본인이 작성한 글이 아니라면 참여신청 버튼이 노출된다. -->
	       				<c:if test="${list.recruit_end == 0 and sessionScope.loginId ne list.member_id}">
							<input id="apply-button" type="button" value="참여신청"/>
						</c:if>
					</td>
	       		</tr>
	       		<tr>
	       			<td colspan="4" style="text-align: center">
		       			<c:if test="${sessionScope.loginId eq list.member_id}">
			       			<input type="button" value="삭제" onclick="location.href='/deliDelete?board_idx=${list.board_idx}'"/>
			       		</c:if>	
						<input type="button" value="돌아가기" onclick="location.href='/taxiList?page=${sessionScope.page}&option=${sessionScope.option}&word=${sessionScope.word}'"/>
					</td>
	       		</tr>
	       </table>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>

	var msg = "${msg}";
	
	if(msg != "") {
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
	
	
	// 참여신청 모달팝업
	$(document).ready(function() {
	    $("#apply-button").click(function() {
	        $("#banner_online").show();
	    });

	    $("#close_button").click(function(){
	        $("#banner_online").fadeOut();
	        $("#modal").fadeOut();
	    });
	});
	
/* 	// 이미지 지도에 표시할 마커입니다
	// 이미지 지도에 표시할 마커를 아래와 같이 배열로 넣어주면 여러개의 마커를 표시할 수 있습니다 
	var markers = [
	    {
	        position: new kakao.maps.LatLng(lat, lng)
	    },
	    {
	        position: new kakao.maps.LatLng(lat, lng), 
	        text: '여기서 만나요!' // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다     
	    }
	];
	
	var staticMapContainer  = document.getElementById('map'), // 이미지 지도를 표시할 div  
    staticMapOption = { 
        center: new kakao.maps.LatLng(lat, lng), // 이미지 지도의 중심좌표
        level: 3, // 이미지 지도의 확대 레벨
        marker: markers // 이미지 지도에 표시할 마커 
    };    

	// 이미지 지도를 생성합니다
	var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption); */

	<!-- 신고하기위해 추가함 -제한- -->
	function reportPop(){
		window.open('reportWrite.go?board_idx=${list.board_idx}','report','width=1000, height=600, top=200, left=500')
	}
	
</script>
</html>