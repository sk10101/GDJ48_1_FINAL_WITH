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
idFindTable{
	width:370px;
}
.FindCol2{
	width:300px;
}
.FindCol2 #email,#id{
	width:100%;
	font-size:16px;
	background-color:#fff;
	border:1px solid #333;
	border-radius:5px;
}
.FindBtn-area{
	width:370px;
	margin-top:20px;
	text-align:right;
}
.FindBtn-area .FindBtn{
	background-color: #86b049;
	color:#fff;
	font-size:16px;
	font-weight:700;
	width:72px;
	height:30px;
	margin-left:10px;
	border:none;
	border-radius:5px;
}
.FindBtn-area .idFindBtn:hover{
	cursor:pointer;
}

<!-- css되면 지울것 -->
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

/* CSS 작업[삭제 해도 됨] */
.myinfo th, td {
	border: 1px solid #000000;
	padding: 8px;
}

.myinfo th {
	background-color: #2962ff;
	color: #ffffff;
}

.myinfo td {
	padding-right: 400px;
	width: 710px;
}

.button {
	margin-top: 50px;
	margin-left: 750px;
}

.btu {
	width: 100px;
	height: 30px;
}

 
</style>
<body>
    <div class="main">
        <div class="logo"><a href="#"><img src="./resources/images/logo.png" alt="logo"></a></div>  
        <div class="content">
		 <!-- 여기에서 작업 시작하세요 -->
	<h3 id="title">ID 찾기</h3>
	<table class="idFindTable">
		<tr>
			<th class="col1">이름</th>
			<td class="FindCol2">
				<input type="text" id = "name"/>
			</td>
		</tr>	
		<tr>
			<th class="col1">이메일</th>
			<td class="FindCol2">
				<input type="email" id = "email"/>
			</td>
		</tr>
	</table>
		<div class="FindBtn-area">
			<button class="FindBtn" type="button" onclick="idFind()">ID찾기</button>
			<button class="FindBtn" type="button" onclick="location.href='./login.go'">취소</button>
		</div>           
      </div>
    </div>
	<jsp:include page="../commons/memberFooter.jsp"/>
</body>
<script>
function idFind(){
	var name =$("#name").val()	
	var email =$("#email").val()
	 if(name== ""|| name == null){
         alert("이름을 입력해주세요");
         $("#name").focus();
         return false;
      }
	 if(email== ""|| email == null){
         alert("이메일을 입력해주세요");
         $("#email").focus();
         return false;
      }
	
	$.ajax({
		type:'get',
		url:'idFind.ajax',
		data:{
			name :name,
			email :email},
		dataType:'text',
		success:function(data){			
			if(data){
				alert("회원님의 아이디는 "+ data + "입니다");
				 location.href="../login.go"
			}else{
				alert("회원님의 정보를 찾을수 없습니다.");				
			}
		},
		error:function(e){
			console.log(e);
		}			
	});
}


</script>
</html>