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
        min-height: 100vh;
        margin: 0 auto;
        background-color: rgb(249, 249, 249);
        border-radius: 20px 20px 0 0;
  		overflow: hidden;
    }
    
    div.logo {
        display: inline-block;
        position: absolute;
        transform: translate(-50%, -50%);
        left: 50%;
        top: 100px;
    }
    
    div.logo img {
        width: 140px;
    }

    .content {
        display: inline-block;
        max-width: 400px;
        width: 100%;
        min-height: 500px;
        margin-left: 400px;
        margin-top: 170px;
        border-radius: 20px;
        /* background-color: #f4f4f4; */
        background-color: #fff;
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
        padding: 30px 30px;
    }
    
    #title {
    	text-align: center;
    	color: rgb(88, 88, 88);
    	font-size: 20px;
    }
    
    table {
    	margin: 0 auto;
    	color: rgb(88, 88, 88);
    	margin-top: 50px;
    }
    
    td, th {
    	padding: 10px 10px;
    }
    
    table tr:last-child td {
		padding-top: 30px;
		text-align: center;
	}

</style>
<body>
    <div class="main">
        <div class="logo"><a href="#"><img src="./resources/images/logo.png" alt="logo"></a></div>  
        <div class="content">
		 <!-- 여기에서 작업 시작하세요 -->
			<p id="title">ID 찾기</p>
			<table class="idFindTable">
				<tr>
					<th class="col1">이름</th>
					<td class="FindCol2">
						<input type="text" id = "name" required/>
					</td>
				</tr>	
				<tr>
					<th class="col1">EMAIL</th>
					<td class="FindCol2">
						<input type="email" id = "email" required/>
					</td>
				</tr>
				<tr>
					<td>
						<button class="FindBtn" type="button" onclick="idFind()">확인</button>
						<button class="FindBtn" type="button" onclick="location.href='./login.go'">돌아가기</button>
					</td>
				</tr>           
			</table>
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