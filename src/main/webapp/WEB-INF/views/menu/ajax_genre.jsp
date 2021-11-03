<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/musical_show.css">

<script type="text/javascript">lcs_do(); </script>
<script type="text/javascript">
	// ë¤ì´ë² íë¦¬ë¯¸ì ë¡ê·¸ (201704 ì¶ê°)
	if (!wcs_add) var wcs_add = {};
	wcs_add["wa"] = "s_765d50fa49a";
	if (!_nasa) var _nasa = {};
	wcs.inflow();
	wcs_do(_nasa);

	// ë¤ì´ë² ë¡ê·¸ (ê¸°ì¡´ë¶í° ì¡´ì¬)
	if (!wcs_add) var wcs_add = {};
	wcs_add["wa"] = "3ce26ce585ae64";
	wcs_do();
</script>

<script type="text/javascript" src="/resources/js/lcslog.js"></script>
<script type="text/javascript">lcs_do(); </script>
<!-- AceCounter Log Gathering Script V.7.5.2013010701 -->
<script language='javascript'>
	var _AceGID = (function () {
		var Inf = ['gtc9.acecounter.com', '8080', 'BS2A39876863068', 'AW', '0', 'NaPm,Ncisy', 'ALL', '0'];
		var _CI = (!_AceGID) ? [] : _AceGID.val;
		var _N = 0;
		var _T = new Image(0, 0);
		if (_CI.join('.').indexOf(Inf[3]) < 0) {
			_T.src = (location.protocol == "https:" ? "https://" + Inf[0] : "http://" + Inf[0] + ":" + Inf[1]) + '/?cookie';
			_CI.push(Inf);
			_N = _CI.length;
		}
		return {o: _N, val: _CI};
	})();
	var _AceCounter = (function () {
		var G = _AceGID;
		var _sc = document.createElement('script');
		var _sm = document.getElementsByTagName('script')[0];
		if (G.o != 0) {
			var _A = G.val[G.o - 1];
			var _G = (_A[0]).substr(0, _A[0].indexOf('.'));
			var _C = (_A[7] != '0') ? (_A[2]) : _A[3];
			var _U = (_A[5]).replace(/\,/g, '_');
			_sc.src = (location.protocol.indexOf('http') == 0 ? location.protocol : 'http:') + '//cr.acecounter.com/Web/AceCounter_' + _C + '.js?gc=' + _A[2] + '&py=' + _A[4] + '&gd=' + _G + '&gp=' + _A[1] + '&up=' + _U + '&rd=' + (new Date().getTime());
			_sm.parentNode.insertBefore(_sc, _sm);
			return _sc.src;
		}
	})();
</script>
<!-- *) AceClick ê³µíµ ë¶ìì¤í¬ë¦½í¸ -->
<script language='javascript' type='text/javascript'>
	if (document.cookie.indexOf('VIEW_TKLINK_ID') > 0) {
		var mr_id = 'member';	// ë¡ê·¸ì¸ íìíë¨( 'member' ê³ ì ê°)
	}
</script>
<!-- AceClick WebSite Gathering Script V0.91.20190304-->
<script type="text/Javascript">
	if (typeof (AMRS_GC) == 'undefined') {
		var AMRS_O = [];
		var AMRS_CK = new Image();
		var AMRS_GC = 'AG5A4302491053';
		var AMRS_GD = 'mrsg.aceclick.co.kr';
		var AMRS_GP = '8080';
		var AMRS_TI = (new Date()).getTime();
		var AMRS_PR = location.protocol == "https:" ? "https://" + AMRS_GD + ":843" : "http://" + AMRS_GD + ":" + AMRS_GP;
		AMRS_CK.src = AMRS_PR + '/?cookie';
		if (typeof (Array.prototype.push) != 'undefined') {
			AMRS_O.push(AMRS_CK);
		}
		var _AMSC = document.createElement('script');
		var _AMSM = document.getElementsByTagName('script')[0];
		_AMSC.src = (location.protocol.indexOf('http') == 0 ? location.protocol : 'http:') + '//cr.acecounter.com/aceclick.js?rt=' + AMRS_TI;
		_AMSM.parentNode.insertBefore(_AMSC, _AMSM);
	}
</script>
<!-- AceClick WebSite Gathering Script End V0.91.20190304 -->
<noscript><img src='http://gtc9.acecounter.com:8080/?uid=BS2A39876863068&je=n&' border='0' width='0' height='0' alt=''></noscript>

<!-- AceCounter Log Gathering Script End -->


<!-- Facebook Pixel Code -->
<script>
	!function (f, b, e, v, n, t, s) {
		if (f.fbq) return;
		n = f.fbq = function () {
			n.callMethod ?
				n.callMethod.apply(n, arguments) : n.queue.push(arguments)
		};
		if (!f._fbq) f._fbq = n;
		n.push = n;
		n.loaded = !0;
		n.version = '2.0';
		n.queue = [];
		t = b.createElement(e);
		t.async = !0;
		t.src = v;
		s = b.getElementsByTagName(e)[0];
		s.parentNode.insertBefore(t, s)
	}(window,
		document, 'script', '//connect.facebook.net/en_US/fbevents.js');

	fbq('init', '1028038810619064');
	fbq('track', "PageView");
</script>
<noscript>
<img height="1" width="1" style="display:none"
               src="https://www.facebook.com/tr?id=1028038810619064&ev=PageView&noscript=1"/>
</noscript>
<!-- End Facebook Pixel Code -->

<!-- NHN AD MORE Script -->
<script>
	var _croID = '5d148869e4b0adaa9beaa9d1';

	function getMoreRecommend (e, n) {
		"undefined" != typeof globalCRO ? new globalCRO.MoreRecommendData(e, n) :
			("undefined" == typeof gCroRCData && (window.gCroRCData = new Array), gCroRCData.push({config: e, callback: n}))
	}

	function createMoreRCView (e) {
		"undefined" != typeof globalCRO ? new globalCRO.MoreRecommendView(e) :
			("undefined" == typeof gCroRCV && (window.gCroRCV = new Array), gCroRCV.push({config: e}))
	}

	function mcroPushEvent (n) {
		"undefined" != typeof globalCRO ? globalCRO.sendEvent(n) :
			("undefined" == typeof gCro && (window.gCro = new Array), gCro.push(n))
	}

	function _cro_initialize () {
		window.globalCRO = new MCro, globalCRO.jsInit(_croID)
	}
</script>
<script async type="text/javascript" src="//cro.myshp.us/resources/common/js/more-common.js"></script>
<!-- AceCounter Log Gathering Script V.7.5.2013010701 -->

<!-- *) AceClick ê³µíµ ë¶ìì¤í¬ë¦½í¸ -->

<!-- AceClick WebSite Gathering Script V0.91.20190304-->

<!-- AceClick WebSite Gathering Script End V0.91.20190304 -->
<!-- AceCounter Log Gathering Script End -->


<!-- Facebook Pixel Code -->


<!-- End Facebook Pixel Code -->

<!-- NHN AD MORE Script -->

<!-- End NHN AD MORE Script -->

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

</head>

<body>
<div id="wrap" class="subwrap">
        
    <div id="container" class="submain_front">

<div class="inner">
    
    <ul id="genreNav" class="nav nav-pills nav-justified">
			<li class="nav-item"><a class="nav-link select nav-font" href="#">전체</a>
			</li>
			<li class="nav-item"><a class="nav-link nav-font default" href="#">로맨틱</a></li>
			<li class="nav-item"><a class="nav-link nav-font default" href="#">코미디</a></li>
			<li class="nav-item"><a class="nav-link nav-font default" href="#">드라마</a>
			</li>
			<li class="nav-item"><a class="nav-link nav-font default" href="#">스릴러</a>
			</li>
		</ul>
    
    <div class="top_area" style="padding-bottom:0px; margin-bottom:39px;">
    <h2 class="title" style="margin-top:39px; display:inline-block">연극>장르명</h2>
        <div class="suggest_wrap">
            <h3 class="suggest sgst_consert">추천공연</h3>
            <ul class="goods_list">
                
                    <li><a href="http://www.ticketlink.co.kr/product/30128">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_8/again_postser0917.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">연극 한번더해요</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2019.09.07 ~ 2019.11.30</dd>
                                <dt>장소</dt>
                                <dd>동양예술극장 3관</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/23802">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_7/bhc-post-0122.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">발칙한 로맨스</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2018.04.25 ~ 2019.09.30</dd>
                                <dt>장소</dt>
                                <dd>대학로 JTN 아트홀 2관</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/30120">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_1/class_main.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">연극 〈수업〉</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2019.10.09 ~ 2019.10.20</dd>
                                <dt>장소</dt>
                                <dd>대학로 노을소극장 </dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/29579">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_6/a_main0814.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">아몬드</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2019.09.19 ~ 2019.09.25</dd>
                                <dt>장소</dt>
                                <dd>세종문화회관 S씨어터</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/29663">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_9/sado_0808.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">천사들이 들려주는 사도요한</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2019.08.22 ~ 2019.09.29</dd>
                                <dt>장소</dt>
                                <dd>랑씨어터</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/29910">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_5/MAIN0828.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">더 가이즈 - 서울</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2019.10.03 ~ 2019.10.30</dd>
                                <dt>장소</dt>
                                <dd>대학로 한성아트홀 2관</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/29395">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_2/The-Audience_poster0725.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp"><디 오디언스></strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2019.09.26 ~ 2019.09.29</dd>
                                <dt>장소</dt>
                                <dd>국립극장 달오름극장</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/28463">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_6/poster(190525).jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">연애하기좋은날-대구</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2018.11.30 ~ 2019.09.30</dd>
                                <dt>장소</dt>
                                <dd>하모니아아트홀 1관</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/27176">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_7/dpst_0619.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">달콤한 의뢰인</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2019.02.23 ~ 2019.09.30</dd>
                                <dt>장소</dt>
                                <dd>대학로 아티스탄홀</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/29981">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_4/main(5).jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">내 모든걸 - 청주 </strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2019.10.02 ~ 2019.12.31</dd>
                                <dt>장소</dt>
                                <dd>메가폴리스 아트홀</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/29465">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_2/190710_[19-20]티저포스터_춘풍이온다(티켓링크).jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">춘풍이 온다</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2019.12.12 ~ 2020.01.26</dd>
                                <dt>장소</dt>
                                <dd>국립극장 달오름극장</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/22855">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_2/lucpst_0302.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">코미디 연극〈럭키〉</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2018.03.06 ~ 2019.09.29</dd>
                                <dt>장소</dt>
                                <dd>대학로 단막극장</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/22925">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_2/sapst_0516.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">〈사춘기메들리〉</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2018.03.10 ~ 2019.09.30</dd>
                                <dt>장소</dt>
                                <dd>대학로 아티스탄홀</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/25633">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_6/h_main1017.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">연극 하트 시그널</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2018.10.20 ~ 2019.09.30</dd>
                                <dt>장소</dt>
                                <dd>대학로 스타시티 타이니앨리스( 구 아트홀 마리카2관)</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/bridge/359">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_4/taxi_main_0214.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">택시안에서 - 서울/부산</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2018.10.12 ~ 2019.06.30</dd>
                                <dt>장소</dt>
                                <dd>해바라기 소극장(구, 훈아트홀)/부산 해바라기 소극장</dd>
                            </dl>
                        </div>
                    </a></li>
                
                    <li><a href="http://www.ticketlink.co.kr/product/29659">

                        
                            
                        

                        

                        <p><img src="//image.toast.com/aaaaab/ticketlink/TKL_10/holmes_0808.jpg" alt=""></p>
                        <div class="list_info">
                            <strong class="elp">연극 셜록홈즈 - 대구</strong>
                            <dl>
                                <dt>기간</dt>
                                <dd>2019.08.28 ~ 2019.10.06</dd>
                                <dt>장소</dt>
                                <dd>대구문화예술전용극장 CT</dd>
                            </dl>
                        </div>
                    </a></li>
                
            </ul>
        </div>
<script type="text/javascript" src="/resources/js/date.js"></script>
<script type="text/javascript">
	//<![CDATA[

	var page = 1;
	var categoryNum = 10;
	var itemPerPage = 30;
	var isEndOfItem = false;
	var isLoadingNow = false;

	$(document).ready(function () {
		switch (document.URL.split("/concert/")[1]) {
			case "main" :
				categoryNum = 10;
				$("#concertListDiv").text("전체");
				isEndOfItem = true;
				break;
			case "musical" :
				categoryNum = 16;
				$("#concertListDiv").text("뮤지컬");
				break;
			case "theater" :
				categoryNum = 15;
				$("#concertListDiv").text("연극");
				break;
			case "concert" :
				categoryNum = 14;
				$("#concertListDiv").text("콘서트");
				break;
			case "classic" :
				categoryNum = 18;
				$("#concertListDiv").text("클래식/무용");
				break;
			case "daehakro" :
				categoryNum = 84;
				$("#concertListDiv").text("대학로");
				break;
			case "family" :
				categoryNum = 85;
				$("#concertListDiv").text("아동/가족");
				break;
		}
		switch (document.URL.split("/preview/")[1]) {
			case "main" :
				categoryNum = 10;
				$("#concertListDiv").text("전체");
				isEndOfItem = true;
				break;
			case "musical" :
				categoryNum = 16;
				$("#concertListDiv").text("뮤지컬");
				break;
			case "theater" :
				categoryNum = 15;
				$("#concertListDiv").text("연극");
				break;
			case "concert" :
				categoryNum = 14;
				$("#concertListDiv").text("콘서트");
				break;
			case "classic" :
				categoryNum = 18;
				$("#concertListDiv").text("클래식/무용");
				break;
			case "daehakro" :
				categoryNum = 84;
				$("#concertListDiv").text("대학로");
				break;
			case "family" :
				categoryNum = 85;
				$("#concertListDiv").text("아동/가족");
				break;
		}
		switch (document.URL.split("/exhibition/")[1]) {
			case "family" :
				categoryNum = 85;
				$("#concertListDiv").text("아동/가족");
				break;
		}

		if (!isEndOfItem) {
			getConcertList(page++, categoryNum, true);
			$(window).scroll(function () {
				if (!isLoadingNow) {
					var maxHeight = $(document).height();
					var currentScroll = $(window).scrollTop() + $(window).height();
					if (maxHeight <= currentScroll + 100) {
						if (!isEndOfItem) {
							isLoadingNow = true;
							getConcertList(page++, categoryNum, false);
						}
					}
				}
			});
		}
	});

	function getConcertList (page, varCategoryNum, isCleanProductList) {
		categoryNum = varCategoryNum;
		$.ajax({
			dataType: "json",
			async: "false",
			url: "/concert/getConcertList",
			data: {
				page: page,
				categoryId: categoryNum,
				frontExposureYn: 'Y'
			},
			success: function (result) {
				if (result.result == null) {
					alert("오류가 발생했습니다. 관리자에게 문의하세요.");
					isLoadingNow = false;
					return;
				}
				toggleDiv(categoryNum);
				displayConcert(result.result.result, categoryNum, isCleanProductList, isCleanProductList);
				isLoadingNow = false;
			},
			error: function (status) {
				/* alert("오류가 발생했습니다. 관리자에게 문의하세요."); */
				isLoadingNow = false;
			}
		});
	}

	function toggleDiv (categoryNum) {
		if (categoryNum == 14 || categoryNum == 15 || categoryNum == 16 || categoryNum == 18 || categoryNum == 84 || categoryNum == 85) {
			$(".genre_main").css("display", "block");
			$("#d2_main").css("display", "inline-block");
			$("#d2_path").css("display", "none");
			$(".bottom_area").css("background", "#dadad9");
		} else {
			$(".genre_main").css("display", "none");
			$("#d2_main").css("display", "none");
			$("#d2_path").css("display", "block");
			$(".bottom_area").css("background", "#F4F4F4");
			$("#d2_path").css("padding-top", "0px");
		}
	}

	function displayConcert (concertList, categoryNum, isCleanProductList) {
		var concertItemUl = $("#goodsList");

		$(".depth3 li").removeClass("on");
		$("#" + categoryNum).addClass("on");
		$(".lastCategoryName").text($("#" + categoryNum + " a").text());

		if (isCleanProductList) {
			concertItemUl.html('');
			isEndOfItem = false;
		}
		for (var i = 0; i < concertList.length; i++) {
			var startDate = getDateFromFormat(concertList[i].startDate, 'yyyy.MM.dd');
			var endDate = getDateFromFormat(concertList[i].endDate, 'yyyy.MM.dd');
			var url = concertList[i].bridgeId == null ? "/product/" + concertList[i].productId : "/bridge/" + concertList[i].bridgeId;
			var displayName = concertList[i].productThumbName ? concertList[i].productThumbName : concertList[i].productName;

			var contents = "<li><a href='" + url + "'>";
			contents += getSpanTag(concertList[i]);
			contents += "<p><img src='" + concertList[i].productImagePath + "' alt='상품 썸네일'></p><div class='list_info'>";
			contents += "<strong class='elp'>" + displayName + "</strong>";
			contents += "<dl><dt>기간</dt><dd>" + startDate + " ~ " + endDate + "</dd><dt>장소</dt><dd>" + concertList[i].hallName + "</dd></dl>";
			contents += "</div></a></li>"
			concertItemUl.append(contents);
		}

		if (concertList.length == 0 && page == 2) {
			var contents = "<li>등록된 상품이 없습니다.</li>";
			concertItemUl.append(contents);
		}

		if (concertList.length != itemPerPage) {
			isEndOfItem = true;
		}
	}

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

	//]]>
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>