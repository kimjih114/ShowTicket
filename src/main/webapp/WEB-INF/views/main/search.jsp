<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/contents.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/searchResult.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">
	
<script>
$(()=>{
	$("#musical-nav").on("click", function(){
		$("#sResultCont").css("display", "none");
		$("#mResultCont").css("display", "block");
	});
	
	$("#show-nav").on("click", function(){
		$("#mResultCont").css("display", "none");
		$("#sResultCont").css("display", "block");
	});

	$("ul > li > div").click((e)=>{
		$(".nav-pills .nav-link.select").attr('class', 'nav-link nav-font default');
		$(e.target).attr('class','nav-link select nav-font')
	});


});


</script>

<div id="wrap" class="subwrap">   
    <div id="container" class="submain_front">
<div class="inner">
	<div class="amount">
	<h2 class="small-title">
	<span class="color_purple bold">검색어</span>에 대한 검색결과는 총 ${mTotalContents+sTotalContents+eTotalContents }건입니다.
    </h2>
    </div>
     <span class="resultTitle">티켓 검색 결과(${mTotalContents+sTotalContents })</span>
 
    <ul id="searchNav" class="nav nav-pills nav-justified">
		<li class="nav-item"><div class="nav-link select nav-font" id="musical-nav">뮤지컬(${mTotalContents })</div></li>
		<li class="nav-item"><div class="nav-link nav-font default" id="show-nav">연극(${sTotalContents })</div></li>
	</ul>
   
   <div id="mResultCont" class="cont-result">
	 <table class="tbl-result">
	 <c:forEach items="${mTicketResultEnd }" var="m">
   		<tr>
   			<td class="td-result">
   				<div class="resultInfo">
   					<div class="cont-poster">
   						<img src="${m.poster }" alt="" />
   					</div>
   					<div class="ticketInfo">
   						<span class="ticketTitle">${m.prfnm}</span>
   						<span class="ticketLoc">${m.fcltynm }</span>
   						<span class="ticketDate">기간: ${m.prfpdfrom } ~ ${m.prfpdto}</span>
   						<span class="ticketPrice">관람가: ${m.pcseguidance }</span>
   						
   					</div>
   					<div>
   					<button type="button" class="btn btn-color reserve" onclick="location.href='${pageContext.request.contextPath}/musical/musicalDetail.do?musicalId=${m.mt20id}'">예매하기</button>
   					</div>
   				</div>
   			</td>
   		</tr>
   		</c:forEach>
	</table>
	<div>
		<div class='pageBar'>
			${mPageBar }
		</div>
	</div>
   </div>
   
   <div id="sResultCont" class="cont-result">
	 <table class="tbl-result">
	 <c:forEach items="${sTicketResultEnd }" var="s">
   		<tr>
   			<td class="td-result">
   				<div class="resultInfo">
   					<div class="cont-poster">
   						<img src="${s.poster }" alt="" />
   					</div>
   					<div class="ticketInfo">
   						<span class="ticketTitle">${s.prfnm}</span>
   						<span class="ticketLoc">${s.fcltynm }</span>
   						<span class="ticketDate">기간: ${s.prfpdfrom } ~ ${s.prfpdto}</span>
   						<span class="ticketPrice">관람가: ${s.pcseguidance }</span>
   						
   					</div>
   					<div>
   					<button type="button" class="btn btn-color reserve" onclick="location.href='${pageContext.request.contextPath}/show/showDetail.do?showId=${s.mt20id}'">예매하기</button>
   					</div>
   				</div>
   			</td>
   		</tr>
   		</c:forEach>
	</table>
	<div>
		<div class='pageBar'>
			${sPageBar }
		</div>
	</div>
   </div>
   
   
   
     <div class="cont-result">
   <span class="resultTitle">이벤트 검색 결과(${eTotalContents})</span>
	 <table class="tbl-result">
	 <c:forEach items="${eventResult }" var="e">
   		<tr>
   			<td class="td-result">
   				<div class="resultInfo">
   					<div class="cont-poster">
   						<!-- 차후 수정 바람 -->
   						<img src="${e.eventImg }" alt="" />
   					</div>
   					<div class="eventInfo">
   						<span class="eventTitle">${e.eventTitle}</span>
   						<span class="eventContent">${e.eventContent }</span>
   						<span class="eventDate">기간: 
   						<fmt:formatDate value="${e.eventStartDate }" pattern="yyyy.MM.dd" />
   						 ~ 
   						<fmt:formatDate value="${e.eventEndDate }" pattern="yyyy.MM.dd" />
   						</span>
   					</div>
   					<div>
   					<button type="button" class="btn btn-color reserve" onclick="location.href='${pageContext.request.contextPath}/event/eventView.do?eventNo=${e.eventNo}'">상세보기</button>
   					</div>
   				</div>
   			</td>
   		</tr>
   		</c:forEach>
	</table>
   </div>


</div></div></div>
   
<%@ include file="/WEB-INF/views/common/footer.jsp"%>