<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>사원등록</title>
<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
				
	<link rel="stylesheet" href="/include/css/commons/insertMember.css">
				
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
		
	<script type="text/javascript">
	$(document).ready(function(){
		 $("#authentication").hide();
		 
		$("input:text[numberOnly]").on("keyup", function() {
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		});
	

		$('#hmp_picture').change(function(){
		    setImageFromFile(this, '#preview');
		});
		$('#hmp_birth').change(function(){
			
			$("#residentnum_1").val($("#hmp_birth").val());
		});
		
		$("#hmp_workexperience").change(function(){			
			if($("#hmp_workexperience").val()=="66"){
				$("#hmp_workcontents").val("없음");
			}
		});
		
		$("#signUP").click(function(){
			if($("#email_code").val()!=$("#emailCode").val()){
				alert("이메일 인증코드가 다릅니다.!");
			}
			
			if($("#checkPW").val()=='N'){
				alert("비밀번호 확인버튼을 눌러주세요!");
			}
			if($("#checkID").val()=='N'){
				alert("아이디 중복 방지를 확인하세요!");
			}
			if($("#checkPW").val()=='Y'&&$("#checkID").val()=='Y'){
				$("#hmp_residentnum").val($("#residentnum_1").val()+$("#residentnum_2").val());
				$("#hmp_email").val($("#email1").val()+"@"+$("#email2").val());
				$("#hmp_bank").attr("38");
				$("#insertMember").attr("action","/etc/insertMember.td").submit();
			}
		
		});
		$("#PwCheck").click(function(){
			var cPwVal=$("#hmp_pw").val();
			var cIdVa1=$("#hmp_id").val();
			var cPwVal2=$("#pwC").val();
			var cPwVal3=chkPW(cPwVal,cIdVa1);
			
			if(!cPwVal){
				alert('비밀번호를 입력하세요');
				$("#hmp_pw").focus();
				return false;
			}
			if(cPwVal!=cPwVal2){
				alert('비밀번호를 확인하세요');
				$("#hmp_pw").val('');
				$("#pwC").val('');
				$("#hmp_pw").focus();
				return false;
			}
			if(cPwVal==cPwVal2&&cPwVal3==true){
				alert('비밀번호가 확인되었습니다.');
				$("#checkPW").val('Y');
				return false;
			}
		});
		$("#cIdCheck").click(function(){	
			var ID=$("#hmp_id").val();
			$.ajax({
				url:"/human/idCheckCtr.td",
				type:"POST",
				data:{id:ID},
				error:function(){
					alert('시스템 오류 입니다. 관리자에게 문의 하세요');
				},
				success:function(resultData){
					if(resultData==false){
						alert("사용 불가능한 아이디 입니다.!");
					}
					if(resultData==true){
						$("#checkID").val('Y');
						
						alert("사용 가능한 아이디 입니다.");
						
					}
				}
			});
		});
		$("#emailCk").click(function(){	
			var flag='0';
			var hm_name=$("#hmp_name").val();
			var hm_email=$("#email1").val()+"@"+$("#email2").val();
			$.ajax({
				url:"/etc/emailAuth.td",
				type:"POST",
				data:{selectFunc:flag,
					  hm_name:hm_name,
					  hm_email:hm_email},
				error:function(){
					alert('시스템 오류 입니다. 관리자에게 문의 하세요');
				},
				success:function(resultData){
					var data=$(resultData).find("resultData").text();
					$("#emailCode").val(data);
					alert('이메일 주소로 인증 메일을 전송했습니다 코드를 적어주세요');
					$("#authentication").show();
				}
			});
		});
		 $("#hmp_birth").datepicker({
	    	 dateFormat: 'ymmdd'
	    	,showMonthAfterYear:true       
	    	,minDate:'-70y'
	        ,yearSuffix: "년" 
	       	,yearRange: 'c-100:c+0'
	       	,changeYear: true //콤보박스에서 년 선택 가능
	        ,changeMonth: true //콤보박스에서 월 선택 가능       
	        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] 
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] 
	        ,dayNamesMin: ['일','월','화','수','목','금','토']
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
	    });
		
		 $('#hmp_picture').change(function() {
				console.log("파일이름 textbox에 넣어주기");
				
				var file_dir = $('#hmp_picture').val();
				console.log("file_dir >>> : " + file_dir);
				
				var start = file_dir.lastIndexOf("\\")+1;
				console.log("start >>> : " + start);
				var end = file_dir.length;
				console.log("end >>> : " + end);
				var file_name = file_dir.substring(start, end);
				console.log("file_name >>> : " + file_name);
				
				$('#file_name').attr("value",file_name);
				
			}); 
		 
	});
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var fullRoadAddr = data.roadAddress; 
	            var extraRoadAddr = ''; 
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }	             
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	         
	            if(fullRoadAddr !== ''){
	                fullRoadAddr += extraRoadAddr;
	            }
	            document.getElementById('hmp_postcode').value = data.zonecode; 
	            document.getElementById('hmp_addr').value = fullRoadAddr;
	            if(data.autoRoadAddress) {
	 
	                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	            }else if(data.autoJibunAddress) {
	                var expJibunAddr = data.autoJibunAddress;
	                document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	
	            } else {
	                document.getElementById('guide').innerHTML = '';
	            }
	        }
	    }).open();
}		
	function setImageFromFile(input, expression) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $(expression).attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	function selectEmail(ele){ 
		var $ele = $(ele);
		var $email2 = $('input[name=email2]'); 
		if($ele.val() == "1"){ 
			$email2.attr('readonly', false); 
			$email2.val(''); 
		}else{
			$email2.attr('readonly', true);
			$email2.val($ele.val()); }
		}
	

	function chkPW(cPwVal,cIdVa1){

		var pw = cPwVal;
		var id = cIdVa1;
			
		var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
		
		 
		if(false === reg.test(pw)) {
		alert('비밀번호는 8자 이상이어야 하며, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다.');
		}else if(/(\w)\1\1\1/.test(pw)){
		 alert('같은 문자를 4번 이상 사용하실 수 없습니다.');
		 return false;
		 }else if(pw.search(id) > -1){
		 alert("비밀번호에 아이디가 포함되었습니다.");
		  return false;
		 }else if(pw.search(/\s/) != -1){
		 alert("비밀번호는 공백 없이 입력해주세요.");
		 return false;
		 }else {
		 return true;
		 }

	}	
	
</script>

</head>

	<body>
		<form name="insertMember"
		      id="insertMember"
		      method="POST"
		      enctype="multipart/form-data"
		      autocomplete="off">
			<fieldset>
			<div class="toptitle" name="toptitle">사원정보</div>
			<div class="firstbox">
				<strong>성명</strong>
				<input type="text" name="hmp_name" id="hmp_name">
			</div>
			<div>
				<strong>아이디</strong>
				<input type="text" name="hmp_id" id="hmp_id">
				<input type="button" class="button" id="cIdCheck" value="ID확인">
			</div>
			<div>
				<strong>비밀번호</strong>
				<input type="password" name="hmp_pw" id="hmp_pw">
			</div>
			<div>
				<strong>비밀번호확인</strong>
				<input type="password" name="pwC" id="pwC">
				<input type="button" class="button" name="PwCheck" id="PwCheck" value="PW확인">
			</div>
			<div>
				<strong>생년원일</strong>
				<input type="text"
							name="hmp_birth" id="hmp_birth">
			</div>
			<div>
				<strong>주민번호</strong>
				<input type="text" name="residentnum_1" id="residentnum_1" readonly/>-
				<input type="password" name="residentnum_2" id="residentnum_2" maxlength="7" numberOnly/>
			</div>
			<div>
				<strong>핸드폰번호</strong>
				<input type="text" name="hmp_hpnum" id="hmp_hpnum" placeholder="-없이 숫자만 입력하세요" numberOnly>
			</div>
			<div>
				<strong>이메일</strong>
				<input name="email1" id="email1" type="text"> @ <input name="email2" id="email2" type="text">
							<select name="select_email" onChange="selectEmail(this)" class="select_css"> 
								<option value="" selected>선택하세요</option> 
								<option value="naver.com">naver.com</option> 
								<option value="gmail.com">gmail.com</option> 
								<option value="hanmail.com">hanmail.com</option> 
								<option value="1">직접입력</option> 
							</select>
								<input type="button" class="button" name="emailCk" id="emailCk" value="email확인">
			</div>
			<div id = "authentication">
				<strong>이메일 인증 코드</strong>
				<input type="text" name="email_code" id="email_code">
			</div>
			<div class="picbox">
				<strong>사진</strong>
				<!-- <div class="preview">사진 미리보기</div> -->
				<input type="text" id="file_name" class="file_textbox" readonly>
				<input type="button" value="찾아보기" class="button" onclick="document.all.hmp_picture.click();">
				<input type="file" name="hmp_picture" id="hmp_picture" style="display:none;">
			</div>
			<div>
				<strong>우편번호</strong>
				<input type="text" id="hmp_postcode" name="hmp_postcode" placeholder="우편번호">
				<input type="button" class="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			</div>
			<div>
				<strong>도로명주소</strong>
				<input type="text" name="hmp_addr" id="hmp_addr" placeholder="도로명주소">
				<span id="guide" style="color:#999"></span>
			</div>
			<div>
				<strong>상세주소</strong>
				<input type="text" name="cadress" id="cadress">
			</div>
			<div>
				<strong>은행</strong>
				<input type="text" name="hmp_bank" id="hmp_bank" value="국민" readonly >
			</div>
			<div>
				<strong>예금주명</strong>
				<input type="text" name="hmp_depositors" id="hmp_depositors">
			</div>
			<div>
				<strong>계좌번호</strong>
				<input type="text"
					   name="hmp_accountnum" 
					   id="hmp_accountnum"
					   placeholder="-없이 숫자만 입력" 
					   numberOnly>
			</div>
			<div>
				<strong>최종학력</strong>
					<SELECT NAME = "hmp_education" class="select_css">
						<OPTION VALUE="28">고졸</OPTION>
						<OPTION VALUE="29">초대졸</OPTION>
						<OPTION VALUE="30">대졸</OPTION>
						<OPTION VALUE="31">석사</OPTION>
						<OPTION VALUE="32">박사</OPTION>
				    </SELECT>
			</div>
			<div>
				<strong>학력내용</strong>
				<input type="text" name="hmp_educontents" id="hmp_educontents">
			</div>
			<div>
				<strong>경력</strong>
					<SELECT NAME = "hmp_workexperience" id="hmp_workexperience" class="select_css">
						<OPTION VALUE="65">경력</OPTION>
						<OPTION VALUE="66">신입</OPTION>
					</SELECT>
			</div>
			<div>
				<strong>경력내용</strong>
				<input type="text" name="hmp_workcontents" id="hmp_workcontents" class="select_css">
			</div>
			<div class="lastbox">
				
			</div>
				<input type="hidden" name="hmp_email" id="hmp_email" >
		    	<input type="hidden" name="hmp_residentnum" id="hmp_residentnum">
				<input type="hidden" name="emailCode" id="emailCode">
				<input type="hidden" value="N" name="checkID" id="checkID">
				<input type="hidden" value="N" name="checkPW" id="checkPW">
				<input type="button" class="button" value="입력" name="signUP" id="signUP" style="width:80px;">
		</fieldset>
	 </form>
	</body>
</html>