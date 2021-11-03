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
			
			$(".help_rcont .search input[type=text] ").val("");
			faqList(type, searchType);
		});
		//테이블의 열을 클릭시 해당 게시물로 이동
			$(document.body).delegate('.basic_tbl table tbody tr td', 'click', function(e) {
				var faqNo = $(e.target).parents("tr").children("td").children("input[id='faqNo']").val();
				location.href = "${pageContext.request.contextPath}/help/faqView.do?faqNo="+faqNo; 
			});
	 	
		
		
		/*글쓰기 페이지 이동*/
	 	$("#write").click(function() {
		location.href = "${pageContext.request.contextPath}/help/faqWrite.do";
		});
		
		//엔터키 누를경우 새로고침 방지 코드*
	 	document.addEventListener('keydown', function(event) {
	 		  if (event.keyCode === 13) {
	 		    event.preventDefault();
	 		  };
	 		}, true);

});
//엔터키처리
function enterkey() {
    if (window.event.keyCode == 13) {

         // 엔터키가 눌렸을 때 실행할 내용
         search();
    }
}



function search(){
	//검색 버튼 클릭
		var type = "";
		var searchType = "";
		
		searchType = $(".help_rcont .search input[type=text] ").val();
		
		faqList(type, searchType);
}

function faqList(type, searchType){
	
	var faq ={};
	faq.type = type;
	faq.question =searchType;
	faq.answer = searchType;

    $.ajax({
        url : '${pageContext.request.contextPath}/help/faqTicketList.do',
        data: JSON.stringify(faq),
		contentType: 'application/json; charset=utf-8',
		dataType: "json",
		type: "POST",
        success : function(data) {
           console.log(data);

           var html = "";
               html += "<table><caption>faq 리스트</caption><colgroup><col style='width: 100px'><col><col style='width: 270px'></colgroup><thead>";
   
               html +="<tr><th scope='col'>카테고리</th><th colspan='2' scope='col'>질문</th></tr></thead><tbody id='nTableBody'>";
                if(data.length>0){
                    for(var i in data){
                        html += "<tr><td>"+(data[i].type=='T'?"예매/취소":(data[i].type=='M'?"회원":(data[i].type=='C'?"쿠폰/이벤트":(data[i].type=='B'?"결제":"기타"))))+"<input type='hidden' id='faqNo' value='"+data[i].faqNo+"'/><input type='hidden' id='type' value='"+data[i].type+"'/></td>";
                        html += "<td colspan='2'>"+data[i].question+"</td></tr>"; 
                    
                    
                    } /* for문끝 */
                }  /* if문끝 */
                    else{
                    	html+="<tr><td colspan='3'>faq가 존재하지 않습니다.</td></tr>";
                    }
                    html+="</tbody></table>";
                    $("#basic_tbl").html(html);
                
               
                	
                	
                
       /*function success(data)끝 */
       },error:function(e){
            if(e.status==300){
               alert("데이터를 가져오는데 실패하였습니다.");
           }; 
       }
    }); 
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
				</div>
				<div class="search_area">
	

					<div class="question">질문 검색하기</div>
					<div class="search" id="searchBtn">
						<form name="searchForm"
							action="" method="GET">
							<fieldset id="fieldsetS">
								<legend>검색</legend>
								<input type="text" name="query" title="검색어 입력" onkeyup="enterkey();" value="">
								<p class="btn_search">
									<a href="javascript:search()"
										class="material-icons w3-xlarge">search</a>
								<p>
							</fieldset>

						</form>
					</div>

					<!-- // 검색창 덮는 배너 추가 -->
				</div>
					<c:if test="${'admin' eq memberLoggedIn.memberId}">
					<button class="btn btn-primary btn-color btn-sm" id="write">글쓰기</button>
					</c:if>
				
				<ul id="genreNav" class="nav nav-pills nav-justified">
					<li class="nav-item"><a class="nav-link select nav-font"
						href="#" id="T">예매/취소</a></li>
					<li class="nav-item"><a class="nav-link nav-font default"
						href="#" id="B">결제</a></li>
					<li class="nav-item"><a class="nav-link nav-font default"
						href="#" id="M">회원</a></li>
					<li class="nav-item"><a class="nav-link nav-font default"
						href="#" id="C">쿠폰/이벤트</a></li>
					<li class="nav-item"><a class="nav-link nav-font default"
						href="#" id="E">기타</a></li>
				</ul>
				
				<div class="basic_tbl" id="basic_tbl">
					<table>
						<caption>공지사항 리스트</caption>
						<colgroup>
							<col style="width: 120px">
							<col>
							<col style="width: 250px">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">카테고리</th>
								<th colspan="2" scope="col">질문</th>
							</tr>
						</thead>
						<tbody id="nTableBody">
								<c:if test="${empty list }">
										<tr>
											<td colspan="2">faq가 존재하지 않습니다.</td>
										</tr>
								</c:if>
								<c:if test="${not empty list }">
								<c:forEach items="${list}" var="f">
											<c:if test="${f.type.equals('T') }">
												<tr>
													<td>예매/취소
														<input type="hidden" id="faqNo" value="${f.faqNo }">
													</td>
													<td colspan="2">${f.question}</td>
														
														
												</tr>
											</c:if>
											<c:if test="${f.type.equals('M') }">
												<tr>
													<td>회원
														<input type="hidden" id="faqNo" value="${f.faqNo }">
													</td>
													<td colspan="2">${f.question}</td>
														
														
												</tr>
											</c:if>
											<c:if test="${f.type.equals('B') }">
												<tr>
													<td>결제
														<input type="hidden" id="faqNo" value="${f.faqNo }">
													</td>
													<td colspan="2">${f.question}</td>
														
														
												</tr>
											</c:if>
											<c:if test="${f.type.equals('C') }">
												<tr>
													<td>쿠폰/이벤트
														<input type="hidden" id="faqNo" value="${f.faqNo }">
													</td>
													<td colspan="2">${f.question}</td>
														
														
												</tr>
											</c:if>
											<c:if test="${f.type.equals('E') }">
												<tr>
													<td>기타
														<input type="hidden" id="faqNo" value="${f.faqNo }">
													</td>
													<td colspan="2">${f.question}</td>
														
														
												</tr>
											</c:if>
									</c:forEach>
								</c:if>
						</tbody>
					</table>
				</div>

<!-- 
				<div id="pagination" class="paging">
					<a href="javascript:goPage('1')" class="first">맨앞</a><a
						href="javascript:goPage('1')" class="prev">이전</a><strong>1</strong><a
						href="javascript:goPage('2')"> 2</a><a
						href="javascript:goPage('3')"> 3</a><a
						href="javascript:goPage('4')"> 4</a><a
						href="javascript:goPage('5')"> 5</a><a
						href="javascript:goPage('6')"> 6</a><a
						href="javascript:goPage('7')"> 7</a><a
						href="javascript:goPage('8')"> 8</a><a
						href="javascript:goPage('9')"> 9</a><a
						href="javascript:goPage('10')"> 10</a><a
						href="javascript:goPage('11')" class="next">다음</a><a
						href="javascript:goPage('452')" class="end">맨뒤</a>
				</div>
 -->
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>