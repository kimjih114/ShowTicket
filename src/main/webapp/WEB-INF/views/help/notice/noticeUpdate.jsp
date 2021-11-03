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

<div id="container">
	<div class="inner">
		<div class="quick_menu">
			<div class="title">고객센터</div>
			<ul>
				<li class="qmenu1"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=62"><i
						class="material-icons">lock_open</i><br />아이디/비밀번호<br>찾기 </a></li>
				<li class="qmenu2"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=64"><i
						class="material-icons">shopping_cart</i><br />예매/취소<br>환불 </a></li>
				<li class="qmenu3"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=69"><i
						class="material-icons">location_on</i><br>티켓수령<br>문의 </a></li>
				<li class="qmenu4"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=66"><i
						class="material-icons">turned_in_not</i><br />할인수단<br>안내 </a></li>
				<li class="qmenu5"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=68"><i
						class="material-icons">hourglass_empty</i><br />관심공연알림<br>안내
				</a></li>
				<li class="qmenu6"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=67"><i
						class="material-icons">star_border</i><br />이벤트<br>안내 </a></li>
			</ul>
		</div>

		<div class="help_cont">

			<ul class="help_lmenu">
				<!-- [D] 활성상태일 때 .on 추가입니다. -->
				<li id="help_lmeu"><a
					href="${pageContext.request.contextPath}/help/main.do"
					class="help_lmeu1">고객센터홈</a></li>
				<li id="help_lmeu2"><a
					href="${pageContext.request.contextPath}/help/notice.do"
					class="help_lmeu2 focus">공지사항</a></li>
				<li id="help_lmeu"><a
					href="${pageContext.request.contextPath}/help/faq.do"
					class="help_lmeu3">FAQ</a></li>
			</ul>

			<div class="help_rcont">
				<div>
					<h2 class="help-title">공지사항</h2>
				</div>
				<div id="enroll-container">

					<form name="noticeUpdateFrm" id="noticeUpdate"
						action="noticeUpdateEnd.do" method="post"
						onsubmit="return validate();">
						<input type="hidden" name="noticeNo" value="${n.noticeNo}"/>
						<table id="tbl-write" class="table">
							<tr>
								<th class="text-left">제목<i class="ico-star">*</i>
								</th>
								<td><input type="text" name="noticeTitle"
									class="form-control title" required placeholder="한글 20자까지 작성가능"
									value="${n.noticeTitle}"></input></td>
							</tr>
							<tr>
								<th class="text-left">카테고리<i class="ico-star">*</i></th>
								<td>
									<div class="custom-radio">
										<input type="radio" name="noticeCategory" id="t" value="t"
											${n.noticeCategory eq 't'?"checked":""} required /> <label
											for="t">티켓오픈</label>
									</div>
									<div class="custom-radio">
										<input type="radio" name="noticeCategory" id="s" value="s"
											${n.noticeCategory eq 's'?"checked":""} required /> <label
											for="s">시스템관련</label>
									</div>
									<div class="custom-radio">
										<input type="radio" name="noticeCategory" id="c" value="c"
											${n.noticeCategory eq 'c'?"checked":""} required /> <label
											for="c">변경취소</label>
									</div>
									<div class="custom-radio">
										<input type="radio" name="noticeCategory" id="o" value="o"
											${n.noticeCategory eq 'o'?"checked":""} required /> <label
											for="o">기타</label>
									</div>
								</td>
							</tr>

							<tr>
								<th class="text-left">내용<i class="ico-star">*</i></th>
								<td><textarea name="noticeContent" cols="40" rows="10"
										class="form-control" required>${n.noticeContent}</textarea></td>
							</tr>
						</table>
						<input class="btn btn-color" id="complete" type="submit"
							value="완료"> <input class="btn btn-gray" id="cancel"
							type="button"
							onclick="location.href='${pageContext.request.contextPath}/help/notice.do'"
							value="취소">
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
	$(document).ready(function() {
		$("#help_lmeu1").addClass("on");
		$('input, textarea').placeholder();
	});

	function searchNotice() {
		var searchKeyword = encodeURI($("#search_help").val());
		location.replace("/help/notice?searchKeyword=" + searchKeyword + "");
	}
	//]]>
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>