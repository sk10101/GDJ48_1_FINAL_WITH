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
        padding-bottom: 60px;
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
    
    table {
    	margin: 0 auto;
    	margin-top: 30px;
    	color: rgb(64, 64, 64);
    }
    
    table th, table td {
    	padding: 8px 10px;
    }
    
    table tr:last-child th {
    	padding-bottom: 30px;
    }
    
    input[type='text'], input[type='password'] {
    	border: 0.4px solid gray;
    	border-radius: 5px;
    	padding: 2px 5px;
    }
    
    .bottom-button {
    	margin: 0 10px;
    }
    
    #chkNotice {
    	margin-left: 20px;
    }
    

</style>
<body>
<form action="main/join.do" id="test" method="post" enctype="multipart/form-data">
    <div class="main">
        <div class="logo"><a href="#"><img src="/resources/images/logo.png" alt="logo"></a></div>  
        <div class="content">
            <!-- 여기에서 작업 시작하세요 -->
		<table>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="member_id" id="member_id" placeholder="아이디 입력" required/>
					<button type="button" class="btn btn-default" id="idoverlay" onclick="IdOverlay()">중복확인</button>
				<td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="member_pw" id="member_pw" placeholder="비밀번호 입력" required/></td> <!--   어떤 패스워드넣었는지 확인하려고 text 타입으로.. -->
				<td>* 8 ~ 15자 입력 </td>
			</tr>
			<tr>
			<!-- onkeyup="JS function" 입력이 되었을 때, -->
				<th>비밀번호 확인</th>
				<td><input type="password"  id="member_pw2" placeholder="비밀번호확인" required/></td>
				<font id="chkNotice" size="2"></font>
				<!-- <span id="confirmMsg"></span></td> -->
			</tr>			
			<tr>
				<th>이름</th>
				<td><input type="text" name="name"  id="name" placeholder="이름 입력" required/></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<label><input name="gender" type="radio" value="남자" checked> 남</label>
					&nbsp;&nbsp;&nbsp;
	                <label><input id="female" name="gender" type="radio" value="여자"> 여</label>
				</td>
			</tr>
			<tr>
				<th>대학교</th>
				<td>
						<input type="hidden" id="university_idx" name='university_idx' />
						<input type="text" id="university_name" name='university_name'  placeholder="대학교 입력"readonly />
					   <button type="button" id="empSearch" class="btn btn-default">검색</button>
				</td>	
			  <tr>
				<th>연락처</th>
				<td><input type="text" class="phone-number-check" name="phone"  id="phone" placeholder="휴대폰번호 입력" required/></td>
			</tr>
				<tr>
					<th>EMAIL</th>
					<td><input type="text" name="email" id="email"  placeholder="이메일주소 입력" required/>
							<button type="button" class="btn btn-default" id="emailoverlay" onclick="EmailOverlay()">중복확인</button>
					</td>
				</tr>
	         <tr>
	              <th>인증서</th>
	              <td>
	              		<input type="file" name="photos" id="photos" multiple="multiple"/>
	              </td>			
			  </tr>		
			  <tr>
				<th colspan="3" style="text-align: center;"><br>
					<button class="btn btn-default bottom-button" type="button" onclick="save(); return false;">회원가입</button>
					<button class="btn btn-default bottom-button" type="button" onclick="location.href='/'"/>돌아가기</button> 
<!-- 				<input type="submit"  class="btn btn-default" value="회원가입" />
					<input type="button"  class="btn btn-default" value="돌아가기" onclick="location.href='/'"/>  -->
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
		  <!-- <input type="hide" id="univ_idx" name=univ_idx/> --> 
		  <button type="button" id="empsearch" style="width:20%" class="btn btn-default">검색</button> 
		 </div>
        	<thead style="text-align:center; font-size:20px;">
        		<tr><td>대학교</td><tr>
        	</thead>
        	<tbody id="list" style="font-size:20px;">
        	</tbody>
        </table>

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
	<link href="../resources/img/goodfavicon.png" rel="icon">
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script>

// 연락처 입력할때 하이픈(-) 자동입력
$(function(){

    $(".phone-number-check").on('keydown', function(e){
       // 숫자만 입력받기
        var trans_num = $(this).val().replace(/-/gi,'');
	var k = e.keyCode;
				
	if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687 || k==32 || k==229 || (k>=45032 && k<=55203)) ))
	{
  	    e.preventDefault();
	}
    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
        if($(this).val() == '') return;

        // 기존 번호에서 - 를 삭제합니다.
        var trans_num = $(this).val().replace(/-/gi,'');
      
        // 입력값이 있을때만 실행합니다.
        if(trans_num != null && trans_num != '')
        {
            // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
            if(trans_num.length==11 || trans_num.length==10) 
            {   
                // 유효성 체크
                var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
                if(regExp_ctn.test(trans_num))
                {
                    // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿔줍니다.
                    trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");                  
                    $(this).val(trans_num);
                }
                else
                {
                    alert("유효하지 않은 연락처 입니다.");
                    $(this).val("");
                    $(this).focus();
                }
            }
            else 
            {
                alert("유효하지 않은 연락처 입니다.");
                $(this).val("");
                $(this).focus();
            }
      }
  });  
});


	//비밀번호 일치 불일치 여부 확인후 내용띄우기
	$(function(){
	    $('#member_pw').keyup(function(){
	      $('#chkNotice').html('');
	    });
	
	    $('#member_pw2').keyup(function(){
	
	        if($('#member_pw').val() != $('#member_pw2').val()){
	          $('#chkNotice').html('비밀번호 일치하지 않음<br><br>');
	          $('#chkNotice').attr('color', '#f82a2aa3');
	        } else{
	          $('#chkNotice').html('비밀번호 일치함<br><br>');
	          $('#chkNotice').attr('color', '#199894b3');
	        }
	
	    });
	});
	
	//아이디 중복 체크
	var overChk = false; //중복체크 여부
	//아이디는 숫자 또는 영문만 가능 
	function IdOverlay(){
		var member_id = $("#member_id").val();
 		var idChk = /^[0-9a-z]+$/;
	      if(!idChk.test($("#member_id").val())){
	          alert("아이디는 숫자 또는 영문만 가능합니다.");
	          return false; 
	       }
	      
	       if(member_id == ""|| member_id == null){
	         alert("아이디를 입력해주세요");
	         return false;
	      } 
		console.log('아이디 중복 체크'+member_id);
		$.ajax({
			type:'get',
			url:'IdCheck.ajax',
			data:{chkId:member_id},
			dataType:'JSON',
			success:function(data){
				if(data.IdOverlay){
					alert("사용중인 아이디입니다.");
				} else {
					alert("사용 가능한 아이디입니다.");
					overChk = true;
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}

	
	
	
	
	//이메일 중복 체크
	var overChkEmail = false; // 중복체크 여부

	function EmailOverlay(){
		var email = $("#email").val();
		 if(email== ""|| email == null){
	         alert("이메일을 입력해주세요");
	         return false;
	      }
		console.log('이메일 중복 체크 : '+email);		
		$.ajax({
			type:'get',
			url:'EmailCheck.ajax',
			data:{chkEmail:email},
			dataType:'JSON',
			success:function(data){
				//console.log(data);
				if(data.overlays){
					alert("이미 사용중인 이메일 입니다.");
				}else{
					alert("사용 가능한 이메일 입니다.");
					overChkEmail = true;
				}
			},
			error:function(e){
				console.log(e);
			}			
		});
	} 

	//모달뜨게하는 기능
	$("#empSearch").click(function(){
		       $('#empSearchModal').modal();
		
		// 모달창 띄우고 뿌리기 
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
	
	
	// 대학 검색 
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
	function empUp(){
			$("#university_idx").val($('input[name=selectUniv]:checked').val());		
			$("#university_name").val($('input[name=selectUniv]:checked').attr("class"));		
			$('#empSearchModal').modal('hide')
		}
		
		function joinDo(){
			alert("test");
			location.href="/join.do";
		}

		
	function save() {
		
		 /* 정규식 설명
숫자 (0~9) or 알파벳 (a~z, A~Z) 으로 시작하며 중간에 -_. 문자가 있을 수 있으며 그 후 숫자 (0~9) or 알파벳 (a~z, A~Z)이 올 수도 있고 연달아 올 수도 있고 없을 수도 있다. 
@ 는 반드시 존재하며 . 도 반드시 존재하고 a~z, A~Z 의 문자가 2,3개 존재하고 i = 대소문자 구분 안한다.
		*/
		//특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내의 암호 정규식 ( 3 가지 조합)

	   var pw_rule =/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	   var email_rule =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	   // var tel_rule = /^\d{2,3}-\d{3,4}-\d{4}$/; 전화번호용
	    
	   if ($("#member_id").val() == null || $("#member_id").val() == "") {
	      alert("아이디를 입력해주세요.");
	      $("#member_id").focus();
	    
	      return false;
	      } 
	   
	   
	   if(!overChk){
	      alert("아이디 중복체크를 눌러주세요.");
	      $("#IdOverlay").focus();
	    
	      return false;
	      }
	   
	   
	   if ($("#member_pw").val() == null || $("#member_pw").val() == "") {
	      alert("비밀번호를 입력해주세요.");
	      $("#member_pw").focus();
		    return false;
       }  

	 	if(!pw_rule.test($("#member_pw").val()))  {
		    alert("비밀번호는 8 ~ 16자 영문, 숫자, 특수문자를 최소 한가지씩 조합해야 합니다.");
		    $("#member_pw").focus();
		    return false;
	       }
	   
	   if ($("#member_pw2").val() == null || $("#member_pw2").val() == "") {
	      alert("비밀번호 확인을 입력해주세요.");
	      $("#member_pw2").focus();
	       
	      return false;
	      }
	    
	   
	   if ($("#member_pw").val() != $("#member_pw2").val()) {
	      alert("비밀번호가 일치하지 않습니다.");
	      $("#member_pw2").focus();
	    
	      return false;
	      }
	   
	   if ($("#name").val() == null || $("#name").val() == "") {
	   alert("이름을 입력해주세요.");
	   $("#name").focus();
	    
	      return false;
	      } 
	   
	   
	   if ($("#university_name").val() == null || $("#university_name").val() == "") {
	      alert("대학교를 입력해주세요.");
	      $("#university_name").focus();
	       
	      return false;
	      } 
	   
	   if ($("#phone").val() == null || $("#phone").val() == "") {
	      alert("연락처를 입력해주세요.");
	      $("#phone").focus();
	    
	      return false;
	      }
	   
	   
	   if ($("#email").val() == null || $("#email").val() == "") {
	      alert("이메일을 입력해주세요.");
	      $("#email").focus();
	    
	      return false;
	      }
	   
	   
	   
	   if(!EmailOverlay){
	      alert("이메일 중복체크를 눌러주세요.");
	      $("#EmailOverlay").focus();
	       
	      return false;
	      }
	   

	   
	   if ($("#photos").val() == null || $("#photos").val() == "") {
	      alert("인증서를 등록해주세요.");
	      $("#photos").focus();
	       
	      return false;
	      }

	   
	   if(!email_rule.test($("#email").val())){
		      alert("이메일을 형식에 맞게 입력해주세요. ex) 1234@naver.com");
		      $("#email").focus();
		      return false;
		      }
	   
	   
	   if (confirm("회원가입하시겠습니까?")) {
	    
	   $("#test").submit();
	    
	      return false;
	      }
	   }		
		
		
		
</script>
</html>