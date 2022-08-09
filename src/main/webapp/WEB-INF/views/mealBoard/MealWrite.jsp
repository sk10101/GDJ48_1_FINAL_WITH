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
        min-height: 680px;
        /* background-color: #f4f4f4; */
        background-color: rgb(249, 249, 249);
    }
</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <jsp:include page="../commons/memberSideBar3.jsp"/>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     <form action="MealWrite.do" method="post">
	<h3>글쓰기</h3>
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="subject"  placeholder="30자 이내"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content"  placeholder="500자 이내"></textarea></td>
			</tr>
			<tr>
			<tr>
				<th>성별</th>
				<td><input type="checkbox" name="gender"/>남자만&nbsp;&nbsp;<input type="checkbox">여자만&nbsp;&nbsp;<input type="checkbox">상관없음</td>
			</tr>
			<tr>
				<th>약속장소</th>
				<td><input type="text" name="appoint_place"/> <input type="button" value="주소 검색"></td>
			</tr>
			<tr>
				<th>사진</th>
				<td><input type="file" name="photo"/></td>
			</tr>
			<tr>
				<th>모집인원</th>
				<td>
					<select name="option">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>마감시간</th>
				<td><input type="datetime-local" name="deadline"/></td>
			</tr>
			<tr>
			<th colspan="2">
				<button>등록</button>
			</th>
			</tr>
		</table>
	</form>
	   </div>
	</div>
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
</script>
</html>