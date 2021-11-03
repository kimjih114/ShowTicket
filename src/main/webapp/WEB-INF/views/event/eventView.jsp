<%@page import="com.kh.showticket.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="안녕 스프링	" name="pageTitle" />
</jsp:include>


<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/eventView.css">


<body>	
	<ul class="nav nav-pills nav-justified">
		<li class="nav-item"><a class="nav-link nav-font select"
			href="${pageContext.request.contextPath}/event/eventList.do">진행중인
				이벤트</a></li>
		<li class="nav-item"><a class="nav-link nav-font default"
			href="${pageContext.request.contextPath}/event/endEventList.do">종료된
				이벤트</a></li>
		<li class="nav-item"><a class="nav-link nav-font default"
			href="${pageContext.request.contextPath}/event/prizewinner.do">당첨자
				발표</a></li>
		<li class="nav-item"><a class="nav-link nav-font default"
			href="${pageContext.request.contextPath}/coupon/coupon.do">쿠폰</a></li>
	</ul>


	<div class="event_cont_box event_cont_box_v2">
		<dl class="evt_detail">
			<div class="evt_inner">
				<dd class="evt_title" id="eventTitle">
					<h2>
						<span>
							<c:if test="${eventList.eventKind eq 'I' }">[초대]</c:if>
							<c:if test="${eventList.eventKind eq 'E' }">[응모]</c:if>
						</span>
						<span>&lt;${eventList.eventTitle } &gt;</span>이벤트
					</h2>
				</dd>
			</div>

			<div class="rhr" style="background: gray;"></div>
			<!-- 선 -->
			<dd class="evt_date">
				<h6>
					<span>이벤트 기간 </span> <span><fmt:formatDate
							pattern="yyyy-MM-dd" value="${eventList.eventStartDate}" /> ~ <fmt:formatDate
							pattern="yyyy-MM-dd" value="${eventList.eventEndDate}" /></span>
				</h6>
				
			</dd>
			<div class="container-t">
				<h2 style="text-align: center; left: 30%;">
					<span>Showticket</span>과 <span>&lt;${eventList.eventTitle }&gt;</span>가
					<br /> 함께하는
					<c:if test="${eventList.eventKind eq 'I' }">[초대]</c:if>
					<c:if test="${eventList.eventKind eq 'E' }">[응모]</c:if>
					이벤트
				</h2>
			</div>
			<dd class="evt_cont">

				<div>
					<img src="${eventList.eventImg }" alt="" border="0">
					<div class="inner">
						<h6>
							<strong><span>&lt;${eventList.eventTitle }&gt; 에
									대한 기대평을 남겨주세요. </strong><br /> 기대평을 남겨주신 분 중, 추첨을 통해 총 10명의 회원님께 <br />

							&lt;${eventList.eventTitle }&gt; 공연 관람권을 드립니다. <br />
							<br /> *본 이벤트는 당사의 운영 정책에 따라 진행되며 <br /> 내부 사정에 의해 변경될 수 있습니다.
							<br />
							</span>
						</h6>

					</div>
					<div class="rhr" style="background: gray;"></div>
					<!-- 선 -->

					<div class="evt_content">
						<table>
							<tr>
								<th>상세 정보</th>
								<td>${eventList.eventTimeMen }</td>
							</tr>
							<tr>
								<th>이벤트 기간</th>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${eventList.eventStartDate}" /> ~ 
								<fmt:formatDate pattern="yyyy-MM-dd" value="${eventList.eventEndDate}" /></td>
							</tr>
							<tr>
								<th>당첨자 발표</th>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${eventList.announcementDate}" /></td>
							</tr>

						</table>

					</div>




				</div>
				<div id="btnbox" style="width: 65%;">
					<button type="button" class="btn btn-secondary btn-lg btn-block">공연 상세보기</button>
				</div>

			<c:if test="${!empty memberLoggedIn }">				

				<div id="comment-container" name="comment-container">
					<div class="comment-editor">

						<form name="commentInsertForm" id="commentInsertForm">
							<input type="hidden" name="eventNo" value="${eventList.eventNo}" />
							<input type="hidden" name="memberId" value="${memberLoggedIn.memberId }" /> 
							<input type="text" class="form-control" id="commentContent"
								name="commentContent" placeholder="내용을 입력하세요."> 
							<input type="button" id="rebtn" class="btn btn-primary btn-send" name="commentInsertBtn" value="댓글입력"  style="background-color: #8f01a3; border-color: white;" />
						</form>
					</div>
				</div>
			</c:if>	

<script>


</script>

				<div class="container" style="margin-left: 20%;">
					<div class="commentList"></div>
				</div>




<script>
$(document).ready(function(){
	console.log("클릭 클릭");
    commentList(); //페이지 로딩시 댓글 목록 출력 
    
});
var eventNo = '${eventList.eventNo}'; //게시글 번호
console.log(eventNo);
var memberLoggedId = '${memberLoggedIn.memberId}'; 
console.log(memberLoggedId);

//댓글 목록 
function commentList(){
  $.ajax({
      url : "${pageContext.request.contextPath}/event/list",
      type : 'get',
      data : {'eventNo':eventNo},
      success : function(data){
          var a =''; 
          $.each(data, function(key, value){ 
         
          	var s = new Date(value.commentDate).toLocaleDateString("ko-KR") ;
          	console.log(s);
          	if(memberLoggedId == value.memberId){
          		
              a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
              a += '<div class="commentInfo'+value.commentNo+'"><h7> 작성일:'+s+' / 작성자 : '+value.memberId+'</h7>';
              a += '<button class="comment-btn btn-primary" onclick="commentDelete('+value.commentNo+');"> 삭제 </button> </div>';
              a += '<div class="commentContent'+value.commentNo+'"> <h6> <span id="reple">▶</span>  '+value.commentContent +'</h6>';
              a += '</div></div>';
          	}else{
          		 a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                 a += '<div class="commentInfo'+value.commentNo+'"><h7> 작성일:'+s+' / 작성자 : '+value.memberId+'</h7> </div>';
                 a += '<div class="commentContent'+value.commentNo+'"> <h6> <span id="reple">▶</span>  '+value.commentContent +'</h6>';
                 a += '</div></div>';
          	}
          });
          
          $(".commentList").html(a);
      }
  });
}

//댓글 삭제
function commentDelete(commentNo){
	
	
    $.ajax({
        url : "${pageContext.request.contextPath}/event/delete/"+commentNo,
        type : 'post',
        success : function(data){
            if(data == 1) commentList(eventNo); //댓글 삭제후 목록 출력 
        }
    });
}
 




$("#rebtn").on("click", e => {
	var event = {}; 
	
	event.eventNo=${eventList.eventNo}; //게시글 번호
	event.memberId='${memberLoggedIn.memberId}';
	
	event.commentContent= $("[name=commentContent]").val();
	if(event.commentContent.length==0){
		alert("댓글을 입력해주세요!!"); 
		return;
	}
	
	
	//댓글 등록
	    $.ajax({
	        url : "${pageContext.request.contextPath}/event/eventCommentInsert",
	        type : 'POST',
	        data : JSON.stringify(event),
	        dataType: "json",
	        contentType: 'application/json; charset=utf-8',
	        success : (data)=>{
	        	
	            if(data == 1) {
	            	
	                $('[name=commentContent]').val('');
	            }
	        }
	    });
	    $(".form-control").val("");
	    commentList(); //댓글 작성 후 댓글 목록 reload
});




</script>
</body>

<style>
input.form-control {
	width: 80%;
	display: inline;
}

div#btnbox {
	margin-left: 18%;
	margin-top: 20px;
	padding-bottom: 20px;
}

dl.evt_detail>div.event_inner {
	position: absolute;
	background: #8f01a3;
	border-radius: 10px;
	width: 82px;
	height: 40px;
	left: 80%;
	top: 32px;
}

div.evt_content {
	height: 200px;
	margin-left: 20%;
	width: 443px;
}

div.evt_content table {
	font-family: 'Gothic A1', sans-serif;
	margin-left: 10%;
	margin-top: 5%;
	width: 443px;
}

div.evt_content table th, td {
	padding-bottom: 25px;
}

div.evt_content table th, td {
	font-size: 15px;
}

div.commentList {
	width: 470px;
}

input#rebtn {
	width: 94px;
	height: 36px;
	padding-right: 0px;
	padding-left: 0px;
}

dd.evt_date>h6>span {
	color: gray;
}

div#comment-container {
	margin-left: 20%;
	width: 493px;
	height: 60px;
}

div.comment-editor {
	width: 493px;
}

#boardCommentContent {
	margin-left: 3px;
}

button#detailView {
	margin-left: 40%;
	position: absolute;
	top: 87px;
	left: 300px;
}

h6 {
	font-family: 'Gothic A1', sans-serif;
}

input {
	font-family: 'Gothic A1', sans-serif;
}

body {
	font-family: 'Gothic A1', sans-serif;
}

.comment-btn{background:#8f01a3; border-radius: 3px; font-family: 'Gothic A1', sans-serif; }
div.commentArea{font-family: 'Gothic A1', sans-serif; font-size: 13px;}
h7{margin-right: 100px;}
h6>span#reple{color:#8f01a3;}
</style>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>