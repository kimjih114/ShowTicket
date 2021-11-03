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

<form class="delete" method="post" action="${pageContext.request.contextPath}/coupon/deleteCoupon.do"></form>
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

function goUpdate(dbShowId) {
	if(dbShowId == "null"){
		$(".edit").append("<input type='hidden' name='showId' value='null'/>").submit();
	}
	else{
		$(".edit").append("<input type='hidden' name='showId' value='"+dbShowId+"'/>").submit();
	}
}

function goDelete(couponNo) {
	if(confirm("쿠폰을 삭제하시겠습니까?")){
		$(".delete").append("<input type='hidden' name='couponNo' value='"+couponNo+"'/>").submit();		
	}
	else{
		return;
	}
}

</script>

<div id="container" class="event_cont">
	<div class="inner">
			<h2 class="title">쿠폰 공연정보</h2>
				<div class="editperformanceList">
					<table class="scrollList">
						<thead>
							<tr>
								<th>공연ID</th>
								<th class="n2">종류</th>
								<th class="n3">공연명</th>
								<th class="n4">공연시작일</th>
								<th class="n5">공연종료일</th>
								<th>공연상태</th>
							</tr>
						</thead>
						<tbody class="editTbody">
						<c:if test="${editCoupon == null }">
							<tr>
								<td colspan="6">전 공연 대상 쿠폰입니다.</td>
							</tr>
						</c:if>
						<c:if test="${editCoupon != null }">
							<c:forEach items="${editCoupon}" var="ec">
								<tr>
									<td>${ec.mt20id }</td>
									<td>${ec.genrenm }</td>
									<td>${ec.prfnm }</td>
									<td>${ec.prfpdfrom }</td>
									<td>${ec.prfpdto }</td>
									<td>${ec.prfstate }</td>
								</tr>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
				</div>
				
			<h2 class="title">쿠폰</h2>
			<div class="cAddDiv">
				<form class="edit" method="post" action="${pageContext.request.contextPath}/coupon/editCouponUpdate.do">
				<c:set var="couponNo" value="${couponNo }"/>
					<p class="cAddP">쿠폰 이름 : &nbsp;&nbsp; <input type="text" id="couponTitle" name="couponTitle" class="cAddInput" value="${couponTitle }"/></p>
					<p class="cAddP">할인 가격 : &nbsp;&nbsp; <input type="text" id="couponPrice" name="couponPrice" class="cAddInput" value="${couponPrice }"/></p>
					<p class="cAddP">쿠폰 기간 : &nbsp;&nbsp; <input type="text" id="couponTime" name="couponTime" class="cAddInput" value="${couponTime }"/></p>
					<p class="cAddP">쿠폰 개수 : &nbsp;&nbsp; <input type="text" id="couponCount" name="couponCount" class="cAddInput" value="${couponCount }"/></p>
					<input type="hidden" name="couponNo" value="${couponNo }"/>
				</form>
					<p class="cAddP">제한 조건 : &nbsp;&nbsp; <input type="text" id="couponDetail" class="cAddInput" value="${dbShowId eq 'null'?'전 공연 대상':'해당 공연 대상' }"/></p>
			</div>
			
			<div class="cFont cView">&lt;쿠폰 미리보기&gt;</div>
			<table id="couponlist" style="margin:0 auto;">
				<tr>
					<td>
						<div class="couponWrap">
							<div class="coupon cPlusSize">
								<h2 class="couponTitle cFont">${couponTitle }</h2>
								<div class="couponMore cFont">
									<span class="couponExpire">기간 </span><span class="couponTime">${couponTime }</span><span>일</span>
										<p class="couponDetail cFont">${dbShowId eq 'null'?'전 공연 대상':'해당 공연 대상' }</p>
		 						</div>
		 						<div class="couponDown cFont dPlusSize">
										<p>show</p>     			
		                       	</div>      			
		                     </div>
		                </div>
		            </td>
               </tr>
             </table>
             <button type="button" class="cAddEnd cUpdate" onclick="goUpdate('${dbShowId}');">수정</button>
             <button type="button" class="cAddEnd cDelete" onclick="goDelete('${couponNo}');">삭제</button>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>