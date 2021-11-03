<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/member.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle" />
</jsp:include>
<script>

var emailAuthFlag = 0; //이메일 인증 버튼 누르지 않음.
$(()=>{
	
	if($("#email").val().trim().length>0){
		emailAuthFlag = 1;
	}

	$("#deleteMember").click(function() {
		var bool = confirm("정말로 탈퇴하시겠습니까?");
		if (bool) {
			var id = $("#memberId").val();
			location.href = "${pageContext.request.contextPath}/member/deleteMember.do?memberId="+id;
		}
	});
	
	$("#emailAuth").on("click", function(){
		var email = $("#email").val().trim();
		
		if(email.length==0){
			alert("이메일을 입력해주세요.");
			return;
		}
		
		$.ajax({
	        url : '${pageContext.request.contextPath}/member/chkEmailUsable.do',
	        data : {email : email},
	        success : function(data) {
	        	console.log(data)
				if(data!=''){
					$("#emailAuthContainer").css("display", "block");
					alert("입력하신 이메일로 송신된 인증번호를 입력해주세요.");
				}
				else{
					alert("이미 등록된 이메일입니다.");
					return;
				}
	       },error:function(e){
	         	alert(e);
	       },complete:function(data){
	    	   $("#btn-emailAuth").on("click", function(){
	    		   if($("#emailAuthCode").val().trim()==data.responseText){
	    			   alert("인증되셨습니다!");
	    			   
	    			   $("#emailAuthContainer").css("display", "none");
	    			   $("#emailAuth").prop("disabled", "true");
	    			   $("#email").attr("readonly", "true");
	    			   
	    			   emailAuthFlag = 1;
	    		   }
	    	   })
	       }
	    });
	});
	
	$("#email").on("keyup",function(){
		emailAuthFlag = 0;
	});

});
function validate(){
	
	if(emailAuthFlag == 0){
		alert("이메일을 인증해주십시오.");
		return false;
	}
	
	var bool = confirm("정말로 수정하시겠습니까?");
	if (bool) {
		return true;
	}
	return false;
}

</script>

<script>

function updatePwd() {
	var url ="${pageContext.request.contextPath}/member/updatePwd.do?memberId=${memberLoggedIn.memberId}";/* ?memberId=아이디" */
	var title = "비밀번호 변경";
	var status="left=500px, top:200px;, width=420px height=450px";
	
	var popup=window.open(url, title, status); 	
	}	
</script>

<div id="container">
	<jsp:include page="/WEB-INF/views/common/memberViewnav.jsp">
		<jsp:param value="마이 페이지" name="pageTitle" />
	</jsp:include>

	<br>
	<div class="div-memberFrm">
		<form name="memberUpdateFrm" id="memberUpdateFrm" action="memberUpdate.do" method="post" onsubmit="return validate();" >
			<h2 class="small-title"style="text-align:left;">회원정보 수정</h2>
			<br />
			<table style="margin-left:auto; margin-right:auto;">
				<tr>
	
				<th>아이디</th>
				<td><input type="text" class="form-control" name="memberId" id="memberId" value="${memberLoggedIn.memberId }" required readonly>
				</td>

			</tr>
			
			<tr>
				<th>비밀번호</th>
				<td>
				<button type="button" class="btn btn-secondary" style="width:140px;"onclick="updatePwd()">비밀번호 변경</button>
				</td>
			</tr> 
			<tr>
				<th>이름</th>
				<td>	
				<input type="text" class="form-control" name="memberName" id="memberName" value="${memberLoggedIn.memberName}" required>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>	
					<input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone" value="${memberLoggedIn.phone}" maxlength="11" required>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<div>
					<input type="email" class="form-control" placeholder="abc@naver.com" name="email" id="email" value="${memberLoggedIn.email}">
					<button type="button" class="btn btn-primary" id="emailAuth">인증</button>
					</div>
					<div class="authContainer" id="emailAuthContainer">
						<span>인증번호 : </span>
						<input type="text" class="form-control" id="emailAuthCode" />
						<button type="button" class="btn btn-primary" id="btn-emailAuth">확인</button>
					</div>
					<div style="clear:both; margin-top:5px;">
						<input type="checkbox" id="chk-email"/><label for="chk-email">정보수신동의</label>
					</div>
				</td>
			</tr>
			
			
	<!-- 		<tr>
				<th>회원등급 </th>
				<td>
					<div class="form-check form-check-inline">
						<input type="checkbox" class="form-check-input" name="grade" id="admin" value="관리자"><label class="form-check-label" for="admin">운동</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="grade" id="general" value="일반"><label class="form-check-label" for="general">등산</label>&nbsp;
						<input type="checkbox" class="form-check-input" name="grade" id="supporter" value="서포터"><label class="form-check-label" for="supporter">등산</label>&nbsp;
					 </div>
				</td>
			</tr> -->
		</table>
		<br /> <br />
		
		<c:if test="${'admin' ne memberLoggedIn.memberId}">

		<button class="btn btn-outline-success my-2 my-sm-0" type="submit" id="updateMember"
			>회원정보
			수정</button>
		</c:if>

		<button class="btn btn-outline-success my-2 my-sm-0" type="button" id="deleteMember">회원정보
			탈퇴</button>
		<br /><br />
	</form>
	</div> <!-- div-memberFrm 끝 -->
</div> <!-- container끝  -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
