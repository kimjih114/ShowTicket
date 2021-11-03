<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle" />
</jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/help.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">

<script>
function talkPopup(){
	
	if('${memberLoggedIn.memberId}'==''){
		alert("로그인 후 사용해주십시오.");
		return false;
	}
	var url = "${pageContext.request.contextPath}/talk.do";
    var name = "popup test";
    var option = "width = 400, height = 500, top = 100, left = 400, location = no"
    window.open(url, name, option);
}

//엔터키처리
function enterkey() {
    if (window.event.keyCode == 13) {

         // 엔터키가 눌렸을 때 실행할 내용
         search();
    }
}

//엔터키 누를경우 새로고침 방지 코드*
	document.addEventListener('keydown', function(event) {
		  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
		}, true);


function search(){
	//검색 버튼 클릭
		var srch = "";
		
		srch = $(".help_rcont .search input[type=text] ").val();
		location.href = "${pageContext.request.contextPath}/help/mainSearch.do?question="+srch+"&answer="+srch;

}
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
				<li id="help_lmeu1"><a
					href="${pageContext.request.contextPath}/help/main.do"
					class="help_lmeu1">고객센터홈</a></li>
				<li id="help_lmeu"><a
					href="${pageContext.request.contextPath}/help/notice.do"
					class="help_meu2">공지사항</a></li>
				<li id="help_lmeu"><a
					href="${pageContext.request.contextPath}/help/faq.do"
					class="help_meu3">FAQ</a></li>
			</ul>

			<div class="help_rcont">
				<div>
					<h2>고객센터홈</h2>
				</div>
				<div class="search_area">


					<div class="question">질문 검색하기</div>
					<div class="search">
						<form name="searchForm"
							action="http://www.ticketlink.co.kr/search" method="GET">
							<fieldset id="fieldsetS">
								<legend>검색</legend>
								<input type="text" name="query" title="검색어 입력" value="" onkeyup="enterkey();">
								<p class="btn_search">
									<a href="javascript:search()"
										class="material-icons w3-xlarge">search</a>
								<p>
							</fieldset>
						</form>
					</div>

					<!-- // 검색창 덮는 배너 추가 -->
				</div>

				<ul class="help_link">
					<li class="first"><a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=64"
						class="hlink1"> <img
							src="${pageContext.request.contextPath }/resources/images/help/appoint.png" /></a>
					</li>
					<li><a href="javascript:talkPopup();" class="hlink2" id="hlink2"> <img
                            src="${pageContext.request.contextPath }/resources/images/help/talk.PNG" /></a>
                    </li>
					<li><a href="${pageContext.request.contextPath}/help/faq.do" class="hlink3"> <img
							src="${pageContext.request.contextPath }/resources/images/help/faq.PNG" /></a>
					</li>
					<li class="first"><a href="/help/notice" class="hlink4"> <img
							src="${pageContext.request.contextPath }/resources/images/help/new.PNG" /></a>
					</li>
					<li><span class="hlink5"> <img
							src="${pageContext.request.contextPath }/resources/images/help/ars.PNG" />
					</span></li>
					<li><span class="hlink6"> <img
							src="${pageContext.request.contextPath }/resources/images/help/arsreq.PNG" />
					</span></li>
				</ul>
				<div class="helpmain_list">
					<div class="helpmain_question">
						<strong>자주 묻는 질문</strong>
						<ul>
							<li><a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=25">티켓 환불은 어떻게 받나요??</a></li>
							<li><a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=16">회원 가입은 어떻게 하나요?</a></li>
							<li><a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=14">[아이디 찾기]와 [비밀번호 찾기]는 어떻게 하나요?</a></li>
							<li><a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=23">이벤트 당첨되었는데 티켓은 어떻게 받나요?</a></li>
							<li><a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=18">각종 쿠폰 오픈쿠폰 등은 언제 지급되나요?</a></li>
						</ul>
					</div>
					<div class="helpmain_notice">
						<strong>최근 공지 사항</strong>
						<ul>
							<c:forEach items="${noticeList}" var="n">
								<li>
									<a href="${pageContext.request.contextPath}/help/noticeView.do?noticeNo=${n.noticeNo}">
										[${(n.noticeCategory=='t'?"티켓오픈":(n.noticeCategory=='s'?"시스템":(n.noticeCategory=='c'?"변경/취소":"기타")))}] ${n.noticeTitle}
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

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