<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/find.css"></link>
<meta charset="utf-8">
<title>아이디 찾기</title>
</head>


<script language="JavaScript" type="text/JavaScript">

	//마우스 우클릭 방지
	document.oncontextmenu = function() {
		return false;
	}

	//텍스트 블럭지정 복사 방지
	document.onselectstart = function() {
		return false;
	}

	//드래그 방지
	document.ondragstart = function() {
		return false;
	}

	function newPwd(){
		var auth = $("#auth").val();
		
		console.log(auth);
		if(auth != '${authKey}'){			
			alert("인증번호가 틀렸습니다. 다시 입력해주세요. ");
			$("#auth").val("");
			return;
		}
	
		var html ="<form name='updatePwdByFindfrm' id='updatePwdByFind' action='updatePwdByFind.do' method='post'>"; 
		html +=	"<h4>비밀번호 재설정</h4> <div class='id'><span>ID : ${memberId}</span></div><input id='memberId' name='memberId' type='hidden' value='${memberId}'><div class='styleInput'>";
		html += "<input id='pwd' name='password_new' type='password' class='iInput' required placeholder='새 비밀번호'></div>";
		html += "<div class='styleInput'><input id='pwd2' type='password' class='iInput' required placeholder='새 비밀번호 확인'></div>";
		html += "<span class='pw ok'>비밀번호 일치</span><span class='pw error'>비밀번호 불일치</span>"
		html += "<div class='btnArea'><button type='submit' class='btn8f'>비밀번호 변경</button></div></form>";
		
		$(".resultBox").html(html);	
	}
	
$(()=>{
	
	// 비밀번호 검사
	$(document).on('keyup', '#pwd2', function(){
 		
 		var password1 = $("#pwd").val().trim();
 		var password2 = $("#pwd2").val().trim();
 		
 		if(password1 != password2){
 			$(".pw.error").show();
			$(".pw.ok").hide();
 		}
 		else{
 			$(".pw.error").hide();
			$(".pw.ok").show();
 		}
 	});
})
</script>


<body>
	<img
		src="${pageContext.request.contextPath }/resources/images/showticket_logo.png"
		style="width: 100px; height: 40px; padding-top: 20px; margin-left: 171px;"
		id="center-image" alt="스프링로고" />
	<br />
	<hr />
	<div class="accordionMenu">
		<ul class="nav nav-pills nav-justified">
			<li class="nav-item"><a class="nav-link select nav-font"
				href="${pageContext.request.contextPath}/member/memberIdFind.do">아이디
					찾기</a></li>
			<li class="nav-item"><a class="nav-link nav-font default"
				href="${pageContext.request.contextPath}/member/memberPwdFind.do">비밀번호
					찾기</a></li>
		</ul>
		<hr />
		<div class="resultBox">
			<h4>비밀번호 찾기</h4>
			<c:if test="${authKey eq null }">
				<div class="id">
					<span>입력된 회원정보가 존재하지 않습니다. <br />비회원일 경우 회원가입 후 이용해주세요.
					</span>
				</div>
			</c:if>
			<c:if test="${authKey ne null }">
				<div class="inputBox">
					<div class="styleInput">
						<input id="auth" name="auth" type="text" class="iInput" required
							placeholder="인증번호 입력">
					</div>
				</div>
				<div class="btnArea">
					<button type="button" class="btn8f" onclick="newPwd();">비밀번호 찾기</button>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>