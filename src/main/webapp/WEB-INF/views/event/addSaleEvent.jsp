<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/event.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/addSale.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="특가입력" name="pageTitle" />
</jsp:include>
<style>
table#showList::-webkit-scrollbar-thumb {background-color:#8f01a3;background:#8f01a3;border-radius: 10px;}
#showList-box::-webkit-input-placeholder { text-align:right;pointer-events: none; }
input {border: none; }
#inputText{width:100px;    display: contents;}
.enrollText{width:190px;}
div.search{display: inline-block;  margin-bottom: 23px;}
div#showList-box{width:98%; height:200px; overflow:auto;}
h2.title{font-size: 20px; !important;}

</style>
<script>


$(()=>{
	$("input#chk_yn").click(function(){  //확인 버튼 클릭시 체크된 row의 값을 가져온다 
		var Data =new Array(); //(0,1)
		var rowData= new Array(); 
		var tdArr = new Array(); 
		var chkbox = $("input[name=chk_yn]:checked");
		
		chkbox.each(function(i){
			var tr =  chkbox.parent().parent().eq(i); 
			
			var td = tr.children();  
 			
		
		 	Data.push(tr.eq(0));
		 	var img =td.eq(0).text();
			var showId = td.eq(1).text(); 
			var genre = td.eq(2).text(); 
			var showName = td.eq(3).text(); 
			var startDate = td.eq(4).text(); 
			var endDate = td.eq(5).text(); 
			var status = td.eq(6).text(); 
			var dicaYN = td.eq(7).text();  //할인 유무
		
			tdArr.push(img);
			tdArr.push(showId); 
			tdArr.push(genre);
			tdArr.push(showName);
			tdArr.push(startDate);
			tdArr.push(endDate);
			tdArr.push(status);
			tdArr.push(dicaYN);
			
			rowData.push(tdArr);
			
			
		});
		for(var i=0; i<Data.length; i++){
		var html=""; 
		

		var contain= "<h2 class='title'>특가할인</h2><br/><div class='search'><form action='${pageContext.request.contextPath}/event/insertAddSale.do'>";
		contain+="<img id='photo' src='"+tdArr[0]+"'width='100px' height='122px'>"; 
		contain +="<table class='ListTable' id='detail' style='position:relative;'>";
		contain+="<tr><th id='service'>공연아이디</th>";
		contain+="<th id='genre'>종류</th>"; 
		contain+="<th id='title'>공연명</th>"; 
		contain+="<th id='start'>공연 시작일</th>";
		contain+="<th id='finish'>공연 종료일</th>";
		contain+="<th>공연 상태</th>";
		contain+="</tr>";
			
		contain+="<tr>";
		contain+="<td id='showId' >"+tdArr[1]+"</td>";
		contain+="<td id='showGenre' >"+tdArr[2]+"</td>";
		contain+="<td id='showName'>"+tdArr[3]+"</td>";
		contain+="<td id='showStart'> "+tdArr[4]+"</td>";
		contain+="<td id='showEnd' >"+tdArr[5]+"</td>";
		contain+="<td id='sale_yn' >"+tdArr[6]+"</td>";
		contain+="</tr>";
		contain+="<input type='hidden' name='disCountImg' value='"+tdArr[0]+"' />"
		contain+="<input type='hidden' name='showId' value='"+tdArr[1]+"' />"
		contain+="<input type='hidden' name='showGenre' value='"+tdArr[2]+"' />"
		contain+="<input type='hidden' name='showName' value='"+tdArr[3]+"' />"
		contain+="</table><br/><br/><br/>";
		contain+="<div id='enroll'><h2 class='small-title'>할인률</h2>"; 
		contain+="<input type='number' class='enrollText' name='disCountRate' placeholder='%'><br/><h2 class='small-title'>할인기간</h2>";
		contain+="<input type='date' class='enrollText' name='disCountStartDate' ><h2 id='inputText'>~</h2><input type='date' name='disCountEndDate' class='enrollText' >";
		contain+="</div><button type='submit' class='btn btn-secondary' id='changebutton'>작성완료</button>";
		contain+="</div><button type='button' class='btn btn-secondary' id='goList' onclick=\"goList();\">목록으로</button>";
		contain+="</form></div>";
																					
		html+=contain;
		$("div#searchC").html(html);
		}
		
		
		
	});
});


function goList(){
	location.href="${pageContext.request.contextPath}/event/eventList.do";
}
</script>

<style>

</style>

<div id="container" class="event_cont">
	<div class="inner" style="width:970px;">

		<h2 class="title scrolltbody">공연목록</h2>
		
		
		<table class="ListTable" style="width:932px;" border="0" >
		<tr>
			<th>공연 ID</th>
			<th>종류</th>
			<th>공연명</th>
			<th>공연시작일</th>
			<th>공연종료일</th>
			<th>공연유무</th>
			<th>할인선택</th>
		</tr>
		</table>
		<div id="showList-box">

		<c:if test="${empty evt }"><h4>공연리스트가 없습니다.</h4></c:if>
		<c:if test="${!empty evt }"> 
			<table class="ListTable scrolltable" id="showList" width="100%" border="0" cellspacing="0" cellpadding="0">
				<c:forEach items="${evt }" var="evt">
					<c:if test="${evt.prfstate eq '공연중'}">
						<tr>
							<td style="display: none;">${evt.poster }</td>
							<td>${evt.mt20id }</td>
							<td>${evt.genrenm}</td>
							<td>${evt.prfnm}</td>
							<td>${evt.prfpdfrom}</td>
							<td>${evt.prfpdto}</td>
							<td>${evt.prfstate}</td>
							<td><input type="radio" name="chk_yn" id="chk_yn"></td>
						</tr>
					</c:if>
				</c:forEach>
				
				
			</table>
		</c:if>	
		</div>
		
		
		
		
		<div id="searchC" ></div>
		
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>