<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/admin.css"/>

<form class="cnt" action="${pageContext.request.contextPath}/admin/adminReportDetail.do" method="post"></form>
<form class="delete" action="${pageContext.request.contextPath}/admin/adminReportDelete.do" method="post"></form>

<script>

$(".nav").click(function(){
    $(this).css("color","#8f01a3");
});

function goReport(num,user,rNo,rpNo) {
	var cnt = num;
	var memberId = user;
	var reviewNo = rNo;
	var reportNo = rpNo;
	
	if(confirm("신고수를 누적하시겠습니까?")){
		$(".cnt").append("<input type='hidden' name='cnt' value='"+num+"'/>")
				 .append("<input type='hidden' name='memberId' value='"+memberId+"'/>")
				 .append("<input type='hidden' name='reviewNo' value='"+reviewNo+"'/>")
				 .append("<input type='hidden' name='reportNo' value='"+reportNo+"'/>").submit();
	}
	else{
		return;		
	}
}

function goDelete(num) {
	var reviewNo = num;
	
	if(confirm("삭제 하시겠습니까?")){
		$(".delete").append("<input type='hidden' name='reviewNo' value='"+reviewNo+"'/>").submit();
	}
	else{
		return;		
	}
}
</script>

<nav id="myPageNavBar">
	<span id="myPage"><label>관리자 메뉴</label></span>
	<table id="navBar">
		<tr>
			<td class="nav" onclick="location.href='${pageContext.request.contextPath}/admin/adminReport.do'">신고 게시판</td>
		</tr>
		<tr>
			<td class="nav" onclick="location.href='${pageContext.request.contextPath}/admin/adminMemberList.do'">내 회원목록</td>
		</tr>
	</table>
</nav>

<div id="container">
	<jsp:include page="/WEB-INF/views/common/adminReportnav.jsp"/>
   
	<div id="report">
		<div class="inner">
			<h2 class="font">회원 목록</h2>
			<div class="rhr"></div>
		</div>	
			
		<c:forEach items="${reportList }" var="list">
			<table class="detailTable">
				<thead>
					<tr>
						<th class="rNo border">번호</th>
						<th class="reason border">신고사유</th>
						<th colspan="2" class="rwidth border">신고한 회원</th>
						<th colspan="2" class="rwidth border">신고 받은 회원</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="user1" value="${list.reportMemberId }"/>
					<c:set var="user2" value="${list.receiveMemberId }"/>
					<c:set var="reviewNo" value="${list.reviewNo }"/>
					<c:set var="reportNo" value="${list.reportNo }"/>
					<tr class="parent cursor">
				      <td class="border">${list.reviewNo }</td>
				      <td class="border">${list.reportReason }</td>
				      <td class="user border">${list.reportMemberId }</td>
				      <td class="border">
				      	<button type="button" class="rbtn" onclick="goReport(1,'${user1 }','${reviewNo }','${reportNo }');">신고+</button>			      
				      </td>
				      <td class="user border">${list.receiveMemberId }</td>
				      <td class="border">
				      	<button type="button" class="rbtn" onclick="goReport(1,'${user2}','${reviewNo }','${reportNo }');">신고+</button>			      
				      </td>
				    </tr>
				 </tbody>
			</table>
			<table class="detailTable tbottom">
				<c:forEach items="${reviewList}" var="rlist">
				 <tr>
				  	<td class="rcontent border">신고된 글 내용</td>
				    <td class="border">${rlist.reviewContent }</td>
				 </tr>
				</c:forEach>
			</table>
		
			<button type="button" class="r_dbtn" onclick="goDelete('${reviewNo}')">삭제</button>
			<button type="button" class="rbtn btn_" onclick="location.href='${pageContext.request.contextPath}/admin/adminReport.do'">목록</button>
		</c:forEach>
	</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>