<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Date"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/musical_show.css">
<script>
var cpage = 2;
var srchFlag = false;
var srchOFlag = false;

$(function(){
     getList(cpage);
     cpage++;
     
     $("#searchBtn").on("click", function(){
  		srchFlag = true;
  		srchOFlag = false;
  		cpage=2;
 		getSearchList(1);
 	});

});
 
$(window).scroll(function(){   //스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
     if($(window).scrollTop() > $(document).height() - $(window).height()-100){
    	 
    	 if(srchFlag==true){
    		 getSearchList(cpage);
	    	 cpage++;
    	 }
    	 else if(srchFlag==false){
	          getList(cpage);
	          cpage++;
    	 }
     } 
});

function getSearchList(cpage){

	var cate = $("#category-musical").val();
	var srchKeyword = $("#searchKeyword").val();
	var param= {
			cpage : cpage,
			cate : cate,
			srchKeyword : srchKeyword
	}
	   $.ajax({
	        url : '${pageContext.request.contextPath}/musical/musicalSearch.do',
	        data : param,
	        success : function(data) {
	            var html = "";
	       
	         	if(data.length==0 && srchOFlag == false){
	         		$("#musicalListAll").css("display", "none");
	         		$("#srchEmpty").css("display", "block");
	        		return;
	        	}
	       
	         	if(data.length>0){
	         		$("#musicalListAll").css("display", "block");
	         		$("#srchEmpty").css("display", "none");
	         		srchOFlag = true;
	         		
	         		
	            for(var i=0; i<data.length; i++){
	                		
		            html+="<li><a href='${pageContext.request.contextPath}/musical/musicalDetail.do?musicalId="+data[i].mt20id+"'>";
		            html+="<p><img src="+data[i].poster+" alt=''></p>";
		            html+="<div class='list_info'>";
		            html+="<strong class='elp'>"+data[i].prfnm+"</strong>";
		            html+="<dl>";
		            html+="<dt>기간</dt>";
		            html+="<dd>"+data[i].prfpdfrom+" ~ "+data[i].prfpdto+"</dd>";
		            html+="<dt>장소</dt>";
		            html+="<dd>"+data[i].fcltynm+"</dd>";
		            html+="</dl>";
		            html+="</div>";
		            html+="</a>";
		            html+="</li>";
	                	
	              }
	         	}
	            html = html.replace(/%20/gi, " ");
	            
	            if (cpage==1){  //페이지가 1이 아닐경우 데이터를 붙힌다.
	                $("#musicalListAll").html(html); 
	            }else{
	            	$("#musicalListAll").append(html);
	            }
	            
	       },error:function(e){
	           if(e.status==300){
	               alert("데이터를 가져오는데 실패하였습니다.");
	         	};
			}
	   });
	
};
 
function getList(cpage){
    $.ajax({
        url : '${pageContext.request.contextPath}/musical/musicalAjax.do',
        data : {"cpage" : cpage},
        success : function(data) {
        	
        	if(srchOFlag=false){
        		
        	}

            var html = "";
            
            if (cpage==1){ //페이지가 1일경우에만 id가 list인 html을 비운다.
                  $("#musicalListAll").html(""); 
            }
            
            
                if(data.length>0){
                	
                	srchOFlag = true;
                	
                	for(var i=0; i<data.length; i++){
                		
	                	html+="<li><a href='${pageContext.request.contextPath}/musical/musicalDetail.do?musicalId="+data[i].mt20id+"'>";
	                	html+="<p><img src="+data[i].poster+" alt=''></p>";
	                	html+="<div class='list_info'>";
	                	html+="<strong class='elp'>"+data[i].prfnm+"</strong>";
	                	html+="<dl>";
	                	html+="<dt>기간</dt>";
	                	html+="<dd>"+data[i].prfpdfrom+" ~ "+data[i].prfpdto+"</dd>";
	                	html+="<dt>장소</dt>";
	                	html+="<dd>"+data[i].fcltynm+"</dd>";
	                	html+="</dl>";
	                	html+="</div>";
	                	html+="</a>";
	                	html+="</li>";
                	}
                }
            
            html = html.replace(/%20/gi, " ");
            
            if (cpage==1){  //페이지가 1이 아닐경우 데이터를 붙힌다.
                $("#musicalListAll").html(html); 
            }else{
            	$("#musicalListAll").append(html); 
            }
       },error:function(e){
           if(e.status==300){
               alert("데이터를 가져오는데 실패하였습니다.");
           };
       	}
    }); 
};

</script>



<script type="text/javascript">
var index=0;
/* window.onload = function(){
	slideShow();
	$(".submain_topban").hover($(".arrow").css("visibility","visible"))
} */
function slideShow(){
	var i;
	var x = document.getElementsByClassName("mySlides");
	for(i=0; i<x.length;i++){
		x[i].style.display="none";
	}
	index++;
	if($("#prev").click()){
		index+1;
	}
	else if($("#next").click()){
		index-2;
	}
		
	if(index>x.length){
		index=1;
	}
	x[index-1].style.display = "block";
	setTimeout(slideShow,4000);
	
}
</script>
<script type="text/javascript">
window.onload = function(){
	$("#order-musical").change((e)=>{
		var type = $(e.target).val();
		if(type=='byRank'){

			getRankList();
		}
		else if(type=='byDate'){
			getDayIndex();
		}
	});
}
</script>
<script type="text/javascript">
function getDayIndex(){
	
	<c:set var="monthBefore" value="<%=new Date(new Date().getTime()-30*60*60*24*1000)%>"/>
	<fmt:formatDate value="${monthBefore}" pattern="yyyyMMdd" var="monthBefore"/>
	<c:set var="today" value="<%=new Date(new Date().getTime())%>"/>
	<fmt:formatDate value="${today}" pattern="yyyyMMdd" var="today"/>
	
	var url1 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate="+${monthBefore}+"&eddate="+${today}+"&shcate=AAAB&rows="+<%=Integer.MAX_VALUE%>+"&cpage=1";
	
	var param = {url1:url1}
	$.ajax({
		url : '${pageContext.request.contextPath}/musical/musicalNewAjax.do',
        data : param,
        success : function(data) {
        	
        	var html = "";
        	for(var i=0;i<data.length;i++){	
        	html += "<li><a href='${pageContext.request.contextPath}/musical/musicalDetail.do?musicalId="+data[i].mt20id+"'>";
        	html += "<p><img src='"+data[i].poster+"' </p>";
        	html += "<div class='list_info'>";
			html += "<strong class='elp'>"+data[i].prfnm+"</strong>";
			html += "<dl><dt>기간</dt><dd>"+data[i].prfpdfrom+"~"+data[i].prfpdto+"</dd>";
        	html += "<dt>장소</dt><dd>"+data[i].fcltynm+"</dd>";	
        	html += "</dl></div></a></li>";
        	}
        	
        	$("#musicalListAll").html(html);
        	
      	  }, error: function(jqxhr, textStatus, errorThrown){
            console.log(jqxhr, textStatus, errorThrown);
                alert("데이터를 가져오는데 실패하였습니다.");
                
        }
	});
}

</script>
<script type="text/javascript">
function getRankList(){
	
	<c:set var="yesterday" value="<%=new Date(new Date().getTime()-60*60*24*1000)%>"/>
	<fmt:formatDate value="${yesterday}" pattern="yyyyMMdd" var="yesterday"/>
	
	var url1 = "http://kopis.or.kr/openApi/restful/boxoffice?service=9f6a9651f5e648ac95d2cc7a210a4587&ststype=month&date="+${yesterday}+"&catecode=AAAB";

	var param = {url1:url1}
	
	$.ajax({
		url : '${pageContext.request.contextPath}/musical/musicalrankAjax.do',
        data : param,
        success : function(data) {
        	
        	var html = "";
        	for(var i=0;i<data.length;i++){	

        	html += "<li><a href='${pageContext.request.contextPath}/musical/musicalDetail.do?musicalId="+data[i].mt20id+"'>";
        	html += "<p><img src='http://www.kopis.or.kr/"+data[i].poster+"' </p>";
        	html += "<div class='list_info'>";
			html += "<strong class='elp'>"+data[i].prfnm+"</strong>";
			html += "<dl><dt>기간</dt><dd>"+data[i].prfpd+"</dd>";
        	html += "<dt>장소</dt><dd>"+data[i].prfplcnm+"</dd>";	
        	html += "</dl></div></a></li>";
        	}
        	
        	$("#musicalListAll").html(html);
        	
      	  }, error: function(jqxhr, textStatus, errorThrown){
            console.log(jqxhr, textStatus, errorThrown);
                alert("데이터를 가져오는데 실패하였습니다.");
                
        }
	});
}
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/newMS.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">
<style type="text/css">
span.dummy_bg.on {
	display: none
}

ul.lst_thumb li.on::before {
	position: absolute;
	top: -1px;
	left: -1px;
	right: -1px;
	bottom: -1px;
	border: 2px solid #40b409;
	content: ''
}
</style>


<div id="wrap" class="subwrap">

	<div id="container" class="submain_front">

		<div class="inner">
			<h2 class="blind">공연</h2>
			<!-- [D]  1 depth의 값을 h2로 뿌려줍니다 -->
			<div class="top_area"
				style="padding-bottom: 0px; margin-bottom: 39px;">
				<h2 class="title" style="margin-top: 39px; display: inline-block">베스트
					뮤지컬</h2>

				<div class="top_area">
					<div class="submain_topban">
						<div class="submain_goods" style="width: 990px; margin: auto;">
							<img class="mySlides"
								src="//image.toast.com/aaaaab/ticketlink/TKL_7/공연전시_메인_990x280_드라큘라.jpg"
								width="990" height="280"> <img class="mySlides"
								src="//image.toast.com/aaaaab/ticketlink/TKL_3/공연전시_메인_990x280_친정엄마_v3.jpg"
								width="990" height="280"> <img class="mySlides"
								src="//image.toast.com/aaaaab/ticketlink/TKL_7/공연전시_메인_990x280_사랑의가객_1.jpg"
								width="990" height="280"> <img class="mySlides"
								src="//image.toast.com/aaaaab/ticketlink/TKL_5/공연전시_메인_990x280_다윈영의-악의기원.jpg"
								width="990" height="280"> <img class="mySlides"
								src="//image.toast.com/aaaaab/ticketlink/TKL_7/공연전시_메인_990x280_에드거앨런포.jpg"
								width="990" height="280"> <img class="mySlides"
								src="//image.toast.com/aaaaab/ticketlink/TKL_3/공연전시_메인_990x280_정글라이프.jpg"
								width="990" height="280"> <img class="mySlides"
								src="//image.toast.com/aaaaab/ticketlink/TKL_7/공연전시_메인_990x280_NEW-달을품은슈퍼맨.jpg"
								width="990" height="280"> <img class="mySlides"
								src="//image.toast.com/aaaaab/ticketlink/TKL_3/공연전시_메인_990x280_시티오브엔젤.jpg"
								width="990" height="280">
						</div>
						<button class="arrow" id="prev">&lt;</button>
						<button class="arrow" id="next">&gt;</button>
					</div>
				</div>
			</div>

			<!-- [D] 전시메인의 경우 .exhibition 추가입니다. -->
			<div class="newMusical_wrap concert" style="margin-top: 0px;">
				<div class="header" style="margin-bottom: 4px;">
					<h2 class="small-title"
						style="margin-top: 0px; display: inline-block">최신 뮤지컬</h2>

				</div>
				<div class="attention">
					<ul style="width: 1880px">
						<!-- [D] li 1개 가로 사이즈 178+여백10=188 x li 갯수(10) = 1880px 인라인으로 박아줍니다. -->
						<c:forEach items="${recentMusicalList }" var="rList">
							<li class="newMusical_first"><a
								href="${pageContext.request.contextPath}/musical/musicalDetail.do?musicalId=${rList.mt20id }">
									<img src="${rList.poster }" alt="최신뮤지컬 포스터" />
									<div class="list_info" style="height: 50px; margin-left: 4px;">
										<!--제목-->
										<strong class="elp">${rList.prfnm }</strong>
										<!--기간-->
										<small>${rList.prfpdfrom } ~ ${rList.prfpdto }</small><br />
										<!--장소-->
										<small>${rList.fcltynm }</small>
									</div>
							</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>


			<div class="bottom_area">
				<div class="inner">
					<h2 class="title beforeSearch">전체 뮤지컬</h2>
					<div class="searchFrm">
						<select name="searchCategory" id="category-musical">
							<option value="searchAll">전체</option>
							<option value="searchTitle">제목</option>
							<option value="searchActor">배우</option>
						</select> <input type="text" class="form-control form-control-lg"
							id="searchKeyword">
						<button type="button" class="btn btn-primary btn-color btn-sm"
							id="searchBtn">검색</button>
					</div>


					<div class="orderWrap">
						<select name="selectOrder" id="order-musical">
							<option value="byRank" id="byRank">랭킹순</option>
							<option value="byDate" id="byDate">최신순</option>

						</select>
					</div>
				</div>

				<div class="searchContainer">
					<ul id="musicalListAll" class="goods_list" style="clear: both;">
						<c:forEach items="${musicalList}" var="map">
							<li><a
								href="${pageContext.request.contextPath}/musical/musicalDetail.do?musicalId=${map.mt20id}">
									<p>
										<img src="${map.poster }" alt="" />
									</p>
									<div class="list_info">
										<strong class="elp">${map.prfnm }</strong>
										<dl>
											<dt>기간</dt>
											<dd>${map.prfpdfrom }~ ${map.prfpdto }</dd>
											<dt>장소</dt>
											<dd>${map.fcltynm }</dd>
										</dl>
									</div>
							</a></li>
						</c:forEach>
					</ul>

					<div id="srchEmpty">
						검색결과가 없습니다.
						<div></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

		if ($("#noticeList").find("ul> li").length > 4) {
			$(function () {
				var $this = $("#noticeList");
				var scrollTimer;
				$this.hover(function () {
					clearInterval(scrollTimer);
				}, function () {
					scrollTimer = setInterval(function () {
						scrollNoticeList($this);
					}, 5000);
				}).trigger("mouseleave");

				function scrollNoticeList (obj) {
					var $self = obj.find("ul");
					var lineHeight = $self.find("li:first").height();
					$self.animate({
						"marginTop": -lineHeight + "px"
					}, 400, function () {
						$self.css({
							marginTop: 0
						}).find("li:first").appendTo($self);
					})
				}
			})
		}

		function toggleAttention (tabNumber) {
			if (tabNumber == 1) {
				$(".SHOW_ISSUE_V1_FIRST").css("display", "block");
				$(".SHOW_ISSUE_V1_SECOND").css("display", "none");
				$("#attention_tab_1").addClass("on");
				$("#attention_tab_2").removeClass("on");
			} else if (tabNumber == 2) {
				$(".SHOW_ISSUE_V1_FIRST").css("display", "none");
				$(".SHOW_ISSUE_V1_SECOND").css("display", "block");
				$("#attention_tab_1").removeClass("on");
				$("#attention_tab_2").addClass("on");
			}
		}

		$(".rankingItem").hover(function () {
			$(".rankingItem").removeClass("on");
			$(this).addClass("on");
			$(".rangkingImg").attr("src", $(this).data("url"));
			$(".rangkingImgLink").attr("href", "/product/" + $(this).data("productid"));
		});
    </script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>