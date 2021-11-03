<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle" />
</jsp:include>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/help.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">
<script>

$(()=>{


	$("#write").click(function() {
			location.href = "${pageContext.request.contextPath}/help/faqWrite.do";
		}
	});

});


</script>

<div id="container">
	<div class="inner">
		<div class="quick_menu">
			<div class="title">고객센터</div>
			<ul>
				<li class="qmenu1"> <a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=62"><i class="material-icons">lock_open</i><br />아이디/비밀번호<br>찾기
				</a></li>
				<li class="qmenu2">
					<a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=64"><i class="material-icons">shopping_cart</i><br/>예매/취소<br>환불
				</a></li>
				<li class="qmenu3"> <a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=69"><i class="material-icons">location_on</i><br>티켓수령<br>문의
				</a></li>
				<li class="qmenu4">
					<a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=66"><i class="material-icons">turned_in_not</i><br />할인수단<br>안내
				</a></li>
				<li class="qmenu5">
					<a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=68"><i class="material-icons">hourglass_empty</i><br />관심공연알림<br>안내
				</a></li>
				<li class="qmenu6"> <a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=67"><i class="material-icons">star_border</i><br />이벤트<br>안내
				</a></li>
			</ul>
		</div>

		<div class="help_cont">

			<ul class="help_lmenu">
				<!-- [D] 활성상태일 때 .on 추가입니다. -->
				<li id="help_lmeu"><a
					href="${pageContext.request.contextPath}/help/main.do"
					class="help_lmeu1">고객센터홈</a></li>
				<li id="help_lmeu"><a
					href="${pageContext.request.contextPath}/help/notice.do"
					class="help_lmeu2">공지사항</a></li>
				<li id="help_lmeu3"><a
					href="${pageContext.request.contextPath}/help/faq.do"
					class="help_lmeu3">FAQ</a></li>
			</ul>

			<div class="help_rcont">
				<div>
					<h2>FAQ</h2>
				</div>
				<div id="enroll-container">
	<form name="faqWriteFrm" id="faqWriteEnd" action="faqWriteEnd.do" method="post" onsubmit="return validate();" >
		<table id="faqWriteTable">
			<tr>
				<th>종류<span class="star">*</span></th>
				<td>
					 <div id="type-container">
			            <select name="type" id="type">
			            <option value="T">예매/취소</option>
			            <option value="B">결제</option>
			            <option value="M">회원</option>
			            <option value="C">쿠폰/이벤트</option>
			            <option value="E">기타</option>
			            </select>
					</div>
				</td>
			</tr>
			
			<tr>
				<th>질문<span class="star">*</span></th>
				<td>
					<input type="text" class="form-control" name="question" id="question" required>
				</td>
			</tr>
			
			<tr>
				<th>답<span class="star">*</span></th>
				<td>
					<div id="password-container">
						<textarea name="answer" id="answer" cols="60" rows="15"></textarea>
					</div>
				</td>
			</tr>  
			
			
		</table>
		<input class="btn btn-color" id="complete" type="submit" value="완료" >
		<input class="btn btn-gray" id="cancel" type="button" onclick="location.href='${pageContext.request.contextPath}/help/faq.do'" value="취소">
	</form>
</div>
				




			</div>
		</div>
	</div>
</div>
<a href="javascript:window.scrollTo(0,0);" id="back_to_top">위로</a>

<script type="text/javascript"
	src="/resources/js/jquery.placeholder.min.js"></script>
<script type="text/javascript">
	//<![CDATA[
	$(document).ready(function () {
		$("#help_lmeu1").addClass("on");
		$('input, textarea').placeholder();
	});

	function searchFaq () {
		var searchKeyword = encodeURI($("#search_help").val());
		location.replace("/help/faq?searchKeyword=" + searchKeyword + "");
	}
	//]]>
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>