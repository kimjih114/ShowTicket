<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/member.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle" />
</jsp:include>


<div id="container">
	<jsp:include page="/WEB-INF/views/common/memberViewnav.jsp">
		<jsp:param value="마이 페이지" name="pageTitle" />
	</jsp:include>

	<br>
	<div class="div-memberFrm">
		<form id="coupon">
			<h2 class="small-title">쿠폰</h2>
			<br />
			<hr>
			<p id="coupon-top">
				쿠폰 페이지에서 사용 가능한 쿠폰을 다운로드 받을 수 있습니다. <br /> 기간만료 등으로 사용 불가해진 쿠폰은 '사용
				완료된 쿠폰' 탭에서 확인해주세요. <br /> <br /> <input type=button
					id="buttonDownload" value="쿠폰 다운로드"> <br /> <br />
			</p>
			<div id="mainCoupon">

				<table id="couponTable">
					<tr>
						<th>쿠폰명</th>
						<th>할인금액</th>
						<th>사용조건</th>
						<th>사용기간</th>
						<th>쿠폰만료일</th>
					</tr>
					<c:forEach items="${myCouponList }" var="mycoupon">
						<tr>
							<td>${mycoupon.couponTitle }</td>
							<td>${mycoupon.couponPrice }원</td>
							<td>${empty mycoupon.showId ? "전 공연 대상" : "해당 공연 대상" }</td>
							<td>${mycoupon.couponTime }일</td>
							<td>
								<fmt:formatDate value="${mycoupon.couponEndDate }" />
								</td>
						</tr>
					</c:forEach>
				</table>

				<br /> <br />
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<li class="page-item disabled"><a class="page-link" href="#"
							tabindex="-1" aria-disabled="true"
							style="background-color: #F2F2F2; border: 0px;"><</a></li>
						<li class="page-item"><a class="page-link" href="#"
							style="color: gray; border: 0px;">1</a></li>
						<li class="page-item"><a class="page-link" href="#"
							style="color: gray; border: 0px;">2</a></li>
						<li class="page-item"><a class="page-link" href="#"
							style="color: gray; border: 0px;">3</a></li>
						<li class="page-item disabled"><a class="page-link" href="#"
							tabindex="1" aria-disabled="true"
							style="background-color: #F2F2F2; border: 0px;">></a></li>
					</ul>
				</nav>
			</div>
			<br /> <br />
			<div id="info">
				<h6>
					<img alt=""
						src="${pageContext.request.contextPath}/resources/images/info.png">
					쿠폰 사용 안내
				</h6>
				<br />
				<ul>
					<li>쿠폰은 사용 조건에 따라 사용이 제한될 수 있습니다. 쿠폰 사용 조건을 반드시 확인해주세요.</li>
					<li>예매 시, 다운로드 받은 쿠폰을 선태하면 결제 금액에서 할인이 적용됩니다.(쿠폰을 다운로드 받지
						않았거나, 쿠폰 사용 조건에 해당하지 않는 예매라면 쿠폰 선택이 불가할 수 있습니다.)</li>
					<li>예매 취소 시, 취소 수수료 부과는 쿠폰을 적용하지 않은 티켓금액 기준입니다.</li>
					<li>쿠폰을 사용해서 예매할 경우 티켓의 일부만 취소하는 부분취소는 불가합니다. 티켓 부분취소를 원하실 경우
						전체취소 후 다시 예매해주셔야 합니다. 단, 이 경우 기존의 좌석을 유지할 수 없을 수도 있습니다.</li>
					<li>쿠폰을 사용한 예매를 전체취소 하실 경우 쿠폰이 복구되어 재사용 가능합니다. 단, 특정쿠폰 및
						쿠폰유효기간이 지난 쿠폰일 경우는 복구되지 않을 수 있습니다.</li>
				</ul>
			</div>
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
