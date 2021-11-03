package com.kh.showticket.alarm;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.showticket.member.model.service.MemberService;
import com.kh.showticket.phone.UtilSms;
import com.kh.showticket.phone.model.request.Message;

@Component
public class EchoHandler extends TextWebSocketHandler {
	Logger logger = LoggerFactory.getLogger(getClass());
	List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	HttpSession httpSession; 
	
	@Autowired
	MemberService memberService;
	
	//클라이언트와 연결 이후 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		logger.info("{} 연결됨", session.getId());
	}
	
	//클라이언트가 서버로 메세지를 전송했을 때 실행되는 메서드
	@Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        //client단 기본 websocket은 
        logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
        
        Map<String,Object> map = session.getAttributes();
        //String memberLoggedIn = ((Member)map.get("memberLoggedIn")).getMemberId();
        //System.out.println("로그인 한 아이디 : " + memberLoggedIn);

        //List<String> myStandByList = memberService.selectMyStandByList(memberLoggedIn);

        String ticketShowName = "";
        String ticketDate = "";
        String ticketTime = "";
        String ticketShowId = "";
        
        String ticketNo_ = message.getPayload();
        int ticketNo = Integer.parseInt(ticketNo_);
        
        Map<String, String> canceledInfo =  memberService.selectOneTicketByNo(ticketNo);
        
        ticketShowName = canceledInfo.get("ticketShowName");
        ticketDate = canceledInfo.get("ticketDate");
		ticketTime = canceledInfo.get("ticketTime");
		ticketShowId = canceledInfo.get("ticketShowId");
		
		List<String> standByList = memberService.selectWaitingIdListByShowId(ticketShowId);
        logger.debug("list={}",  standByList);

  
        for (WebSocketSession sess : sessionList) {
            //sess.sendMessage(new TextMessage(session.getId() + " : " + message.getPayload()));
        	 //sess.sendMessage(new TextMessage("대기공연에 등록하신 "+ticketShowName+"의 "+ticketDate+" "+ticketTime+" 취소표가 나왔습니다."));
        }
        
        
        for(String memberId : standByList) {
        	
        	String phone = (memberService.selectOneMember(memberId)).getPhone();
        	logger.debug("phone={}", phone);
        	Message smsMessage = new Message(phone, "01099377714", "[쇼티켓] 대기공연에 등록하신 "+ticketShowName+"의 "+ticketDate+" "+ticketTime+" 취소표가 나왔습니다.");
        	UtilSms.sendMessage(smsMessage);
        }
    }

	 // 클라이언트와 연결을 끊었을 때 실행되는 메소드
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionList.remove(session);
        logger.info("{} 연결 끊김", session.getId());
    }

}