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
function deleteFollow(playId){
	location.href="${pageContext.request.contextPath}/member/deleteFollow.do?playId="+playId;
};
$(()=>{
	
	$("#musical-nav").on("click", function(){
		$("#showList").css("display", "none");
		$("#musicalList").css("display", "block");
	});
	
	$("#show-nav").on("click", function(){
		$("#musicalList").css("display", "none");
		$("#showList").css("display", "block");
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
		<h2 class="small-title">관심공연</h2>

		<ul id="nav" class="nav nav-pills nav-justified nav-member">
			<li class="nav-item"><div class="nav-link select nav-font"
					id="musical-nav">뮤지컬</div></li>
			<li class="nav-item"><div class="nav-link nav-font default"
					id="show-nav">연극</div></li>
		</ul>
		<div class="list" id="musicalList" style="margin-top: 20px;">
			<table class="playList">
				<tr>
					<th>공연명</th>
					<th>오픈일시</th>
					<th>삭제</th>
				</tr>
				<c:forEach items="${masList }" var="mas">
					<c:if test="${mas.genre eq '뮤지컬'}">
						<tr>
							<td>뮤지컬&lt;${mas.name }&gt;</td>
							<td>${mas.startDate }</td>
							<c:if test="${mas.state eq '공연예정'}">
							<td><button type="button" class="btn"
									onclick="deleteFollow('${mas.id}')">삭제</button></td>
							</c:if>
							<c:if test="${mas.state eq '공연중'}">
							<td><button type="button" class="btn"
									onclick="location.href='${pageContext.request.contextPath}/musical/musicalDetail.do?musicalId=${mas.id}'">예매하기</button></td>
							</c:if>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
		<div class="list" id="showList"
			style="margin-top: 20px; display: none;">
			<table class="playList">
				<tr>
					<th>공연명</th>
					<th>오픈일시</th>
					<th>삭제</th>
				</tr>
				<c:forEach items="${masList }" var="mas">
					<c:if test="${mas.genre eq '연극'}">
						<tr>
							<td>연극&lt;${mas.name }&gt;</td>
							<td>${mas.startDate }</td>
							<c:if test="${mas.state eq '공연예정'}">
							<td><button type="button" class="btn"
									onclick="location.href='${pageContext.request.contextPath}'">삭제</button></td>
							</c:if>
							<c:if test="${mas.state eq '공연중'}">
							<td><button type="button" class="btn"
									onclick="location.href='${pageContext.request.contextPath}/show/showDetail.do?showId=${mas.id}'">예매하기</button></td>
							</c:if>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>

		<!-- <nav aria-label="Page navigation example">
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
					<li class="page-item"><a class="page-link" href="#"
						style="color: gray; border: 0px;">4</a></li>
					<li class="page-item disabled"><a class="page-link" href="#"
						tabindex="1" aria-disabled="true"
						style="background-color: #F2F2F2; border: 0px;">></a></li>
				</ul>
			</nav> -->
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$("input[type=button] #button2").click(function() {
			$(this).css("background-color", "gray").css("color", "white");
		});

	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
