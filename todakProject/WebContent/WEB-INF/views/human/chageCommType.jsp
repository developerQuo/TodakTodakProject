<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	Object obj=request.getAttribute("comnum");
	String comnum=(String)obj;
	
	String hm_empnum = (String)request.getAttribute("hm_empnum");
%>
	<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
		
	<script type="text/javascript">
	$(document).ready(function(){
		$("#changeComm").click(function(){
			var result=null;
			if($('input:checkbox[id="leave"]').is(":checked")){
				result=$('input:checkbox[id="leave"]').val();
			}
			if($('input:checkbox[id="hd"]').is(":checked")){
				result=$('input:checkbox[id="hd"]').val();
			}
			if($('input:checkbox[id="half"]').is(":checked")){
				result=$('input:checkbox[id="half"]').val();
			}
			$("#hc_tanda").val(result);
			$("#hc_comnum").val('<%=comnum %>');
			$("#hm_empnum").val('<%=hm_empnum %>');
			$("#change").attr({
				"method":"get",
				"action":"/human/changeCommUpdate.td"
			});
			$("#change").submit();
		});
	});
	function oneCheckbox(a){
        var obj = document.getElementsByName("comm");
        for(var i=0; i<obj.length; i++){
            if(obj[i] != a){
                obj[i].checked = false;
            }
        }
    }
	</script>
</head>
<body>
		<form name="change" id="change" method="post">
			<input type="hidden" name="hc_tanda" id="hc_tanda">
			<input type="hidden" name="hc_comnum" id="hc_comnum">
			<input type="hidden" name="hm_empnum" id="hm_empnum">
     		<label><input type="checkbox" name="comm" id="leave" value="71" onclick="oneCheckbox(this)"> 퇴근</label>
     		<label><input type="checkbox" name="comm" id="hd" value="72" onclick="oneCheckbox(this)"> 휴가</label>
     		<label><input type="checkbox" name="comm" id="half" value="49" onclick="oneCheckbox(this)"> 반차</label>
     		<input type="button" value="등록" id="changeComm"/>	
		</form>
</body>
</html>