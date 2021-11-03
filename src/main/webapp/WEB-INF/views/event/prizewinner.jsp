<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">

	
<div id="container" class="event_cont">
        <div class="inner">
            <h2 class="blind">이벤트</h2>
            
            <ul class="nav nav-pills nav-justified">
				<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/event/eventList.do">진행중인 이벤트</a></li>
				<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/event/endEventList.do">종료된 이벤트</a></li>
				<li class="nav-item"><a class="nav-link nav-font select" href="${pageContext.request.contextPath}/event/prizewinner.do">당첨자 발표</a></li>
				<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/coupon/coupon.do">쿠폰</a></li>
			</ul>
		
            <!-- [D]  1 depth의 값을 h2로 뿌려줍니다 -->
            <h2 class="title">당첨자 발표</h2>
            
            <div class="event_cont_box">
                <div class="basic_tbl mgt10">
                    <table>
                        <caption>당첨자 리스트</caption>
                       
                        <thead>
                        <tr>
                            <th scope="col" style="width: 80px">번호</th>
                            <th scope="col" style="width: 120px">카테고리</th>
                            <th scope="col">이벤트명</th>
                            <th scope="col" style="width: 200px">기간</th>
                            <c:if test="${memberLoggedIn.memberId =='admin' }">
                            <th scope="col" style="width: 100px">작성</th>
                            </c:if>
                        </tr>
                        </thead>
					<tbody id="winnerList">
						<c:forEach items="${eventList }" var="evt">
							<tr eventNo="${evt.eventNo}">
								<td>${evt.eventNo }</td>
								<td>
									 <c:if test="${evt.EVENT_KIND eq 'I'}">[초대]</c:if>
									 <c:if test="${evt.EVENT_KIND eq 'E'}">[응모]</c:if>
								</td>
								<td ><a href="${pageContext.request.contextPath}/event/prizewinnerView.do?eventNo=${evt.eventNo }">${evt.eventTitle }</a>
								</td>
								<td> 
								 <fmt:formatDate pattern="yyyy-MM-dd" value="${evt.eventStartDate }"/>~
								 <fmt:formatDate pattern="yyyy-MM-dd" value="${evt.eventEndDate }"/>
							    </td>
								<c:if test="${memberLoggedIn.memberId =='admin' }">
								<td style="text-align: center;"> 
								 	<button class="btn btn-primary btn-sm btn-color" style="margin:10px; width:50px; height:30px;"
            						onclick = "location.href = '${pageContext.request.contextPath}/event/prizewinnerWrite.do?eventNo=${evt.eventNo }' ">작성</button>
							    </td>
							    </c:if>
							</tr>
						</c:forEach>	
					</tbody>
				</table>
                </div>
               
            </div>
        </div>
    </div>
    


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>