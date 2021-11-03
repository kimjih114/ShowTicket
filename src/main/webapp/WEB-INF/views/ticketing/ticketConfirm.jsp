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

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
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
<script>
function next(){
	$("#next").submit();
}
function pre(){
	$("#pre").submit();
}
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
		<li class="nav-item"><a class="nav-link default nav-font"
			href="#">할인/매수선택</a></li>
		<li class="nav-item"><a class="nav-link select nav-font" href="#">예매확인</a></li>
		<li class="nav-item"><a class="nav-link default nav-font"
			href="#">결제</a></li>
	</div>

	<div class="t_cdiv1">
		<p class="t_cgenre">${mas.genre}</p>
		<p class="t_cname">&lt;${mas.name}&gt;</p>
		<img src="${mas.poster}" alt="공연 이미지" class="t_cimg" />
	</div>
	<div class="t_cdiv2">
		<table class="t_ctable">
			<tr>
				<td>R석</td>
				<td class="t_purple">1층 23열 43번</td>
			</tr>
			<tr>
				<td>관람일시</td>
				<td>${selectDate} ${selectTime}시</td>
			</tr>
			<tr>
				<td>티켓금액</td>
				<td>${ticket.ticketPrice }</td>
			</tr>
			<tr>
				<td>예매수수료</td>
				<td>1,000</td>
			</tr>
			<tr>
				<td>쿠폰할인</td>
				<td>${totalCouponPrice}</td>
			</tr>
			<tr>
				<td class="t_hr">사용 포인트</td>
				<td class="t_hr">${totalPointPrice }</td>
			</tr>
			<tr>
				<td class="t_hr">총 결제</td>
				<td class="t_hr t_total">${resultPrice }</td>
			</tr>
		</table>

		<span class="t_cspan">
			<p class="t_cancel1">취소 기한 :</p>
			<p class="t_cancel2">${ticket.ticketCancel}&nbsp;18:00까지</p>
		</span> <span class="t_cspan">
			<p class="t_cancel1">취소 수수료 :</p>
			<p class="t_cancel2">티켓 금액의 0~30%</p>
		</span> <input type="checkbox" class="t_checkbox" />
		<p class="t_checkboxtext">취소 기한 및 취소 수수료 동의</p>
		<form name="nextFrm"
		action="${pageContext.request.contextPath}/ticketing/pay.do"
		id="next" method="post">
		<input
			type="hidden" name="resultPrice" value="${resultPrice }" />
			
			
	</form>
		<form name="preFrm" action="${pageContext.request.contextPath}/ticketing/ticketingPoint.do" id="pre" method="post">
			<input type="hidden" name="playId" value="${mas.id}" /> 
			<input type="hidden" name="selectDate" value="${selectDate}" /> 
			<input type="hidden" name="selectTime" value="${selectTime}" />
		</form>
		<div class="t_cbtndiv">
			<input type="button" value="이전단계" class="t_button1" onclick="pre();" />
			<input type="button" value="결제하기" class="t_button3" onclick="next();"/>
		</div>
	</div>
</div>
