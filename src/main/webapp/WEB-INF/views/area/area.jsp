<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp" >
	<jsp:param value="" name="pageTitle" />
</jsp:include>

<script>
var cpage = 2;
var area = '';

$(()=>{

	$("ul > li > div").click((e)=>{

			$(".nav-pills .nav-link.select").attr('class', 'nav-link nav-font default');
			$(e.target).attr('class','nav-link select nav-font')

			
			cpage=1;
			
			area = $(e.target).html();

        	$(".title").html(area);

			getList(cpage);
			cpage++;

		
	});

	
});


$(window).scroll(function(){   //스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
     if($(window).scrollTop() > $(document).height() - $(window).height()-30){
          getList(cpage);
          cpage++;   
     } 
});
 
function getList(cpage){
	
	var url1="http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate=20190923&eddate=20191030&cpage="+cpage+"&rows=4&shcate=AAAA";
	var url2="http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate=20190923&eddate=20191030&cpage="+cpage+"&rows=4&shcate=AAAB";

	if(area=='서울'){
		url1+="&signgucode=11";
		url2+="&signgucode=11";
	}
	else if(area=='부산'){
		url1+="&signgucode=26";
		url2+="&signgucode=26";
	}
	else if(area=='대구'){
		url1+="&signgucode=27";
		url2+="&signgucode=27";
	}
	else if(area=='인천'){
		url1+="&signgucode=28";
		url2+="&signgucode=28";
	}
	else if(area=='광주'){
		url1+="&signgucode=29";
		url2+="&signgucode=29";
	}
	else if(area=='대전'){
		url1+="&signgucode=30";
		url2+="&signgucode=30";
	}
	else if(area=='울산'){
		url1+="&signgucode=31";
		url2+="&signgucode=31";
	}
	else if(area=='제주'){
		url1+="&signgucode=50";
		url2+="&signgucode=50";
	}
	
	var param = {url1 : url1, url2 : url2}
	
    $.ajax({
        url : '${pageContext.request.contextPath}/area/areaAjax.do',
        data : param,
        success : function(data) {

           var html = "";
            
           if (cpage==1){
                  $("#goods_list").html(""); 
            }
   
                if(data.length>0){
                	for(var i=0; i<data.length; i++){
	                	html+="<li><a href='http://www.ticketlink.co.kr/product/29767'>";
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
            
            if (cpage==1){
                $("#goods_list").html(html); 
            }else{
            	$("#goods_list").append(html); 
            }
       },error:function(e){
           if(e.status==300){
               alert("데이터를 가져오는데 실패하였습니다.");
           };
       }
    }); 
}






</script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/contents.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/area.css"/>

    <!-- container 시작 -->
    <div id="container" class="submain_front">
        <div class="inner submain_district">
            <h2 class="blind">공연</h2><!-- [D]  1 depth의 값을 h2로 뿌려줍니다 -->

			

<ul class="nav nav-pills nav-justified" style="margin-top: 30px; margin-bottom: 20px;">
	<li class="nav-item"><div class="nav-link select nav-font">전체</div></li>
	<li class="nav-item"><div class="nav-link default nav-font">서울</div></li>
	<li class="nav-item"><div class="nav-link default nav-font">부산</div></li>
	<li class="nav-item"><div class="nav-link default nav-font">대구</div></li>
	<li class="nav-item"><div class="nav-link default nav-font">인천</div></li>
	<li class="nav-item"><div class="nav-link default nav-font">광주</div></li>
	<li class="nav-item"><div class="nav-link default nav-font">대전</div></li>
	<li class="nav-item"><div class="nav-link default nav-font">울산</div></li>
	<li class="nav-item"><div class="nav-link default nav-font">제주</div></li>
</ul>
			
			<h2 class="title">전체</h2>
			
            <ul class="goods_list" id="goods_list">
               <c:forEach items="${concatList}" var="map">
	                <li><a href="http://www.ticketlink.co.kr/product/29767">
	                    <p><img src="${map.poster }" alt=""></p>
	                    <div class="list_info">
	                        <strong class="elp">${map.prfnm }</strong>
	                        <dl>
	                            <dt>기간</dt>
	                            <dd>${map.prfpdfrom } ~ ${map.prfpdto }</dd>
	                            <dt>장소</dt>
	                            <dd>${map.fcltynm }</dd>
	                        </dl>
	                    </div>
	                </a></li>
	               </c:forEach>   
            </ul>

        </div>
    </div>
    <!-- container 끝 -->

<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js"></script>
<noscript>
      <div style="display:inline;">
          <img height="1" width="1" style="border-style:none;" alt=""
               src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/950223509/?value=0&amp;guid=ON&amp;script=0"/>
      </div>
</noscript>
<script type="text/javascript">
		$("iframe[name='google_conversion_frame']").css("display", "none");
</script>

<script type="text/javascript">
	//<![CDATA[

/*	var page = 1;
	var itemPerPage = 50;
	var locationCode = document.URL.split("/local/")[1];
	var isEndOfItem = false;
	var isLoadingNow = false;

	$(document).ready(function () {
		$("#" + locationCode).css("display", "block");
		getLocationList(page++, locationCode, true);
				
		$(window).scroll(function () {
			if (!isLoadingNow) {
				var maxHeight = $(document).height();
				var currentScroll = $(window).scrollTop() + $(window).height();
				if (maxHeight <= currentScroll + 100) {
					if (!isEndOfItem) {
						isLoadingNow = true;
						getLocationList(page++, locationCode, false);
					}
				}
			}
		});	
		
	});
	
	function getLocationList (page, locationCode, isCleanProductList) {
		$.ajax({
			cache: false,
			dataType: "json",
			url: "/local/product.nhn",
			data: {
				page: page,
				locationCodeGroup: locationCode
			},
			success: function (result) {
				displayLocationItem(result.data.content, isCleanProductList);
				isLoadingNow = false;
			},
			error: function (status) {
				/* alert("오류가 발생했습니다. 관리자에게 문의하세요.");
				isLoadingNow = false;
			}
		});
	}

	function displayLocationItem (locationItemList, isCleanProductList) {
		var locationItemUl = $("#goods_list");
		//locationItemUl.html('');
		if (isCleanProductList) {
			locationItemUl.html('');
			isEndOfItem = false;
		}

		for (var i = 0; i < locationItemList.length; i++) {
			var level = "";
			var startDate = getDateFromFormat(locationItemList[i].startDate, 'yyyy.MM.dd');
			var endDate = getDateFromFormat(locationItemList[i].endDate, 'yyyy.MM.dd');
			var url = locationItemList[i].bridgeId == null ? "/product/" + locationItemList[i].productId : "/bridge/" + locationItemList[i].bridgeId;
			var displayName = locationItemList[i].productThumbName ? locationItemList[i].productThumbName : locationItemList[i].productName;

			var contents = "<li><a href='" + url + "'>";
			contents += getSpanTag(locationItemList[i]);
			contents += "<p><img src='" + locationItemList[i].productImagePath + "' alt='상품 썸네일'></p><div class='list_info'>";
			contents += "<strong class='elp'>" + displayName + "</strong>";
			contents += "<dl><dt>기간</dt><dd>" + startDate + " ~ " + endDate + "</dd><dt>장소</dt><dd>" + locationItemList[i].hallName + "</dd></dl>";
			contents += "</div></a></li>"
			locationItemUl.append(contents);
		}
		if (locationItemList.length == 0 && page == 2) {
			var contents = '<div class="no_data" style="display:block; top:25%;"><span>등록된 상품이 없습니다.</span></div>';
			locationItemUl.append(contents);
		}

		if (locationItemList.length != itemPerPage) {
			isEndOfItem = true;
		}

	}*/

	function getSpanTag (product) {
		if (product.solelySaleCode == "HIDE" && !product.productDiscountText) {
			return "";
		}

		var spanCss = product.productDiscountText ? "flag_vr sale" : "flag_vr level";
		var emCss = (product.productDiscountText && product.solelySaleCode != "HIDE") ? "flag_txt type2" : "flag_txt";
		var flagText = "";

		switch (product.solelySaleCode) {
			case "RELATIVE" :
				flagText += "상대우위";
				break;
			case "SOLELY" :
				flagText += "단독판매";
				break;
			case "ABSOLUTE" :
				flagText += "절대우위";
				break;
			case "CUSTOM" :
				flagText += product.customCodeValue;
				break;
		}

		if (emCss == "flag_txt type2") {
			flagText += "<br/>";
		}

		if (product.productDiscountText) {
			flagText += product.productDiscountText;
		}

		var spanTag = "<span class='" + spanCss + "'><em class='" + emCss + "'>" + flagText + "</em></span>";

		return spanTag;
	}

	// ]]>
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" ></jsp:include>
