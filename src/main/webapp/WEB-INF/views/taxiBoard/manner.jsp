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
    
    .button {
    	opacity: 0;
    	width: 0;
    	height: 0;
    }
    
    .content #manner-table {
    	box-shadow: rgba(100, 100, 111, 0.6) 0px 7px 29px 0px;
    	border-radius: 20px;
    }
    
    .content #manner-table img {
    	width: 30px;
    	transition: all 0.3s ease;
    }

	.content #manner-table,th,td {
		margin: 0 auto;
		border-collapse: collapse;
		padding: 25px 50px;
		color: rgb(110, 110, 110);
	}
    
    .content #manner-table img:hover {
    	transform: scale(1.2);
    }
    
    .on {
		content: url("./resources/images/star.png");
	}
	
	.bottom-button {
		background-color: #2962ff;
		color: #eaeaea;
		border-radius: 5px;
		border: none;
		padding: 5px 10px;
		font-size: 14px;
	}
  
</style>
<body>
   	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
		<c:choose>
			<c:when test="${chkCate eq '배달게시판' and sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar1.jsp"/>
			</c:when>
			<c:when test="${chkCate eq '택시게시판' and sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar2.jsp"/>
			</c:when>
			<c:when test="${chkCate eq '밥게시판' and sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar3.jsp"/>
			</c:when>
			<c:when test="${chkCate eq '배달게시판' and sessionScope.member_class eq '관리자'}">
			   <jsp:include page="../commons/adminSideBar1.jsp"/>
			</c:when>
			<c:when test="${chkCate eq '택시게시판' and sessionScope.member_class eq '관리자'}">
			   <jsp:include page="../commons/adminSideBar2.jsp"/>
			</c:when>
			<c:when test="${chkCate eq '밥게시판' and sessionScope.member_class eq '관리자'}">
			   <jsp:include page="../commons/adminSideBar3.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	       <form action="mannerDo" method="post">
		      	<input type="hidden" name="board_idx" value="${board_idx}"/>
		      	<input type="hidden" name="member_id" value="${member_id}"/>
		          <table id="manner-table">
		          	<tr>
		          		<th colspan="2" style="padding-bottom: 50px;"><h2>${member_id}님은 어떤 사람이었나요?</h2></th>
		          	</tr>
		          	<tr>
		          		<th>친절함 </th>
		          		<td>
		          			<label>
		          				<input class="button" type="radio" name="kind" value="1" checked/>
		          				<img class="k-star on" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="kind" value="2"/>
		          				<img class="k-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="kind" value="3"/>
		          				<img class="k-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="kind" value="4"/>
		          				<img class="k-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="kind" value="5"/>
		          				<img class="k-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th>응답속도 </th>
		          		<td>
		          			<label>
		          				<input class="button" type="radio" name="response" value="1" checked/>
		          				<img class="r-star on" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="response" value="2"/>
		          				<img class="r-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="response" value="3"/>
		          				<img class="r-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="response" value="4"/>
		          				<img class="r-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="response" value="5"/>
		          				<img class="r-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
		          		</td>
		          	</tr>
		          	<tr>
		          		<th>시간약속 </th>
		          		<td>
		          			<label>
		          				<input class="button" type="radio" name="time" value="1" checked/>
		          				<img class="t-star on" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="time" value="2"/>
		          				<img class="t-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="time" value="3"/>
		          				<img class="t-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="time" value="4"/>
		          				<img class="t-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
	          				<label>
		          				<input class="button" type="radio" name="time" value="5"/>
		          				<img class="t-star" src="./resources/images/star1.png" alt="star"/>
	          				</label>
		          		</td>
		          	</tr>
		          	<tr>
		          		<td colspan="2" style="text-align: center;">
		          			<input style="margin-right: 20px;" class="bottom-button" type="submit" value="완료"/>
		          		<c:choose>
							<c:when test="${chkCate eq '배달게시판'}">
							   <input class="bottom-button" type="button" value="돌아가기" onclick="location.href='/deliDetail?board_idx=${board_idx}'"/>
							</c:when>
							<c:when test="${chkCate eq '택시게시판'}">
							   <input class="bottom-button" type="button" value="돌아가기" onclick="location.href='/taxiDetail?board_idx=${board_idx}'"/>
							</c:when>
							<c:when test="${chkCate eq '밥게시판'}">
							   <input class="bottom-button" type="button" value="돌아가기" onclick="location.href='/mealDetail?board_idx=${board_idx}'"/>
							</c:when>
						</c:choose>	
						</td>
		          	</tr>
		          </table>
	  	 	</form>
		</div>
	</div>	
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
	
	$('.k-star').click(function(){
		  $('.k-star').removeClass('on');
		  $(this).addClass('on').parent().prevAll().find('.k-star').addClass('on');
	});
	
	$('.r-star').click(function(){
		  $('.r-star').removeClass('on');
		  $(this).addClass('on').parent().prevAll().find('.r-star').addClass('on');
	});
	
	$('.t-star').click(function(){
		  $('.t-star').removeClass('on');
		  $(this).addClass('on').parent().prevAll().find('.t-star').addClass('on');
	});
	

</script>
</html>