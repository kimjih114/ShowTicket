<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
	
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script> 
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/member.css">	  
</head>
<script>

function passwordValidate(){
	 var pwd_new = $("#password_new").val().trim(); 
	 var pwd_chk =$("#password_chk").val().trim(); 

	 if(pwd_new!=pwd_chk){
			alert("입력하신 비밀번호가 일치하지 않습니다.");
			$("#password_new").select();
			return false;
		}
		return true;	
 }
</script>

<body>
	
	<div id="updatePassword-container">
		<img src="${pageContext.request.contextPath }/resources/images/showticket_logo.png" alt="" />
		<form name="updatePwdFrm" id="updatePFrm" action="${pageContext.request.contextPath }/member/updatePasswordEnd.do" method="post" >
		
				
				<label for="password">현재 비밀번호</label>
				<input type="password" id="password" name="password" class="form-control" required>
				
		
				<label for="password">변경할 비밀번호</label>
				<input type="password" name="password_new" id="password_new" class="form-control" required>
					
				<label for="password">비밀번호 확인</label>
				<input type="password" id="password_chk" class="form-control" required><br>
				
				
				<br />
				<input type="submit" class="btn btn-outline-success my-2 my-lm-0" id="btn_pwd"  value="변경" onclick="return passwordValidate();"/>
				<input type="button" class="btn btn-outline-success my-2 my-lm-0" onclick="self.close();" value="닫기" />						
					
				<input type="hidden" name="memberId" value="honggd" />
		</form>
		
	</div>
	
</body>
</html>