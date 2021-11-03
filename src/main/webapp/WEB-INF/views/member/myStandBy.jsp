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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/member.css">

<script>
function deleteStandBy(showId){

	location.href="${pageContext.request.contextPath}/member/deleteStandBy.do?showId="+showId;
};
$(()=>{
	
	$("#musical-nav").on("click", function(){
		$("#showWList").css("display", "none");
		$("#musicalWList").css("display", "block");
	});
	
	$("#show-nav").on("click", function(){
		$("#musicalWList").css("display", "none");
		$("#showWList").css("display", "block");
	});

	$("ul > li > div").click((e)=>{
 		$(".nav-pills .nav-link.select").attr('class', 'nav-link nav-font default');
		$(e.target).attr('class','nav-link select nav-font')
	});


});
</script>

<div id="container">
	<jsp:include page="/WEB-INF/views/common/memberViewnav.jsp">
		<jsp:param value="마이 페이지" name="pageTitle" />
	</jsp:include>

	<br>
	<div class="div-memberFrm">
		<h2 class="small-title">대기공연</h2>

		<ul id="wnav" class="nav nav-pills nav-justified nav-member">
			<li class="nav-item"><div class="nav-link select nav-font"
					id="musical-nav">뮤지컬</div></li>
			<li class="nav-item"><div class="nav-link nav-font default"
					id="show-nav">연극</div></li>
		</ul>

			<div class="wList" id="musicalWList" style="margin-top: 20px;">
			<table class="playList">
				<tr>
					<th>공연명</th>
					<th>취소</th>
				</tr>
				<c:if test="${not empty myStandByMList }">
				<c:forEach items="${myStandByMList }" var='m'>
					<tr>
						<td>${m.prfnm }</td>
						<td>
							<button type="button" class="btn btn-secondary"
								onclick="deleteStandBy('${m.mt20id}')">취소</button>
						</td>
					</tr>
				</c:forEach>
				</c:if>
			</table>
			</div>
			
			<div class="wList" id="showWList" style="margin-top: 20px;">
			<table class="playList">
				<tr>
					<th>공연명</th>
					<th>취소</th>
				</tr>
				<c:if test="${not empty myStandBySList }">
				<c:forEach items="${myStandBySList }" var='s'>
					<tr>
						<td>${s.prfnm }</td>
						<td>
							<button type="button" class="btn btn-secondary"
								onclick="deleteStandBy('${s.mt20id}')">취소</button>
						</td>
					</tr>
				</c:forEach>
				</c:if>
			</table>
			</div>

			<br />

		
	
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
