<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.kh.showticket.common.MusicalAndShow"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>





<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/musical_showdetail.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<!-- <script src="/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script> -->
<!--지도api  -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=90fa5b9d28b260d5191bb13ef4764b06"></script>
<!--  <link rel="stylesheet" type="text/css"
						href="http://ticketlink.dn.toastoven.net/web/pcweb/markup_resources/201506191200/jindoStarRating/css/star.css">  -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/demo.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/star-rating-svg.css">
<script type="text/javascript" charset="utf-8"
	src="${pageContext.request.contextPath}/resources/js/jquery.star-rating-svg.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

<%

	/*-------------------------------희수 코딩 영역--------------------------------*/
	MusicalAndShow show = (MusicalAndShow) request.getAttribute("show");
			System.out.println("urls:"+show.getUrls());
			System.out.println("show"+show);

	String[] times = show.getTime().split(", ");
	Map<String, List<String>> dayTime = new HashMap<>();
	Map<String, Integer> days = new HashMap<>();
	days.put("월", 0);
	days.put("화", 1);
	days.put("수", 2);
	days.put("목", 3);
	days.put("금", 4);
	days.put("토", 5);
	days.put("일", 6);
	String[] d = { "월", "화", "수", "목", "금", "토", "일"};
	for (String s : times) {
		System.out.println(s);
		String time = s.substring(s.indexOf("(") + 1, s.indexOf(")"));
		String[] ts = time.split(",");
		System.out.println(time);
		if (s.contains("~")) {
			String day1 = s.substring(s.indexOf("요일") - 1, s.indexOf("요일"));
			String day2 = s.substring(s.lastIndexOf("요일") - 1, s.lastIndexOf("요일"));
			System.out.println(day1);
			System.out.println(day2);
			for (int i = days.get(day1); i <= days.get(day2); i++) {
				System.out.println(i);
				/* for (int j = 0; j < ts.length; j++) {
					System.out.println(d[i]);
					System.out.println(ts[j]);
					dayTime.put(d[i], ts[j]);
				} */
				dayTime.put(d[i], Arrays.asList(ts));
			}
		} else {
			String day1 = "";
			if (s.contains("HOL")) {
				day1 = "HOL";
			} else {
				day1 = s.substring(s.indexOf("요일") - 1, s.indexOf("요일"));
			}
			/* for (int i = 0; i < ts.length; i++) {
				System.out.println(day1);
				System.out.println(ts[i]);
				dayTime.put(day1, ts[i]);
			} */
			dayTime.put(day1, Arrays.asList(ts));
		}
	}
	
	Object[] str = dayTime.keySet().toArray();
	String[] day = { "일", "월", "화", "수", "목", "금", "토"};
	String st = "";
	for(Object s:str){
		System.out.println((String)s);
		st += (String)s;		
	}

	List<Integer> list = new ArrayList<>();
	for(int i=0;i<day.length;i++){
		if(!st.contains(day[i])){
			list.add(i);	
		}
	}
	/*-------------------------------희수 코딩 영역--------------------------------*/
%>


<script language='javascript'>
/*--------------------------석현씨 코딩영역-----------------------------  */	

$(()=>{
	$("#review-star").starRating({
	    initialRating: ${show.getReviewStar()},
	    readOnly: true,
	    starSize: 15,
	  });
	
	 $(".tabs-Num").css("display","none");
	
	$("#tabs-3").css("display","block");
	
	$(document.body).delegate('#reportReview', 'click', function(e) {
		MemberCommonCheck();
		var reviewNo = $(e.target).parents("li").children("input[id='reviewNo']").val();
		var receiveId = $(e.target).parents("li").children("input[id='reviewWriter']").val();
		insertReport(reviewNo, receiveId);
	});
	/* 좋아요 */
	$(document.body).delegate('#checkLikes', 'click', function(e) {
		MemberCommonCheck();
		var likes = {};
		likes.reviewNo = $(e.target).parents("li").children("input[id='reviewNo']").val();
		likes.likesId = "${memberLoggedIn.memberId}";
		
		 $.ajax({
			url: "${pageContext.request.contextPath}/review/reviewLikes.do",
			data: JSON.stringify(likes),
			contentType: 'application/json; charset=utf-8',
			dataType: "json",
			type: "POST",
			success: (data)=>{
				var total = JSON.parse(data);
				var html = "<i class='far fa-thumbs-up'></i>  ";
				html += total;
				$(e.target).parents("li").children("#checkLikes").html(html);
			},
			error: (xhr, txtStatus, err)=>{
				console.log("ajax처리실패!",xhr, txtStatus, err);
			}
			
		}); 
	});
	
	
	
	/* 리뷰삭제 */
	$(document.body).delegate('#dReview', 'click', function(e) {
		if(!confirm("정말 삭제하시겠습니까?")){
			return false;
		}
		var review = {};
		
		var reviewNo = $(e.target).parents("li").children("input[id='reviewNo']").val();
		review.reviewNo = reviewNo;
		$.ajax({
			url: '${pageContext.request.contextPath}/review/deleteReview.do',
			data: JSON.stringify(review),
			contentType: 'application/json; charset=utf-8',
			dataType: "json",
			type: "DELETE",
			success: (data)=>{
				alert("삭제되었습니다.");
				reviewList();
			},
			error: (xhr, txtStatus, err)=>{
				console.log("ajax처리실패!",xhr, txtStatus, err);
			}
			
		});
		
	});
	
})



/*--------------------------석현씨 코딩영역-----------------------------  */		

    var _JV = "AMZ2013010701";//script Version
    var _UD = 'undefined';
    var _UN = 'unknown';
    function _IDV (a) {
        return (typeof a != _UD) ? 1 : 0
    }
    var _CRL = 'http://' + 'gtc9.acecounter.com:8080/';
    var _GCD = 'BS2A39876863068';
    if (document.URL.substring(0, 8) == 'https://') {
        _CRL = 'https://gtc9.acecounter.com/logecgather/';
    }
    ;
    if (!_IDV(_A_i)) var _A_i = new Image();
    if (!_IDV(_A_i0)) var _A_i0 = new Image();
    if (!_IDV(_A_i1)) var _A_i1 = new Image();
    if (!_IDV(_A_i2)) var _A_i2 = new Image();
    if (!_IDV(_A_i3)) var _A_i3 = new Image();
    if (!_IDV(_A_i4)) var _A_i4 = new Image();
    function _RP (s, m) {
        if (typeof s == 'string') {
            if (m == 1) {
                return s.replace(/[#&^@,]/g, '');
            } else {
                return s.replace(/[#&^@]/g, '');
            }
        } else {
            return s;
        }
    }
    ;
    function _RPS (a, b, c) {
        var d = a.indexOf(b), e = b.length > 0 ? c.length : 1;
        while (a && d >= 0) {
            a = a.substring(0, d) + c + a.substring(d + b.length);
            d = a.indexOf(b, d + e);
        }
        return a
    }
    ;
    function AEC_F_D (pd, md, cnum)	 {
        var i = 0, amt = 0, num = 0;
        var cat = '', nm = '';
        num = cnum;
        md = md.toLowerCase();
        if (md == 'b' || md == 'i' || md == 'o') {
            for (i = 0; i < _A_pl.length; i++) {
                if (_A_nl[i] == '' || _A_nl[i] == 0)_A_nl[i] = '1';
                if (num == 0 || num == '')num = '1';
                if (_A_pl[i] == pd) {
                    nm = _RP(_A_pn[i]);
                    amt = (parseInt(_RP(_A_amt[i], 1)) / parseInt(_RP(_A_nl[i], 1))) * num;
                    cat = _RP(_A_ct[i]);
                    var _A_cart = _CRL + '?cuid=' + _GCD;
                    _A_cart += '&md=' + md + '&ll=' + _RPS(escape(cat + '@' + nm + '@' + amt + '@' + num + '^&'), '+', '%2B');
                    break;
                }
                ;
            }
            ;
            if (_A_cart.length > 0)_A_i.src = _A_cart + "rn=" + String(new Date().getTime());
            setTimeout("", 2000);
        }
        ;
    }
    ;
    if (!_IDV(_A_pl)) var _A_pl = Array(1);
    if (!_IDV(_A_nl)) var _A_nl = Array(1);
    if (!_IDV(_A_ct)) var _A_ct = Array(1);
    if (!_IDV(_A_pn)) var _A_pn = Array(1);
    if (!_IDV(_A_amt)) var _A_amt = Array(1);
    if (!_IDV(_pd)) var _pd = '';
    if (!_IDV(_ct)) var _ct = '';
    if (!_IDV(_amt)) var _amt = '';
</script>
<!-- Function and Variables Definition Block End-->

<!-- Data Allocation (Product_Detail) -->
<script language='javascript'>
    _pd = _RP("뮤지컬 <사랑했어요> (사랑의 가객 故김현식 뮤지컬) ");
    _ct = _RP("창작뮤지컬");
    _amt = _RP("0", 1); // _RP(1)-> price

    _A_amt = Array('0');
    _A_nl = Array('1');
    _A_pl = Array('29652');
    _A_pn = Array('뮤지컬 <사랑했어요> (사랑의 가객 故김현식 뮤지컬) ');
    _A_ct = Array('99');
</script>



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
<noscript>
	<img src='http://gtc9.acecounter.com:8080/?uid=BS2A39876863068&je=n&'
		border='0' width='0' height='0' alt=''>
</noscript>

<!-- AceCounter Log Gathering Script End -->

<script>
	
	

	try {
		var evt_data = {};
		evt_data.evt = "view"; // 고정
		evt_data.p_no = "29652"; // 상품코드
		evt_data.p_name = "뮤지컬 <사랑했어요> (사랑의 가객 故김현식 뮤지컬) "; // 상품명
		evt_data.thumb = "http://image.toast.com/aaaaab/ticketlink/TKL_6/SPST_0905.jpg"; // 상품이미지 url
		evt_data.p_url = "http://www.ticketlink.co.kr/product/29652"; // 해당 상품페이지 url
		evt_data.p_url_m = "http://m.ticketlink.co.kr/product/29652"; // 해당 상품페이지 모바일 url
		evt_data.startdate = "20190920"; // 공연시작일
		evt_data.enddate = "20191027"; // 공연종료일
		evt_data.sale_startdate = "20190807"; // 예매오픈일
		evt_data.place = "성남아트센터 오페라하우스"; // 공연장소
		evt_data.view_grade = "만7세이상"; // 관람등급
		evt_data.city = "경기"; // 공연지역
		evt_data.price = "60000"; // 상품판매가격(숫자만 포함한 문자열)
		evt_data.price_table = "A석:60000|S석:90000|R석:120000|VIP석:140000"; // 좌석별 가격표 (가격오름차순, 가격은 숫자만 포함한 문자열)
		evt_data.soldout = "0"; // 품절여부. (품절이 아닐경우 '0', 품절일 경우 '1')
		evt_data.cate1 = '공연'; // 카테고리 대분류. 존재하지 않으면 ''
		evt_data.cate2 = '뮤지컬'; // 카테고리 중분류. 존재하지 않으면 ''
		evt_data.cate3 = ''; // 카테고리 소분류. 존재하지 않으면 ''

		mcroPushEvent(evt_data);
	} catch
		(e) {
	}
</script>


<meta property="og:type" content="website" />
<meta property="og:title" content="[티켓링크]뮤지컬 <사랑했어요> (사랑의 가객 故김현식 뮤지컬) " />
<meta property="og:url"
	content="http://www.ticketlink.co.kr/product/29652" />
<meta property="og:description" content="뮤지컬 <사랑했어요> (사랑의 가객 故김현식 뮤지컬) " />
<meta property="og:image"
	content="//image.toast.com/aaaaab/ticketlink/TKL_6/SPST_0905.jpg" />

</head>



<script>
	var meta = document.createElement('meta');
	meta.setAttribute('name', 'more_page_type');
	meta.setAttribute('content', 'detail');
	document.getElementsByTagName('head')[0].appendChild(meta);
</script>


<div id="detailContainer">

	<div class="inner">
		<h2 class="blind">공연</h2>
		<!-- [D]  1 depth의 값을 h2로 뿌려줍니다 -->
		<h3 class="blind">뮤지컬</h3>
		<!-- [D]  2 depth의 값을 h3로 뿌려줍니다 -->
		<p class="location_path"></p>

		<div class="detail_box_top ">
			<form name="ticketingFrm" method="post" enctype="multipart/form-data">
				<div class="bx_title">
					<!-- [D] 제목이 길어져서 태그가 아래로 떨어질 경우 : .title에 long_case 클래스 추가 -->
					<div class="title">연극&lt;${show.getName()}&gt;</div>
				</div>
				<div class="detail_info">
					<div class="bx_thumb">
						<span class="bx_img"> <!-- 뮤지컬포스터 --> <img
							src="${show.getPoster()}" alt="대표이미지" width="314" height="382">
						</span>
					</div>
					<div class="etc_info">
						<div class="bx_dummy">
							<em class="info_tit">별점</em> <span class="txt"><span
								id="review-star"></span></span>
						</div>
						<div class="bx_dummy">
							<em class="info_tit">장소</em> <span class="txt">${show.getHallName()}</span>
						</div>
						<div class="bx_dummy">
							<em class="info_tit">기간</em> <span class="txt">${show.getStartDate()}
								~ ${show.getEndDate()}</span>
						</div>
						<div class="bx_dummy">
							<em class="info_tit">관람시간</em> <span class="txt">${show.getRuntime() }</span>
						</div>
						<div class="bx_dummy border_type">
							<em class="info_tit">관람등급</em> <span class="txt">${show.getAge() }</span>
						</div>
						<!-- [D] 레이어 들어간 유형 : include_layer 클래스 추가 -->
						<div class="bx_dummy include_layer">
							<em class="info_tit">가격</em>
							<div class="txt ui-dialog  price-dialog">
								<ul class="lst_dsc">
									<%
									String[] prices = show.getPrice().split(", ");
								%>
									<c:forEach items="<%=prices%>" var="m">
										<li>${fn:substring(m,0,fn:indexOf(m,"석")+1)}-<span
											class="color_purple fbold">${fn:substring(m,fn:indexOf(m,"석")+1,fn:indexOf(m,"원")) }</span>
											${fn:substring(m,fn:indexOf(m,"원"),fn:indexOf(m,"원")+1)}
										</li>
										<br />
									</c:forEach>
								</ul>

								<!-- [D] 활성화 시 display:block 처리 -->

							</div>
						</div>
						<div class="bx_dummy include_layer border_type">
							<em class="info_tit">할인</em>
							<div class="txt ui-dialog  price-dialog">
								<ul class="lst_dsc">
									<c:forEach items="${coupon}" var="c">
										<li>${c.couponTitle }- <span class="color_purple fbold ">${c.couponPrice }</span>원
											할인
										</li>
									</c:forEach>
									<c:if test="${discount != 0}">
										<li><span class="color_purple fbold ">${discount }</span>% 할인중</li>
									</c:if>
								</ul>
							</div>
						</div>
						<div class="bx_dummy">
							<em class="info_tit">대기공연추가</em> <span class="txt"> <span
								id="wait"><img
									src="${pageContext.request.contextPath }/resources/images/heart.png"
									alt="" width=15px; /></span>
							</span>
						</div>
					</div>
				</div>
				<!-- FE 지원 form 시작 -->
				<c:if test="${show.getState() eq '공연중'}">
					<div class="detail_info_right">
						<div id="calendar"></div>

						<dl class="dotline_x">
							<dt>예매가능 회차</dt>
							<dd>
								<!-- [D] 셀렉트박스 -->
								<select name="watchTime" id="watchTime">
									<option>회차선택(날짜선택후)</option>
								</select>
							</dd>
						</dl>

						<button type="button" class="btn reserve s_after first-child"
							id="book">
							<span>예매하기 </span>
						</button>
					</div>
				</c:if>
				<c:if test="${show.getState() eq '공연예정'}">
					<div class="detail_info_right">
						<div class="noinfo_txt">티켓 오픈일은 공지사항을 참고해주세요.</div>

						<button type="button" class="btn reserve due s_after first-child"
							onclick="">
							<span>판매예정 </span>
						</button>
					</div>
				</c:if>
				<c:if test="${show.getState() eq '공연완료'}">
					<div class="detail_info_right">
						<div class="noinfo_txt">공연이 종료되었습니다.</div>

						<button type="button" class="btn reserve due s_after first-child"
							onclick="">
							<span>공연완료</span>
						</button>
					</div>
				</c:if>
			</form>
			<!-- FE 지원 form 종료 -->
		</div>
		<!-- 배너영역 -->

		<!-- 하단 탭 출력 -->


		<div class="detail_box_bot">
			<div class="detailbox_bot_left" id="tabs">
				<ul class="detail_tab">
					<li class="on">
						<div onclick="selectTap(this);" id="detailTop" class="btn_menu">
							상세정보</div>
					</li>

					<li id="productTabs2">
						<div class="btn_menu" id="reviewTap" onclick="selectTap(this);">
							관람후기</div>
					</li>


					<li>
						<div id="placeTap" onclick="selectTap(this);" class="btn_menu">
							공연장정보</div>
					</li>

					<li>
						<div onclick="selectTap(this);" id="cancelTap" class="btn_menu">
							티켓수령 취소/환불</div>
					</li>
				</ul>
				<div class="tabs-Num" id="tabs-1">
				
					<div class="detail_cont">
						
							<strong>[공연장 정보]</strong><br />
							장소 : ${show.hallName }<br> 주소 : ${address.adres }<br>
								대표번호 : <span id="phoneNumber">${address.telno }</span><br> <br /> <br /> <br />							
 								<div id="map" style="clear:both; width:800px;height:400px;position: relative;
    												overflow: visible;margin-left:66px;"></div>
					</div>


				</div>

				<div class="tabs-Num" id="tabs-2">

		
					<div class="detail_cont detail_cont_v2">
						
						<div class="title_wrap">
							<strong class="title title21">네티즌 별점 및 후기</strong>
						</div>
						<p class="guide_txt">
							네티즌 별점 및 후기 게시판에 티켓 양도와 매매성 등 글과 같이 게시판 성격에 벗어난 글을 게재할 경우 사전 통보
							없이 삭제될 수 있습니다.<br> 티켓 양도 및 매매의 경우 전화번호, 이메일 등의 개인정보가 악용될 소지가
							있으므로 게재를 삼가 주시기 바랍니다.<br> 운영 규정을 지속적으로 어기는 게시글을 게재할 경우 쇼티켓
							게시판 이용이 제한될 수 있습니다.
						</p>
						
						
						
				<!-- 				[D] st_off 영역에 마우스 오버시 : 클래스 st_over 추가
                    [D] 버튼 선택시 : 선택된 버튼 클래스 'on' 추가, 대체텍스트 '선택됨' 추가, 짝수 점수 버튼에 클래스 st_r 추가, 디폴트는 화면에 보이지 않는 0점 버튼
								jindo.StarRating 을 사용함. http://jindo.dev.naver.com/docs/jindo-component/1.2.0/doc/external/classes/jindo.StarRating.html -->

						<div class="star_review" id="star_review">
							<fieldset>
								<legend>네티즌 별점 및 후기 작성</legend>
									<strong class="blind">평점선택</strong>
									<span class="my-rating-9" style="float:left;"></span>
									<span class="live-rating" id="rating" style="float:left;"></span>
									

								<dl class="star_average">
									<dt>현재 평균 별점</dt>
									<dd class="grade color_purple" id="ratingAverage">${show.reviewStar }점</dd>
									<dd class="grade_star">
										<span class="star_gauge" id="ratingAverageStar"
											style="width: 0%"></span>
									</dd>
									<dd class="bar">|</dd>
									<c:if test="${empty total }">
									<dt>참여인원 0명</dt>
									</c:if>
									<c:if test="${not empty total }">
									<dt>참여인원 ${total }명</dt>
									</c:if>
									<dd class="person" id="countReviewe"></dd>
								</dl>
								<div class="write_review">
									<textarea title="후기 작성하기" id="reviewContent"
										name="reviewContent" onclick="MemberCommonCheck();"
										onkeyup="checkTextLength(this);"
										onpaste="checkTextLength(this);"
										onchange="checkTextLength(this);"
										style="height: 25px; resize: none;" maxlength="3000"
										placeholder="주민번호, 전화번호, 이메일 등 개인정보를 남기면 타인에 의해 악용될 소지가 있습니다."></textarea>
									<button type="button" id="reviewInsertButton" onclick="insertReview()"
										class="btn btn_reply">댓글입력</button>
								</div>
							</fieldset>
							<div id="star_review_errors"></div>
						</div>

						<div class="title_wrap mgt40">
							<strong class="title title22 fl">후기보기</strong> <a
								href="javascript:;" class="btn_text3 fr"
								id="displayAllReviewBtn" onclick="displayAllreview();">전체후기보기</a>
						</div>
						
						<div id="review_list" class="review_list">

						</div>
<!--<button id="likes"><i class='fas fa-thumbs-up'></i>좋아요</button>-->										
						<script>
						
						function reviewList(){
							
						var reviewShowId = "${show.id}";
						/* var reviewNo = 0;
                        var receiveId = ""; */
						
						    $.ajax({
						        url : "${pageContext.request.contextPath}/review/reviewList.do",
						        data: {reviewShowId: reviewShowId},
								contentType: 'application/json; charset=utf-8',
								dataType: "json",
								type: "GET",
						        success : function(data) {
									
						           var html = "";
						               html += "<ul id='reviewUl' style='word-break: break-all;'>";
						   
						                if(data.length>0){
						                    for(var i in data){
						                        /* reviewNo = data[i].reviewNo;
						                        receiveId = data[i].reviewWriter; */
						                    	
						               			html += "<li class='reviewOne'>"
						                        /* html += "<span class='my-rating-7'></span>"; */
						                        html += "<input type='hidden' id='reviewNo' value='"+data[i].reviewNo+"'>"
						                        html += "<input type='hidden' id='reviewWriter' value='"+data[i].reviewWriter+"'>"
						                        html += "<span class='review-rating-"+i+"'></span>"; 
						                        html += "<span class='reviewId color_purple'>"+data[i].reviewWriter+"&nbsp;";
						                        if("" == "${memberLoggedIn.memberId}"){
							                        html += "<a href='javascript:MemberCommonCheck();'>";
						                        }
						                        else{
							                        /*신고하는 부분  */
						                        	
						                        	html += "<a href='javascript:void(0);' id='reportReview'>";
						                        }  
							                        /* html += "<a href='${pageContext.request.contextPath}/main.do?reviewNo="+data[i].reviewNo+"&reportMemberId2="+data[i].reviewWriter+"&reportMemberId="+${memberLoggedIn.memberId}+"'>"; */

						                        html += "<img src='${pageContext.request.contextPath }/resources/images/alert.png' style='padding-bottom:2px; width:18px; height:18px;'></a>";
						                        html += "</span>";
						                        	/* 삭제하는 부분 */
						                        if(data[i].reviewWriter == "${memberLoggedIn.memberId}" || "admin" == "'"+data[i].reviewWriter+"'"){
						                        html += "<div class='btns'><button class='btn-sm btn-primary' id='dReview'>삭제</button></div>"
						                        }
						                        html += "<div class='reviewContent'>"+data[i].reviewContent+"</div>";
						                        html += "<span class='reviewDate small-font'>"+data[i].reviewDate+"</span>";
						                        /*좋아요하는 부분  */
						                        html += "<button id='checkLikes'><i class='far fa-thumbs-up'></i>  "+data[i].reviewLike+"</button>";
						                        html += "</li>"; 

						                    } /* for문끝 */
						                }  /* if문끝 */
						                    else{
						               			html += "<li class='reviewOne'>"
						                        html += "<div class='reviewContent'>리뷰가 존재하지 않습니다.</div>";
						                        html += "</li>"; 
						                    }
						                    html+="</ul>";
						                    $("#review_list").html(html);
						                    var cnt = data.length;
						                    var i = 0;
						                    while(i < cnt) {
							                	$(".review-rating-"+i).starRating({
							                	    initialRating: data[i].reviewStar,
							                	    readOnly: true,
							                	    starSize: 25,
							                	  });
						                        
						                    	i++;
						                    }
						               		
						                    
						                	
						                
						       /*function success(data)끝 */
						       },error:function(e){
						            if(e.status==300){
						               alert("데이터를 가져오는데 실패하였습니다.");
						           }; 
						       }
						    }); //ajax끝 
						
						}// reviewList끝
						
						
						
						</script>
						<div id="pagination" class="paging"></div>

					</div>
				</div>
<!-- 후기 별점 api  -->				


<script type="text/javascript">

$(function colorRating() {



	  $(".my-rating-7").starRating({
	    initialRating: 3.5,
	    readOnly: true,
	    starSize: 25,
	  });



	  $(".my-rating-9").starRating({
	    totalStars: 5,
	    
	    disableAfterRate: false,
	    emptyColor: 'gray',
	    hoverColor: '#8f01a3',
	    activeColor: '#8f01a3',
	    strokeColor: '#8f01a3',
	  
	    onHover: function(currentIndex, currentRating, $el){
	      $('.live-rating').text(currentIndex);
	    },
	    onLeave: function(currentIndex, currentRating, $el){
	      $('.live-rating').text(currentRating);
	    }
	  });

	});

</script>
<script type="text/javascript">

function MemberCommonCheck(){
	var memberId = "";	
	if(memberId == "${memberLoggedIn.memberId}"){
		alert("로그인 해주세요");
		$("#goLogin").click();				
	}
	
}
	/* if(MemberLoggedIn == "null"){
		$(.login).attr("onclick", "");
	} */
/*신고하기  */
function insertReport(reviewNo, receiveId){
	
		if(!confirm("신고하시겠습니까?")){
			return false;
		}
		
	 var report = {};
	report.reviewNo = reviewNo;
	report.reportMemberId = "${memberLoggedIn.memberId}";
	report.receiveMemberId = receiveId; 
	
	 $.ajax({
		url: "${pageContext.request.contextPath}/admin/insertReport.do",
		data: JSON.stringify(report),
		contentType: 'application/json; charset=utf-8',
		dataType: "json",
		type: "POST",
		success: (data)=>{
			var msg = JSON.parse(data);
			alert(msg);
			console.log(data.msg);
		
		},
		error: (xhr, txtStatus, err)=>{
			console.log("ajax처리실패!",xhr, txtStatus, err);
		}
		
	}); 
	
	
}
function isValidReview() {
	var rating = $.trim($("#rating").text());
	var reviewContent = $.trim($("#reviewContent").val());

	if (rating == "" || rating == null) {
		alert("별점을 선택해주세요.");
		return false
	} else if (reviewContent == "" || reviewContent == null) {
		alert("후기를 입력해주세요.");
		return false
	} else {
		return true;
	}
}

function insertReview(){
	if(!isValidReview()){
		return;
	}
	
	var review = {};
	review.reviewShowId = "${show.id}";
	review.reviewWriter = "${memberLoggedIn.memberId}";
	review.reviewStar = $("#rating").text();
	review.reviewContent = $("#reviewContent").val();

	
	$.ajax({
		dataType: "json",
		contentType: 'application/json; charset=utf-8',
        url : '${pageContext.request.contextPath}/review/insertReview.do',
		type: "POST",
		data: JSON.stringify(review),
		success: function (result) {
			/* if (result.message == "validation fail") {
				setValidationMessage(result.result);
				return;
			} */
			alert("후기가 등록되었습니다.");
			reviewList();
			/* $("#reviewContent").val("");
			$("#reviewInsertButton").attr("onclick", "insertProductReview();"); */
		},
		error: function (request, status, error) {
			alert("오류가 발생하였습니다. 관리자에게 문의하세요.");
			/* $("#reviewInsertButton").attr("onclick", "insertProductReview();"); */
		}
	});
}



</script>
<!--리뷰 후기 영역  -->				
				
				<div class="tabs-Num" id="tabs-3">

						
						<div class="detail_cont" style="clear:both;">
							<strong>[공연시간 정보]</strong>
							<div class="bx_dummy">
								<em class="info_tit">장소</em> <span class="txt">${show.getHallName()}</span>
							</div>
							<div class="bx_dummy">
								<em class="info_tit">기간</em> <span class="txt">${show.getStartDate()}
									~ ${show.getEndDate()}</span>
							</div>
		
		
		
							<div class="bx_dummy">
								<em class="info_tit">관람시간</em> <span class="txt">${show.getRuntime() }</span>
							</div>
							<c:if test="${not empty show.time }">
							<div class="bx_dummy">
								<em class="info_tit">정기 공연일정</em> <br /> 
									<span class="txt">
										${show.time }
										<%-- <c:forTokens var="item" items="${show.time}" delims=",">${item}<br /></c:forTokens> --%>
	
									</span>
							</div>
							</c:if>
							<div class="bx_dummy">
								<c:if test="${empty show.urls }">
								</c:if>
								<c:if test="${not empty show.urls }">
									<c:forEach items="${show.urls}" var="f">
												<img src="${f }" alt="" style="max-width: 900px;"/>	
									</c:forEach>
								</c:if> 
							</div>
						</div>


					</div>

				</div>
				<script>


//지도 kakao maps api
//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
   		var container = document.getElementById('map'); 
   		
   		var la = ${address.la};//위도
   		var lo = ${address.lo};//경도
		var options = {
			center: new kakao.maps.LatLng(la, lo), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
		};
		var map = new kakao.maps.Map(container, options);
		
		// 마커가 표시될 위치입니다 
		var markerPosition  =new kakao.maps.LatLng(la, lo); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map); 
	</script>

				<div class="tabs-Num" id="tabs-4">

					<div class="detail_cont" style="padding: 30px 70px;">

						<strong>[티켓 수령 안내]</strong>
						<div class="contents">
							<p>
								<strong><span style="font-family: 돋움, dotum;">1)
										일반배송</span></strong><br> <span style="font-family: 돋움, dotum;"> 티켓
									예매 확인 후 인편으로 배송되며, 예매 후 10일 이내(영업일 기준) 수령 가능합니다.</span><br> <span
									style="font-family: 돋움, dotum;">일괄 배송 상품의 경우 고지된 배송일 이후
									10일 이내(영업일 기준) 수령 가능합니다.</span><br> <span
									style="font-family: 돋움, dotum;">배송비는 행사에 따라&nbsp;상이합니다.
									상품 상세 페이지 안내에서 확인할 수 있습니다. </span><br> <span
									style="font-family: 돋움, dotum;">행사 또는 행사일에 따라 우편배송 방법의
									선택이 제한될 수 있습니다.</span>
							</p>
							<p>
								<span style="font-family: 나눔고딕, NanumGothic, sans-serif;"></span><br>
								<strong><span style="font-family: 돋움, dotum;">2)
										현장수령</span></strong><br> <span style="font-family: 돋움, dotum;">
									행사당일 공연 시작 1시간~30분 전까지 행사장 매표소에서 수령하실 수 있습니다.</span><br> <span
									style="font-family: 돋움, dotum;">예매번호, 예매하신 분의 신분증(필수),
									예매확인서(프린트 또는, 티켓링크 앱 예매확인 페이지)를&nbsp;매표소에 제시하시면 편리하게 티켓을 수령하실 수
									있습니다.</span><br> <span style="font-family: 돋움, dotum;">행사
									또는 행사일에 따라 현장수령 방법의 선택이 제한될 수 있습니다.</span><br> <span
									style="font-family: 돋움, dotum;">수령장소는 각 행사장 매표소이며, 매표소의
									예매자 전용 창구를 이용하시면 됩니다.&nbsp;</span>
							</p>
						</div>


						<strong>[예매 취소 안내]</strong>
						<div class="contents">
							<strong>예매 취소 시 주의사항</strong><br> 티켓 예매 후 7일 이내에 취소 시,
							취소수수료가 없습니다. <br>단, 예매 후 7일 이내라도 취소 시점이 공연일로부터 10일 이내라면 그에
							해당하는 취소수수료가 부과됩니다.<br>예매 당일 자정(12:00) 전에 취소할 경우 예매 수수료가
							환불되며, 그 이후에는 환불되지 않습니다.<br>예매티켓 취소는 아래 안내된 취소가능일 이내에만 할 수
							있습니다.
							<table class="detail_info_tbl mgt15">
								<caption>예매 취소 안내</caption>
								<colgroup>
									<col style="width: 180px;">
									<col style="width: 130px;">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th rowspan="1" colspan="1" scope="col">행사일</th>
										<th rowspan="1" colspan="1" scope="col">배송방법</th>
										<th rowspan="1" colspan="1" scope="col">취소가능시간</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td rowspan="2">평일/토요일</td>
										<td>현장수령</td>
										<td>행사 전 일, 17:00까지</td>
									</tr>
									<tr>
										<td>인편배송</td>
										<td>행사 전 일, 17:00까지 반송하여 도착하는 티켓</td>
									</tr>
									<tr>
										<td rowspan="2">일요일</td>
										<td>현장수령</td>
										<td>행사 전 토요일, 17:00까지</td>
									</tr>
									<tr>
										<td>인편배송</td>
										<td>행사 전 토요일, 11:00까지 반송하여 도착하는 티켓</td>
									</tr>
									<tr>
										<td rowspan="2">행사전일 : 평일<br>행사일 : 연휴기간/연휴다음날
										</td>
										<td>현장수령</td>
										<td>행사 전 일, 17:00까지</td>
									</tr>
									<tr>
										<td>인편배송</td>
										<td>행사 전 일, 17:00까지 반송하여 도착하는 티켓</td>
									</tr>
									<tr>
										<td rowspan="2">행사전일 : 토요일<br> 행사일 : 연휴기간/연휴다음날
										</td>
										<td>현장수령</td>
										<td>연휴 전 토요일, 17:00까지</td>
									</tr>
									<tr>
										<td>인편배송</td>
										<td>연휴 전 토요일, 11:00까지 반송하여 도착하는 티켓</td>
									</tr>
								</tbody>
							</table>
							<p>단, 롯데콘서트홀 공연의 경우 관람일 하루 전 18:00까지 취소 가능하며 토/일/월 공연의 경우 금요일
								18:00까지 취소 가능합니다.&nbsp;</p>
							<p>&nbsp;</p>
							<p>
								구입하신 예매채널을 통해서만 취소가 가능합니다. (티켓링크에서는 티켓링크에서 예매한 티켓만 취소 가능합니다.) <br>구입하신
								티켓의 일부분 취소, 날짜/시간/좌석등급/좌석위치 변경은 불가능합니다. (관련 상담 : 티켓링크 콜센터
								1588-7890)<br>반송 시, 고객님의 예매번호와 연락처, 반송사유, 환불계좌, 예금주를 적으셔서
								티켓과 동봉해 보내주시면 정확한 처리에<br> 도움이 됩니다.<br>취소 가능 시간이 공연일까지
								3일 이상 남지 않았을 경우 특급우편을 이용하거나 콜센터 1588-7890으로 문의 바랍니다.<br>발송
								받으신 티켓이 분실되거나 훼손되었을 경우 취소 및 변경이 절대 불가합니다.<br>공연상의 문제로 환불을
								받으실 경우 별도의 수수료를 공제하지 않으며, 환불 주체가 티켓링크가 아닌 행사 주최사가 <br>될 수
								있습니다.
							</p>
							<p>
								<strong>취소수수료 안내</strong><br>무통장 입금으로 결제하신 경우, 취소수수료와 송금수수료
								500원을 제외한 나머지 금액이 고객 환불 계좌에 입금됩니다.<br>환불은행, 계좌번호, 예금주는
								본인명의로 정확히 입력 부탁드리며, 취소처리를 접수한 날로부터 3~5일 이내에 환불 받으실 수 있습니다.<br>
								또한, 타인의 계좌를 이용하거나 명의를 도용했을 경우 서비스 이용이 제한될 수 있습니다.<br>신용카드로
								결제 시, 취소수수료 및 우편 발송비를 재승인 후 기존 승인금액을 취소 처리합니다.
							</p>
							<table class="detail_info_tbl mgt15">
								<caption></caption>
								<colgroup>
									<col style="width: 86px;">
									<col style="width: 163px;">
									<col style="width: 180px;">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th rowspan="1" colspan="2" scope="col">행사일</th>
										<th rowspan="1" colspan="1" scope="col">취소수수료 (인터넷, 콜센터)</th>
										<th rowspan="1" colspan="1" scope="col">비고</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th rowspan="5" colspan="1">공연 / 전시</th>
										<td>예매후 7일 이내 / 예매당일</td>
										<td>없음</td>
										<td rowspan="7">예매 당일에 취소하는 경우 이외에는<br>예매수수료가 환불되지
											않음 (약관 28조 의거)<br> <br>예매 후 7일 이내라도 취소 시점이 공연일로부터<br>10일
											이내라면 그에 해당하는 취소수수료가 부과됨<br>(약관 32조 의거)
										</td>
									</tr>
									<tr>
										<td>예매후 8일 ~ 관람일 10일 전</td>
										<td>뮤지컬, 콘서트, 클래식 등 공연권<br>: 장당 4,000원<br> 연극,
											전시 등 입장권 <br> 장당 2,000원<br>* 티켓금액의 10% 이내
										</td>
									</tr>
									<tr>
										<td>관람일 9일 전 ~ 7일 전</td>
										<td>티켓금액의 10%</td>
									</tr>
									<tr>
										<td>관람일 6일 전 ~ 3일 전</td>
										<td>티켓금액의 20%</td>
									</tr>
									<tr>
										<td>관람일 2일 전 ~ 1일 전</td>
										<td>티켓금액의 30%</td>
									</tr>
									<tr>
										<th rowspan="1" colspan="2" scope="row">스포츠</th>
										<td>티켓 구매 금액의 10%</td>
									</tr>
								</tbody>
							</table>




						</div>


						<strong>[티켓 환불 안내]</strong>
						<div class="contents">
							<span class="fbold">신용카드</span> : 취소 시 승인이 취소됩니다.<br> <span
								class="fbold">무통장입금</span> : 인터넷 또는 콜센터(1588-7890)로 접수된 고객님의
							환불계좌로 입금해드립니다.
						</div>


						<strong>[기타 안내]</strong>
						<div class="contents">
							<p>
								<span class="fbold"><strong>입금 계좌 번호</strong></span>
							</p>
							<p>
								예매 완료 페이지에 별도 표시 (기록해두면 환불 시 편리합니다.)<br> <strong></strong>
							</p>
							<p>
								<strong><br></strong>
							</p>
							<p>
								<strong>주의사항</strong> <br>입금 계좌를 분실했을 경우 예매확인/취소 메뉴를 이용해서 각
								예매건에 대한 입금계좌를 확인하시기 바랍니다. <br>1일 1건 이상 무통장 입금으로 티켓을 예매한 경우,
								각각의 예매건에 대한 입금계좌가 다르게 부여됩니다. <br>예매금액과 입금금액이 일치하지 않을 경우 입금
								오류가 발생하여 입금처리 되지 않습니다. 예매 시 예매금액을 꼭 확인하세요. <br>예매당일을 포함하여 그
								다음날 23:59(주말 및 공휴일 포함)까지 지정된 계좌로 입금하셔야만 예매가 유효합니다.
							</p>
							<p>&nbsp;</p>
							<p>
								<span style="line-height: 1.5;">은행에 따라 23:30에 온라인 입금이
									마감되는 경우가 있으니 참고 부탁드립니다.</span> (단, 외환은행, 수협은 22:40에 온라인 입금이 마감됩니다.)
							</p>
							<p>&nbsp;</p>
							<p>
								무통장 입금의 경우 입금 확인 및 고객 확인을 위한 기간이 필요하므로 이용기간이 제한됩니다. 양해 부탁 드립니다.
								<br>예매 당일을 포함하여 그 다음날 23:59(주말 및 공휴일 포함)까지 입금하지 않으실 경우 별도의
								통보 없이 예매가 취소됩니다.
							</p>
						</div>


						<strong>[예매수수료 안내]</strong>
						<div class="contents">
							티켓링크 인터넷, 콜센터를 통한 티켓 예매 시, 소정의 수수료가 부과됩니다. (시행일 2002.3.4)<br>
							<br>
						</div>

					</div>

				</div>
			</div>

			<!-- //배너영역 -->
			<!-- [D] 공연/전시용 윙배너 -->
			<!-- [D] 메인 윙배너와 동일한 동작 -->
			<!-- [D] 스크롤 발생 시 .moving 추가 -->
		</div>
	</div>


<script type="text/javascript">
		/* <![CDATA[ */
		var google_conversion_id = 950223509;
		var google_custom_params = window.google_tag_params;
		var google_remarketing_only = true;
		/* ]]> */
    </script>
<script type="text/javascript"
	src="//www.googleadservices.com/pagead/conversion.js"></script>
<noscript>
	<div style="display: inline;">
		<img height="1" width="1" style="border-style: none;" alt=""
			src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/950223509/?value=0&amp;guid=ON&amp;script=0" />
	</div>
</noscript>
<script type="text/javascript">
		$("iframe[name='google_conversion_frame']").css("display", "none");
    </script>


<!-- 다이얼로그 창  -->
<div class="layer l_installment popup" id="dialog1"
	style="display: none">
	<a href="javascript:;" onclick="$('#dialog1').dialog('close');"
		class="close">레이어 닫기</a> <strong>무이자 할부</strong>
	<table>
		<caption>무이자 할부 정보</caption>
		<colgroup>
			<col style="width: 62px">
			<col style="width: 59px">
			<col>
		</colgroup>
		<tbody>

		</tbody>
	</table>
</div>


<div class="layer l_installment popup" id="dialog4"
	style="display: none">
	<a href="javascript:;" onclick="$('#dialog4').dialog('close');"
		class="close">레이어 닫기</a> <strong>가격정보</strong>
	<ul class="fs11">

		VIP석 -
		<span class="num">140,000</span>원
		<br> R석 -
		<span class="num">120,000</span>원
		<br> S석 -
		<span class="num">90,000</span>원
		<br> A석 -
		<span class="num">60,000</span>원
		<br>

	</ul>
</div>

<div class="layer l_installment popup" id="dialog5"
	style="display: none">
	<a href="javascript:;" onclick="$('#dialog5').dialog('close');"
		class="close">레이어 닫기</a> <strong>가격정보</strong>
	<ul class="fs11">

		일반 -
		<span class="num">140,000</span>원
		<br>
		</span>

	</ul>
</div>

<div class="layer l_installment popup" id="dialog7"
	style="display: none">
	<a href="javascript:;" onclick="$('#dialog7').dialog('close');"
		class="close">레이어 닫기</a> <strong>할인정보</strong>
	<ul class="fs11">

		<li>추억만들기 - <span class="color_green fbold">30</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>초연기념특별할인 - <span class="color_green fbold">40</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>마티네 할인 - <span class="color_green fbold">30</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>뮤지컬 <사랑했어요> 실물 유료 티켓 소지자 (재관람 할인) - <span
				class="color_green fbold">20</span> <span class="color_green fbold">
				% </span> 할인 </li>

		<li>학생 할인 (초,중,고) - <span class="color_green fbold">20</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>학생 할인 (초,중,고) - <span class="color_green fbold">30</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>대학생 할인 - <span class="color_green fbold">20</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>대학생 할인 - <span class="color_green fbold">30</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>장애인 1-3급(1인 2매) - <span class="color_green fbold">50</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>장애인 4-6급(1인 1매) - <span class="color_green fbold">50</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>국가유공자(1인 1매) - <span class="color_green fbold">50</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>경기도 성남시 거주자 및 직장인할인 - <span class="color_green fbold">20</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>4인 이상 - <span class="color_green fbold">30</span><span
			class="color_green fbold"> % </span> 할인
		</li>

		<li>영피프티(50세 이상) - <span class="color_green fbold">40</span><span
			class="color_green fbold"> % </span> 할인
		</li>

	</ul>
</div>
<style>
.detail_box_bot .detailbox_bot_left .detail_cont .detail_cont>div {
    clear: both;
    padding: 41px 30px 100px;
    border-width: 0 1px 1px;
    border-style: solid;
    border-color: #dedede;
    min-height: 1300px;
    text-align: left;
    font-size: 20px;
	}

</style>




<script type="text/javascript">
	//<![CDATA[
	
	var RESERVE_DATA = {
		SELECTED_DATE: "",
		SELECTED_ROUND: "",
		SELECTED_SCHEDULE: ""
	};
	var URL_DATA = {
		SELECTED_DATE: document.URL.split("productDate=")[1] != null ? document.URL.split("productDate=")[1].split("&")[0] : "",
		SELECTED_ROUND: document.URL.split("productRound=")[1] != null ? document.URL.split("productRound=")[1].split("&")[0] : ""
	};
	days = ["일","월","화","수","목","금","토"];
	
	var times;
	<!-- 달력 -->
	$.fn.datepicker.dates['kr'] = {
			days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
			daysShort: days,
			daysMin: days,
			months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		    today: "Today",
		    clear: "Clear",
		    titleFormat: "yyyy.mm", /* Leverages same syntax as 'format' */
		    weekStart: 0
	};
	
	
	var selectDate;
	
	$(document).ready(function () {
		/*-------------------------------희수 코딩 영역--------------------------------*/
		//달력
		
		$('#calendar').datepicker({
			format: "yyyy.mm.dd",
			startDate: '${show.getStartDate()}',
			endDate: '${show.getEndDate()}',
			calendarWeeks: false,
            todayHighlight: true,
            daysOfWeekDisabled : <%=list%>,
			language: 'kr'
		}).on('changeDate',function(e){
			var today = new Date();	//오늘 날짜
			selectDate = new Date(e.format());
			if(today>selectDate){
				alert("지난 날짜입니다. 다시 선택해주세요.");
				return;
			}
			var day = selectDate.getDay();
			var timeList;
			if(day==0){
				timeList = '<%=dayTime.get("일")%>';
			}
			else if(day==1){
				timeList = '<%=dayTime.get("월")%>';
			}
			else if(day==2){
				timeList = '<%=dayTime.get("화")%>';
			}
			else if(day==3){
				timeList = '<%=dayTime.get("수")%>';		
			}
			else if(day==4){
				timeList = '<%=dayTime.get("목")%>';
			}
			else if(day==5){
				timeList = '<%=dayTime.get("금")%>';
			}
			else if(day==6){
				timeList = '<%=dayTime.get("토")%>';
			}
			
			$("#watchTime").children().remove();
			
			if(timeList != null){
				var t = timeList.substring(1,timeList.length-1);
				times = t.split(",");
			}
			for(var i=0;i<times.length;i++){
				var time = times[i].split(":");
				var html = "<option value='"+times[i]+"'>"+time[0]+"시 "+time[1]+"분</option>";
				$("#watchTime").append(html);				
			}		
		});
		
		$("#wait").on("click",()=>{
			if(${memberLoggedIn!=null}){
				location.href = "${pageContext.request.contextPath}/show/insertWait.do?showId=${show.getId()}";
			}
			else{
				alert("로그인이 필요합니다.");
			}
		});
	
		$("#book").on("click",()=>{
			if(${memberLoggedIn==null}){
				alert("로그인이 필요합니다.");
				return;
			}
			var selectTime = $("#watchTime").val();
			
			if(selectDate==null||selectTime==''){//날짜나 회차가 선택되지 않은 경우 
				alert("날짜와 회차를 선택해주세요");
				return;
			}
			
			var selectNum;
			for(var i=0;i<times.length;i++){
				if(times[i]== selectTime){
					selectNum = i+1;
				}
			}
			var year = selectDate.getFullYear();
			var month = selectDate.getMonth()+1;
			var date = selectDate.getDate();
			var sDate = year+"."+month+"."+date;
			
			var form = document.createElement("form");
			form.setAttribute("charset", "UTF-8");
			form.setAttribute("method", "Post"); // Get 또는 Post 입력
			form.setAttribute("action", "${pageContext.request.contextPath}/ticketing/ticketingSeat.do");
			 
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "playId");
			hiddenField.setAttribute("value", "${show.id}");
			form.appendChild(hiddenField);
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "selectDate");
			hiddenField.setAttribute("value", sDate);
			form.appendChild(hiddenField);
			
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "selectTime");
			hiddenField.setAttribute("value", selectTime);
			form.appendChild(hiddenField);
			
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "selectNum");
			hiddenField.setAttribute("value", selectNum);
			form.appendChild(hiddenField);
		
			var url = "${pageContext.request.contextPath}/ticketing/ticketingSeat.do";
			/* var url = "${pageContext.request.contextPath}/ticketing/interpark.do"; */
			var name = "bookTicket";
		    var option = "width = 900, height = 630, top = 0, left = 100, location = no";
		    window.open(url, name, option);
		    
		    form.target = name;
		    document.body.appendChild(form);
		    form.submit(); 
		});
		
		/*-------------------------------희수 코딩 영역--------------------------------*/
	
	});
	function initCleanReserveInfo () {
		var contentDiv = $("div.ly_clean_reserve");
		$(".tag_clean").click(function () {
			contentDiv.removeClass("blind");
		});
		$("#btnCloseCleanReserveInfo").click(function () {
			contentDiv.addClass("blind");
		});
	}
	function setLongTitle () {
		var titleWidth = $("div.title")[0].offsetWidth;
		var titleBoxWidth = $("div.bx_title")[0].offsetWidth;
		var popupWidth = $("div.ly_clean_reserve")[0].offsetWidth;
		var groupTagWidth = $("div.group_tag")[0].offsetWidth;
		var isLongTitle = titleWidth === titleBoxWidth;     // 제목 2줄 이상
		var isShortTitle = titleWidth < (popupWidth + 5);   // 짧은제목
		if (isLongTitle) {
			$("div.title").addClass("long_case");
			$("div.ly_clean_reserve").css("display", "block").css("left", "5px");
		}
		if (isShortTitle) {
			var pxLeft = (5 - titleWidth + groupTagWidth) + "px";
			$("div.ly_clean_reserve").css("left", pxLeft).css("right", "");
		}
	}
	function getProductDatesByProductId () {
		var postData = $("#productId").val();
		$.ajax({
			method: "POST",
			url: "/api/product/dates",
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify(postData),
			success: function (result) {
				setMonthButton(result.data);
				ne.tkl.selectSchedule.updateDates(result.data);
				if (URL_DATA.SELECTED_DATE != "") {
					ne.tkl.selectSchedule.setDate(URL_DATA.SELECTED_DATE);
					URL_DATA.SELECTED_DATE = "";
				}
			},
			error: function () {
				//alert("오류가 발생하였습니다. 관리자에게 문의하세요");
			}
		});
	}
	function setMonthButton (dateList) {
		if (dateList.length > 0) {
			if (dateList[0].productDate.split('.')[1] == dateList[dateList.length - 1].productDate.split('.')[1]) {
				ne.tkl.selectSchedule.disableNext();
				ne.tkl.selectSchedule.disablePrev();
			}
		} else {
			ne.tkl.selectSchedule.disableNext();
			ne.tkl.selectSchedule.disablePrev();
		}
	}
	function getProductRound (productDate) {
		var jsonObject = {productId: $("#productId").val(), productDate: productDate};
		$.ajax({
			method: "POST",
			url: "/api/product/round",
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify(jsonObject),
			success: function (result) {
				var message = result.result.message;
				if (message == 'success') {
					var result = result.data;
					$("#product_round_select_list").html('<li><a href="javascript:;">======= 회차 선택 =======</a></li>');
					for (var i = 0; i < result.length; i++) {
						var roundInfo = parseRoundTime(result[i]);
						$("#product_round_select_list").append('<li><a href="javascript:;" onclick="selectScheduleItem(this,\'' +
							roundInfo.productDate + '\', \'' + roundInfo.productRound + '\', \'' + roundInfo.scheduleId + '\')" >' + roundInfo.time + '</a></li>');
					}
					if (URL_DATA.SELECTED_ROUND != "") {
						$("#product_round_select_list").find("li").eq(URL_DATA.SELECTED_ROUND).find("a").click();
						URL_DATA.SELECTED_ROUND = "";
					}
					selectDefaultRounds(result);
				} else {
					//alert("오류가 발생하였습니다. 관리자에게 문의하세요");
				}
			}
		});
	}
	function selectDefaultRounds (data) {
		if (data.length === 1) {          // 예매 가능한 회차가 1개일 때
			$("#product_round_select_list li a").eq(1).click();
		} else {
			$("#selectboxDefaultOption").click();
		}
	}
	function selectScheduleItem (obj, productDate, productRound, scheduleId) {
		$('#selectboxDefaultOption').text($(obj).html());
		//회차, 스케쥴 아이디 전역 변수값 설정
		RESERVE_DATA.SELECTED_ROUND = productRound;
		RESERVE_DATA.SELECTED_SCHEDULE = scheduleId;
		$("#product_round_select_list").css("display", "none");
		if (isSeatProduct($("#productClassCode").val())) {
			getGradeConcert(scheduleId);
		} else {
			getGradeExhibition(scheduleId);
		}
	}
	function isSeatProduct (productClassCode) {
		if (productClassCode === 'EXHIBITION') {
			return false;
		}
		if (productClassCode === 'ADVANCE_TICKET') {
			return false;
		}
		return productClassCode !== 'SPORTS_ZONE';
	}
	function getGradeConcert (scheduleId) {
		$.ajax({
			url: "/api/product/schedules/" + scheduleId + "/grades",
			method: "get",
			type: "json",
			contentType: "application/json",
			data: "",
			timeout: 5000,
			async: false,
			success: function (result) {
				makeGradeList(result.data);
			}
		});
	}
	function getGradeExhibition (scheduleId) {
		var productId = $("#productId").val();
		$.ajax({
			method: "POST",
			url: "/api/reserve/exhibition/grade/" + productId,
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify(scheduleId),
			success: function (result) {
				makeGradeList(result.data);
			},
			error: function () {
				//alert("오류가 발생하였습니다. 관리자에게 문의하세요");
			}
		});
	}
	function makeGradeList (scheduleGrades) {
		var gradeList = $('#seatingInfoPerRound').html('');
		var totalCnt = 0;
		if (scheduleGrades.length > 0) {
			for (var i = 0; i < scheduleGrades.length; i++) {
				totalCnt += scheduleGrades[i].remainCnt;
			}
			if (totalCnt <= 0) {
				var contents = "<li> 전체 <span class='num'>매진</span></li>";
				makeReserveBtnToSoldOutBtn();
			} else {
				var contents = "<li> 전체 <span class='num'>" + totalCnt + "</span>석</li>";
			}
			gradeList.append(contents);
			for (var i = 0; i < scheduleGrades.length; i++) {
				if (scheduleGrades[i].remainCnt <= 0) {
					contents = "<li>" + scheduleGrades[i].name + " <span class='num'>매진</span></li>";
				} else {
					contents = "<li>" + scheduleGrades[i].name + " <span class='num'>" + scheduleGrades[i].remainCnt + "</span>석</li>";
				}
				gradeList.append(contents);
			}
		} else {
			var contents = "<li> 전체 <span class='num'>매진</span></li>";
			makeReserveBtnToSoldOutBtn();
			gradeList.append(contents);
		}
	}
	function makeReserveBtnToSoldOutBtn () {
		var reserveButton = $("#reserve_btn");
		reserveButton.removeClass("s_after");
		reserveButton.attr("onclick", "");
		reserveButton.unbind("click");
		reserveButton.bind("click", function () {
			alert("매진된 상품입니다.");
		});
	}
	function makeSoldOutBtnToReserveBtn () {
		var reserveButton = $("#reserve_btn");
		reserveButton.addClass("s_after");
		reserveButton.attr("onclick", "");
		reserveButton.unbind("click");
		reserveButton.bind("click", function () {
			popReserveDialog();
		});
	}
	function parseRoundTime (data) {
		var date = new Date(data.startDatetime),
			parsedData = {},
			hour,
			min;
		parsedData.productRound = data.productRound;
		parsedData.productDate = data.startDate;
		parsedData.time = data.startTime;
		parsedData.scheduleId = data.scheduleId;
		parsedData.logicalPlanId = data.logicalPlanId;
		return parsedData;
	}
	function selectTap (obj) {
		
		$(".tabs-Num").css("display","none");
		
		if ($(obj).attr('id') == "detailTop") {
			$("#tabs-3").css("display","block");
		} else if ($(obj).attr('id') == "reviewTap") {
			$("#tabs-2").css("display","block");
			 reviewList(); 
		} else if ($(obj).attr('id') == "placeTap") {
			$("#tabs-1").css("display","block");
		} else if ($(obj).attr('id') == "cancelTap") {
			$("#tabs-4").css("display","block");
		}
		
		
		$("ul.detail_tab li").removeClass("on");
		$(obj).parent().addClass("on");
	}
	function makeTap () {
		$("#tabs").tabs();
	}
	
	function authorizedFanclubCallback () {
		window.open('/member/fanclub/auth?productId=' + 29652, '', 'width=500, height=500');
	}
	function authorizeFanclub () {
		if (!memberCommonCheck(location.href, 'authorizedFanclubCallback')) {
			return;
		}
	}
	function onClickSelect (obj) {
		if ($("#product_round_select_list li").length > 0) {
			$("#product_round_select_list").css("display", "block");
		} else {
			alert("날짜를 먼저 선택해주세요");
		}
	}
	function popReserveDialog () {
		if (false) {
			alert('팬클럽/멤버십 인증 후 예매가 가능합니다.');
			return;
		}
		var now = new Date();
		var year = now.getFullYear();
		var mon = (now.getMonth() + 1) > 9 ? '' + (now.getMonth() + 1) : '0' + (now.getMonth() + 1);
		var day = now.getDate() > 9 ? '' + now.getDate() : '0' + now.getDate();
		var today = year + '.' + mon + '.' + day;
		if (RESERVE_DATA.SELECTED_DATE == today) {
			alert('당일공연은 예매취소/환불/변경이 불가합니다.');
		}
		var url = "http://" + location.hostname + "/product/" + $('#productId').val() + "?productDate=" + RESERVE_DATA.SELECTED_DATE + "&scheduleId=" + RESERVE_DATA.SELECTED_SCHEDULE;
		if (!memberCommonCheck(url, 'callBackPopReserveDialog')	) {
			return;
		}
		AEC_F_D('29652', 'i', 1);
	}
	function callBackPopReserveDialog (url) {
		if ($("#isValidProduct").val() == 'true') {
			if ("false" == "true") {
				if (!isAdultMember()) {
					return;
				}
			}
		}
		if (/.*\/product\/\d*.*/.test(url)) {
			url = "/reserve/product/" + $('#productId').val() + "?productDate=" + RESERVE_DATA.SELECTED_DATE + "&scheduleId=" + RESERVE_DATA.SELECTED_SCHEDULE;
		}
		var hight = 980;
		var scrollbarFlag = false;
		if (hight > screen.height) {
			scrollbarFlag = true;
		}
		alertBeforeReserve();
		if ("true" != "true") {
			return;
		}
		popupwindow(url, '티켓링크', 990, 890, scrollbarFlag ? 'yes' : 'no');
	}
	function isAdultMember () {
		var isAdult = false;
		$.ajax({
			cache: false,
			async: false,
			dataType: "json",
			url: "/adult/isAdultMember",
			success: function (resultData) {
				if (resultData.code == '1') {
					alert('오류가 발생했습니다');
					return;
				}
				if (resultData.result == null) {
					alert('로그인이 필요한 상품입니다');
					return;
				}
				if (resultData.result == 'Y') {
					isAdult = true;
					return;
				} else {
					adultConfirmControll(document.URL);
				}
			},
			error: function (result) {
				alert("오류가 발생하였습니다");
			}
		});
		return isAdult;
	}
	function adultConfirmControll (nextPage) {
		if (confirm("성인인증이 필요한 상품입니다. 성인인증 페이지로 이동하시겠습니까?")) {
			document.location.href = "/adult/confirm?nextPage=" + nextPage;
		}
	}
	function createCouponLayerTemplate (couponList) {
		var template = "";
		couponList.forEach(function (coupon) {
			var discountObj = couponTemplate.getCouponDiscountInfoObj(coupon.couponDiscountAmount, coupon.couponDiscountAmountCode);
			template += "<tr><td class='tl'>" + coupon.couponName + "</td>";
			template += "<td>" + discountObj.text + "</td>";
			template += "<td class='tl'><ul>";
			template += couponTemplate.couponDetailInfoinLiTag(coupon);
			template += "</ul></td>";
			if (coupon.possibleIssue) {
				template += "<td><a href='javascript:;' onclick='couponIssue(" + coupon.couponId + ", this)' class='link_green fbold'>쿠폰받기</a></td>";
			} else {
				template += "<td>발급완료</td>";
			}
			template += "</tr>";
		});
		return template;
	}
	function popupClipReserveCallback () {
		$.ajax({
			url: '/product/validation/member-info',
			method: 'POST',
			contentType: 'application/json',
			success: function (resultData) {
				memberInfo = resultData.result;
				if (memberInfo == null) {
					alert('로그인 후 이용가능합니다.');
					return;
				}
				var query = '?';
				query += 'memberId=' + memberInfo.memberId;
				query += '&memberTypeCode=' + memberInfo.memberTypeCode;
				query += '&memberName=' + memberInfo.memberName;
				query += '&memberNo=' + memberInfo.memberNo;
				query += '&productId=' + $('#productId').val();
				var hight = 980;
				var scrollbarFlag = false;
				if (hight > screen.height) {
					scrollbarFlag = true;
				}
				var url = 'http://alpha.napi.ticketlink.co.kr/clipservice/gw/reserve.nhn' + query;
				
				url = 'http://napi.ticketlink.co.kr/clipservice/gw/reserve.nhn' + query;
				
				
				callBackPopReserveDialog(url);
				AEC_F_D('29652', 'i', 1);
			},
			error: function () {
				alert('현재 서비스가 원할하지 않습니다.');
				return;
			}
		});
	}
	function popupClipReserve () {
		if (!memberCommonCheck(location.href, "popupClipReserveCallback")) {
			return;
		}
	}
	function popupwindow (url, title, w, h, sc) {
		var left = (screen.width / 2) - (w / 2);
		var top = (screen.height / 2) - (h / 2);
		return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=' + sc + ', resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
	}
	function popupBoardRule () {
		var url = "/rule/board/popup";
		var title = "티켓링크";
		popupwindow(url, title, 500, 642, 'no');
	}
	function setProductTap () {
		var tab = document.URL.split("#")[1];
		if (tab == "review") {
			$("#reviewTap").click();
		} else if (tab == "inquiry") {
			$("#inquiryTap").click();
		} else if (tab == "place") {
			$("#placeTap").click();
		}
	}
	function checkTextLength (obj) {
		var maxLength = 100;
		if (obj.value.length > maxLength) {
			obj.value = obj.obj.substring(0, maxLength);
		}
	}
	function setTextareaMax (e) {
		if (!document.createElement('textarea').maxLength) {
			var m = e.attributes.maxLength.value;
			e.onkeypress = function () {
				if (this.value.length > m) {
					this.value = this.value.substring(0, m);
					return false;
				}
			};
			e.onkeyup = function () {
				if (this.value.length > m) {
					alert(m + "자까지 입력가능합니다.");
					this.value = this.value.substring(0, m);
					return false;
				}
			};
			e.onpaste = function () {
				if (this.value.length > m) {
					this.value = this.value.substring(0, m);
					return false;
				}
			};
			e.onchange = function () {
				if (this.value.length > m) {
					this.value = this.value.substring(0, m);
					alert(m + "자까지 입력가능합니다.");
					return false;
				}
			};
		}
	}
	function alertBeforeReserve () {
		if ("false" == "true") {
			alert("");
		}
	}
	function couponIssue (couponId, domObj) {
		if (!memberCommonCheck("/product/" + "29652")) {
			return;
		}
		realCouponIssue(couponId, function () {
			alert("쿠폰이 발급되었습니다.");
			$(domObj).parents("td").html("발급완료");
		});
	}
		//]]>
	
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
