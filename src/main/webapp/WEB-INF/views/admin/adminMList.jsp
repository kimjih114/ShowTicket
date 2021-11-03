<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/admin.css"/>

<form class="out" action="${pageContext.request.contextPath}/admin/adminMemberDelete.do" method="post"></form>
<script>
$(()=>{
	$("#search-memberName").hide();
	$("#searchType").on("click", (e)=>{
		var type = $(e.target).val();
		console.log(type);	
		$(".asearch").hide();
		$("#search-"+type).css("display","inline-block");
	});
	
	$(".nav").click(function(){
	    $(this).css("color","#8f01a3");
	});
	
});

function goOut(user) {
	var memberId = user;

	if(confirm("탈퇴 하시겠습니까?")){
		$(".out").append("<input type='hidden' name='memberId' value='"+memberId+"'/>").submit();
	}
	else{
		return;		
	}
}

function goSearch(num) {
	if(num == 1){
		$(".idForm").submit();				
	}
	else{
		$(".nameForm").submit();				
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
		
		<!-- 검색 부분 -->
		<select id="searchType" class="option_">
    		<option value="memberId" ${"memberId".equals(searchType)?'selected':"" }>아이디</option>
    		<option value="memberName" ${"memberName".equals(searchType)?'selected':"" }>회원명</option>
    	</select>
		
		<div class="asearch_area">
			<div id="search-memberId" class="asearch">
				<form class="idForm" name="searchMForm" action="${pageContext.request.contextPath }/admin/adminMemberSearch.do" method="GET">
					<fieldset id="fieldsetS">
						<legend>검색</legend>
						<input type="hidden" name="searchType" value="memberId"/>
						<input type="text" name="searchKeyword" title="검색어 입력" value="" style="padding:10px;">
						<p class="btn_search">
							<a onclick="goSearch(1);" class="material-icons w3-xlarge" style="color: white;">search</a>
						<p>
					</fieldset>
				</form>
			</div>
			<div id="search-memberName" class="asearch" >
				<form class="nameForm" name="searchMForm" action="${pageContext.request.contextPath }/admin/adminMemberSearch.do" method="GET">
					<fieldset id="fieldsets">
						<legend>검색</legend>
						<input type="hidden" name="searchType" value="memberName"/>
						<input type="text" name="searchKeyword" title="검색어 입력" value="" style="padding:10px;">
						<p class="btn_search">
							<a onclick="goSearch(2);" class="material-icons w3-xlarge" style="color: white;">search</a>
						<p>
					</fieldset>
				</form>
			</div>
		</div>
				
		<table class="table" id="reporttbl">
			  <thead>
			    <tr>
			      <th scope="col">아이디</th>
			      <th scope="col">이름</th>
			      <th scope="col">이메일</th>
			      <th scope="col">연락처</th>
			      <th scope="col">탈퇴</th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:forEach items="${memberList}" var="list">
			  	<c:set var="memberId" value="${list.memberId }"/>
			  	<tr class="cursor">
			  		<th scope="row">${list.memberId}</th>
					<td>${list.memberName}</td>
				    <td>${list.email}</td>
				    <td>${list.phone}</td>
				    <td class="deleteBtn">
				    	<button type="button" id="dropM" class="rbtn" onclick="goOut('${list.memberId}');" style="height: 24px;">탈퇴</button>
				    </td>
				</tr>
				   </c:forEach>	    
			  </tbody>
		</table>
			
		<!-- 페이지바  -->
		<nav aria-label="Page navigation example" class="mnav_top font">
			<ul class="pagination justify-content-center font_size">
			<c:set var="barNo" value="${paging.barNo }"/>
			<c:set var="barEnd" value="${paging.barEnd }"/>
			<c:set var="totalPage" value="${paging.totalPage }"/>
			<c:set var="cPage" value="${paging.cPage }"/>
			<c:set var="s" value="${paging.barStart }"/>
				<c:if test="${barNo eq 1}">
					<li class="page-item disabled">
						<a class="page-link" style="background-color: #F2F2F2; border: 0px;">&lt;</a>
					</li>
				</c:if>
				<c:if test="${barNo ne 1}">
					<li class="page-item">
						<a class="page-link" href="${pageContext.request.contextPath }/admin/adminMemberList.do?cPage=${barNo-1}" style="background-color: #F2F2F2; border: 0px;">&lt;</a>
					</li>
				</c:if>
				<c:if test="${!(barNo>barEnd || barNo>totalPage)}">
					<c:forEach var="barNo" begin="${barNo }" end="${barEnd }">
						<c:choose>
							<c:when test="${barNo eq cPage}">
								<li class="page-item disabled">
									<a class="page-link" style="color: black; border: 0px;">${barNo }</a>
								</li>
							</c:when>
							<c:when test="${(barNo ne s && cPage eq totalPage) }">
								<li class="page-item disabled">
									<a class="page-link" href="${pageContext.request.contextPath }/admin/adminMemberList.do?cPage=${barNo}" style="color: gray; border: 0px;">${barNo }</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a class="page-link" href="${pageContext.request.contextPath }/admin/adminMemberList.do?cPage=${barNo}" style="color: gray; border: 0px;">${barNo }</a>
								</li>
							</c:otherwise>
						</c:choose>
						<c:set var="next" value="${barNo+1 }"/>
					</c:forEach>
				</c:if>
				<c:choose>
					<c:when test="${(barNo>totalPage || cPage eq totalPage)}">
						<li class="page-item disabled">
							<a class="page-link" style="background-color: #F2F2F2; border: 0px;">&gt;</a>
						</li>
					</c:when>
					<c:when test="${barEnd > totalPage }">
						<li class="page-item disabled">
							<a class="page-link" href="${pageContext.request.contextPath }/admin/adminMemberList.do?cPage=${next}" style="background-color: #F2F2F2; border: 0px;">&gt;</a>
						</li>
					</c:when>
					<c:when test="${!(barNo>totalPage || cPage eq totalPage) }">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath }/admin/adminMemberList.do?cPage=${next}" style="background-color: #F2F2F2; border: 0px;">&gt;</a>
						</li>
					</c:when>
				</c:choose>
			</ul>
		</nav>	
	</div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>