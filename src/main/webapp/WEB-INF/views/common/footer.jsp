<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
#footer img{
	position: absolute;
	left: 10%;
    width: 200px;
}
#footer{
	clear:both;
	position: relative;
	
}
</style>
<div id="footer">
    <img src="${pageContext.request.contextPath}/resources/images/showticket_logo_gray.png" alt="로고">
    <div class="inner">
        
        <address>주소 : <em class="lspacing0">13487</em> 서울특별시 강남구 테헤란로 10길 9 그랑프리빌딩 4F, 5F, 7F<span>|</span> showticket팀 <span>|</span> 팩스번호 :<em class="lspacing0">02-501-8570</em></address>
        <p class="co_info">
            <em class="lspacing0">1544-9970</em> <span>|</span> <a href="mailto:membership@ticketlink"
                                                                   class="lspacing0">showticket@gmail.com</a>
        </p>
        <p class="copy">Copyright &copy; showticket Corporation. All rights reserved.</p>
    </div>
</div>
</body>
</html>