<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
    <script>
  /*   console.log("지금아이디는>>"+'${memberLoggedIn.memberId}'); */
    
    $(function(){
    	var IMP = window.IMP;
		IMP.init('imp68757717');

		IMP.request_pay({
		    pg : 'inicis',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명: Showticket 예매',
		    amount : '${resultPrice}',
	
		    /* buyer_addr : '', */
		    /* buyer_postcode : '123-456', */
		    /* m_redirect_url : 'https://www.yourdomain.com/payments/complete' */
		}, function(rsp) {
			
			if ( rsp.success ) {
				alert("결제되었습니다!");
				location.href="${pageContext.request.contextPath}/member/updatePt.do?memberId=${memberLoggedIn.memberId}";
		    } else {
		        return;
		    }
			
			
		    
		});
		
     });


    </script>
 
</body>
</html>
