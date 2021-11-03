<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.kh.showticket.common.MusicalAndShow"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bookticket.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/ticketing.css" />
<style type="text/css">
nav-pills .nav-link {
	border-radius: 0;
}

.SeatT {
	background-color:white;
	width :60px; 
	height :10px; 
	font-size:7pt;	
	clear: left;
    float: left;
	padding:0 10 0 0;
}
.SeatR {
	background-color:whitesmoke;
	width:10px;
	height:10px;
	margin:1px;
    padding:0 0 0 0;
    display:inline-block;
}
.SeatB {
	background-color:white;
	width:10px;
	height:1px;
	margin:1px;
    padding:0 0 0 0;
    display:inline-block;
}
.SeatN {
	width:10px;
	height:10px;
	margin:1px;
    padding:0 0 0 0;
    display:inline-block;
	cursor:pointer;
}

.SeatN_Daegu {
	width:30px;
	height:30px;
	margin:3px;
	padding:0 0 0 0;
    display:inline-block;
	cursor:pointer;
}


</style>
<script>


function SelectSeat(me, SeatGrade, Floor, RowNo, SeatNo, Block, SeatGradeName){
	 if (typeof me == "string") {
		me = document.getElementById(me);
	} 
	
	if(me.style.display == 'none'){
	me.style.display = 'block';	
	}
	else{
	me.style.display = 'none';	
	}
	var seatCnt = 0;
	var seatTotal = document.getElementById("ImgSeatCount").value;
	var html = "<h5>선택좌석</h5><br>";
	for(i = 0; i < seatTotal ; i++){
	  	var sid = "SID"+i;
	  	sid = document.getElementById(sid);
	  	if(sid.style.display == 'block'){
			html += sid.previousElementSibling.getAttribute("title");
	  		html += "<br/>";

			seatCnt++;
	  	}
	}
	html += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;총"+seatCnt+"좌석";	
	$("#r_seat").html(html);


}

function next(){
	var cnt = 1;
	var seatTotal = document.getElementById("ImgSeatCount").value;
	for(i = 0; i < seatTotal ; i++){
	  	var sid = "SID"+i;
	  	sid = document.getElementById(sid);
	  	if(sid.style.display == 'block'){
 			$("#Seat"+cnt).attr('value', sid.previousElementSibling.getAttribute("title"));
 			cnt++;
	  	}
	  	if(cnt > 5){
	  		alert("4명까지 예매가능합니다.");
	  		return false;
	  	}
	}
	$("#next").submit();
}
</script>
<body>
	<table width="100%" height="100%" cellpadding="0" cellspacing="0" id="TmgsTable" name="TmgsTable">
<tr>
	<td align="center" valign="middle">

		<style> 
			.stySelectSeat
			{
				position:absolute;
				z-index:3;
				CURSOR:pointer;
				border:#ffffff 0px solid;
				background-repeat:no-repeat;
			}
			 
			.stySeat
			{
				position:absolute;
				z-index:2;
				CURSOR:pointer;
				border:#ffffff 0px solid;
				background-repeat:no-repeat;
			} 
				
			.stySeatBase
			{
				position:absolute;
				display:none2;
			} 
			
			.color_purple {
    		color: #8f01a3 !important;
			}
			ul, ol {
    		list-style: none;
			}
		</style> 
		
		
		${html }
	
</td>
</tr>
</table>
	<div id="seatgdimg">
		 <img id="seatSimg"
			src="${main }"
			alt="" /> 
	</div>
	<div id="seatgd">
		<h6>좌석 등급</h6>
		<div id="seatinner">
			<!-- 뮤지컬 가격 -->
			<% 
				MusicalAndShow musical = (MusicalAndShow) request.getAttribute("mas");
				String[] prices = musical.getPrice().split(", ");%>
									<c:forEach items="<%=prices%>" var="m">
										<li id="getGrade">${fn:substring(m,0,fn:indexOf(m,"석")+1)}-<span id="getPrice"
											class="color_purple fbold">${fn:substring(m,fn:indexOf(m,"석")+1,fn:indexOf(m,"원")) }</span>
											${fn:substring(m,fn:indexOf(m,"원"),fn:indexOf(m,"원")+1)}
										</li>
										<br />
									</c:forEach>
		
			<!-- <label for="vip" id="vip">VIP석</label> <label for="price"
				style="margin-left: 25px;">80,000원</label> <label for="seat"><span>10</span>석</label>
			<br /> <label for="r" id="r" style="padding-right: 16px;">R석</label>
			<label for="price" style="margin-left: 26px;">80,000원</label> <label
				for="seat"><span>10</span>석</label> <br /> <label for="s" id="s">S석</label>
			<label for="price" style="margin-left: 44px;">80,000원</label> <label
				for="seat"><span>10</span>석</label> <br /> <label for="e" id="e"
				style="padding-right: 18px;">일반석</label> <label for="price">50,000원</label>
			<label for="seat"><span>10</span>석</label> <br /> -->

		</div>

		<div id="r_seat">

		</div>
	
		
		<form name="nextFrm" action="${pageContext.request.contextPath}/ticketing/ticketingPoint.do" id="next" method="post">
			<input type="hidden" name="playId" value="${mas.id}" />
			<input type="hidden" name="selectDate" value="${selectDate}" />
			<input type="hidden" id="selectTime" name="selectTime" value="${selectTime}" />
			<input type="hidden" id="Seat1" name="seat" value="" />
			<input type="hidden" id="Seat2" name="seat" value="" />
			<input type="hidden" id="Seat3" name="seat" value="" />
			<input type="hidden" id="Seat4" name="seat" value="" />
			<input type="hidden" id="Seat5" name="seat" value="" />
			<!--  -->
		</form>
		<div class="t_btndiv">
			<input type="button" value="이전단계" class="t_button1"/> 
			<input type="button" value="다음단계" class="t_button2" onclick="next();"/>
		</div>


	</div>

</body>
<script>
$(()=>{
	
	var seatTotal = document.getElementById("ImgSeatCount").value;
	for(i = 0; i < seatTotal ; i++){
	  	var sid = "SID"+i;
	  	sid = document.getElementById(sid);
	  	var title = sid.previousElementSibling.getAttribute("title");
	/* 	if(title.indexOf("1층-B열-33") != -1){
			
	  		sid.previousElementSibling.style.display = "none";
		}
		if(title.indexOf("1층-B열-32") != -1){
			
		}
		if(title.indexOf("1층-B열-34") != -1){
			
		} */
		var list1 = new Array();
	  	<c:forEach items="${list}" var="m" >
		list1.push("${m.ticketSeat}");
		</c:forEach>
		for(var j = 0; j < list1.length; j++){
	 		if(title.indexOf(list1[j]) != -1){
	  		sid.previousElementSibling.style.display = "none";
	 		}
		}
	} 
});
	
	/* $("img").empty("[title=[R석] 1층-B열-31]");
	$("img").empty("[title=[R석] 1층-B열-32]");
	$("img").empty("[title=[R석] 1층-B열-33]");
	$("img").empty("[title=[R석] 1층-B열-34]"); */

	

</script>

