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
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
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
		/* background-color: #f4f4f4; */
		background-color: rgb(249, 249, 249);
		padding: 60px 100px;
	}
	
	.myinfo {
    	color: rgb(88, 88, 88);
    	margin: 0 auto;
    	padding: 30px 50px;
    	box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
    	border-radius: 20px;
    	font-size: 16px;
	}
	
	.myinfo th,
	.myinfo td {
		padding: 10px 10px;
	}
	
	.myinfo input[type='text'],
	.myinfo input[type='password'] {
		padding: 3px 10px;
		border-radius: 5px;
		border: 0.4px solid gray;
		font-size: 16px;
	}
	
	.btu {
		background-color: #537ef4;
		color: #eaeaea;
		border-radius: 5px;
		border: none;
		padding: 7px 20px;
		font-size: 16px;
		margin: 0 10px;
	}

</style>
<body>
	<jsp:include page="../commons/header.jsp"/>
	<div class="content-wrap">
	   <c:choose>
			<c:when test="${sessionScope.member_class eq '일반회원'}">
			   <jsp:include page="../commons/memberSideBar4.jsp"/>
			</c:when>
			<c:when test="${sessionScope.member_class eq '관리자'}">
				<jsp:include page="../commons/adminSideBar4.jsp"/>
			</c:when>
		</c:choose>
	   <div class="content">
	       <!-- 여기에서 작업 시작하세요 -->
	     <form action="mbUpdate.do" method="POST" enctype="multipart/form-data">
	     <table class="myinfo">
            	<tr>
            		<th>ID</th>
            		<td>${mblist.member_id}</td>
            	</tr>
            	<tr>
            		<th>PW</th>
            		<td>
	            		<input id="pw" name="pw" type="password"/>
	            		<br>※ 8 ~ 15자 입력, 비밀번호 수정시에만 작성
            		</td>
            	</tr>
            	<tr>
            		<th>PW확인</th>
	            		<td><input id="member_pw" name="member_pw" type="password"/><p id=result></p>&nbsp;&nbsp;&nbsp; ※ 8 ~ 15자 입력, 비밀번호 수정시에만 작성</td>
            	</tr>
            	<tr>
            		<th>이름</th>
            		<td>${mblist.name}</td>
            	</tr>
            	<tr>
            		<th>성별</th>
            		<td>${mblist.gender}</td>
            	</tr>
            	<tr>
            		<th>대학교</th>
            		<td>
            			<input type="hidden" id="university_idx" name='university_idx' />
						<input type="text" id="university_name" name='university_name'  placeholder="대학교 입력" readonly />
					    <button type="button" id="univSearch" class="btn btn-default">검색</button>
            		</td>
            	</tr>
            	<tr>
            		<th>인증서</th>
            		<td><input id="photo_idx" name="photo_idx" type="file"/></td>
            	</tr>
            	<tr>
            		<th>연락처</th>
            		<td><input type="text" id="phone" name="phone" value="${mblist.phone}" required/> &nbsp;&nbsp;&nbsp; ※ '-'를 포함해서 입력</td>
            	</tr>
            	<tr>
            		<th>이메일</th>
            		<td>${mblist.email}</td>
            	</tr>
            	<tr>
            		<th>회원탈퇴 신청</th>
            		<td>
            		<!-- <input id="hide" name="hide" type="checkbox" value=0/>&emsp; -->
					  <div><input type="radio" id="hide" name="hide" value=1>예<input type="radio" id="hide" name="hide" value=0 checked="checked">아니요</div>&emsp;
            		※ 체크하신 후 수정버튼을 누르시면 탈퇴신청이 접수됩니다.
					(탈퇴 시 with 서비스를 이용하실 수 없으며 해당 아이디로 재 가입이 불가능 합니다.)
            		</td>
            	</tr>
            	<tr>
            		<td colspan="2" style="text-align: right; padding-top: 40px;">
            			<button class="btu">변경</button>
            			<input class="btu" type="button" value="돌아가기" onclick="location.href='/myInfo'"/>
            		</td>
            	</tr>
            </table>
            </form>
	   </div>
	</div>
	
	 <!-- 대학검색 Modal -->
	<div id="univSearchModal" class="modal fade" role="dialog" data-backdrop="static">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	      <h4 class="modal-title">대학 검색 </h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>        
	      </div>
	      <div class="modal-body" style="width:100%; height:500px; overflow:auto">
	        <table id="univtable" class="table table-striped">
	        <div id="List" class="form-inline">
				<span>대학이름 : </span>
			  <input  class="form-control" type="text" style="width:50%" id="keyword" name="keyword" display="inline-block"/> 
			  <!-- <input type="hide" id="univ_idx" name=univ_idx/> --> 
			  <button type="button" id="univsearch" style="width:20%" class="btn btn-default">검색</button> 
			 </div>
	        	<thead style="text-align:center; font-size:20px;">
	        		<tr><td>대학교</td><tr>
	        	</thead>
	        	<tbody id="list" style="font-size:20px;">
	        	</tbody>
	        </table>
	
	      </div>
	      <div class="modal-footer" >
	      	<button type="button" id="univUp" onclick="univUp()" class="btn btn-default" >선택</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div> 
	
	<jsp:include page="../commons/footer.jsp"/>
</body>
<script>
	var checkbox = document.getElementById("hide");
	const is_checked = checkbox.checked;
	if(checkbox==true){
			Myelement.value = 1;
	}

	$('#member_pw').keyup(function(){
    var pass1 = $("#pw").val();
    var pass2 = $("#member_pw").val();
	
    if(pass1 != "" || pass2 != ""){
        if(pass1 == pass2){
            $("#result").html('※일치');
            $("#result").css('color','blue');
        }else{
            $("#result").html('※불일치');
            $("#result").css('color','red');
        }
    }
})

//모달뜨게하는 기능
	$("#univSearch").click(function(){
		       $('#univSearchModal').modal();
		
		// 모달창 띄우고 뿌리기 
		$.ajax({
			type:'get',
			url:'univList.ajax',
			data:{},
			dataType:'json',
			success:function(data){
				drawList(data);
				
			},
			error:function(e){console.log(e)
				}
		});	
		
	});
	
	
	// 대학 검색 
	$('#univsearch').on('click',function(){

		$.ajax({
			type:'get',
			url:'univSearch.ajax',
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
	
	
	// 모달창에서 에이잭스 뿌리기 
	function drawList(list){
		var content = '';
		list.forEach(function(item){
			//console.log(item);
			content += '<tr>';
			content += '<td><input type="radio" id="selectUniv" name="selectUniv" value="'+item.university_idx+'" class="'+item.university_name+'" /></td>';
			content += '<td>'+item.university_name+'</td>';
			content += '</tr>';
		});
		$('#list').empty();
		$('#list').append(content);
	}
	
	//대학 등록 
	function univUp(){
			$("#university_idx").val($('input[name=selectUniv]:checked').val());		
			$("#university_name").val($('input[name=selectUniv]:checked').attr("class"));		
			$('#univSearchModal').modal('hide')
	}
		function joinDo(){
			alert("test");
			location.href="/join.do";
	} 
</script>
</html>