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
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        text-decoration: none;
        list-style: none;
    }

    .main {
        max-width: 1200px;
        width: 100%;
        margin: 0 auto;
    }

    .navbar-top-bg {
        position: fixed;
        max-width: 1200px;
        width: 100%;
        max-height: 100px;
        height: 100%;
        background-color: #fff;
    }

    .navbar-top {
        max-width: 1200px;
        width: 100%;
        max-height: 100px;
        height: 100%;
        background-color: #f3f3f3;
        border-radius: 20px 20px 0 0;
        position: fixed;
        z-index: 1;
    }

    .navbar-top .logo {
        margin-top: 20px;
        margin-left: 20px;
        width: 110px;
    }

    .navbar-top .dot {
        width: 40px;
        position: absolute;
        right: 30px;
        top: 45px;
    }

    .navbar-top .bell {
        position: absolute;
        z-index: 1;
        width: 27px;
        right: 25px;
        top: 60px;
    }

    .sidebar {
        top: 100px;
        max-width: 160px;
        width: 100%;
        height: 100%;
        background-color: #2962ff;
        display: inline-block;
        position: fixed;
        border-radius: 0 0 0 20px;
        background-image: linear-gradient(#2962ff, #42a5f5);
    }

    .sidebar ul {
        position: relative;
        top: 10px;
    } 

    .sidebar li {
        position: relative;
        list-style: none;
        text-align: center;
        margin-top: 15px;
        transition: all 0.3s ease;
    }

    .sidebar li:nth-child(1):hover,
    li:nth-child(2):hover,
    li:nth-child(3):hover {
        transform: translateX(17px);
    }

    .sidebar li:nth-child(5):hover,
    li:nth-child(6):hover,
    li:nth-child(7):hover,
    li:nth-child(8):hover {
        background-color: #0026ca;
    }
    
    .sidebar li a {
        color: #eaeaea;
        text-decoration: none;
        font-size: 16px;
        display: block;
        height: 73px;
    }

    .sidebar li a.my {
        height: 50px;
        line-height: 50px;
    }

    .sidebar li .line {
        position: relative;
        background-color: #eaeaea;
        display: inline-block;
        height: 1px;
        width: 80%;
        top: -10px;
    }

    .navbar-top p {
        float: right;
        margin-top: 20px;
        margin-right: 20px;
        font-size: 14px;
    }

    .navbar-top p a {
        text-decoration: none;
        color: rgb(104, 104, 104);
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

    .content-top {
        display: inline-block;
        width: 100%;
        min-height: 300px;
    }

    .content-left {
        display: inline-block;
        max-width: 520px;
        width: 100%;
        min-height: 380px;
    }

    .content-right {
        max-width: 520px;
        width: 100%;
        min-height: 380px;
        float: right;
    }


    .sidebar ul li img {
        width: 40px;
        position: relative;
        top: 15px;
        right: 15px;
        z-index: 1;
    }

    .circle {
        background-color: #0026ca;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        position: absolute;
        left: 21px;
        top: 6px;
    }

    .content-top .collage {
        position: absolute;
        left: 50%;
        top: 150px;
        color: #fff;
        font-size: 25px;
        padding: 10px 30px;
        /* background-color: #2962ff; */
        background-image: linear-gradient(#2962ff, #2f9df7);
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
        border-radius: 10px;
    }

    .content-top .score {
        color: rgb(103, 103, 103);
        font-size: 18px;    
        text-align: center;
        font-weight: bold;
    }

    .content-top .star {
        display: inline-block;
        margin-left: 436.578px;
        margin-top: 15px;
        transition: all 0.3s ease;
    }

    .content-top .star:hover {
        transform: scale(1.1);
    }

    .content-top img {
        width: 30px;
    }

    .content-box table {
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
        border-radius: 20px;
        table-layout: fixed;
    }

    .content-box th {
        padding-bottom: 30px;
    }

    .content-box table,th,td,.content-box > table > tbody > tr > td > a {
        border-collapse: collapse;
        padding: 10px 20px;
        width: 350px;
        font-size: 14px;
        margin: 0 auto;
        margin-top: 5%;
        color: rgb(103, 103, 103);
    }

    .content-box table th {
        font-size: 16px;
    }
    
    .content-box table td {
        white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
		max-width: 350px;
    }

    .content-box tbody tr:nth-child(odd):not(tr:last-child) td {
        background-color: #537ef4;
        color: #eaeaea;
    }
    
    .content-box tbody tr:nth-child(odd):not(tr:last-child) a {
        color: #eaeaea;
    }

    .content-box table tbody tr:last-child td {
        text-align: right;
        text-decoration: underline;
        color: rgb(103, 103, 103);
    }
    
    .center-line {
        position: absolute;
        display: inline-block;
        border-radius: 30px;
        margin-left: 520px;
        width: 2px;
        min-height: 500px;
        background-color: #d1d1d1;
    }

    .footer-wrap {
        margin: 0 auto;
        max-width: 1200px;
        width: 100%;
    }

    .footer {
        position: relative;
        max-width: 1040px;
        width: 100%;
        height: 100px;
        margin-left: 160px;
        background-color: #dedede;
        border-radius: 0 0 20px 0;
    }

    .footer p {
        position: absolute;
        text-align: center;
        transform: translate(-50%, -50%); /* 중심축 잡기 */
        left: 50%;
        top: 50%;
        font-size: 12px;
        letter-spacing: 1px;
        padding: 0px 30px;
        line-height: 25px;
        color: rgb(104, 104, 104);
    }
    

</style>
<body>
    <div class="main">
        <div class="navbar-top-bg"></div>
        <div class="navbar-top">
            <a href="/main"><img class="logo" src="./resources/images/logo.png" alt="logo"></a>
            <p><a href="#">${sessionScope.loginId}(${sessionScope.member_class}) 님 환영합니다.</a> &nbsp; | &nbsp; <a href="logout">로그아웃</a></p>
            <a href="#"><img class="bell" src="./resources/images/bell.png" alt="bell"></a>
            <img class="dot" src="./resources/images/dot.png" alt="dot">
        </div>
        <div class="sidebar">
            <ul>
                <li><a href="/deliListGo"><img src="./resources/images/delivery.png" alt="delivery"><div class="circle"></div>배달</a></li>
                <li><a href="/taxiListGo"><img src="./resources/images/taxi.png" alt="taxi"><div class="circle"></div>택시</a></li>
                <li><a href="/mealList.go"><img class="eating" src="./resources/images/eating.png" alt="eating"><div class="circle"></div>식사</a></li>
                <li><div class="line"></div></li>
                <li><a class="my" href="/myInfo">내 정보</a></li>
                <li><a class="my" href="/mygList.go">이용내역</a></li>
                <li><a class="my" href="/blockUserList.go">차단 회원 관리</a></li>
                <li><a class="my" href="/inqueryList.go">고객 문의</a></li>
            </ul>
        </div>
        <div class="content">
            <div class="content-top">
                <span class="collage">${univ}</span>
                <br><br><br><br><br><br><br>
                <p class="score">내 평점</p>
                <div class="star" onClick="location.href='/myInfo'">
                    <td>
                    	<c:forEach var="i" begin="1" end="5">
							<c:if test="${avg >= i}"><img src="./resources/images/star.png" alt="star" style="width: 30px;"></c:if>
							<c:if test="${avg < i}"><img src="./resources/images/star1.png" alt="star1" style="width: 30px;"></c:if>
						</c:forEach>
					</td>
                </div>
                <br><br>
				<p class="score">${avg}</p>
            </div>
            <div class="content-box content-left">
                <div class="center-line"></div>
                <table>
                    <thead>
                        <tr>
                            <th>주최 중인 모임</th>
                        </tr>
                    </thead>
                    <tbody class="r-body">
                    <c:forEach items="${recruitIng}" var="rI">
                        <tr class="r-tr">
                        	<c:if test="${rI.category_id eq '배달게시판'}">
                            	<td><a class="content-left-a" href="/deliDetail?board_idx=${rI.board_idx}">[${rI.category_id}] ${rI.subject}</a></td>
                            </c:if>	
                        	<c:if test="${rI.category_id eq '택시게시판'}">
                            	<td><a class="content-left-a" href="/taxiDetail?board_idx=${rI.board_idx}">[${rI.category_id}] ${rI.subject}</a></td>
                            </c:if>	
                        	<c:if test="${rI.category_id eq '밥게시판'}">
                            	<td><a class="content-left-a" href="/mealDetail?board_idx=${rI.board_idx}">[${rI.category_id}] ${rI.subject}</a></td>
                            </c:if>	
                        </tr>
                    </c:forEach>
                    <tr>
                    	<c:if test="${recruitCnt gt 5}">
                        	<td><a class="content-left-a" href="/mygList.go">more</a></td>
                        </c:if>
                    	<c:if test="${recruitCnt le 5}">
                        	<td><a class="content-left-a" href="#"></a></td>
                        </c:if>	
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="content-box content-right">
                <table>
                    <thead>
                        <tr>
                            <th>참여 중인 모임</th>
                        </tr>
                    </thead>
                    <tbody class="p-body">
                    <c:forEach items="${partIng}" var="pI">
                        <tr class="p-tr">
                        	<c:if test="${pI.category_id eq '배달게시판'}">
                            	<td><a class="content-right-a" href="/deliDetail?board_idx=${pI.board_idx}">[${pI.category_id}] ${pI.subject}</a></td>
                            </c:if>
                        	<c:if test="${pI.category_id eq '택시게시판'}">
                            	<td><a class="content-right-a" href="/taxiDetail?board_idx=${pI.board_idx}">[${pI.category_id}] ${pI.subject}</a></td>
                            </c:if>
                        	<c:if test="${pI.category_id eq '밥게시판'}">
                            	<td><a class="content-right-a" href="/mealDetail?board_idx=${pI.board_idx}">[${pI.category_id}] ${pI.subject}</a></td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    <tr>
                    	<c:if test="${partCnt gt 5}">
                        	<td><a class="content-right-a" href="/myApplyList.go">more</a></td>
                        </c:if>	
                    	<c:if test="${partCnt le 5}">
                        	<td><a class="content-right-a" href="#"></a></td>
                        </c:if>	
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="footer-wrap">
        <div class="footer">
            <p>Copyright 2022. With<br/>Designed by With<br/>All right reserved.</p>
        </div>
    </div>
</body>
<script>
   /* 아래 코드는 지우지 마세요 */
/*     $(".sidebar").css("height", ($(".content").height() + $(".footer").height()));
   
    var msg = '${msg}';
	if (msg != "") {
			alert(msg);
	} */
	
	
	// 리스트의 사이즈에 따라 변하는 테이블의 크기를 고정시켜주기 위한 코드 (좌측 테이블)
	$(document).ready(function(){
		
	var rCnt = "${recruitCnt}";
	var pCnt = "${partCnt}";	
		
	var contentR = "";	
	var contentP = "";	
		
	switch (rCnt) {
	  case "0" :
		for(i = 0; i < 5; i++) {
			contentR += '<tr>';
			if(i == 2) {
				contentR += '<td style="font-size: 16px; text-align: center; background-color: rgb(249, 249, 249); font-weight: bold; color: #ef5350;">';
				contentR += '주최 중인 모임이 존재하지 않습니다.';
			} else {
				contentR += '<td style="background-color: rgb(249, 249, 249)">';
				contentR += '<a class="content-left-a" href="#">';
				contentR += '</a>';
			}
			contentR += '</td>';
			contentR += '</tr>';
		}
		$('.r-body').prepend(contentR);  
	    break;
	  case "1" :
		for(i = 0; i < 4; i++) {
			contentR += '<tr>';
			contentR += '<td style="background-color: rgb(249, 249, 249);">';
			contentR += '<a class="content-left-a" href="#">';
			contentR += '</a>';
			contentR += '</td>';
			contentR += '</tr>';
		}
		$('.r-tr:last').after(contentR);   
	    break;
	  case "2" :
		for(i = 0; i < 3; i++) {
			contentR += '<tr>';
			contentR += '<td style="background-color: rgb(249, 249, 249);">';
			contentR += '<a class="content-left-a" href="#">';
			contentR += '</a>';
			contentR += '</td>';
			contentR += '</tr>';
		}
		$('.r-tr:last').after(contentR);   
	    break;
	  case "3" :
		for(i = 0; i < 2; i++) {
			contentR += '<tr>';
			contentR += '<td style="background-color: rgb(249, 249, 249);">';
			contentR += '<a class="content-left-a" href="#">';
			contentR += '</a>';
			contentR += '</td>';
			contentR += '</tr>';
		}
		$('.r-tr:last').after(contentR);   
	    break;
	  case "4" :
		contentR += '<tr>';
		contentR += '<td style="background-color: rgb(249, 249, 249);">';
		contentR += '<a class="content-left-a" href="#">';
		contentR += '</a>';
		contentR += '</td>';
		contentR += '</tr>';
		$('.r-tr:last').after(contentR);   
	    break;
	  default :
	    break;
	}
	
	// 리스트의 사이즈에 따라 변하는 테이블의 크기를 고정시켜주기 위한 코드 (우측 테이블)
	switch (pCnt) {
	  case "0" :
		for(i = 0; i < 5; i++) {
			contentP += '<tr>';
			if(i == 2) {
				contentP += '<td style="font-size: 16px; text-align: center; background-color: rgb(249, 249, 249); font-weight: bold; color: #ef5350;">';
				contentP += '참여 중인 모임이 존재하지 않습니다.';
			} else {
				contentP += '<td style="background-color: rgb(249, 249, 249)">';
				contentP += '<a class="content-left-a" href="#">';
				contentP += '</a>';
			}
			contentP += '</td>';
			contentP += '</tr>';
		}
		$('.p-body').prepend(contentP);  
	    break;
	  case "1" :
		for(i = 0; i < 4; i++) {
			contentP += '<tr>';
			contentP += '<td style="background-color: rgb(249, 249, 249);">';
			contentP += '<a class="content-left-a" href="#">';
			contentP += '</a>';
			contentP += '</td>';
			contentP += '</tr>';
		}
		$('.p-tr:last').after(contentP);   
	    break;
	  case "2" :
		for(i = 0; i < 3; i++) {
			contentP += '<tr>';
			contentP += '<td style="background-color: rgb(249, 249, 249);">';
			contentP += '<a class="content-left-a" href="#">';
			contentP += '</a>';
			contentP += '</td>';
			contentP += '</tr>';
		}
		$('.p-tr:last').after(contentP);   
	    break;
	  case "3" :
		for(i = 0; i < 2; i++) {
			contentP += '<tr>';
			contentP += '<td style="background-color: rgb(249, 249, 249);">';
			contentP += '<a class="content-left-a" href="#">';
			contentP += '</a>';
			contentP += '</td>';
			contentP += '</tr>';
		}
		$('.p-tr:last').after(contentP);   
	    break;
	  case "4" :
		contentP += '<tr>';
		contentP += '<td style="background-color: rgb(249, 249, 249);">';
		contentP += '<a class="content-left-a" href="#">';
		contentP += '</a>';
		contentP += '</td>';
		contentP += '</tr>';
		$('.p-tr:last').after(contentP);   
	    break;
	  default :
	    break;
	}
	});
</script>
</html>