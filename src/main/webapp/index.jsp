<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/index.css">


<script type="text/javascript">
	$(function() {

		var i;
		var x = document.getElementsByClassName("mySlides");
		for (i = 0; i < x.length; i++) {
			x[i].style.display = "none";
		}
		index++;
		if (index > x.length) {
			index = 1;
		}
		x[index - 1].style.display = "block";
		setTimeout(slideShow, 4000);

	});
</script>
<script type="text/javascript">
	var index = 0;
	window.onload = function() {
		//slideShow();
		change();
	}
	function slideShow() {
		var i;
		var x = document.getElementsByClassName("mySlides");
		for (i = 0; i < x.length; i++) {
			x[i].style.display = "none";
		}
		index++;
		if (index > x.length) {
			index = 1;
		}
		x[index - 1].style.display = "block";
		setTimeout(slideShow, 4000);

	}
</script>
<script type="text/javascript">
	window.onload = function() {

		$("#ticket1")
				.hover(
						function() {
							$("#openingImg")
									.attr("src",
											"http://www.kopis.or.kr/upload/pfmPoster/PF_PF155674_191007_095930.gif")
						});
		$("#ticket2")
				.hover(
						function() {
							$("#openingImg")
									.attr("src",
											"http://www.kopis.or.kr/upload/pfmPoster/PF_PF155761_191007_164000.gif")
						});
		$("#ticket3")
				.hover(
						function() {
							$("#openingImg")
									.attr("src",
											"http://www.kopis.or.kr/upload/pfmPoster/PF_PF155492_191002_143931.JPG")
						});
		$("#ticket4")
				.hover(
						function() {
							$("#openingImg")
									.attr("src",
											"http://www.kopis.or.kr/upload/pfmPoster/PF_PF155520_191004_093220.gif")
						});
		$("#ticket5")
				.hover(
						function() {
							$("#openingImg")
									.attr("src",
											"http://www.kopis.or.kr//upload/pfmPoster/PF_PF152640_190806_111855.gif")
						});

		var f = $("#rank1").attr("data-url");
		var g = $("#rank2").attr("data-url");
		var h = $("#rank3").attr("data-url");
		var i = $("#rank4").attr("data-url");
		var j = $("#rank5").attr("data-url");

		$("#rank1")
				.hover(
						function() {
							$("#rangkingImg")
									.attr("src", f)
									.attr("href",
											"${pageContext.request.contextPath }/show/showDetail.do?showId=${map.mt20id}")
						});
		$("#rank2")
				.hover(
						function() {
							$("#rangkingImg")
									.attr("src", g)
									.attr("href",
											"${pageContext.request.contextPath }/show/showDetail.do?showId=${map.mt20id}")
						});
		$("#rank3")
				.hover(
						function() {
							$("#rangkingImg")
									.attr("src", h)
									.attr(
											"href",
											"${pageContext.request.contextPath }/musical/musicalDetail.do?musicalId=${map.mt20id}")
						});
		$("#rank4")
				.hover(
						function() {
							$("#rangkingImg")
									.attr("src", i)
									.attr("href",
											"${pageContext.request.contextPath }/show/showDetail.do?showId=${map.mt20id}")
						});
		$("#rank5")
				.hover(
						function() {
							$("#rangkingImg")
									.attr("src", j)
									.attr(
											"href",
											"${pageContext.request.contextPath }/musical/musicalDetail.do?musicalId=${map.mt20id}")
						});
	}
</script>

<div class="w3-content w3-section" style="max-width: 500px"></div>
<div class="top_area">
	<div class="submain_topban">
		<div class="submain_goods" style="width: 990px; margin: auto;">
			<img class="mySlides"
				src="//image.toast.com/aaaaab/ticketlink/TKL_7/공연전시_메인_990x280_드라큘라.jpg"
				width="990" height="280"> <img class="mySlides"
				src="//image.toast.com/aaaaab/ticketlink/TKL_3/공연전시_메인_990x280_친정엄마_v3.jpg"
				width="990" height="280"> <img class="mySlides"
				src="//image.toast.com/aaaaab/ticketlink/TKL_7/공연전시_메인_990x280_사랑의가객_1.jpg"
				width="990" height="280"> <img class="mySlides"
				src="//image.toast.com/aaaaab/ticketlink/TKL_5/공연전시_메인_990x280_다윈영의-악의기원.jpg"
				width="990" height="280"> <img class="mySlides"
				src="//image.toast.com/aaaaab/ticketlink/TKL_7/공연전시_메인_990x280_에드거앨런포.jpg"
				width="990" height="280"> <img class="mySlides"
				src="//image.toast.com/aaaaab/ticketlink/TKL_3/공연전시_메인_990x280_정글라이프.jpg"
				width="990" height="280"> <img class="mySlides"
				src="//image.toast.com/aaaaab/ticketlink/TKL_7/공연전시_메인_990x280_NEW-달을품은슈퍼맨.jpg"
				width="990" height="280"> <img class="mySlides"
				src="//image.toast.com/aaaaab/ticketlink/TKL_3/공연전시_메인_990x280_시티오브엔젤.jpg"
				width="990" height="280">
		</div>
		<!-- 슬릭 END -->

		<div class="section_top">
			<div class="inner">
				<div class="maintop_new open_spot">
					<div class="maintop_left">
						<div class="header">
							<a href="${pageContext.request.contextPath }/help/notice.do">
								<h2 class="title">티켓오픈</h2>
							</a>
						</div>

						<div class="maintop_cont">
							<ul style="list-style-type: square;" id="ticketO">

								<li class="first"><a class="rangkingImgLink"
									href="/product/28807"> <img class="rangkingImg"
										id="openingImg"
										src="http://www.kopis.or.kr/upload/pfmPoster/PF_PF155674_191007_095930.gif"
										width="180" height="218">
								</a></li>

								<c:forEach items="${list}" var="map" begin="0" end="4"
									varStatus="status">

									<li class='rankingItem on' data-productid="28807"
										id="ticket${status.count}" style="font-weight: bold;"
										data-url="http://www.kopis.or.kr/upload/pfmPoster/"+${map.playId }+".gif"><a
										href="/product/28807" style="color: #585858;">
											${map.noticeTitle }</a></li>

								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="inner">
				<div class="maintop_new real_ranking">
					<div class="maintop_left">
						<div class="header">
							<a href="${pageContext.request.contextPath }/ranking/ranking.do">
								<h2 class="title">일간 랭킹</h2>
							</a>
						</div>
						<div class="maintop_cont">
							<ul id="concertRankingListUl">
								<c:forEach items="${BoxlistT1}" var="map" begin="0" end="0">
									<li class="first"><a class="rangkingImgLink"
										href="${pageContext.request.contextPath }/musical/musicalDetail.do?musicalId=${map.mt20id}">
											<img class="rangkingImg" id="rangkingImg"
											src="http://www.kopis.or.kr/${map.poster }" width="180"
											height="218" alt="">
									</a></li>
								</c:forEach>
								<c:forEach items="${BoxlistT1}" var="map" begin="0" end="0">
									<li class='rankingItem on' data-productid="28807" id="rank1"
										data-url="http://www.kopis.or.kr/${map.poster }"><a
										href="${pageContext.request.contextPath }/musical/musicalDetail.do?musicalId=${map.mt20id}"
										style="color: #585858; width: 500px;"> ${map.prfnm }&nbsp;&nbsp;-&nbsp;&nbsp;${map.prfpd }</a></li>
								</c:forEach>
								<c:forEach items="${BoxlistT2}" var="map" begin="0" end="0">
									<li class='rankingItem on' data-productid="28807" id="rank2"
										data-url="http://www.kopis.or.kr/${map.poster }"><a
										href="/product/28807" style="color: #585858;"> ${map.prfnm }&nbsp;&nbsp;-&nbsp;&nbsp;${map.prfpd }</a></li>
								</c:forEach>
								<c:forEach items="${BoxlistT1}" var="map" begin="1" end="1">
									<li class='rankingItem on' data-productid="28807" id="rank3"
										data-url="http://www.kopis.or.kr/${map.poster }"><a
										href="${pageContext.request.contextPath }/musical/musicalDetail.do?musicalId=${map.mt20id}"
										style="color: #585858;"> ${map.prfnm }&nbsp;&nbsp;-&nbsp;&nbsp;${map.prfpd }</a></li>
								</c:forEach>
								<c:forEach items="${BoxlistT2}" var="map" begin="1" end="1">
									<li class='rankingItem on' data-productid="28807" id="rank4"
										data-url="http://www.kopis.or.kr/${map.poster }"><a
										href="/product/28807" style="color: #585858;"> ${map.prfnm }&nbsp;&nbsp;-&nbsp;&nbsp;${map.prfpd }</a></li>
								</c:forEach>
								<c:forEach items="${BoxlistT1}" var="map" begin="2" end="2">
									<li class='rankingItem on' data-productid="28807" id="rank5"
										data-url="http://www.kopis.or.kr/${map.poster }"><a
										href="${pageContext.request.contextPath }/musical/musicalDetail.do?musicalId=${map.mt20id}"
										style="color: #585858;"> ${map.prfnm }&nbsp;&nbsp;-&nbsp;&nbsp;${map.prfpd }</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<div class="maintop_right slide_wrap">

						<div class="slide_ctrl" style="display: none;">
							<!-- [D] 이전페이지 없을 경우 off 클래스, disabled="disabled" 추가 -->
							<button type="button" id="prev_btn" class="prev">이전</button>
							<!-- [D] 다음페이지 없을 경우 off 클래스 추가 -->
							<button type="button" id="next_btn" class="next off">다음</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="inner">
			<div class="section_best">
				<a href="${pageContext.request.contextPath }/musical/musical.do">
					<h2 class="title">베스트뮤지컬</h2>
				</a>
				<div class="suggest_wrap">
					<ul class="best_list">
						<c:forEach items="${BoxlistM}" var="map" begin="0" end="3">
							<li><a
								href="${pageContext.request.contextPath }/musical/musicalDetail.do?musicalId=${map.mt20id}">
									<p>
										<img src="http://www.kopis.or.kr/${map.poster }">
									</p>
									<div class="list_info">
										<strong class="elp">${map.prfnm }</strong>
										<dl>
											<dt>기간</dt>
											<dd>${map.prfpd }</dd>
											<dt>장소</dt>
											<dd>${map.area }</dd>
										</dl>
									</div>
							</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>

		<div class="inner">
			<div class="section_best">
				<a href="${pageContext.request.contextPath }/show/show.do">
					<h2 class="title">베스트 연극</h2>
				</a>
				<ul class="best_list">
					<c:forEach items="${BoxlistP}" var="map" begin="0" end="3">
						<li><a
							href="${pageContext.request.contextPath }/show/showDetail.do?showId=${map.mt20id}">
								<p>
									<img src="http://www.kopis.or.kr/${map.poster }">
								</p>
								<div class="list_info">
									<strong class="elp">${map.prfnm }</strong>
									<dl>
										<dt>기간</dt>
										<dd>${map.prfpd }</dd>
										<dt>장소</dt>
										<dd>${map.area }</dd>
									</dl>
								</div>
						</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</div>


<!-- <a href="javascript:window.scrollTo(0,0);" id="back_to_top">위로</a> -->


<%@ include file="/WEB-INF/views/common/footer.jsp"%>