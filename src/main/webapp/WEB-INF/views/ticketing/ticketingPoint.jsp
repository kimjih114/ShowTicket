
<%@page import="com.kh.showticket.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
%>
<fmt:requestEncoding value="utf-8" />

<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/contents.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/ticketing.css" />
<link
	href="https://fonts.googleapis.com/css?family=Gothic+A1&display=swap"
	rel="stylesheet">
<%
	int i = 0;	

%>
<script>
function allPoint1(){
	$("#point1").val("${myPoint}");
	var pointCount = parseInt($("#point1").val("${myPoint}"));
}
function allPoint2(){
	$("#point2").val("${myPoint}");
	pointCount += parseInt($("#point2").val("${myPoint}"));
}
function allPoint3(){
	$("#point3").val("${myPoint}");
}
function next(){
	totalprice();
	$("#next").submit();
}
function pre(){
	$("#pre").submit();
}
function totalprice(){
	var couponPrice = parseInt($("#couponP").html());
	var couponCount = parseInt($("#coupon").val());
	var totalCouponPrice = couponPrice*couponCount;
	var myTotalPoint = $(".t_dinput").val();
	$('input[name=totalCouponPrice]').attr('value',totalCouponPrice);
	$('input[name=totalPointPrice]').attr('value',myTotalPoint);

}
</script>
<script type="text/javascript">
$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
</script>
<script type="text/javascript">
$(()=>{
	
	var count = ${fn:length(cList) } 
	
	var maxPoint = $("#point1").val();
	maxPoint *= 1;
$('#point1').on('keyup', function() {
  
  if (this.value > maxPoint) {
      this.value = maxPoint;
      
  }
	});
	
	$(".t_button2").on("click", function(){
		console.log("EHLSL?");
		var couponPrice = parseInt($("#couponP").html());
		var couponCount = parseInt($("#coupon").val());
		var totalCouponPrice = couponPrice*couponCount;
		var myTotalPoint = $(".t_dinput").val();
		$('input[name=totalCouponPrice]').attr('value',totalCouponPrice);
		$('input[name=totalPointPrice]').attr('value',myTotalPoint);

			console.log("couponPrice="+couponPrice);
			console.log("couponCount="+couponCount);
			console.log("playId="+$("input[name=playId]").val());
			console.log("selectDate="+$("input[name=selectDate]").val());
			console.log("selectTime="+$("input[name=selectTime]").val());
			console.log("totalCouponPrice="+$("input[name=totalCouponPrice]").val());
			console.log("totalPointPrice="+$("input[name=totalPointPrice]").val());
			console.log("Rnum="+$("input[name=Rnum]").val());
			console.log("Snum="+$("input[name=Snum]").val());
			console.log("s1="+$("input[name=s1]").val());
			console.log("s2="+$("input[name=s2]").val());
		
		$("#next").submit();
	});
});
</script>

<div class="t_background">
	<img
		src="${pageContext.request.contextPath }/resources/images/showticket_logo.png"
		alt="show티켓 로고" class="t_logo" />
	<div class="nav nav-pills nav-justified tnav_margin">
		<li class="nav-item"><a class="nav-link default nav-font"
			href="#">날짜/회차선택</a></li>
		<li class="nav-item"><a class="nav-link default nav-font"
			href="#">좌석선택</a></li>
		<li class="nav-item"><a class="nav-link select nav-font" href="#">할인/매수선택</a></li>
		<li class="nav-item"><a class="nav-link default nav-font"
			href="#">예매확인</a></li>
		<li class="nav-item"><a class="nav-link default nav-font"
			href="#">결제</a></li>
	</div>

	<div class="t_ddiv1">
		<p class="t_title">쿠폰할인</p>
		
		<table class="t_dtable">
			<tr>
				<td colspan="4">
					<p class="t_dsize">
						<span class="t_purple">R석 ${Rnum}개</span>를 선택하셨습니다.
					</p>
				</td>
			</tr>
			<tr>
				<td>일반(정가)</td>
				<td class="t_dtable_name">일반</td>
				<td class="t_dtable_price"><span class="t_purple">${mas.price }</span>
				</td>
				<td><select class="selectcss" name="general">
						<option value="">1매</option>
				</select></td>
			</tr>
				<c:forEach items="${cList }" var="c">
			<tr>
				
				<td rowspan="1">쿠폰</td>
					<td>${c.couponTitle}</td>
					<td class="t_dtable_price"><span class="t_purple" id="couponP">${c.couponPrice}</span><span>원</span>
					</td>
					<td style="display:none" id="count">${c.count }</td>
					<td><select class="selectcss" name="coupon" id="coupon">
							<option value="0">0매</option>
							<option value="1">1매</option>
					</select></td>
			</tr>
				</c:forEach>
			
		</table>
		<table class="t_ptable">
			<tr>
				<td>포인트</td>
				<td>사용포인트</td>
				<td><input type="text" numberonly="true" class="t_dinput"
					id="point<%=++i %>" max="${myPoint }" value="${myPoint}" /> <span>point</span>
				</td>
				<td><input type="button" value="전액사용" class="inputcss"
					onclick="allPoint<%=i %>();" /></td>
			</tr>
		</table>

		
	</div>

	<div class="t_ddiv2">
		<img src="${mas.poster}" alt="공연 이미지" class="t_dimg" />
		<p class="t_dname">
			<span>${mas.genre}</span> <span>&lt;${mas.name}&gt;</span>
		</p>
		<table class="t_dtable2">
			<tr>
				<td>관람일시</td>
				<td>${selectDate} ${selectTime}시</td>
			</tr>
			<tr>
				<td>좌석정보</td>
				<td class="">${s1 }</td>
			</tr>
		</table>
	</div>
	<form name="nextFrm"
		action="${pageContext.request.contextPath}/ticketing/ticketConfirm.do"
		id="next">
		<input type="hidden" name="playId" value="${mas.id}" /> <input
			type="hidden" name="selectDate" value="${selectDate}" /> <input
			type="hidden" name="selectTime" value="${selectTime}" />  <input
			type="hidden" name="totalCouponPrice" value="" />
			<input
			type="hidden" name="totalPointPrice" value="" /><input
			type="hidden" name="Rnum" value="${Rnum}" /><input
			type="hidden" name="Snum" value="${Snum}" /><input
			type="hidden" name="s1" value="${s1}" /><input
			type="hidden" name="s2" value="${s2}" />
			
	</form>
	
	<form name="preFrm"
		action="${pageContext.request.contextPath}/ticketing/ticketingSeat.do"
		id="pre" method="post">
		<input type="hidden" name="playId" value="${mas.id}" /> <input
			type="hidden" name="selectDate" value="${selectDate}" /> <input
			type="hidden" name="selectTime" value="${selectTime}" /> 
	</form>
	<div class="t_dbtndiv">
		<input type="button" value="이전단계" class="t_button1" onclick="pre();" />
		<input type="button" value="다음단계" class="t_button2"/>
	</div>
</div>