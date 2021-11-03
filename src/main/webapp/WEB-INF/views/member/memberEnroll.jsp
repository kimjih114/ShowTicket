<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	//System.out.println("memberEnroll.jsp");
%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원 등록" name="pageTitle"/>
</jsp:include>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/member.css">


<div id="enroll-container">
	<form name="memberEnrollFrm" action="memberEnrollEnd.do" method="post" onsubmit="return validate();" >
		<table>
			<tr>
				<th>아이디<span class="star">*</span></th>
				<td>
					 <div id="memberId-container">
						<input type="text" class="form-control" placeholder="4글자이상" name="memberId" id="memberId_" required>
						<span class="guide ok">아이디 사용 가능</span>
			            <span class="guide error">아이디 사용 불가능</span>
			            <input type="hidden" name="idDuplicateCheck" id="idDuplicateCheck" value="0"/>
					</div>
				</td>
			</tr>
			
			<tr>
				<th>비밀번호<span class="star">*</span></th>
				<td>
					<input type="password" class="form-control" name="password" id="password_" required>
				</td>
			</tr>
			
			<tr>
				<th>비밀번호확인</th>
				<td>
					<div id="password-container">
						<input type="password" class="form-control" id="password2" required>
						<span class="pw ok">비밀번호 일치</span>
						<span class="pw error">비밀번호 불일치</span>
					</div>
				</td>
			</tr>  
			
			<tr>
				<th>이름<span class="star">*</span></th>
				<td>	
				<input type="text" class="form-control" name="memberName" id="memberName" required>
				</td>
			</tr>
	
			<tr>
				<th>이메일</th>
				<td>
					<input type="email" class="form-control" placeholder="abc@naver.com" name="email" id="email">			
					<span class="btn btn-gray btn-sm" id="emailAuthSubmit">이메일 인증</span>
					<div style="clear:both; margin-top:5px;">
							<input type="checkbox" id="chk-email"/><label for="chk-email">정보수신동의</label>
					</div>
					<div class="authContainer" id="emailAuthContainer">
							<span>인증번호 : </span>
							<input type="text" class="form-control" id="emailAuthCode" />
							<button type="button" class="btn btn-primary" id="btn-emailAuth">확인</button>
							<p class="ok" id="emailAuthstatus">이메일 인증이 완료되었습니다.</p>						
					</div>
				</td>
			</tr>
			
			<tr>
				<th>휴대폰<span class="star">*</span></th>
				<td>
					<input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required>
					<span class="btn btn-gray btn-sm" id="phoneAuthSubmit">휴대폰 인증</span>
					<div style="clear:both; margin-top:5px;">
							<input type="checkbox" id="chk-phone"/><label for="phone">정보수신동의</label>
					</div>
					<div class="authContainer" id="phoneAuthContainer">
							<span>인증번호 : </span>
							<input type="text" class="form-control" id="phoneAuthCode"/>
							<button type="button" class="btn btn-primary" id="btn-phoneAuth">확인</button>
							<p class="ok" id="phoneAuthstatus">휴대폰 인증이 완료되었습니다.</p>						
					</div>
				</td>
			</tr>
						
		</table>
		<input class="btn btn-color" type="submit" id="enroll" value="회원가입" onclick="validate();">
		<input class="btn btn-gray" type="reset" value="취소">
	</form>
</div>

<script>
var emailAuthstatus = 0;
var phoneAuthstatus = 0;

$(function(){

 	// 비밀번호 검사
 	$("#password2").keyup(function(){
 		
 		var password1 = $("#password_").val().trim();
 		var password2 = $("#password2").val().trim();
 		
 		
 		if(password1 != password2){
 			$(".pw.error").show();
			$(".pw.ok").hide();
 		}
 		else{
 			$(".pw.error").hide();
			$(".pw.ok").show();
 		}
 	});
 	
 	
	//아이디 중복체크 ajax
 	$("#memberId_").on("keyup",(e)=>{
		var memberId = $(e.target).val().trim();
		
		if(memberId.length < 4){
			$(".guide").hide();
			$("#idDuplicateCheck").val(0);
			return;
		}
		
		$.ajax({
			url: "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
			data: {memberId: memberId},//memberId=honggd
			//dataType: "json",
			success: data => {
				console.log(data);//json타입이 js object로 변환되어 전달됨.
				if(data.isUsable==true){
					$(".guide.error").hide();
					$(".guide.ok").show();
					$("#idDuplicateCheck").val(1);//중복체크 했음
				}
				else{
					$(".guide.error").show();
					$(".guide.ok").hide();
					$("#idDuplicateCheck").val(0);//중복체크 안했음					
				}
				
			},
			error: (jqxhr, textStatus, errorThrown)=>{
				console.log("ajax처리실패!", jqxhr, textStatus, errorThrown);
			}
			
		});
		
		
	});
	
	var authKey;
	<!-- 인증이메일 보내기 -->
	$("#emailAuthSubmit").on("click",function(){
		var email = $("#email").val().trim();
		
		if(email.length==0){
			alert("이메일을 입력해주세요.");
			return;
		}
		
		if($("input:checkbox[id='chk-email']").is(":checked") == false){
			alert("정보수신에 동의해주세요.");
			return;
		};
		
		alert("이메일이 발송되었습니다. 수신까지 몇분정도 소요됩니다.")
		
		$("#emailAuthContainer").show();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/member/sendMail.do",
			data: {email: email},
			success: data =>{
				console.log(data);
				authKey = data;
			},
			error: (jqxhr, textStatus, errorThrown)=>{
				console.log("ajax처리실패!", jqxhr, textStatus, errorThrown);
			}
		});
	});
	
	$("#email").on("keyup",function(){
		emailAuthstatus = 0;
		authKey = "";
		$("#emailAuthstatus").hide();
	});
	
	<!-- 인증코드 확인 -->
	$("#btn-emailAuth").on("click",()=>{
		if(authKey == $("#emailAuthCode").val()){
			alert("이메일 인증에 성공했습니다.");	
			emailAuthstatus = 1;
			$("#emailAuthstatus").show();
		}
		else{
			alert("이메일 인증에 실패했습니다. 인증번호를 확인하세요.");
		}		
	});
		
	
	/* 휴대폰 인증 */
	var authPhone;
	
	$("#phoneAuthSubmit").on("click",function(e){
		var phone = $("#phone").val().trim();
		
		if(phone.length==0){
			alert("핸드폰 번호를 입력해주세요.");
			return;
		}
		
		if($("input:checkbox[id='chk-phone']").is(":checked") == false){
			alert("정보수신에 동의해주세요.");
			return;
		};
		
		$("#testPhone").append("<input type='hidden' name='phone' value='"+phone+"'/>").submit();
		
		$.ajax({
			url: "${pageContext.request.contextPath}/member/phone.do",
			type: "POST",
			data: {phone: phone},
			success: data =>{
				authPhone = data;
			},
			error: (jqxhr, textStatus, errorThrown)=>{
				console.log("ajax처리실패!", jqxhr, textStatus, errorThrown);
			}
		});
		
		alert("인증번호가 발송되었습니다. 수신까지 몇분정도 소요됩니다.")
		
		$("#phoneAuthContainer").show();
		
	});
	
	$("#phone").on("keyup",function(){
		phoneAuthstatus = 0;
		authPhone = "";
		$("#phoneAuthstatus").hide();
	});
	
	<!-- 인증코드 확인 -->
	$("#btn-phoneAuth").on("click",()=>{
		if(authPhone == $("#phoneAuthCode").val()){
			alert("휴대폰 인증에 성공했습니다.");	
			phoneAuthstatus = 1;
			$("#phoneAuthstatus").show();
		}
		else{
			alert("휴대폰 인증에 실패했습니다. 인증번호를 확인하세요.");
		}		
	});//휴대폰 인증 끝
		
});


function validate(){
	var memberId = $("#memberId_");
	if(memberId.val().trim().length<4){
		alert("아이디는 최소 4자리이상이어야 합니다.");
		memberId.focus();
		return false;
	}
	var email = $("#email").val();
	if(email.length!=0&&emailAuthstatus==0){
		alert("이메일 인증을 하시거나 이메일 정보를 지워주세요.");
		return false;
	}

	if(phoneAuthstatus == 0){
		alert("휴대폰 인증을 진행해주세요");
		return false;
	}
	
	return true;
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>