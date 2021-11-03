<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
#myPageNavBar{
	position:absolute;
	width: 100px;
	text-align:center;
	left:0;
	margin-left : 3.5%;
	
}
#myPage{
	text-align:center;
	width:150px;
	height:100px;
	background-color : #8f01a3;
	padding:10px 10px 10px 10px;
	display:inline-block;
}
#myPage label{
	color : white;
	font-size:26px;
	font-weight:bold;
	text-align:center;
	margin-top : 14px;
}
#navBar{
	border : 0px;
	margin-left : 10px;
	font-size : 20px;
	margin-top : 20px;
}
#navBar td{
	border : 0px;
	width : 200px;
	height: 50px;
	color: gray;
	font-size:15px;
}
#navBar td:hover{
	color:#8f01a3;
	cursor:pointer;
}
</style>
<nav id="myPageNavBar">
	<span id="myPage"><label>마이페이지</label></span>
	<table id="navBar">
		<tr>
			<td class="nav"
				onclick="location.href='${pageContext.request.contextPath}/member/reservation.do?cPage=1'">예매확인/취소</td>
		</tr>
		<tr>
			<td class="nav"
				onclick="location.href='${pageContext.request.contextPath}/member/myPoint.do'">내
				포인트</td>
		</tr>
		<tr>
			<td class="nav"
				onclick="location.href='${pageContext.request.contextPath}/member/myCoupon.do'">내
				쿠폰</td>
		</tr>
		<tr>
			<td class="nav"
				onclick="location.href='${pageContext.request.contextPath}/member/memberView.do'">회원정보
				수정</td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td class="nav"
				onclick="location.href='${pageContext.request.contextPath}/member/myStandBy.do'">대기 공연</td>
		</tr>
		<tr>
			<td class="nav"
				onclick="location.href='${pageContext.request.contextPath}/member/myFollow.do'">관심 공연</td>
		</tr>
	</table>
</nav>
<script>
$("nav").click(function() {
	  $(this).css("color","#8f01a3");
	});
</script>