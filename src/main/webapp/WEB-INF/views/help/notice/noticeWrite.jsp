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
	$("#t").on("click",()=>{
		$.ajax({
	        url : '${pageContext.request.contextPath}/help/ticketOpenList.do',
			contentType: 'application/json; charset=utf-8',
			dataType: "json",
			type: "POST",
	        success : function(data) {
	           console.log(data);

	           var html = "";
	           html += "<table class='openList'><tr><th style='width:100px;'>장르</th><th>공연명</th><th style='width:150px;'>공연오픈일</th><th style='width:100px;'>공연선택</th></tr>";
	           if(data.length>0){
	               for(var i in data){
	                   html += "<tr><td>"+data[i].genrenm+"</td>";
	                   html += "<td>"+data[i].prfnm+"</td>";
	                   html += "<td>"+data[i].prfpdfrom+"</td>";
	                   html += "<td><input type='radio' name='chk_yn' class='chk_yn'>";
	                   html += "<div class='ticketInfo playId'>"+data[i].mt20id+"</div><div class='ticketInfo endDate'>"+data[i].prfpdto+"</div><div class='ticketInfo stateName'>"+data[i].fcltynm+"</div></td></tr>";
	               } /* for문끝 */
	           }  /* if문끝 */
	           else{
	           		html+="<tr><td colspan='3'> 오픈티켓이 존재하지 않습니다.</td></tr>";
	           }
	           html+="</table>";
	           $("#show-list").html(html);
	           $(".openList tbody").attr("style","display:block;");
	              
	       /*function success(data)끝 */
	       },error:function(e){
	            if(e.status==300){
	               alert("데이터를 가져오는데 실패하였습니다.");
	           }; 
	       }
		});
	});
	
	$(document).on('click', '.chk_yn', function(e){
		var playId = $(e.target).siblings(".playId").text();
		console.log(playId);
		
		$.ajax({
			url: '${pageContext.request.contextPath}/help/getPlayInfo.do',
			data: "playId="+playId,
	        success : function(data) {
	        	console.log(data);
	        	var text = "안녕하세요. SHOW티켓입니다. \n\n";
	        	
	        	text += data.genre+" "+data.name+" 오픈 안내입니다. \n\n";
	        	text += "<공연정보> \n공연 기간 : "+data.startDate+" ~ "+data.endDate+"\n";
	        	text += "공연 시간 : "+data.time+"\n공연 장소 : "+data.hallName+"\n티켓 가격 : "+data.price+"\n기타 정보 : "+data.age+", "+data.runtime+"\n";
	        	
	        	$("#playInfo").text(text);
	        	$("#tbl-write").after("<input type='hidden' name='playId' value='"+data.id+"'></input>");
	        }
			,error:function(e){
	            if(e.status==300){
		           alert("데이터를 가져오는데 실패하였습니다.");
		        }; 
		    }
		});	
	});
});
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
				<div id="show-list"></div>
				<div id="enroll-container">
					<form name="noticeWriteFrm" id="noticeWrite"
						action="noticeWriteEnd.do" method="post"
						onsubmit="return validate();">
						<table id="tbl-write" class="table">
							<tr>
								<th class="text-left">제목<i class="ico-star">*</i>
								</th>
								<td><input type="text" name="noticeTitle"
									class="form-control title" required placeholder="한글 20자까지 작성가능"></input>
								</td>
							</tr>
							<tr>
								<th class="text-left">카테고리<i class="ico-star">*</i></th>
								<td>
									<div class="custom-radio">
										<input type="radio" name="noticeCategory" id="t" value="t"
											required /> <label for="t">티켓오픈</label>
									</div>
									<div class="custom-radio">
										<input type="radio" name="noticeCategory" id="s" value="s"
											required /> <label for="s">시스템관련</label>
									</div>
									<div class="custom-radio">
										<input type="radio" name="noticeCategory" id="c" value="c"
											required /> <label for="c">변경취소</label>
									</div>
									<div class="custom-radio">
										<input type="radio" name="noticeCategory" id="o" value="o"
											required /> <label for="o">기타</label>
									</div>
								</td>
							</tr>

							<tr>
								<th class="text-left">내용<i class="ico-star">*</i></th>
								<td><textarea name="noticeContent" cols="40" rows="10" id="playInfo"
										class="form-control" required></textarea></td>
							</tr>
						</table>
						<input type="submit" value="등록" class="btn btn-color"
							id="complete" /> <input type="button" value="취소"
							class="btn btn-gray" id="cancel"
							onclick="location.href='${pageContext.request.contextPath}/help/notice.do'" />
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<a href="javascript:window.scrollTo(0,0);" id="back_to_top">위로</a>

<script type="text/javascript">
	//<![CDATA[
	$(document).ready(function() {
		$("#help_lmeu1").addClass("on");
		$('input, textarea').placeholder();
	});

	//]]>
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>