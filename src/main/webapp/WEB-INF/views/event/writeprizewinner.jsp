<%@page import="com.kh.showticket.event.model.vo.EventVO"%>
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
	href="${pageContext.request.contextPath}/resources/css/event.css">


<script>
$(()=>{

	$("input#chk_yn").click(function(){  //확인 버튼 클릭시 체크된 row의 값을 가져온다 
		var Data =new Array(); //(0,1)
		var rowData= new Array(); 
		var tdArr = new Array(); 
		var chkbox = $("input[name=chk_yn]:checked");
		
		chkbox.each(function(i){
			var tr =  chkbox.parent().parent().eq(i); 
			console.log("tr"+tr);
			var td = tr.children();  
 			
		
		 	Data.push(tr.eq(0));
		 	var id =td.eq(0).text();
		 	var name =td.eq(1).text();
		 	var phone =td.eq(2).text();
		 	var date =td.eq(3).text();
		 	var No = ${prize.eventNo };
			console.log("id>>"+id);
			console.log("name>>"+name);
			console.log("phone>>"+phone);
		
			
			tdArr.push(id);
			tdArr.push(name);
			tdArr.push(phone);
			tdArr.push(date);
			tdArr.push(No);
			rowData.push(tdArr);
			console.log(rowData);
			
			
		});
		console.log("tdARRR>>>>>>"+tdArr[1]);
		for(var i=0; i<Data.length; i++){
			var id = tdArr[0]; 
			var name = tdArr[1];
			var phone = tdArr[2];
			var eventNo =tdArr[4];
			
		$("th#name").html(name);
		$("th#phone").html(phone);
		$("th#eventNo").html(eventNo);
		
		 $('input#name').val(name);
		 $('input#phone').val(phone);
		 $('input#no').val(eventNo);
		}
		
		
		
	});
});


</script>

<div id="container" class="event_cont">
	<div class="inner">
		<h2 class="blind">이벤트</h2>

		<ul class="nav nav-pills nav-justified">
			<li class="nav-item"><a class="nav-link nav-font default"
				href="${pageContext.request.contextPath}/event/eventList.do">진행중인
					이벤트</a></li>
			<li class="nav-item"><a class="nav-link nav-font default"
				href="${pageContext.request.contextPath}/event/endEventList.do">종료된
					이벤트</a></li>
			<li class="nav-item"><a class="nav-link nav-font select"
				href="${pageContext.request.contextPath}/event/prizewinner.do">당첨자
					발표</a></li>
			<li class="nav-item"><a class="nav-link nav-font default"
				href="${pageContext.request.contextPath}/coupon/coupon.do">쿠폰</a></li>
		</ul>
		
		
		<c:if test="${empty wList}"> <div class="emt"><h2>참여한 고객이 없습니다.</h2> </div> </c:if>
		<c:if test = "${!empty wList}">
			<div class="eventFrm">
				<br />
				<h1 class="main-title" style="color:#8f01a3;">SHOW</h1><h1 class="main-title">티켓 이벤트 당첨자 발표 글쓰기</h1>
				<br /><br />
				<div id="memberList">
				<h2 class="small-title" style="margin-left:5%;">응모 회원 목록</h2>
					<br />
					<table id="memberTable">
						<tr>
							<th>회원 아이디</th>
							<th>회원명</th>
							<th>회원 전화번호</th>
							<th>응모 날짜</th>
							<th>선택</th>
						</tr>
					 	<c:forEach items="${wList }" var="w"> 
						<tr>
							<td>${w.memberList[0].memberId}</td>
							<td>${w.memberList[0].memberName}</td>
							<td>${w.memberList[0].phone}</td>
							<td>${w.commentDate }</td>
							<td><input type="radio" name="chk_yn" id="chk_yn"></td>
						</tr>
						</c:forEach> 
					 
					</table>
				</div>
				<br /><br />
			<h2 id="txt_st"><strong><span>SHOWTICKET</span>과 함께하는 이벤트 당첨자 발표</strong></h2>
			<form action="${pageContext.request.contextPath}/event/winnerprize.do">
			<div id="b-container"  style="overflow:scroll; width:800px; height:300px;">
				
				  <table id="tbl_info" style="border-radius: 10px;">
                        <caption>당첨자 정보</caption>
                        <colgroup>
                            <col style="width: 100px">
                            <col style="width: 100px">
                            <col style="width:100px">
                        </colgroup>
                  
                        <tr style="background:#D8D8D8; border-radius: 3px;">
                            <th scope="col">이벤트 번호</th>
                            <th scope="col">분류</th>
                            <th scope="col">제목</th>
                            <th scope="col">기간</th>
                        </tr>
                    
						<tr>
							<td>${prize.eventNo }</td>
							<td>
							<c:if test="${prize.eventKind eq 'I' }">[초대]</c:if>
							<c:if test="${prize.eventKind eq 'E' }">[응모]</c:if>
							</td>
							<td>${prize.eventTitle }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${prize.eventStartDate}" /> ~ 
								<fmt:formatDate pattern="yyyy-MM-dd" value="${prize.eventEndDate}" /></td>
						</tr>
				
					</table>
			
					<div id="content">
					
						안녕하세요. SHOW 티켓입니다.
						<br /><br /><br />
						<strong> &lt;${prize.eventTitle } &gt;
						<c:if test="${prize.eventKind eq 'I' }">[초대]</c:if>
						<c:if test="${prize.eventKind eq 'E' }">[응모]</c:if> 
						이벤트</strong>에 참여해주신 모든 분들께 진심으로 감사드립니다. <br />
						당첨되신 모든 분께 축하의 말씀 드리며,<br /> 안내되는 경품 수령에 대한 공지를 꼭! 확인 해주시기 바랍니다.
						 <br /><br /><br /><br />
						
						<h4><strong>1. 이벤트 내용</strong></h4>
					 	 ${prize.eventTimeMen } 
						<br /><br /><br />
					
						<h4><strong>2. 당첨 티켓 수령 방법</strong></h4>
						
						초대 관람 당일, 공연시작 30분전까지 공연장 매표소에 오셔서 <br />
						회원님의 성함과 아이디를 말씀하여 주시면 입장하실 수 있습니다. <br />
						본인 여부를 확인하여야 티켓을 배부할 수 있으므로, <br />
						반드시 신분증을 지참하고 오시기 바랍니다. <br />
						
						※ 초대티켓은 당첨회원 본인만 수령 가능하며, 양도 불가합니다.
						<br /><br /><br />
						<h4><strong>3. 당첨자 확인 * Ctrl + F로 검색하시면, 편리합니다.</strong></h4>
						
						<div id="pr">
							
								<table>
								<colgroup>
		                            <col style="width: 100px">
		                            <col style="width: 100px">
		                        </colgroup>
									<tr>
										<th scope="col" id="name"></th>
										<th scope="col" id="phone"></th>
									</tr>
										<input type="hidden" id="name" name="prizewinnerName" />
										<input type="hidden" id="phone" name="prizePhone"  />
										<input type="hidden" id="no" name="peventNo" value="${prize.eventNo }" />
								</table>
							
						</div>
						
							
					</div>
			
				</div>
				<button class="btn btn-secondary" type="submit" id="List">작성하기</button>
				</form>	
			</div>
		</c:if>
		
		<div id="forbutton">
			<button type="button" class="btn btn-secondary" id="List"
				onclick="location.href = '${pageContext.request.contextPath}/event/prizewinner.do' ">목록으로</button>
		</div>

	</div>
</div>


<style>
div.emt{text-align: center;margin-top: 10%; margin-bottom: 10%;}
div#b-container{border-radius: 10px;width: 80%;margin-left: 10%;height: 700px; border: 2px solid #8f01a3;margin-top: 2%; }
#txt_st{text-align: center;}
#txt_st>span{color:#8f01a3}
table#tbl_info{border-collapse: collapse;width: 100%;text-align: center;font-size: 17px;}
div#content{margin-left: 5%; margin-top: 3%; font-family: 'Gothic A1', sans-serif; font-size: 15px;font-weight: bold; }
h4 strong {color:#8f01a3;}
div.person{width: 100px;}
</style>




<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>