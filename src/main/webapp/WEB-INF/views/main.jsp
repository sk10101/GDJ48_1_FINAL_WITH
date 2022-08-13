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
        min-height: 680px;
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
        background-color: #2962ff;
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

    .content-box tbody tr:nth-child(odd) {
        background-color: #537ef4;
    }
    
    .content-box tbody tr:nth-child(odd) a {
        color: #eaeaea;
    }

    .content-box table tbody tr:last-child {
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
        min-height: 380px;
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
            <a href="/"><img class="logo" src="./resources/images/logo.png" alt="logo"></a>
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
                <li><a class="my" href="/applyList">이용내역</a></li>
                <li><a class="my" href="/block">차단 회원 관리</a></li>
                <li><a class="my" href="/inquery">고객 문의</a></li>
            </ul>
        </div>
        <div class="content">
            <div class="content-top">
                <span class="collage">서울대학교</span>
                <br><br><br><br><br><br><br>
                <p class="score">내 평점</p>
                <div class="star">
                    <a href="#">
                    <img src="./resources/images/star.png" alt="star">
                    <img src="./resources/images/star.png" alt="star">
                    <img src="./resources/images/star.png" alt="star">
                    <img src="./resources/images/star.png" alt="star">
                    <img src="./resources/images/star1.png" alt="star1">
                    </a>
                </div>
                <br><br>
                <p class="score">4.0</p>
            </div>
            <div class="content-box content-left">
                <div class="center-line"></div>
                <table>
                    <thead>
                        <tr>
                            <th>주최 중인 모임</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><a class="content-left-a" href="#">택시 두분 선착순!</a></td>
                        </tr>
                        <tr>
                            <td><a class="content-left-a" href="#">냉면 드실분?</a></td>
                        </tr>
                        <tr>
                            <td><a class="content-left-a" href="#">족발 최소주문 금액 맞춰주셈</a></td>
                        </tr>
                        <tr>
                            <td><a class="content-left-a" href="#">오후 2시에 학식 같이 먹자</a></td>
                        </tr>
                        <tr>
                            <td><a class="content-left-a" href="#">김가네 조지자</a></td>
                        </tr>
                        <tr>
                            <td><a class="content-left-a" href="#">more</a></td>
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
                    <tbody>
                        <tr>
                            <td><a class="content-right-a" href="#">택시 두분 선착순!</a></td>
                        </tr>
                        <tr>
                            <td><a class="content-right-a" href="#">냉면 드실분?</a></td>
                        </tr>
                        <tr>
                            <td><a class="content-right-a" href="#">족발 최소주문 금액 맞춰주셈</a></td>
                        </tr>
                        <tr>
                            <td><a class="content-right-a" href="#">오후 2시에 학식 같이 먹자</a></td>
                        </tr>
                        <tr>
                            <td><a class="content-right-a" href="#">김가네 조지자</a></td>
                        </tr>
                        <tr>
                            <td><a class="content-right-a" href="#">more</a></td>
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
    $(".sidebar").css("height", ($(".content").height() + $(".footer").height()));
   
    var msg = "${msg}"
		if (msg != "") {
			alert(msg);
	}
</script>
</html>