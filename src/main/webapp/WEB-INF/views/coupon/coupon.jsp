<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" >
	<jsp:param value="" name="pageTitle" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/coupon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/contents.css">

<form id="edit" method="post" action="${pageContext.request.contextPath}/coupon/couponUpdate.do"></form>
<script>
$(()=>{
	$(".couponDown").mouseover(function(){
		$(this).css("cursor", "pointer");
	});
	
	$(".couponDown").click(function(){
		if(${memberLoggedIn != null}){
			location.href="${pageContext.request.contextPath}/coupon/couponDownload.do?couponNo="+$(this).attr("id");			
		}
		else{
			alert("로그인 후 이용해 주세요");
		}
	});
});

function goEdit(id,title,price,time,count,no) {
	var showId = id;
	var couponTitle = title;
	var couponPrice = price;
	var couponTime = time;
	var couponCount = count;
	var couponNo = no;
	
	$("#edit").append("<input type='hidden' name='showId' value='"+showId+"'/>")
			  .append("<input type='hidden' name='couponTitle' value='"+couponTitle+"'/>")
			  .append("<input type='hidden' name='couponPrice' value='"+couponPrice+"'/>")
			  .append("<input type='hidden' name='couponTime' value='"+couponTime+"'/>")
			  .append("<input type='hidden' name='couponCount' value='"+couponCount+"'/>")
			  .append("<input type='hidden' name='couponNo' value='"+couponNo+"'/>").submit();
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
			
            <h2 class="title">쿠폰</h2><!-- [D]  1 depth의 값을 h2로 뿌려줍니다 -->
            <c:if test="${memberLoggedIn.memberId == 'admin' }">
            	<button class="btn btn-primary btn-sm btn-color" id="couponAdd" onclick="location.href='${pageContext.request.contextPath}/coupon/couponAdd.do'">추가</button>
            </c:if>
            <div class="coupon_main" style="clear:both;">
               <div class="coupon_lst_wrap">
<!--                     <table class="coupon_lst"> -->
                    <!-- n%3으로 조건을 줘서 채우면 될 것이다. -->
                    <table id="couponlist" style="margin:0 auto;">
	
                       	<tr>
                       		<c:forEach items="${couponList}" var="coupon" varStatus="vs">
                       			<c:if test="${vs.count%3 == 1}">
                       				<tr>
                       			</c:if>
                       			<td>
		             				<div class="couponWrap">
		             				<c:if test="${memberLoggedIn.memberId == 'admin' }">
		             					<div class="coupon cCursor" onclick="goEdit('${coupon.showId == null?'null':coupon.showId}','${coupon.couponTitle }','${coupon.couponPrice }','${coupon.couponTime }','${coupon.couponCount }','${coupon.couponNo }');">
										     <h2 class="couponTitle">${coupon.couponTitle }</h2>
										     <div class="couponMore">
										      <p class="couponExpire">기간 ${coupon.couponTime }일</p>
										      <p class="couponDetail">
										      		${coupon.showId==null? '전 공연 대상' : '해당 공연 대상'}</p>
		 								     </div>
		 								     <div class="couponDown" id="${coupon.couponNo }">
										      		<p>쿠폰다운</p>     			
		                       				 </div>      			
		                       			</div>
		             				</c:if>
		             				<c:if test="${memberLoggedIn.memberId != 'admin'}">
		                       			<div class="coupon">
										     <h2 class="couponTitle">${coupon.couponTitle }</h2>
										     <div class="couponMore">
										      <p class="couponExpire">기간 ${coupon.couponTime }일</p>
										      <p class="couponDetail">
										      		${coupon.showId==null? '전 공연 대상' : '해당 공연 대상'}</p>
		 								     </div>
		 								     <div class="couponDown" id="${coupon.couponNo }">
										      		<p>쿠폰다운</p>
		                       				 </div>
		                       			</div>
		                       		</c:if>
		                       		</div>
                       			</td>
                       			<c:if test="${vs.count%3 == 0}">
                       				<tr>
                       			</c:if>
                       		</c:forEach>
                       </tr>
                    </table>
                </div>

  <div class="notice_wrap" >
                    <strong class="tit" style="font-size:1.2em;">&nbsp;! 쿠폰 발급 주의 사항</strong>
                    <ul>
                        <li>1. 쿠폰은 사용 조건에 따라 사용이 제한될 수 있습니다. 쿠폰 사용 조건을 반드시 확인해주세요.</li>
                        <li>2. 예매 시, 쿠폰다운 받은 쿠폰을 선택하면 결제 금액에서 할인이 적용됩니다.(쿠폰을 쿠폰다운 받지 않았거나, 쿠폰 사용 조건에 해당하지 않는 예매라면 쿠폰 선택이 불가할 수 있습니다.)</li>
                        <li>3. 쿠폰 발급 조건에 따라 ID당 쿠폰다운 받을 수 있는 횟수가 정해져 있습니다. 발급받은 쿠폰을 사용할 수 있는 최대 매수도 쿠폰에 따라 상이하니 발급 전 사용조건을 확인해주세요.</li>
                        <li>4. 예매 취소 시, 취소수수료 부과는 쿠폰을 적용하지 않은 티켓금액 기준입니다.</li>
                        <li>5. 쿠폰을 사용해서 예매할 경우 티켓의 일부만 취소하는 부분취소는 불가합니다. 티켓 부분취소를 원하실 경우 전체취소 후 다시 예매해주셔야 합니다.<br>단, 이 경우 기존의 좌석을 유지할 수 없을 수도 있습니다.</li>
                        <li>6. 쿠폰을 사용한 예매를 전체취소 하실 경우 쿠폰이 복구되어 재사용 가능합니다. 단, 특정쿠폰 및 쿠폰유효기간이 지난 쿠폰일 경우는 복구되지 않을 수 있습니다.</li>
                    </ul>
<!--                 </div> -->
                <!-- [D] 쿠폰 레이어 -->
                <div class="ly_pop_wrap" style="display:none">
                    <div class="dim"></div>
                    <!-- [D] 할인금액 : 추가 없음
                               예매수수료 무료 : coupon_type2 추가
                                할인율 : coupon_type3 추가 -->
                </div>
                <!-- // 쿠폰 레이어 -->
            </div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" ></jsp:include>