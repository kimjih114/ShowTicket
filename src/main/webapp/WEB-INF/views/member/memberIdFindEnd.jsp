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
		<div class="resultBox">
			<h4>아이디 찾기 결과</h4>
			<c:if test="${memberId ne null }">
				<div class="id">
					<span>ID : ${memberId} 입니다.</span>
				</div>
			</c:if>
			<c:if test="${memberId eq null }">
				<div class="id">
					<span>입력된 회원정보가 존재하지 않습니다. <br/>비회원일 경우 회원가입 후 이용해주세요.</span>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>