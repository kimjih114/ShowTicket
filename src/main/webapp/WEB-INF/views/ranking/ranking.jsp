<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<%@ page import="java.util.Date"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/contents.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/area.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/ranking.css">
<script type="text/javascript">
var type='';
var day ='';

$(()=>{
	$(".nav-item > div").click((e)=>{
			$(".nav-pills .nav-link.select").attr('class', 'nav-link nav-font default')
											.attr('id','default');
			$(e.target).attr('class','nav-link select nav-font')
					   .attr('id','select');
			type = $(e.target).html();
			day = $("");
			getList();
			
	});
});

function getList(){
	
	<c:set var="yesterday" value="<%=new Date(new Date().getTime()-60*60*24*1000)%>"/>
	<fmt:formatDate value="${yesterday}" pattern="yyyyMMdd" var="yesterday"/>
	
	var url1 = "http://kopis.or.kr/openApi/restful/boxoffice?service=3127d89913494563a0e9684779988063&ststype=day&date="+${yesterday};

	if(type=='뮤지컬'){
		url1+="&catecode=AAAB";
	
	}
	else if(type=='연극'){
		url1+="&catecode=AAAA";
		
	}
	
	var param = {url1 : url1};
	
    $.ajax({
        url : '${pageContext.request.contextPath}/ranking/rankAjax.do',
        data : param,
        success : function(data) {
         			
        	var html = "";
           
                	for(var i=0; i<10; i++){
	                	html+="<tr class='show_list' id='show_list'>";
	                	html+="<td style='width: 65px'><span style='position: relative; top: -8px; color: black;'class='ranknum n1'>";
	                	html+=(i+1)+"</span> <input type='hidden'name='productId' value='28807'> <input type='hidden'name='saleStatus' value='ON_SALE'></td>";
	                	html+="<td class='img_box' style='width: 130px'><a class='detail_link' href='javascript:;'>";
	                	html+="<img src= 'http://www.kopis.or.kr/"+data[i].poster+"' width='100px' height='122px' alt='공연 포스터'>";
						html+="</a></td>";
	                	html+="<td style='width: 282px'><a class='detail_link' href='javascript:;'>"+data[i].prfnm+"</a></td>";
	                	html+="<td style='width: 80px; word-break: break-all;'>"+data[i].prfpd+"</td>";
	                	html+="<td style='width: 110px'>"+data[i].prfplcnm+"</td>";
	                	html+="<td><button type='button' class='btn btn-secondary' onclick=\"buttongo('"+data[i].mt20id+"');\">예매하기</button>";
						html+="</td></tr>";
                	}
            
                $("#showTable").html(html); 
            
       }, error: function(jqxhr, textStatus, errorThrown){
           console.log(jqxhr, textStatus, errorThrown);
               alert("데이터를 가져오는데 실패하였습니다.");
               
       }
    }); 
}
</script>
<script>
function buttongo(x){
	var type = $("#select").html();
	if(type=='뮤지컬'){
		location.href="${pageContext.request.contextPath}/musical/musicalDetail.do?musicalId="+x;
	}
	else if(type=='연극'){
		location.href="${pageContext.request.contextPath}/show/showDetail.do?showId="+x;
	}
}
</script>
<script type="text/javascript">
var day = '';
window.onload = function(){
	$(".onDate").click((e)=>{
		day = $(e.target).html();
		getDayList();
	});
}
function getDayList(){

	var type = $("#select").html();
	
	<c:set var="yesterday" value="<%=new Date(new Date().getTime()-60*60*24*1000)%>"/>
	<fmt:formatDate value="${yesterday}" pattern="yyyyMMdd" var="yesterday"/>
	
	var url1 = "http://kopis.or.kr/openApi/restful/boxoffice?service=3127d89913494563a0e9684779988063&date="+${yesterday};

	if(type=='뮤지컬'){
        if(day=='오늘'){
        url1+="&ststype=day&catecode=AAAB";
      	
        }
        else if(day=='주간'){
        url1+="&ststype=week&catecode=AAAB";
        
        }
        else if(day=='월간'){
        url1+="&ststype=month&catecode=AAAB";
        
        }
    }
    else if(type=='연극'){
        if(day=='오늘'){
        url1+="&catecode=AAAA&ststype=day";
      
        }
        else if(day=='주간'){
        url1+="&catecode=AAAA&ststype=week";
       
        }
        else if(day=='월간'){
        url1+="&catecode=AAAA&ststype=month";
       
        }
    }
    
	var param = {url1 : url1}
	
    $.ajax({
        url : '${pageContext.request.contextPath}/ranking/rankAjax.do',
        data : param,
        success : function(data) {
         			
        	var html = "";
           
                	for(var i=0; i<10; i++){
	                	html+="<tr class='show_list' id='show_list'>";
	                	html+="<td style='width: 65px'><span style='position: relative; top: -8px; color: black;'class='ranknum n1'>";
	                	html+=(i+1)+"</span> <input type='hidden'name='productId' value='28807'> <input type='hidden'name='saleStatus' value='ON_SALE'></td>";
	                	html+="<td class='img_box' style='width: 130px'><a class='detail_link' href='javascript:;'>";
	                	html+="<img src= 'http://www.kopis.or.kr/"+data[i].poster+"' width='100px' height='122px' alt='공연 포스터'>";
						html+="</a></td>";
	                	html+="<td style='width: 282px'><a class='detail_link' href='javascript:;'>"+data[i].prfnm+"</a></td>";
	                	html+="<td style='width: 80px; word-break: break-all;'>"+data[i].prfpd+"</td>";
	                	html+="<td style='width: 110px'>"+data[i].prfplcnm+"</td>";
	                	html+="<td><button type='button' class='btn btn-secondary' onclick=\"buttongo('"+data[i].mt20id+"');\">예매하기</button>";
						html+="</td></tr>";
                	}
            
                $("#showTable").html(html); 
            
       }, error: function(jqxhr, textStatus, errorThrown){
           console.log(jqxhr, textStatus, errorThrown);
               alert("데이터를 가져오는데 실패하였습니다.");
               
       }
    });
    
}


</script>
<%
	int i = 0;
%>
<div id="container" class="ranking_wrap" style ="padding-bottom:20px;margin-bottom:0px;">
	<div class="inner" style="padding-top: 0px;">
		<h2 class="blind">
			<span> 랭킹 </span>
		</h2>
		<!-- <ul class="rank_bx">
			<li><strong>집계기간</strong>
				<p>
					<span style="color: #4b12b5">2019년 09월 16일 (월) ~ 21:34 현재</span>
					(1시간 단위로 업데이트 됩니다) <br> 당일 오전의 경우 판매 비중이 낮으므로 오전 10:30 이전까지는
					전일 24시간의 집계 현황을 알려드립니다.
				</p></li>
			<li><strong>집계대상</strong>
				<p>
					<span class="color_black">티켓링크 인터넷예매, 모바일웹예매, 모바일앱예매, 전화예매</span>
					(결제 완료/예매 매수 기준)
				</p></li>
		</ul> -->

		<!-- 집계결과 컨텐츠 -->
		<div class="rank_con">

			<ul class="nav nav-pills nav-justified"
				style="margin-top: 30px; margin-bottom: 20px;">
				<li class="nav-item"><div class="nav-link select nav-font"
						id="select">뮤지컬</div></li>
				<li class="nav-item"><div class="nav-link default nav-font"
						id="default">연극</div></li>
			</ul>

			<div class="tabCon">
				<h3 class="blind">랭킹 집계 결과</h3>
				<!-- 집계결과 -->
				<div class="rslt_bx" style="padding-bottom:20px;">
					<!-- 버튼 -->
					<div class="btn_lst">
						<!-- [D] 활성화시 a에 .on 추가-->
						<a class="onDate" style="cursor: pointer"
							href="javascript:void(0);">오늘</a> <span class="bar">l</span> <a
							class="onDate" style="cursor: pointer" href="javascript:void(0);">주간</a>
						<span class="bar">l</span> <a class="onDate"
							style="cursor: pointer" href="javascript:void(0);">월간</a>
					</div>
					<!-- // 버튼 -->
					<!-- 랭킹 테이블 -->
					<div class="basic_tbl rank_tbl">
						<table>
							<caption>랭킹 집계 결과 목록</caption>

							<thead>
								<tr>
									<th
										style="width: 65px; padding-left: 10px; padding-right: 10px;">랭킹</th>
									<th style="width: 130px">포스터</th>
									<th style="width: 282px">공연명</th>
									<th style="width: 80px">기간</th>
									<th style="width: 110px">장소</th>
									<th style="width: 150px">예매하기</th>
								</tr>
							</thead>
							<tbody id="showTable">
								<!-- 여기 show_list -->
								<c:forEach items="${dayBoxList1}" var="map" begin="0" end="9">
									<tr class="show_list" id="show_list">
										<td style="width: 65px"><span
											style="position: relative; top: -8px; color: black;"
											class="ranknum n1"><%=++i%></span> <input type="hidden"
											name="productId" value="28807"> <input type="hidden"
											name="saleStatus" value="ON_SALE"></td>
										<td class="img_box" style="width: 130px"><a
											class="detail_link" href="javascript:;"> <img
												src="http://www.kopis.or.kr/${map.poster }" width="100px"
												height="122px" alt="공연 포스터">
										</a></td>
										<td style="width: 282px"><a class="detail_link"
											href="javascript:;">${map.prfnm }</a></td>
										<td style="width: 80px; word-break: break-all;">${map.prfpd }</td>
										<td style="width: 110px">${map.prfplcnm }</td>
										<td>
											<button type="button" class="btn btn-secondary"
												onclick="location.href = '${pageContext.request.contextPath}/musical/musicalDetail.do?musicalId=${map.mt20id}'">예매하기</button>
										</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>

					</div>

					<!-- //집계결과 -->
				</div>
				<!-- rslt_bxEND -->

			</div>
		</div>
	</div>
</div>
<!-- container -->




</body>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>