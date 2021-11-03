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
	href="${pageContext.request.contextPath}/resources/css/eventWrite.css">

<style>
#showList-box::-webkit-input-placeholder { text-align:right;pointer-events: none; }
div#showList-box{width:98%; height:200px; overflow:auto;margin-bottom: 50px;}
.ListTable {border: 2px solid #D8D8D8;}

</style>

<script>

$(()=>{
	
	$(".checkBtn").click(function(){ 
		
		var str = ""
		var tdArr = new Array();	// 배열 선언
		var checkBtn = $(this);
	
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		
		console.log("클릭한 Row의 모든 데이터 : "+tr.text());
		
		var id = td.eq(0).text();
		var genre = td.eq(1).text();
		var name = td.eq(2).text();
		var start = td.eq(3).text();
		var end = td.eq(4).text();
		var detail = td.eq(5).text();
		var ing = td.eq(6).text();
		console.log(ing);
	
		var html=""; 
	

		var contain ="<form action='${pageContext.request.contextPath}/event/insertEventEnd.do' method='post'  enctype='multipart/form-data'>";
		contain+="<table class='table table-bordered' id='eventWriteTable'>";
		contain+="<tbody><col width='200px'/><col width='400px'/>";
		contain+="<tr><th>제목:</th> <td><input type='text' name='eventTitle' class='form-control' value='"+name+"'/></td>";
		contain+="</tr><tr> <th>항목:</th><td><select class='form-control' name='eventKind'><option value='I'>초대</option><option value='E'>응모</option></select></td></tr>";
		contain+="<tr><th>내용:</th><td><textarea id='textLine' name='eventContent' rows='5' cols='78'></textarea></td></tr>"; 
		contain+="<tr><th>사진첨부:</th><td><input type='file' name='upFile' id='upFile1' ></td></tr>"; 
		contain+="<tr><th>이벤트 날짜:</th><td style='vertical-align:middle;'>"; 
		contain+="<input type='date' class='form-control eventDate' name='eventStartDate' /><span style='float:left; font-size:15px;'>~</span>";
		contain+="<input type='date' class='form-control eventDate1' name='eventEndDate'/></td></tr>";
		contain+="<tr><th>당첨자 발표날짜:</th><td><input type='date' class='form-control eventDate' name='announcementDate'/></td></tr>"; 
		contain+="<tr><th>이벤트 상세날짜:</th><td><input type='date' class='form-control eventDate' name='eventDetailDate'/></td></tr>";
		contain+="<tr><th>상세 시간 및 인원:</th><td><input type='text' palceholder='상세 시간 및 인원을 입력 해주세요' class='form-control' name='eventTimeMen'/></td></tr>"; 
		contain+="</tbody></table>";
		contain+="<input type='hidden' name='showId'  value='"+id+"'/>";
		contain+="<input type='hidden' name='eventStatus' value='"+detail+"'/>";
		contain+="<input type='hidden' name='eventImg' value='"+ing+"'/>";
		contain+="<input type='submit' value='등록'  class='pull-right'/>";
		contain+="<input type='button' value='목록으로' class='btn btn-primary btn-color btn-sm pull-left' onclick='javascript:location.href='eventList.do'/></form>";
		
		html+=contain;
		
		$("div#contain-frm").html(html);
	});
	


});


</script>




<div id="container" class="event_cont">
	<div class="inner">
		<h2 class="title">이벤트</h2>
		<!-- [D]  1 depth의 값을 h2로 뿌려줍니다 -->
		<!-- 3월 스펙 아웃으로 인한 큰 이벤트 이미지 부분 삭제 -->

		<ul class="nav nav-pills nav-justified">
			<li class="nav-item"><a class="nav-link select nav-font"
				href="#">진행중인 이벤트</a></li>
			<li class="nav-item"><a class="nav-link nav-font default"
				href="${pageContext.request.contextPath}/event/endEventList.do">종료된
					이벤트</a></li>
			<li class="nav-item"><a class="nav-link nav-font default"
				href="${pageContext.request.contextPath}/event/prizewinner.do">당첨자
					발표</a></li>
			<li class="nav-item"><a class="nav-link nav-font default"
				href="${pageContext.request.contextPath}/coupon/coupon.do">쿠폰</a></li>
		</ul>

		<h4>공연목록</h4>

	<table class="ListTable" style="width:98%;height: 40px;" border="0" >
		<tr style="text-align: center; background:#D8D8D8 ; border-radius: 3px;">
			<th>공연 ID</th>
			<th>공연명</th>
			<th>공연시작일</th>
			<th>공연종료일</th>
			<th>공연유무</th>
			<th>선택하기</th>
		</tr>
		</table>
		<div id="showList-box">

		<c:if test="${empty eventList}"><h4>공연리스트가 없습니다.</h4></c:if>
		<c:if test="${!empty eventList}"> 
			<table class="ListTable scrolltable" id="showList" width="100%" border="0" cellspacing="0" cellpadding="0">
				<c:forEach items="${eventList}" var="l">
					
						<tr style="text-align: center; border: 2px solid #D8D8D8;">
							<td style="display: none;">${l.mt20id }</td>
							<td>${l.genrenm }</td>
							<td>${l.prfnm}</td>
							<td>${l.prfpdfrom}</td>
							<td>${l.prfpdto}</td>
							<td>${l.prfstate}</td>
							<td style="display: none;">${l.poster }</td>
							<td><input type="radio" class="checkBtn"></td>
						</tr>
					</c:forEach>
				
				
			</table>
		</c:if>	
		</div>
		
	
		<div id="contain-frm">
	
	
		</div>

	</div>
	

</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>