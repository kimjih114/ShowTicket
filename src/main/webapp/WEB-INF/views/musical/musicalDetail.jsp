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

<script language='javascript'>
/*--------------------------석현씨 코딩영역-----------------------------  */	

$(()=>{
	$("#review-star").starRating({
	    initialRating: ${musical.getReviewStar()},
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



</script>
<!-- Function and Variables Definition Block End-->



<div id="detailContainer">

	<div class="inner">
		<h2 class="blind">공연</h2>
		<!-- [D]  1 depth의 값을 h2로 뿌려줍니다 -->
		<h3 class="blind">뮤지컬</h3>
		<!-- [D]  2 depth의 값을 h3로 뿌려줍니다 -->
		<h4 class="blind">창작뮤지컬</h4>
		<p class="location_path"></p>

		<div class="detail_box_top ">
			<form name="ticketingFrm" method="post" enctype="multipart/form-data">
				<div class="bx_title">
					<!-- [D] 제목이 길어져서 태그가 아래로 떨어질 경우 : .title에 long_case 클래스 추가 -->
					<div class="title">뮤지컬 &lt;${musical.getName()}&gt;</div>
				</div>
				<div class="detail_info">
					<div class="bx_thumb">
						<span class="bx_img"> <!-- 뮤지컬포스터 --> <img
							src="${musical.getPoster()}" alt="대표이미지" width="314" height="382">
						</span>
					</div>
					<div class="etc_info">
						<div class="bx_dummy">
							<em class="info_tit">별점</em> <span class="txt"><span
								id="review-star"></span></span>
						</div>
						<div class="bx_dummy">
							<em class="info_tit">장소</em> <span class="txt">${musical.getHallName()}</span>
						</div>
						<div class="bx_dummy">
							<em class="info_tit">기간</em> <span class="txt">${musical.getStartDate()}
								~ ${musical.getEndDate()}</span>
						</div>
						<div class="bx_dummy">
							<em class="info_tit">관람시간</em> <span class="txt">${musical.getRuntime() }</span>
						</div>
						<div class="bx_dummy border_type">
							<em class="info_tit">관람등급</em> <span class="txt">${musical.getAge() }</span>
						</div>
						<!-- [D] 레이어 들어간 유형 : include_layer 클래스 추가 -->
						<div class="bx_dummy include_layer">
							<em class="info_tit">가격</em>
							<div class="txt ui-dialog  price-dialog">
								<ul class="lst_dsc">
									<%
									String[] prices = musical.getPrice().split(", ");
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
				<c:if test="${musical.getState() eq '공연중'}">
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
				<c:if test="${musical.getState() eq '공연예정'}">
					<div class="detail_info_right">
						<div class="noinfo_txt">티켓 오픈일은 공지사항을 참고해주세요.</div>

						<button type="button" class="btn reserve due s_after first-child"
							onclick="">
							<span>판매예정 </span>
						</button>
					</div>
				</c:if>
				<c:if test="${musical.getState() eq '공연완료'}">
					<div class="detail_info_right">
						<div class="noinfo_txt">공연이 종료되었습니다.</div>

						<button type="button" class="btn reserve due s_after first-child"
							onclick="">
							<span>공연완료</span>
						</button>
					</div>
				</c:if>
			</form>

		</div>
</div>

				
				
<script>
		
		$("#wait").on("click",()=>{
			if(${memberLoggedIn!=null}){
				location.href = "${pageContext.request.contextPath}/musical/insertWait.do?musicalId=${musical.getId()}";
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
			hiddenField.setAttribute("value", "${musical.id}");
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
