<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html lang="ko">
<head>
<meta charset="utf-8">
<title>ShowTicket</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/main.css">

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>

<!-- WebSocket:sock.js CDN -->	
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>	

<!-- WebSocket: stomp.js CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

<!-- bootstrap -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/list.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/header.css" />

<!-- 폰트 -->
<!-- font-family: 'Gothic A1', sans-serif; -->
<link
	href="https://fonts.googleapis.com/css?family=Gothic+A1&display=swap"
	rel="stylesheet">

<script type="text/javascript">
let sock = new SockJS("${pageContext.request.contextPath}/echo");

sock.onopen = onOpen;
sock.onmessage = onMessage;
sock.onclose = onClose;


function onOpen(){
 	console.log('websocket opened');
}

//서버로부터 메시지를 받았을 때
function onMessage(msg) {
    var data = msg.data;
   	alert(data);
}

//서버와 연결을 끊었을 때
function onClose(evt) {
	console.log('websocket closed');
}

</script>	


<!-- 로그인 관련 모달 부분 -->
<!-- 로그인모달 : https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">로그인</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <!--로그인폼 : https://getbootstrap.com/docs/4.1/components/forms/#overview -->
          <form action="${pageContext.request.contextPath}/member/memberLogin.do" method="post">
		      <div class="modal-body plusbody">
		      	<div class="loginInfo">
		      		<input type="text" class="form-control" name="memberId" placeholder="아이디" required>
				    <br />
				    <input type="password" class="form-control" name="password" placeholder="비밀번호" required>
				</div>
				<div class="loginbtn">
				    <button type="submit" class="btn btn-color loginsubmit" >로그인</button>
				    <button type="button" class="btn logincancel" data-dismiss="modal">취소</button>		    
				</div>
		      	<div class="find">
					<a href="javascript:popId()" class="findcolor">아이디 찾기</a>
					<span class="findcolor">|</span> <a href="javascript:popPwd()" class="findcolor">비밀번호 찾기</a>
		  	  	</div>
		      </div>
		  </form>
	    </div>
	  </div>
	</div> <!-- 로그인 모달 끝 -->

<body>

<script>
	var meta = document.createElement('meta');
	meta.setAttribute('name', 'more_page_type');
	meta.setAttribute('content', 'main');
	document.getElementsByTagName('head')[0].appendChild(meta);
	
	
	function popId(){
	    var url = "${pageContext.request.contextPath}/member/memberIdFind.do";
	    var name = "popup test";
	    var option = "width = 430, height = 550, top = 80, left = 600, location = no"
	    window.open(url, name, option);
	}
	function popPwd(){
	    var url = "${pageContext.request.contextPath}/member/memberPwdFind.do";
	    var name = "popup test";
	    var option = "width = 430, height = 550, top = 80, left = 600, location = no"
	    window.open(url, name, option);
	}

</script>

	<div id="wrap">
		<div id="header">
			<div class="gnb">
				<div class="inner">
					<div class="user_menu">
						<div id="login">
							<!-- 로그인 안한 경우 -->
							<c:if test="${memberLoggedIn == null }">
								<button class="login" type="button" data-toggle="modal" data-target="#loginModal">로그인</button><span>|</span>
								<a href="javascript:;" id="joinBtn"
									onclick="location.href='${pageContext.request.contextPath}/member/memberEnroll.do'">회원가입</a><span>|</span>
								<a href="" id="reserveLogin">예매확인/취소</a><span>|</span>
								<a href="${pageContext.request.contextPath}/help/main.do">고객센터</a>
							</c:if>
							<!-- 로그인한 경우 -->
							<c:if test="${memberLoggedIn != null }">
								<c:if test="${memberLoggedIn.memberId == 'admin' }">
									<span class="black"><a href="${pageContext.request.contextPath }/admin/adminReport.do">${memberLoggedIn.memberId }</a> 님, 환영합니다</span>
									&nbsp;
									<button class="logout" onclick="location.href='${pageContext.request.contextPath}/member/memberLogout.do'">로그아웃</button><span>|</span> 
									<a href="${pageContext.request.contextPath}/admin/adminReport.do" id="reserveLogin">신고게시판</a><span>|</span>
									<a href="${pageContext.request.contextPath}/help/main.do">고객센터</a>
								</c:if>
								<c:if test="${memberLoggedIn.memberId != 'admin' }">
									<span class="black"><a href="${pageContext.request.contextPath }/member/reservation.do?cPage=1">${memberLoggedIn.memberId }</a> 님, 환영합니다</span>
									&nbsp;
									<button class="logout" onclick="location.href='${pageContext.request.contextPath}/member/memberLogout.do'">로그아웃</button><span>|</span> 
									<a href="${pageContext.request.contextPath}/member/reservation.do?cPage=1" id="reserveLogin">예매확인/취소</a><span>|</span>
									<a href="${pageContext.request.contextPath}/help/main.do">고객센터</a>
								</c:if>
							</c:if>

							<%-- <a href="" id="reserve">예매확인/취소</a><span>|</span> 
							<a href="${pageContext.request.contextPath}/help/main.do">고객센터</a> --%>
						</div>
						<div id="logout" style="display: none;">
							<!-- 이부분 슬기씨한테 여쭤보기, 예매확인/취소, 로그아웃, 고객센터 중복  -->
							<!-- <a id="paycoVipIcon" href="/vip/main" class="ico_vip"
								style="display: none;"></a> <strong id="reserveLoginId"><a
								href="javascript:;" class="user_name"></a><em>님</em></strong><span>|</span> -->
							<!-- [D] 로그인 후 주석 해제 입니다. -->
							<%-- <a href="${pageContext.request.contextPath}/member/reservation.do" id="reserveLogin">예매확인/취소</a><span>|</span>
							<a href="#" id="logoutBtn">로그아웃</a><span>|</span> 
							<a href="${pageContext.request.contextPath}/help/main.do">고객센터</a> --%>

						</div>
					</div>
				</div>
			</div>


			<div class="search_area">
				<a href="${pageContext.request.contextPath }/"> 
					<img src="${pageContext.request.contextPath }/resources/images/showticket_logo.png" id="center-image" alt="쇼티켓로고" />
				</a>

				<div class="search">
					<form name="searchForm" action="${pageContext.request.contextPath }/main/search.do"
						method="GET">
						<fieldset id="fieldsetS">
							<legend>검색</legend>
							<input type="text" name="queryKeyword" title="검색어 입력" value="" style="padding:10px;">
							<p class="btn_search">
								<a href="javascript:document.searchForm.submit()"
									class="material-icons w3-xlarge">search</a>
							<p>
						</fieldset>
					</form>
				</div>

				<!-- // 검색창 덮는 배너 추가 -->
			</div>

			<div class="menu">
				<!-- 메뉴바   -->
				<ul class="inner">
					<!-- [D] 메뉴 활성일때 on 클래스 추가 입니다. -->
					<!-- [D] 메뉴 오버일때 over 클래스 추가 입니다. -->
					<li class="menu2 menu_list" id="menu2">
						<a href="${pageContext.request.contextPath}/musical/musical.do">
							<span class="menu_tit">뮤지컬</span>
						</a> 
						<span class="overbg"></span>
					</li>
					<li class="menu3 menu_list menu_list2" id="menu3">
						<a href="${pageContext.request.contextPath}/show/show.do"> 
							<span class="menu_tit">연극</span>
						</a> 
						<span class="overbg"></span>
					</li>

					<li class="event_cate menu7">
						<a href="${pageContext.request.contextPath}/ranking/ranking.do">
							<span class="menu_tit menu_tit_sm">랭킹</span>
						</a>
					</li>
					<li class="event_cate menu_list6 menu5" id="menu5">
						<a href="${pageContext.request.contextPath }/area/area.do"> 
							<span class="menu_tit menu_tit_sm">지역</span>
						</a>
					</li>
					<li class="event_cate menu_list8 menu6" id="menu6">
						<a href="${pageContext.request.contextPath }/event/eventList.do"> 
							<span class="menu_tit menu_tit_sm">이벤트/쿠폰</span>
						</a> 
					</li>

				</ul>
			</div>
			<!-- 메뉴바 END -->
		</div>
