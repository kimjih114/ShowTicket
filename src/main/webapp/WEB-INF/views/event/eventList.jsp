<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle" />
</jsp:include>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">
<style>

div#saleC{width: 50px; height: 50px; border-radius: 55px; background: #8f01a3; color: white; position: absolute; top: 20px; right: 10px;z-index: 1; border: 2px solid white;}


.percent{
    font-size: 16px;
    font-weight: bold;
    font-family: "Segoe UI",Arial,sans-serif;
    left: 15%;
    top: 20%;
    position: absolute;
}
</style>
<div id="container" class="event_cont">
	<div class="inner">
		<h2 class="blind">이벤트</h2>
		<!-- [D]  1 depth의 값을 h2로 뿌려줍니다 -->
		<!-- 3월 스펙 아웃으로 인한 큰 이벤트 이미지 부분 삭제 -->

		<ul class="nav nav-pills nav-justified">
			<li class="nav-item"><a class="nav-link select nav-font" href="#">진행중인 이벤트</a>
			</li>
			<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/event/endEventList.do">종료된 이벤트</a></li>
			<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/event/prizewinner.do">당첨자 발표</a></li>
			<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/coupon/coupon.do">쿠폰</a>
			</li>
		</ul>
		<h2 class="title">특가 진행</h2>
		<c:if test="${memberLoggedIn.memberId =='admin' }">
			<button type="button" class="btn btn-color" id="saleWritebtn" style="background-color: #8f01a3; border-color: none; font-family: 'Gothic A1', sans-serif;"
				 onclick="location.href='${pageContext.request.contextPath}/event/addSaleEvent.do'">글쓰기</button>
		</c:if>
		<c:if test="${empty dcList }"> <br /> <h2>진행중인 이벤트가 없습니다.</h2><br /></c:if>
		<c:if test="${!empty dcList }"> 
		
			<ul class="event_top_list" style="position: relative;">
				<c:forEach items="${dcList }" var="dcList">
					
				<li showId="${dcList.showId }" style="position: relative;">
					<a href="${pageContext.request.contextPath }/event/addSaleView.do?showId=${dcList.showId }"> 
						
						<img
						src="${dcList.disCountImg}"
						alt="poster" width="285" height="386">
						<div class="event_top_info">
							<input type="hidden" name="evtID" value="${dcList.showId }" />
							<dl>
								<dt>제목</dt>
								<dd class="event_title">
									<span>[특가]  ${dcList.showGenre} </span> <br />
									
									&lt; ${dcList.showName} &gt;
								</dd>
								<dt>이벤트 내용</dt>
								<dd style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
									 특가 할인 이벤트  
								</dd>
								<dt>기간</dt>
								<dd class="event_date"> <fmt:formatDate pattern="yyyy-MM-dd" value="${dcList.disCountStartDate}"/> ~ <fmt:formatDate pattern="yyyy-MM-dd" value="${dcList.disCountEndDate}"/></dd>
								
							</dl>
						</div>
					</a>
					<div id="saleC"> <span class="percent">${dcList.disCountRate }%</span></div>

				</li>
				</c:forEach>
	
			</ul>
		</c:if>
		<h2 class="small-title">전체 이벤트</h2>
		<c:if test="${memberLoggedIn.memberId =='admin' }">
		<!-- 이벤트 글쓰기 페이지  -->
		<button class="btn btn-color" type="button" style="background-color: #8f01a3; font-family: 'Gothic A1', sans-serif; color:white;margin-left: 920px;"
				onclick="location.href='${pageContext.request.contextPath}/event/eventWrite.do'">글쓰기</button>
		</c:if>
		<div class="event_cont_box">
			<div class="event_list_inner">
				<ul id="eventList">
					<c:forEach items="${eventList }" var="evt">
						<li >
							<a href="${pageContext.request.contextPath }/event/eventView.do?eventNo=${evt.eventNo}"> <!-- 전체 이벤트 페이지 ??  -->
								<dl>
									<dt>대표이미지</dt>
									<dd class="thumb">
										<img
											src="${evt.eventImg}" alt="poster"
											width="110" height="134">
									</dd>
									<dt>제목</dt>
									<dd class="event_title">
										<span>
											<c:if test="${evt.EVENT_KIND eq 'I' }">[초대]</c:if>
											<c:if test="${evt.EVENT_KIND eq 'E' }">[응모]</c:if>
										</span> &lt;${evt.eventTitle}&gt; 이벤트
									</dd>
									<dt>이벤트내용</dt>
									<dd>&lt;${evt.eventTitle}&gt; 이벤트</dd>
									<dt>기간</dt>
									<dd class="event_date"><fmt:formatDate pattern="yyyy-MM-dd" value="${evt.eventStartDate}"/> ~ <fmt:formatDate pattern="yyyy-MM-dd" value="${evt.eventEndDate}"/>까지</dd>
									
								</dl>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div id="pagination" class="paging"></div>


		</div>
	</div>
</div>




<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>