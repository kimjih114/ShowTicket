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
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/help.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">

<script>

$(()=>{
		var category = "";
		var searchTitle = "";
		
		/*nav 메뉴 */
		$("#genreNav > li > a").click((e)=>{		
			category = $(e.target).attr('id');
		 	$(".nav-pills .nav-link.select").attr('class','nav-link nav-font default');
			$(e.target).attr('class','nav-link select nav-font'); 
			
			$(".help_rcont .search input[type=text] ").val("");
			noticeList(category, searchTitle);
		});
		
		//테이블의 열을 클릭시 해당 게시물로 이동
		$(document.body).delegate('.basic_tbl table tbody tr', 'click', function(e) {
			var noticeNo = $(e.target).parents("tr").children("td").children(".noticeNo").val();
			location.href = "${pageContext.request.contextPath}/help/noticeView.do?noticeNo="+noticeNo; 
		});
	
		/*글쓰기 페이지 이동*/
	 	$("#write").click(function() {
			location.href = "${pageContext.request.contextPath}/help/noticeWrite.do";
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
	var category = "";
	var searchTitle = "";
	
	searchTitle = $(".help_rcont .search input[type=text] ").val();
	
	noticeList(category, searchTitle);
}

function noticeList(category, searchTitle){
	
	var notice ={};
	notice.noticeCategory = category;
	notice.noticeTitle = searchTitle;

    $.ajax({
        url : '${pageContext.request.contextPath}/help/noticeList.do',
        data: JSON.stringify(notice),
		contentType: 'application/json; charset=utf-8',
		dataType: "json",
		type: "POST",
        success : function(data) {
           console.log(data);

           var html = "";
           html += "<table><col style='width: 100px'><col style='width: 372px'><col style='width: 270px'><thead>";
           html +="<tr><th scope='col' style='text-align: center'>카테고리</th><th scope='col' style='text-align: center'>제목</th><th scope='col' style='text-align: center'>등록일</th></tr></thead><tbody id='nTableBody'>";
           if(data.length>0){
               for(var i in data){
                   html += "<tr><td style='text-align: center'><input type='hidden' class='noticeNo' value='"+data[i].noticeNo+"'>";
                   html += (data[i].noticeCategory=='t'?"티켓오픈":(data[i].noticeCategory=='s'?"시스템":(data[i].noticeCategory=='c'?"변경/취소":"기타")))+"</td>";
                   html += "<td style='text-align: left'>"+data[i].noticeTitle+"</td>";
                  var fullDate = new Date(data[i].noticeEnrollDate);
                  var month = fullDate.getMonth()+1;
                  var date = fullDate.getDate();
                   html += "<td style='text-align: center'>"+fullDate.getFullYear()+"-"+(month<10?'0'+month:month)+"-"+(date<10?'0'+date:date)+"</td></tr>";
               } /* for문끝 */
           }  /* if문끝 */
           else{
           		html+="<tr><td colspan='3'>공지사항이 존재하지 않습니다.</td></tr>";
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
				<li class="qmenu1"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=62"><i
						class="material-icons">lock_open</i><br />아이디/비밀번호<br>찾기 </a></li>
				<li class="qmenu2"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=64"><i
						class="material-icons">shopping_cart</i><br />예매/취소<br>환불 </a></li>
				<li class="qmenu3"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=69"><i
						class="material-icons">location_on</i><br>티켓수령<br>문의 </a></li>
				<li class="qmenu4"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=66"><i
						class="material-icons">turned_in_not</i><br />할인수단<br>안내 </a></li>
				<li class="qmenu5"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=68"><i
						class="material-icons">hourglass_empty</i><br />관심공연알림<br>안내
				</a></li>
				<li class="qmenu6"><a
					href="${pageContext.request.contextPath}/help/faqView.do?faqNo=67"><i
						class="material-icons">star_border</i><br />이벤트<br>안내 </a></li>
			</ul>
		</div>

		<div class="help_cont">
			<ul class="help_lmenu">
				<!-- [D] 활성상태일 때 .on 추가입니다. -->
				<li id="help_lmeu"><a
					href="${pageContext.request.contextPath}/help/main.do"
					class="help_lmeu1">고객센터홈</a></li>
				<li id="help_lmeu2"><a
					href="${pageContext.request.contextPath}/help/notice.do"
					class="help_lmeu2 focus">공지사항</a></li>
				<li id="help_lmeu"><a
					href="${pageContext.request.contextPath}/help/faq.do"
					class="help_lmeu3">FAQ</a></li>
			</ul>
			<div class="help_rcont">
				<div>
					<h2 class="help-title">공지사항</h2>
				</div>
				<div class="search_area">


					<div class="question">공지 검색하기</div>
					<div class="search" id="searchBtn">
						<fieldset id="fieldsetS">
							<legend>검색</legend>
							<input type="text" title="검색어 입력" onkeyup="enterkey();">
							<p class="btn_search">
								<a href="javascript:search()"
									class="material-icons w3-xlarge">search</a>
							<p>
						</fieldset>
					</div>

					<!-- // 검색창 덮는 배너 추가 -->
				</div>
				<c:if test="${'admin' eq memberLoggedIn.memberId}">
					<button class="btn btn-primary btn-color btn-sm" id="write">글쓰기</button>
				</c:if>
				<ul id="genreNav" class="nav nav-pills nav-justified">
					<li class="nav-item"><a class="nav-link select nav-font"
						href="#">전체</a></li>
					<li class="nav-item"><a class="nav-link nav-font default"
						href="#" id="t">티켓오픈</a></li>
					<li class="nav-item"><a class="nav-link nav-font default"
						href="#" id="s">시스템관련</a></li>
					<li class="nav-item"><a class="nav-link nav-font default"
						href="#" id="c">변경취소</a></li>
					<li class="nav-item"><a class="nav-link nav-font default"
						href="#" id="o">기타</a></li>
				</ul>

				<div class="basic_tbl" id="basic_tbl">
					<table>
						<colgroup>
							<col style="width: 100px">
							<col style="width: 372px">
							<col style="width: 270px">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" style="text-align: center">카테고리</th>
								<th scope="col" style="text-align: center">제목</th>
								<th scope="col" style="text-align: center">등록일</th>
							</tr>
						</thead>
						<tbody id="NTableBody">
							<c:if test="${empty list }">
								<tr>
									<td colspan="3">공지사항이 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty list }">
								<c:forEach items="${list }" var="n">
									<tr>
										<td style="text-align: center">
											<input type="hidden" class="noticeNo" value="${n.noticeNo }">
											<c:choose>
												<c:when test="${n.noticeCategory eq 't'}">티켓오픈</c:when>
												<c:when test="${n.noticeCategory eq 's'}">시스템</c:when>
												<c:when test="${n.noticeCategory eq 'c'}">변경/취소</c:when>
												<c:when test="${n.noticeCategory eq 'o'}">기타</c:when>
											</c:choose>
										</td>
										<td style="text-align: left">${n.noticeTitle }</td>
										<td style="text-align: center;">${n.noticeEnrollDate }</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>


				<div id="pagination" class="paging">
					<a href="javascript:goPage('1')" class="first">&lt;&lt;</a><a
						href="javascript:goPage('1')" class="prev">&lt;</a><strong>1</strong><a
						href="javascript:goPage('2')"> 2</a><a
						href="javascript:goPage('3')"> 3</a><a
						href="javascript:goPage('4')"> 4</a><a
						href="javascript:goPage('5')"> 5</a><a
						href="javascript:goPage('6')"> 6</a><a
						href="javascript:goPage('7')"> 7</a><a
						href="javascript:goPage('8')"> 8</a><a
						href="javascript:goPage('9')"> 9</a><a
						href="javascript:goPage('10')"> 10</a><a
						href="javascript:goPage('11')" class="next">&gt;</a><a
						href="javascript:goPage('452')" class="end">&gt;&gt;</a>
				</div>

			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	/* 	//<![CDATA[
	 $(document).ready(function () {
	 $("#help_lmeu1").addClass("on");
	 $('input, textarea').placeholder();
	 });

	 function searchFaq () {
	 var searchKeyword = encodeURI($("#search_help").val());
	 location.replace("/help/faq?searchKeyword=" + searchKeyword + "");
	 }
	 //]]> */
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>