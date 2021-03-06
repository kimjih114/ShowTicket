<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/member.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle" />
</jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>	
<script>
$(()=>{
	
	$("#btn1").click(function() {
		$(this).siblings().removeClass("r_btnSelect").addClass("r_btnDefault");
		$(this).removeClass("r_btnDefault").addClass("r_btnSelect");
		getReservation(100);
	});
	$("#btn2").click(function() {
		$(this).siblings().removeClass("r_btnSelect").addClass("r_btnDefault");
		$(this).removeClass("r_btnDefault").addClass("r_btnSelect");
		getReservation(15);
	});
	$("#btn3").click(function() {
		$(this).siblings().removeClass("r_btnSelect").addClass("r_btnDefault");
		$(this).removeClass("r_btnDefault").addClass("r_btnSelect");
		getReservation(1);
	});
	$("#btn4").click(function() {
		$(this).siblings().removeClass("r_btnSelect").addClass("r_btnDefault");
		$(this).removeClass("r_btnDefault").addClass("r_btnSelect");
		getReservation(2);
	});
	$("#btn5").click(function() {
		$(this).siblings().removeClass("r_btnSelect").addClass("r_btnDefault");
		$(this).removeClass("r_btnDefault").addClass("r_btnSelect");
		getReservation(3);
	});
	
	var a = 0;
	var barNo = 0;
	var next = 0;
	function getReservation(num) {			
	var promise = $.ajax({
			type: "POST",
			async: false,
			url: "${pageContext.request.contextPath}/member/reservationTermAjax.do",
			dataType: "json",
			cache: false,
			data: {
				num: num,
				cPage: barNo
			},
			success: function(data) {
								
				var html = "";
				var list = data.reservationList;
				var status = "";
				
				var page = "";
				var totalPage = data.totalPage;//?????????????????? ??????????????? ?????????
				
				var barNo = data.barNo;
				var barEnd = data.barEnd;
				var cPage = data.cPage;
				var s = data.barStart;
				console.log("?????? totalPage????",totalPage);
				console.log("?????? ???????????? ?????? ?????? barNo????",barNo);
				console.log("?????? ???????????? ????????? ??????????",barEnd);
				console.log("cPage????",cPage);
				
				console.log(data);
				
				html += "<tr>";
				html += "<th id='num'>????????????</th>";
				html += "<th colspan='2'>?????????</th>";
				html += "<th id='date'>?????????</th>";
				html += "<th id='date'>????????????</th>";
				html += "<th id='count'>??????</th>";
				html += "<th id='Cancledate'>???????????????</th>";
				html += "<th id='state'>??????</th>";
				html += "</tr>";
				
				for(var i=0; i<list.length; i++){
					//console.log(list[i].ticketNo);
					status = list[i].ticketStatus.trim();

					html += "<tr>";
					html += "<td>"+list[i].ticketNo+"</td>";
					html += "<td>"+list[i].ticketShowName+"</td>";
					if($.trim(status) == 'Y'){
						html += "<td>";
						html += "<button type='button' class='cancelBtn_' onclick='goCancel("+list[i].ticketNo+");'>????????????</button>";
						html += "</td>";
					}
					else if($.trim(status) != "Y"){
						html += "<td></td>";
					}
					html += "<td>"+list[i].ticketEnrollDate+"</td>";
					html += "<td>"+list[i].ticketDate+"</td>";
					html += "<td>"+list[i].ticketCount+"</td>";
					html += "<td>"+list[i].ticketCancel+"</td>";
					if($.trim(status) == "Y"){
						html += "<td>????????????</td>";						
					}
					else if($.trim(status) != "Y"){
						html += "<td>????????????</td>";
					}
					html += "</tr>";
				}			
					
				/* ???????????? ?????? */
				page += "<ul class='pagination justify-content-center font_size'>";
				if(barNo == 1){
					page += "<li class='page-item disabled'>";
					page += "<a class='page-link' style='background-color: #F2F2F2; border: 0px;'>&lt;</a>";
					page += "</li>";
				}
				else{
					page += "<li class='page-item'>";
					page += "<a class='page-link' href='${pageContext.request.contextPath }/member/reservationTermAjax.do?cPage="+(barNo-1)+"' style='background-color: #F2F2F2; border: 0px;'>&lt;</a>";
					page += "</li>";
				}
				page += "</li>";
				if(!(barNo > barEnd || barNo > totalPage)){
					for(var a=barNo; a==barEnd; a++){
						if(barNo == cPage){
							page += "<li class='page-item disabled'>";
							page += "<a class='page-link' style='color: black; border: 0px;'>"+barNo+"</a>";
							page += "</li>";
						}
						else if(barNo != s && cPage == totalPage){
							page += "<li class='page-item disabled'>";
							page += "<a class='page-link' href='${pageContext.request.contextPath }/member/reservationTermAjax.do?cPage="+barNo+"' style='color: gray; border: 0px;'>"+barNo+"</a>";
							page += "</li>";
						}
						else{
							page += "<li class='page-item'>";
							page += "<a class='page-link' href='${pageContext.request.contextPath }/member/reservationTermAjax.do?cPage="+barNo+"' style='color: gray; border: 0px;'>"+barNo+"</a>";
							page += "</li>";
						}
						next = barNo+1;
					}
				}
				if(barNo > totalPage || cPage == totalPage){
					page += "<li class='page-item disabled'>";
					page += "<a class='page-link' style='background-color: #F2F2F2; border: 0px;'>&gt;</a>";
					page += "</li>";
				}
				else if(barEnd > totalPage){
					page += "<li class='page-item disabled'>";
					page += "<a class='page-link' href='${pageContext.request.contextPath }/member/reservationTermAjax.do?cPage="+next+"' style='background-color: #F2F2F2; border: 0px;'>&gt;</a>";
					page += "</li>";
				}
				else if(!(barNo > totalPage || cPage == totalPage)){
					page += "<li class='page-item'>";
					page += "<a class='page-link' href='${pageContext.request.contextPath }/member/reservationTermAjax.do?cPage="+next+"' style='background-color: #F2F2F2; border: 0px;'>&gt;</a>";
					page += "</li>";
				}
				page += "</ul>";
					
				console.log("??????!!!!!"+list);
				
				$("#ListTable").html(html);
				//$("#page").html(page);
			},
			error: function(data) {
				console.log("????????????"+data);
				alert("ajax ????????????");
			}
		});
		promise.done(successFunction);
		promise.fail(failFunction);
		
		function successFunction(data){
				console.log("???????????????",data);
				cPage = data.barNo
				return cPage;			
		}
	
		function failFunction(data){
			console.log("???????????????",data);
			var a = "???????????? fail";		
			return alert(a);
		}
	
	};

		
});

</script>


<script type="text/javascript">

//????????? ??????
function sendAlarm(ticketNo) {
	sock.send(ticketNo);
}
</script>

<form class="cancel" action="${pageContext.request.contextPath }/member/reservationCancel.do" method="post"></form>
<script>
function goCancel(ticketNo) {
	var cancelTNo = ticketNo;
	//console.log("????????? ????????????",cancelTNo);
	
	if(confirm("????????? ?????????????????????????")){
		sendAlarm(ticketNo);	
		$(".cancel").append("<input type='hidden' name='cancelTNo' value='"+cancelTNo+"'/>").submit();
	}
	else{
		return;
	}
}

</script>

<div id="container">
	<jsp:include page="/WEB-INF/views/common/memberViewnav.jsp">
		<jsp:param value="?????? ?????????" name="pageTitle" />
	</jsp:include>
	<br>
	<div class="div-memberFrm">
		<h2 class="small-title">?????? ??????/??????</h2>
		<div id="reservation">
			<hr />
			<br />
			<div id="search">
				<label id="dateSearch">?????????</label>&nbsp;
				<div class="btn-group">
					<button id="btn1" class="r_btnSelect">??????</button>
					<button id="btn2" class="r_btnDefault">15???</button>
					<button id="btn3" class="r_btnDefault">1??????</button>
					<button id="btn4" class="r_btnDefault">2??????</button>
					<button id="btn5" class="r_btnDefault">3??????</button>
				</div>
			</div>

			<br /> <br /> <br />
			<table id="ListTable" style="margin: auto;">
				<tr>
					<th id="num">????????????</th>
					<th colspan="2">?????????</th>
					<th id="date">?????????</th>
					<th id="date">????????????</th>
					<th id="count">??????</th>
					<th id="Cancledate">???????????????</th>
					<th id="state">??????</th>
				</tr>
				<c:forEach items="${list }" var="list">
					<tr>
						<c:set var="status" value="${list.ticketStatus }"/>
						<td>${list.ticketNo }</td>
						<td>${list.ticketShowName }</td>
						<c:choose>
							<c:when test="${status eq 'Y'}">
								<td>
									<button type="button" class="cancelBtn_" onclick="goCancel(${list.ticketNo});">????????????</button>
								</td>
							</c:when>
							<c:when test="${status eq 'N'}">
								<td></td>								
							</c:when>
						</c:choose>
						<td>${list.ticketEnrollDate }</td>
						<td>${list.ticketDate }</td>
						<td>${list.ticketCount }</td>
						<td>${list.ticketCancel }</td>
						<c:choose>
							<c:when test="${status eq 'Y'}">
								<td>????????????</td>								
							</c:when>
							<c:when test="${status eq 'N'}">
								<td>????????????</td>								
							</c:when>
						</c:choose>
					</tr>
				</c:forEach>
			</table>
			<br />
			
			<!-- ????????????  -->
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
							<a class="page-link" href="${pageContext.request.contextPath }/member/reservation.do?cPage=${barNo-1}" style="background-color: #F2F2F2; border: 0px;">&lt;</a>
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
										<a class="page-link" href="${pageContext.request.contextPath }/member/reservation.do?cPage=${barNo}" style="color: gray; border: 0px;">${barNo }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="page-item">
										<a class="page-link" href="${pageContext.request.contextPath }/member/reservation.do?cPage=${barNo}" style="color: gray; border: 0px;">${barNo }</a>
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
								<a class="page-link" href="${pageContext.request.contextPath }/member/reservation.do?cPage=${next}" style="background-color: #F2F2F2; border: 0px;">&gt;</a>
							</li>
						</c:when>
						<c:when test="${!(barNo>totalPage || cPage eq totalPage) }">
							<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath }/member/reservation.do?cPage=${next}" style="background-color: #F2F2F2; border: 0px;">&gt;</a>
							</li>
						</c:when>
					</c:choose>
				</ul>
			</nav>
			<br />
			
			<div id="info">
				<h6>
					<img alt=""
						src="${pageContext.request.contextPath}/resources/images/info.png">
					???????????? ??????
				</h6>
				<br />
				<ul>
					<li>????????? ?????? ?????? ?????? ?????? ???????????? ?????? ??? ?????? ????????? ???????????????.</li>
					<li>?????? ?????? ???????????? ???????????? ????????? ?????????????????? ????????????, ?????????????????? ???????????? ????????????. ??? ?????????
						???????????? ???????????? ?????????????????? ???????????? ?????????, ?????????????????? ????????? ?????? ???????????????.</li>
					<li>????????? ??????/??????/?????? ??????/?????? ?????? ????????? ???????????????. ????????? ????????? ????????? ?????? ???????????????
						??????????????????.</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
