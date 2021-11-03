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
	
		<div id="css3" class="menuSection">
			<h2>
				<a href="#css3">등록된 이메일로 찾기</a>
			</h2>
			<div id="move">
				<form name="findIdByEmailfrm" id="findIdByEmail"
					action="findIdByEmail.do" method="post">
					<div class="inputEnter" style="display: block;">
						<div class="inputBox">
							<div class="styleInput">
								<input name="memNm" id="memNm2" type="text" class="iInput" required
									placeholder="이름">
							</div>
							<div class="emailInput">
								<div class="styleInput">
									<input name="memEmail" id="memEmail" type="email" class="iInput" required
										placeholder="이메일">
								</div>
							</div>
						</div>
						<div class="btnArea">
							<button type="submit" class="btn8f">확인</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div id="api" class="menuSection">
			<h2>
				<a href="#api">등록된 휴대폰으로 찾기</a>
			</h2>
			<div id="move">
				<form name="findIdByPhonefrm" id="findIdByPhone"
					action="findIdByPhone.do" method="post">
					<div class="inputEnter" style="display: block;">
						<div class="inputBox">
							<div class="styleInput">
								<input id="memNm3" name="memNm" type="text" class="iInput" required
									placeholder="이름">
							</div>
							<div class="styleInput">
								<input id="inputHp" name="inputHp" type="text" class="iInput" required
									placeholder="휴대폰번호 (-없이 입력)">
							</div>
						</div>
						<div class="btnArea">
							<button type="submit" class="btn8f">확인</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>