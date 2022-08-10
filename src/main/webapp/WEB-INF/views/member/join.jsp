<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="favicon" href="./resources/images/with_favicon.ico">
	<title>With</title>
	

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
    }
    
	.goodRegister {
		position: relative;
		margin: 20px auto;
		margin: 0 auto;
		max-width: 180px;
		text-decoration: none;
		border-radius: 4px;
		padding: 10px 20px;
	    color: rgb(26 18 50 / 100%);
	    font-size: 18px;
	    font-weight: 500;
		box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
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
        max-width: 600px;
        width: 100%;
        min-height: 500px;
        margin-left: 300px;
        margin-top: 170px;
        border-radius: 20px;
        /* background-color: #f4f4f4; */
        background-color: #fff;
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    }

</style>
<body>
<form action="/join.do" id="test" method="post">
    <div class="main">
        <div class="logo"><a href="#"><img src="/resources/images/logo.png" alt="logo"></a></div>  
        <div class="content">
            <!-- 여기에서 작업 시작하세요 -->
		<table>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="member_id"/></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="text" name="member_pw"/></td> <!--   어떤 패스워드넣었는지 확인하려고 text 타입으로.. -->
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name"/></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
				<label><input name="gender" type="radio" checked value="남자">남</label>
                <input id="female" name="gender" type="radio" value="여자"><label for="female">여</label>
				</td>
			</tr>
			<tr>
				<th>대학교</th>
				<td>
						<input type="hidden" id="university_idx" name='university_idx' />
						<input type="text" id="university_name" name='university_name' readonly />
					   <button type="button" id="empSearch" class="btn btn-default">검색</button>
				</td>
<!-- 				<td class="hidden"><input type="text" id="university_idx"></td> -->
			</tr>
			<tr>
				<th>연락처</th>
				<td><input type="text" name="phone"/></td>
			</tr>
			<tr>
				<th>EMAIL</th>
				<td><input type="text" name="email"/></td>
			</tr>
		
<!-- 			<tr>
			 <th>프로필 사진 등록</th>
             <td><input name="file" type="file"  name=multiple></td>		
             </tr>	 -->
			<tr>
				<th colspan="2">
					<input type="submit" value="회원가입" />
					<input type="button" value="돌아가기" onclick="location.href='/'"/>
				</th>
			</tr>
		</table>
        </div>
    </div>
</form>
    
 <!-- 대학검색 Modal -->
<div id="empSearchModal" class="modal fade" role="dialog" data-backdrop="static">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
      <h4 class="modal-title">대학 검색 </h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>        
      </div>
      <div class="modal-body" style="width:100%; height:500px; overflow:auto">
        <table id="emptable" class="table table-striped">
        <div id="goodList" class="form-inline" >
		<!--   <select style="width:20%"><option>대학이름</option></select> -->
			<span>대학이름 : </span>
		  <input  class="form-control" type="text" style="width:50%" id="keyword" name="keyword" display="inline-block"/> 
		  <!-- <input type="hide" id="university_name"/> -->
		  <button type="button" id="empsearch" style="width:20%" class="btn btn-default">검색</button> 
		 </div>
        	<thead style="text-align:center; font-size:20px;">
        		<tr><td></td><td>학교</td><tr>
        	</thead>
        	<tbody id="list" style="font-size:20px;">
        	</tbody>
        
        </table>
        <!-- <button type="button" id="empUp" onclick="empUp()" class="btn btn-default">선택</button> -->
        
      </div>
      <div class="modal-footer" >
      	<button type="button" id="empUp" onclick="empUp()" class="btn btn-default" >선택</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>   
    
	<jsp:include page="../commons/memberFooter.jsp"/>
</body>
	<link rel="icon" href="resources/img/icon.png">
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script>
$("#empSearch").click(function(){
	       $('#empSearchModal').modal();
	
	/* 모달창 띄우고 뿌리기 .  */
	$.ajax({
		type:'get',
		url:'cliempList.ajax',
		data:{},
		dataType:'json',
		success:function(data){
			drawList(data);
			
		},
		error:function(e){console.log(e)
			}
	});	
	
});


/* 담당자 검색 */
$('#empsearch').on('click',function(){

	
	$.ajax({
		type:'get',
		url:'cliempSearch.ajax',
		data:{
				keyword:$("#keyword").val()
			},
		dataType:'json',
		success:function(data){
			drawList(data);
		},
		error:function(e){console.log(e)}
		
	});
});


/* 에이잭스 뿌리기 */
function drawList(list){
	var content = '';
	list.forEach(function(item){
		//console.log(item);
		content += '<tr>';
		content += '<td><input type="radio" id="selectUniv" name="selectUniv" value="'+item.university_idx+'" class="'+item.university_name+'" /></td>';
		content += '<td>'+item.university_name+'</td>';
		/*
		content += '<td>'+item.emp_name+'</td>';
		content += '<td>'+item.emp_phone+'</td>'; 
		*/
		content += '</tr>';
	});
	$('#list').empty();
	$('#list').append(content);
}

/* 직원 등록 */
function empUp(){
		$("#university_idx").val($('input[name=selectUniv]:checked').val());		
		$("#university_name").val($('input[name=selectUniv]:checked').attr("class"));		
		$('#empSearchModal').modal('hide')
	}
	
	function joinDo(){
		alert("test");
		location.href="/join.do";
	}
</script>
</html>