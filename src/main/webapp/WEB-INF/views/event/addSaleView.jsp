<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="안녕 스프링	" name="pageTitle"/>
</jsp:include>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/contents.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/eventView.css">


<body>

	   <ul class="nav nav-pills nav-justified">
				<li class="nav-item"><a class="nav-link nav-font select" href="${pageContext.request.contextPath}/event/eventList.do">진행중인 이벤트</a></li>
				<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/event/endEventList.do">종료된 이벤트</a></li>
				<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/event/prizewinner.do">당첨자 발표</a></li>
				<li class="nav-item"><a class="nav-link nav-font default" href="${pageContext.request.contextPath}/coupon/coupon.do">쿠폰</a></li>
			</ul>
	

		<div class="event_cont_box event_cont_box_v2">
                <dl class="evt_detail">
                   	<div class="evt_inner">
	                    <dd class="evt_title" id="eventTitle">
	                       <h2><span>[특가]</span>${dcList.showGenre } <span>&lt;${dcList.showName }&gt;</span> 특가할인 이벤트</h2> 
	                    </dd>
                  	</div>
                 
                    <div class="rhr" style="background: gray;"></div> <!-- 선 -->
	                    <dd class="evt_date">
	                    	<h6>
	                    		<span>이벤트 기간 </span>
	                    		<span>${dcList.disCountStartDate } ~${dcList.disCountEndDate } </span>
	                    	</h6>
	                        
	                    </dd>
	                    <div class="container-t">
	                    	<h2><span>Showticket</span>과 ${dcList.showGenre }<span>&lt;${dcList.showName }&gt;</span>가 함께하는 이벤트</h2>
	                    </div>
	                    <dd class="evt_cont">
	                       
	                        <div>
	                        	<img src="${dcList.disCountImg }" alt="뮤지컬<사랑했어요>관람후기이벤트" border="0" usemap="#Map">
				                <div class="inner">
				                 		<h6><strong><span>${dcList.showGenre }&lt;${dcList.showName }&gt;에 대한 기대평을 남겨주세요. </strong><br />
										
										기대평을 남겨주신 분 중, 추첨을 통해 총 10명의 회원님께 <br />
										
										${dcList.showGenre }&lt;${dcList.showName }&gt;공연 관람권을 드립니다. <br /><br />
										
										*본 이벤트는 당사의 운영 정책에 따라 진행되며 <br /> 
										
										 내부 사정에  의해  변경될 수 있습니다. <br /></span>
				                 		</h6>
			          				
				                </div>
				                <div class="rhr" style="background: gray;"></div> <!-- 선 -->
				                
				                <div class="evt_content">
				                 <table>
				                   
				                   <tr>
								     <th>특가 할인 기간</th>
								     <td>${dcList.disCountStartDate } ~${dcList.disCountEndDate }</td>
								  </tr>
				                  
				                	
				                 </table>
				                	
				                </div>
				                
				                
				   
				                
				  			</div>
				  			<div id="btnbox" style="width:65%;" >
				  			<c:if test="${dcList.showGenre eq '뮤지컬' }">
			                <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="goDetailM();">공연 정보 상세보기</button> 
			                </c:if>
				  			<c:if test="${dcList.showGenre eq '연극' }">
			                <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="goDetailP();">공연 정보 상세보기</button> 
			                </c:if>
				  			</div>
								<script>
								 function goDetailM(){
									 
									 location.href="${pageContext.request.contextPath }/musical/musicalDetail.do?musicalId=${dcList.showId}";
								 }
								 function goDetailP(){
									 //연극상세보기 
									 location.href="${pageContext.request.contextPath }/musical/musicalDetail.do?musicalId=${dcList.showId}";
								 }
								</script>
				
					</div>
			
			    </dd>
		    </dl>
		                  
		</div>
			     
   

</body>

<style>
div#btnbox{ margin-left: 18%; margin-top: 20px; padding-bottom: 20px;}
dl.evt_detail>div.event_inner{position: absolute; background: #8f01a3; border-radius: 10px; width: 82px;height: 40px;left: 80%; top:32px;	}
div.evt_content{ height: 200px; margin-left: 20%;width: 443px;}
div.evt_content table{font-family: 'Gothic A1', sans-serif; margin-left: 10%; margin-top:5%;width: 443px;}
div.evt_content table th ,td{padding-bottom: 25px;}
div.evt_content table th ,td{ font-size: 15px;}
button#rebtn{width: 92.5px;height: 56.25px;} 
dd.evt_date>h6>span {color:gray;}
div#comment-container{margin-left: 20%;  width: 493px;}
div.comment-editor{    width: 493px;}
#boardCommentContent{margin-left: 3px; width: 393px;}
button#detailView{margin-left: 40%;     position: absolute; top: 87px; left: 300px;}
h6{font-family: 'Gothic A1', sans-serif;}
button {font-family: 'Gothic A1', sans-serif;}
</style>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>