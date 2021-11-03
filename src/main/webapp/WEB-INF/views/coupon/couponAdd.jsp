<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/coupon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/contents.css">

<script>

$(()=>{
	$("#couponTitle").keyup(function() {
		$(".couponTitle").html($("#couponTitle").val());
	});
	$("#couponTime").keyup(function() {
		$(".couponTime").html($("#couponTime").val());
	});
	$("#couponDetail").keyup(function() {
		$(".couponDetail").html($("#couponDetail").val());
	});

});

function goAdd(id,sId) {
	   var showId = id;
	   var btnId = sId;
	   console.log(showId);
	   
	   $(".couponDetail").text("해당 공연 대상");
	   $("#showId").remove();
	   $(".add").append("<input type='hidden' name='showId' value='"+showId+"'/>");
	   $("#"+btnId).removeClass("cDefault").addClass("cSelected");
}

function submit() {
	$(".add").submit();
}


</script>

<div id="container" class="event_cont">
	<div class="inner">
        	<ul class="nav nav-pills nav-justified">
				<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/event/eventList.do">진행중인 이벤트</a></li>
				<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/event/endEventList.do">종료된 이벤트</a></li>
				<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/event/prizewinner.do">당첨자 발표</a></li>
				<li class="nav-item"><a class="nav-link nav-font select" href="${pageContext.request.contextPath}/coupon/coupon.do">쿠폰</a></li>
			</ul>
			<h2 class="title">공연목록(연극)</h2>
				<div class="performanceList">
					<table class="scrollList">
						<thead>
							<tr>
								<th>공연ID</th>
								<th>종류</th>
								<th>공연명</th>
								<th>공연시작일</th>
								<th>공연종료일</th>
								<th>공연상태</th>
								<th>선택</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${showList}" var="sList" varStatus="vs">
								<tr>
									<td>${sList.mt20id }</td>
									<td>${sList.genrenm }</td>
									<td>${sList.prfnm }</td>
									<td>${sList.prfpdfrom }</td>
									<td>${sList.prfpdto }</td>
									<td>${sList.prfstate }</td>
									<td>
										<c:set var="sId" value="sList${vs.count }"/>
 										<button type="button" id="${sId }" class="pselectBtn cDefault" onclick="goAdd('${sList.mt20id}','${sId }')">선택</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			<h2 class="title">공연목록(뮤지컬)</h2>
				<div class="performanceList">
					<table class="scrollList">
						<thead>
							<tr>
								<th>공연ID</th>
								<th>종류</th>
								<th>공연명</th>
								<th>공연시작일</th>
								<th>공연종료일</th>
								<th>공연상태</th>
								<th>선택</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${musicalList}" var="mList" varStatus="ms">
								<tr>
									<td>${mList.mt20id }</td>
									<td>${mList.genrenm }</td>
									<td>${mList.prfnm }</td>
									<td>${mList.prfpdfrom }</td>
									<td>${mList.prfpdto }</td>
									<td>${mList.prfstate }</td>
									<td>
										<c:set var="mId" value="mList${ms.count }"/>
										<button type="button" id="${mId }" class="pselectBtn cDefault" onclick="goAdd('${mList.mt20id}','${mId }')">선택</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
			<h2 class="title">쿠폰</h2>
			<div class="cAddDiv">
				<form class="add" method="post" action="${pageContext.request.contextPath}/coupon/insertCouponAdd.do">
					<p class="cAddP">쿠폰 이름 : &nbsp;&nbsp; <input type="text" id="couponTitle" name="couponTitle" class="cAddInput" placeholder="ex)생일 축하 5000원 쿠폰"/></p>
					<p class="cAddP">할인 가격 : &nbsp;&nbsp; <input type="text" id="couponPrice" name="couponPrice" class="cAddInput" placeholder="ex)2000"/></p>
					<p class="cAddP">쿠폰 기간 : &nbsp;&nbsp; <input type="text" id="couponTime" name="couponTime" class="cAddInput" placeholder="ex)7"/></p>
					<p class="cAddP">쿠폰 개수 : &nbsp;&nbsp; <input type="text" id="couponCount" name="couponCount" class="cAddInput" placeholder="ex)50"/></p>
					<p id="showId"><input type="hidden" name="showId" value="null"/></p>
				</form>
					<p class="cAddP">제한 조건 : &nbsp;&nbsp; <input type="text" id="couponDetail" class="cAddInput" /></p>
					<p class="cNotice"> ※ 특정 공연을 선택했을 경우, 제한 조건은 작성하지 않아도 됩니다.</p>
			</div>
			
			<div class="cFont cView">&lt;쿠폰 미리보기&gt;</div>
			<table id="couponlist" style="margin:0 auto;">
				<tr>
					<td>
						<div class="couponWrap">
							<div class="coupon cPlusSize">
								<h2 class="couponTitle cFont"></h2>
								<div class="couponMore cFont">
									<span class="couponExpire">기간 </span><span class="couponTime"></span><span>일</span>
										<p class="couponDetail cFont"></p>
		 						</div>
		 						<div class="couponDown cFont dPlusSize">
										<p>show</p>     			
		                       	</div>      			
		                     </div>
		                </div>
		            </td>
               </tr>
             </table>
             <button type="button" class="cAddEnd" onclick="submit();">쿠폰 등록</button>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>