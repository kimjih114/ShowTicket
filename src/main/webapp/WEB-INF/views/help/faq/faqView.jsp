<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle" />
</jsp:include>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/help.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">
<script>

$(()=>{
		var type = "";
		var searchType = "";
		
		/*nav 메뉴 */
		$("#genreNav > li > a").click((e)=>{		
			type = $(e.target).attr('id');
		 	$(".nav-pills .nav-link.select").attr('class','nav-link nav-font default');
			$(e.target).attr('class','nav-link select nav-font'); 
			
			faqList(type, searchType);
		});
		
		/*글쓰기 페이지 이동*/
	 	$("#write").click(function() {
		location.href = "${pageContext.request.contextPath}/help/faqWrite.do";
		});

});
function faqList(type, searchType){
	
	var faq ={};
	faq.type = type;
	faq.question =searchType;
	faq.answer = searchType;

   
}

</script>
<div id="container">
	<div class="inner">
		<div class="quick_menu">
			<div class="title">고객센터</div>
			<ul>
				<li class="qmenu1"> <a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=62"><i class="material-icons">lock_open</i><br />아이디/비밀번호<br>찾기
				</a></li>
				<li class="qmenu2">
					<a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=64"><i class="material-icons">shopping_cart</i><br/>예매/취소<br>환불
				</a></li>
				<li class="qmenu3"> <a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=69"><i class="material-icons">location_on</i><br>티켓수령<br>문의
				</a></li>
				<li class="qmenu4">
					<a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=66"><i class="material-icons">turned_in_not</i><br />할인수단<br>안내
				</a></li>
				<li class="qmenu5">
					<a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=68"><i class="material-icons">hourglass_empty</i><br />관심공연알림<br>안내
				</a></li>
				<li class="qmenu6"> <a href="${pageContext.request.contextPath}/help/faqView.do?faqNo=67"><i class="material-icons">star_border</i><br />이벤트<br>안내
				</a></li>
			</ul>
		</div>

		<div class="help_cont">

			<ul class="help_lmenu">
				<!-- [D] 활성상태일 때 .on 추가입니다. -->
				<li id="help_lmeu"><a
					href="${pageContext.request.contextPath}/help/main.do"
					class="help_lmeu1">고객센터홈</a></li>
				<li id="help_lmeu"><a
					href="${pageContext.request.contextPath}/help/notice.do"
					class="help_lmeu2">공지사항</a></li>
				<li id="help_lmeu3"><a
					href="${pageContext.request.contextPath}/help/faq.do"
					class="help_lmeu3">FAQ</a></li>
			</ul>

			<div class="help_rcont">
				<div>
					<h2>FAQ</h2>
					<c:if test="${'admin' eq memberLoggedIn.memberId}">
					<button class="btn btn-primary btn-color btn-sm" id="write">글쓰기</button>
					</c:if>
				</div>
				
				<div class="basic_tbl" id="basic_tbl">
				
					<table>
						<caption>공지사항 리스트</caption>
						<colgroup>
							<col style="width: 100px">
							<col>
							<col style="width: 270px">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">카테고리</th>
								<th colspan="2" scope="col">질문</th>
							</tr>
						</thead>
						<tbody id="nTableBody">
								<c:if test="${empty faq }">
										<tr>
											<td colspan="2">faq가 존재하지 않습니다.</td>
										</tr>
								</c:if>
								<c:if test="${not empty faq }">
									<tr>
										<td>
											<c:if test="${faq.type.equals('T') }">예매/취소</c:if>
											<c:if test="${faq.type.equals('M') }">회원</c:if>
											<c:if test="${faq.type.equals('B') }">결제</c:if>
											<c:if test="${faq.type.equals('C') }">쿠폰/이벤트</c:if>
											<c:if test="${faq.type.equals('E') }">기타</c:if>
											
											<input type="hidden" id="faqType" name="type" value="${f.type }">
											<input type="hidden" id="faqNo" name="faqNo" value="${f.faqNo }">
										</td>
										<td colspan="2">${faq.question}</td>
									</tr>
									<tr>
										<td style="vertical-align: middle;">내용</td>
										<td colspan="2"><textarea cols="50" rows="15" style="text-align: center; padding:8% 0%;  width:100%;" readonly>${faq.answer}</textarea></td>
									</tr>
								</c:if>
						</tbody>
					</table>
				</div>					
					<c:if test="${'admin' eq memberLoggedIn.memberId}">
				
						<input class="btn btn-color" id="complete" type="button" onclick="location.href='${pageContext.request.contextPath}/help/faqUpdate.do?faqNo=${faq.faqNo }'" value="수정하기" >
						<input class="btn btn-gray" id="cancel" type="button"  onclick="location.href='${pageContext.request.contextPath}/help/faqDelete.do?faqNo=${faq.faqNo }'" value="삭제">
					</c:if>
					<input class="btn btn-gray" id="cancel" type="button"  onclick="location.href='${pageContext.request.contextPath}/help/faq.do'" value="목록으로">



			

			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>