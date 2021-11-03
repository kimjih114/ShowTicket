
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>다른 이미지 적용</title>
<meta name="class-lists" content="jindo.StarRating"/>
<meta name="screenshots" content=""/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta name="description" content="다른 별 이미지를 사용한 예제입니다.">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/musical_showdetail.css">
<link rel="stylesheet" type="text/css"
						href="${pageContext.request.contextPath}/resources/css/contents.css"> 
<%-- <link rel="stylesheet" type="text/css"
						href="${pageContext.request.contextPath}/resources/css/star.css">  --%>
<!-- <link rel="stylesheet" type="text/css" href="../asset/demo.css">-->
</head>
<body>
	
<div class="star_review" id="star_review">
							<fieldset>
								<legend>네티즌 별점 및 후기 작성</legend>
								<!-- [D] st_off 영역에 마우스 오버시 : 클래스 st_over 추가
                    [D] 버튼 선택시 : 선택된 버튼 클래스 'on' 추가, 대체텍스트 '선택됨' 추가, 짝수 점수 버튼에 클래스 st_r 추가, 디폴트는 화면에 보이지 않는 0점 버튼 -->
								<!-- jindo.StarRating 을 사용함. http://jindo.dev.naver.com/docs/jindo-component/1.2.0/doc/external/classes/jindo.StarRating.html -->
								<div class="star_rating">
									<strong class="blind">평점선택</strong>
									<div class="starrating-background" id="star_rating"
										style="float: left;">
										<span><em></em></span>
									</div>
									
									<span class="blind">평점</span> <span class="star_score"
										id="score" name="rating"></span>
								</div>

								<dl class="star_average">
									<dt>현재 평균 별점</dt>
									<dd class="grade color_purple" id="ratingAverage">점</dd>
									<dd class="grade_star">
										<span class="star_gauge" id="ratingAverageStar"
											style="width: 0%"></span>
									</dd>
									<dd class="bar">|</dd>
									<dt>참여인원</dt>
									<dd class="person" id="countReviewe"></dd>
								</dl>
								<div class="write_review">
									<textarea title="후기 작성하기" id="reviewContent"
										name="reviewContent" onclick="callMemberCommonCheck();"
										onkeyup="checkTextLength(this);"
										onpaste="checkTextLength(this);"
										onchange="checkTextLength(this);"
										style="height: 25px; resize: none;" maxlength="3000"
										placeholder="주민번호, 전화번호, 이메일 등 개인정보를 남기면 타인에 의해 악용될 소지가 있습니다."></textarea>
									<button type="button" id="reviewInsertButton"
										class="btn btn_reply">댓글입력</button>
								</div>
							</fieldset>
							<div id="star_review_errors"></div>
						</div>
<style type="text/css">
	/*  .starrating-background { background:transparent url(../resources/images/w_03.gif) repeat-x scroll 0 0; cursor:pointer; display:inline-block; height:19px; margin:0; width:90px; vertical-align:middle; }
	.starrating-background span { background:transparent url(../resources/images/w_01.gif) repeat-x scroll 0 0; cursor:pointer;	display:inline-block; height:19px !important; }
	.starrating-background em {position:absolute; top:0; left:0; width:0; height:0; overflow:hidden; visibility:hidden; font-size:0; line-height:0;} /* 대체텍스트 숨기기 */  
  	.starrating-background {
  	both:clear;
     background: transparent url(../resources/images/T_03.png) repeat-x scroll 0 0; 
    cursor: pointer;
    display: inline-block;
    height: 30px;
    margin: 0;
    width: 125px;
    vertical-align: middle;
}
	
.starrating-background span {
 	both:clear;
 	background: transparent url(../resources/images/T_01.png)
		repeat-x scroll 0 0; 
	cursor: pointer;
	display: inline-block;
	height: 30px !important;
}

.starrating-background em {
	both:clear;
	position: absolute;
	top: 0;
	left: 0;
	width: 0;
	height: 0;
	overflow: hidden;
	visibility: hidden;
	font-size: 0;
	line-height: 0;
}   
	
/* 
 body,p,h1,h2,h3,h4,h5,h6,ul,ol,li,dl,dt,dd,table,th,td,form,fieldset,legend,pre,input,textarea,button,select{margin:0;padding:0}
body,input,textarea,select,button,table{font-family:'돋움',dotum,applegothic,sans-serif;font-size:12px}
img,fieldset{border:0}
ul,ol{list-style:none}
em,address{font-style:normal}
a{text-decoration:none}
a:hover,a:active,a:focus{text-decoration:underline} 

 div.demo { margin:10px; }

.bg_blue { background-color:#0075c8; }
.bc_darkgray { background-color:#999; }
.bc_gray { background-color:#ccc; }
.bg_lightgray { background-color:#eee; } 
 */


</style>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath }/resources/js/jindo2.ns.js"></script>
<script type="text/javascript"  charset="utf-8"
	src="${pageContext.request.contextPath }/resources/js//jindo.Component.js"></script>
<script type="text/javascript"  charset="utf-8"
	src="${pageContext.request.contextPath }/resources/js/jindo.UIComponent.js"></script>
<script type="text/javascript"  charset="utf-8"
	src="${pageContext.request.contextPath}/resources/js/jindo.StarRating.js"></script>


<script type="text/javascript">
	var oStarRating = new jindo.StarRating(jindo.$("star_rating"), {
		nStep : 0.5,
		nMaxValue : 5,
		nDefaultValue : 0,
		bSnap : true
	}).attach({
		set : function(oCustomEvent) {
			jindo.$("score").innerHTML = oCustomEvent.nValue;
		}
	});
</script>
</body>
</html>
