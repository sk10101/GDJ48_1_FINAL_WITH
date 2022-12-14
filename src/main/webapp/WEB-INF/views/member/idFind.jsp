<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        text-decoration: none;
        list-style: none;
        font-family: 'Noto Sans KR', sans-serif;
    }

    .main {
        max-width: 1200px;
        width: 100%;
        min-height: 100vh;
        margin: 0 auto;
        background-color: rgb(249, 249, 249);
        border-radius: 20px 20px 0 0;
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
	
	.FindBtn {
		padding: 5px 10px;
		border: none;
		background-color: #537ef4;
		color: #eaeaea;
		border-radius: 5px;
		transition: all 0.3s ease;
		margin: 0 10px;
	}
	
	.FindBtn:hover {
		background-color: #004ecb;
		transform: scale(1.05);
	}
	
	input[type='text'], input[type='email'] {
		padding: 3px 10px;
		border-radius: 5px;
		border: 0.3px solid gray;
	}
	
</style>
<body>
    <div class="main">
        <div class="logo"><a href="#"><img src="./resources/images/logo.png" alt="logo"></a></div>  
        <div class="content">
		 <!-- ???????????? ?????? ??????????????? -->
			<p id="title">ID ??????</p>
			<table class="idFindTable">
				<tr>
					<th class="col1">??????</th>
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
					<td colspan="2">
						<input type="button" class="FindBtn" onclick="idFind()" value="??????"/>
						<input type="button" class="FindBtn" onclick="location.href='./login.go'" value="????????????"/>
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
         alert("????????? ??????????????????");
         $("#name").focus();
         return false;
      }
	 if(email== ""|| email == null){
         alert("???????????? ??????????????????");
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
				alert("???????????? ???????????? "+ data + "?????????");
				 location.href="../login.go"
			}else{
				alert("???????????? ????????? ????????? ????????????.");				
			}
		},
		error:function(e){
			console.log(e);
		}			
	});
}


</script>
</html>