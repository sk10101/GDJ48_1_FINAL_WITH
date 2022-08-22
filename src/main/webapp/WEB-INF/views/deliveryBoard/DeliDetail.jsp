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
	<script>
	var msg = '${msg}';
	if (msg != "") {
		alert(msg);
	}
	</script>
</head>
<style>
/*     .content-wrap {
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
        background-color: rgb(249, 249, 249);
        padding: 60px 100px;
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
	
	#link {
		color : black;
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
    } */

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
        background-color: rgb(249, 249, 249);
        padding: 60px 100px;
    }
    
    /* 박스쉐도우를 위해 div 생성 */
    #table-wrap {
    	width: 100%;
    	border-radius: 20px;
    	box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
    }
    
    #main-table {
    	width: 100%;
    	color: rgb(88, 88, 88);
    	padding: 20px 10px;
    }
    
    #center-table {
    	margin: 0 auto;
    	margin-top: 20px;
    	color: rgb(88, 88, 88);
    }
    
    #bottom-table {
    	margin: 0 auto;
    	margin-top: 100px;
    }
    
    
    
    #main-table th,td {
    	border: none;
    	padding: 7px 10px;
    }
    
    #gender {
    	width: 30px;
    }
    
    #people {
    	position: relative;
    	top: 7px;
    	right: 5px;
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
    	background-color: #ef5350; 
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
    #modal-table,
    #modal-table input {
    	font-size: 16px;
    	margin: 0 auto;
    }
    
    #modal-table td {
    	text-align: center;
    	padding-left: 10px;
    }
    
    #modal-table input[type='submit'] {
    	margin-top: 40px;
    	padding: 5px 20px;
    	border: none;
    	border-radius: 10px;
    	background-color: #537ef4;
    	color: #eaeaea;
    }
    
    #banner_online {
	    height: 270px;
	    width: 350px;
	    box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
	    background-color: white;
	    z-index: 9999;
	    left: 45%;
	    top: 30%;
	    display: none;
	    position: fixed;
	    border-radius: 20px;
	}
	
	#banner_online h2 {
	    text-align: center;
	    font-size: 17px;
	    margin-bottom: 60px;
	    margin-top: 20px;
	    color: rgb(64, 64, 64);
	}
	
	.pop_content {
	    font-size: 13px;
	    margin-left: 20px;
	    color: rgb(64, 64, 64);
	}
	
	#close_button {
		position: absolute;
	    float: right;
	    left: 165px;
	    top: 5px;
	}
	
	#close_button a {
		font-size: 20px;
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
	}

	#crown {
		position: relative;
		top: 3px;
		right: 5px;
		width: 20px;
	}
	
    .star {
    	width: 30px;
    }
    
    #apply-button {
    	padding: 10px 20px;
    	border-radius: 5px;
    	border: none;
    	background-color: #537ef4;
    	color: #eaeaea;
    	font-size: 16px;
    	margin-top: 20px;
    }
    
    .bottom-button {
    	padding: 5px 10px;
    	border-radius: 5px;
    	border: none;
    	color: #eaeaea;
    	font-size: 14px;
    	margin: 20px 20px;
    }
    
    .del-button {
    	background-color: #ff6f00;
    }
    
    .back-button {
    	background-color: #537ef4;
    }
    
    .manner-button {
    	background-color: #537ef4;
    	color: #eaeaea;
    	padding: 3px 10px;
    	border-radius: 5px;
    	border: none;
    }
    
    .elim-button {
    	background-color: #ff6f00;
    	color: #eaeaea;
    	padding: 3px 10px;
    	border-radius: 5px;
    	border: none;
    }
    
    #center-table a {
    	color: rgb(88, 88, 88);
    }
    
    #center-table tr:first-child th {
		padding-bottom: 10px;
	}
	
    #center-table tr:not(tr:first-child) th,
    #center-table tr:not(tr:first-child) td {
		padding: 5px 10px;
	}
	
	.gender1 {
    	width: 35px;
    	transition: all 0.3s ease;
	}
	
	.gender1:hover {
		transform: scale(1.1);
	}
	
	#center-table {
		/* border: 0.4px solid gray; */
		border-radius: 10px;
		padding: 15px 15px;
	}
	
	.off {
        width: 40px;
        float: right;
        margin-top: 10px;
        margin-right: 20px;
    }
    
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
		<c:choose>
			<c:when test="${sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar1.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar1.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
     		<c:if test="${sessionScope.loginId ne null and sessionScope.member_class eq '관리자'}">
     			<a href="superBlind?board_idx=${info.board_idx}">
     				<img class="off" src="./resources/images/off.png" alt="off">
     			</a>
     		</c:if>
	     	<p id="subject">
	     		${info.subject}
	     	</p>
	     	<div id="table-wrap">
	     	<table id="main-table">
				<tr>
					<th>약속장소</th>
					<td>${info.appoint_place}</td>
					<th>작성자</th>
					<td>${info.member_id}</td>
				</tr>
				<tr>
					<th>최소주문금액</th>
					<td>${info.min_delivery}</td>
					<th>작성일</th>
					<td>${info.write_date}</td>
				</tr>
				<tr>
					<th>배달료</th>
					<td>${info.delivery_fee}</td>
					<th>조회수</th>
					<td>${info.hit}</td>
				</tr>
				<tr>
					<th>마감시간</th>
					<td>${info.deadline}</td>
					<th>인원</th>
					<td>${partList.size() + 1} / ${info.member_cnt + 1}</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<th>인당 최소비용</th>
					<td>${info.min_fund}</td>
					<c:if test="${info.recruit_end eq 0}">
						<td colspan="2" style="text-align: right">
							<span style="padding: 3px 10px; border-radius: 5px; background-color: #2962ff; color: #eaeaea;">모집중</span>
						</td>
					</c:if>
					<c:if test="${info.recruit_end eq 1}">
						<td colspan="2" style="text-align: right">
							<span style="padding: 3px 10px; border-radius: 5px; background-color: #ef5350; color: #eaeaea;">마감</span>
						</td>
					</c:if>
				</tr>
				<tr>
	       			<th>
	       				<img style="position: relative; top: 5px;" id="gender" src="./resources/images/gender.png" alt="gender"/>&nbsp; ${info.gender}
	       			</th>
					<!-- 신고하기위해 살짝 수정함 -제한- -->
					<c:if test="${info.member_id eq sessionScope.loginId}"><td></td></c:if>
					<c:if test="${info.member_id ne sessionScope.loginId}">
		       			<td colspan="3" style="text-align: right;">
	       					<img id="report-img" src="./resources/images/report.png" alt="report"/>
		       				<!-- 신고하기위해 살짝 수정함 -제한- -->
		       				<input id="report" type="button" name="report" value="신고" onclick="reportPop()"/>
		       			</td>
					</c:if>
				</tr>
	       		<tr>
	       			<td colspan="4"><br/><br/><hr/><br/><br/></td>
	       		<tr>
				<c:if test="${deliPhotoList.size()>0}">
		            <tr>
		                <td colspan="4" style="text-align: center">
			                <c:forEach items="${deliPhotoList}" var="path">
									<img src="/photo/${path.newFileName}" width="400px"/>
							</c:forEach>
						</td>
		            </tr>
            	</c:if>
            	<tr>
            		<td colspan="4" style="padding: 40px 30px;">${info.content}</td>
            	</tr>
	       		<tr>
	       			<th colspan="4"><img id="people" src="./resources/images/people.png" alt="people"/> 참여현황</th>
	       		</tr>
			</table>
			<!-- 아래부터 참여현황 -->
			<table id="center-table">
				<tr>
					<th></th>
					<th>아이디</th>
					<th>성별</th>
					<th>금액</th>
					<c:if test="${partMemberChk > 0}"><th>연락처</th></c:if>
					<%-- <c:if test="${partMemberChk > 0}"><th>평가</th></c:if>
					<c:if test="${info.member_id eq sessionScope.loginId}"><th>강퇴</th></c:if> --%>
				</tr>
				<c:forEach items="${partMaster}" var="ptm">
					<tr>
						<th>
		       				<a href="/mannerInfo?member=${ptm.member_id}&board=${info.board_idx}">
				            	<c:if test="${ptm.gender eq '남자'}">
			           				<img class="gender1" src="./resources/images/man.png" alt="man">
			        				    </c:if>	
					            <c:if test="${ptm.gender eq '여자'}">
					            	<img class="gender1" src="./resources/images/girl.png" alt="girl">
					            </c:if>	
				            </a>
						</th>
						<th>
							<img id="crown" src="./resources/images/crown.png" alt="crown"/>
							<a href="/mannerInfo?member=${ptm.member_id}&board=${info.board_idx}">${ptm.member_id}</a>
						</th>
						<td>${ptm.gender}</td>
						<td style="text-align: center;"> - </td>
						<c:if test="${partMemberChk > 0}"><td>${ptm.phone}</td></c:if>
						<%-- <c:if test="${partMemberChk > 0}"><td></td></c:if> --%>
						<c:if test="${partMemberChk > 0 and ptm.member_id ne sessionScope.loginId}"><td><input class="manner-button" type="button" value="평가하기" onclick="location.href='/mannerGo?member_id=${ptm.member_id}&board_idx=${info.board_idx}'"/></td></c:if>
						<!-- <td></td> -->
					</tr>
				</c:forEach>
				<c:forEach items="${partList}" var="part">
					<tr>
						<th>
		       				<a href="/mannerInfo?member=${part.member_id}&board=${info.board_idx}">
				            	<c:if test="${part.gender eq '남자'}">
			           				<img class="gender1" src="./resources/images/man.png" alt="man">
			        				    </c:if>	
					            <c:if test="${part.gender eq '여자'}">
					            	<img class="gender1" src="./resources/images/girl.png" alt="girl">
					            </c:if>	
				            </a>
						</th>
						<th><a href="/mannerInfo?member=${part.member_id}&board=${info.board_idx}">${part.member_id}</a></th>
						<td>${part.gender}</td>
						<td>${part.investment}</td>
						<td><c:if test="${partMemberChk > 0}">${part.phone}</c:if></td>
						<td><c:if test="${info.recruit_end eq 1 and partMemberChk > 0 and part.member_id ne sessionScope.loginId and partMemberChk > 0 and part.assessNo eq 0}"><input type="button" class="manner-button" value="평가하기" onclick="location.href='/mannerGo?member_id=${part.member_id}&board_idx=${info.board_idx}'"/></c:if></td>
						<td><c:if test="${partMemberChk > 0 and info.member_id eq sessionScope.loginId}"><input id="elim" type="button" class="elim-button" value="강퇴" onclick="location='deliBan?board_idx=${info.board_idx}&member_id=${part.member_id}'"/></c:if></td>
					</tr>
				</c:forEach>
			</table>
			<table id="bottom-table">
			<!-- 아래부터 Kakao Map API 구역 -->
	       		<tr>
	       			<td colspan="4">
						<input type="hidden" id="lat" value="${info.appoint_coords_lat}"/>
						<input type="hidden" id="lng" value="${info.appoint_coords_lng}"/>
						<div id="map" style="width:700px;height:350px; margin: 0 auto;"></div>
					</td>
				</tr>
				<tr>		
					<td colspan="4" style="text-align: center">
						<c:if test="${info.recruit_end eq 0 and info.member_id ne sessionScope.loginId}">
							<input id="apply-button" type="button" value="참여신청"/>
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: center">		
						<c:if test="${info.member_id eq sessionScope.loginId}">
							<input class="bottom-button del-button" type="button" value="삭제" onclick="location.href='deliDelete?board_idx=${info.board_idx}'"/>
						</c:if>
						<input class="bottom-button back-button" type="button" value="돌아가기" onclick="location.href='deliListGo'"/>
					</td>
				</tr>	
			</table>
	   </div>
	</div>
	<!-- 아래부터 참여 신청 모달 부분 -->
  	<form action="applyDeli">
		<div id="modal"></div>
		<div id="banner_online">
        	<div id="close_button" style ="cursor: pointer;"> 
            	<a id="close_button">&times;</a>
        	</div>
	        <h2>참여신청</h2>
	        <div class="pop_content">
	        	<table id="modal-table">
		        	<tr>
		        	   <th>내 연락처 :</th>
		           	   <td>
		           		  <input type="text" value="010-1234-5678" readonly/>
		           	   </td>
		           	</tr>			
		        	<tr>
		        	   <th>투자 금액 :</th>
		           	   <td>
				           <input type="number" step="500" name="investment" placeholder="최소 투자 금액 : ${info.min_fund}" required/><br/>
		           	   </td>
		           	</tr>			
		           <input type="hidden" name="member_id" value="${sessionScope.loginId}"/>
		           <input type="hidden" name="board_idx" value="${info.board_idx}"/>
		           <input type="hidden" name="gd_restriction" value="${info.gender}"/>
		           <tr>
		           	   <th colspan="2"><input type="submit" value="보내기"></th>
		           </tr>
	        	</table>
	        </div>
	    </div>
   	</form>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script type="text/javascript">
// 참여신청 모달팝업
   	$("#apply-button").click(function() {
        	$("#banner_online").show();
    });

    /* $("#deliPop").click(function() {
        $("#banner_online").show();
    }); */

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