package com.kh.showticket.talk.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.member.model.service.MemberService;
import com.kh.showticket.member.model.vo.Member;
import com.kh.showticket.talk.model.service.TalkService;
import com.kh.showticket.talk.model.vo.ChatRoom;
import com.kh.showticket.talk.model.vo.Msg;

@Controller
public class TalkController {
	
	//임시
	@Autowired
	MemberService memberService;
	
	@Autowired
	TalkService talkService;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/talk.do")
	public ModelAndView websocket(ModelAndView mav, HttpSession session, HttpServletRequest request) {
		//@SessionAttribute(value="memberLoggedIn", required=false) Member memberLoggedIn
		//비회원일 경우, httpSessionId값을 memberId로 사용한다.
		
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
	    String memberId = Optional.ofNullable(memberLoggedIn)
	                              .map(Member::getMemberId)
	                              .orElse(session.getId());      

	    
	    String chatId = request.getParameter("chatId");
	    
	    if(chatId == null) {
	    	chatId =  talkService.findChatIdByMemberId(memberId);
	    } 
	    
	    logger.debug("@@@@@@@@@@@@@@@@@@@@@chatId={}" , chatId);
	    

	    //chatId = request.getParameter("chatId");
	    logger.debug("chatId={}", chatId);
	    
	    //chatId조회
	    //1.memberId로 등록한 chatroom존재여부 검사. 있는 경우 chatId 리턴

	    //logger.debug("확인: {}", chatId);
	   
	    //2.로그인을 하지 않았거나, 로그인을 해도 최초 접속인 경우 chatId를 발급하고 db에 저장한다.
	    if(chatId==null) {
	          chatId = getRandomChatId(15); //chat_randomToken -> jdbcType = char(20byte)
	          
	          List<ChatRoom> list = new ArrayList<>();
	          list.add(new ChatRoom(chatId, memberId, 0, "Y", null, null));
	          list.add(new ChatRoom(chatId, "ticket77", 0, "Y", null, null));

	          talkService.insertChatRoom(list);

	    }
	    //chatId가 존재하는 경우, 채팅내역 조회 
	  		else{
	  			List<Map<String,String>> chatList = talkService.findChatListByChatId(chatId);
	  			logger.debug("chatList={}", chatList);
	  			
	  			for(Map<String, String> msg : chatList) {
	  				long longTypeTime = Long.parseLong(String.valueOf(msg.get("time")));
	  				Date date = new Date(longTypeTime);
	  				
	  				//날짜형식설정
	  				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd a hh:mm");
	  				String StringTypeTime = sdf.format(date);
	  				
	  				logger.debug("chatList={}", chatList);
	  				
	  				msg.remove("time");
	  				msg.put("time", StringTypeTime);
	  				
	  				//logger.debug("타임 = {}", msg.get("time"));
	  			}
	  			
	  			mav.addObject("chatList", chatList);
	  		}
	    
	    
	    logger.info("memberId=[{}], chatId=[{}]",memberId, chatId);
	    
	    mav.addObject("memberId", memberId);
	    mav.addObject("chatId", chatId);
		mav.addObject("memberId", memberId);
		
		mav.setViewName("help/talk");
		return mav;
		
		
	}
	
	/*@MessageMapping("/hello")
	@SendTo("/hello")
	public Msg stomp(Msg fromMessage,
					@Header("simpSessionId") String sessionId, //WebsocketSessionId값을 가져옴
					SimpMessageHeaderAccessor headerAccessor//HttpSessionHandshakeInterceptor빈을 통해 httpSession의 속성에 접근 가능함.
					) {
		logger.info("fromMessage={}", fromMessage);
		logger.info("@Header sessionId={}", sessionId); //WebsocketSessionId값을 가져옴.		
		
		//(생략)WesocketSessionId로 부터 httpSession속성 가져오기 테스트
	    //String sessionIdFromHeaderAccessor = headerAccessor.getSessionId();//@Header sessionId와 동일
	    //Map<String,Object> httpSessionAttr = headerAccessor.getSessionAttributes();
	    //Member member = (Member)httpSessionAttr.get("memberLoggedIn");
	    //String httpSessionId = (String)httpSessionAttr.get("HTTP.SESSION.ID");//비회원인 경우 chatId로 사용함.
	    
	    //logger.info("sessionIdFromHeaderAccessor={}",sessionIdFromHeaderAccessor);
	    //logger.info("httpSessionAttr={}",httpSessionAttr);
	    //logger.info("memberLoggedIn={}",member)
		
		logger.debug("fromMessage={}", fromMessage);
		
		return fromMessage;
	}*/
	
	private String getRandomChatId(int len){
		Random rnd = new Random();
		StringBuffer buf =new StringBuffer();
		buf.append("chat_");
		for(int i=0;i<len;i++){
			//임의의 참거짓에 따라 참=>영대소문자, 거짓=> 숫자
		    if(rnd.nextBoolean()){
		    	boolean isCap = rnd.nextBoolean();
		        buf.append((char)((int)(rnd.nextInt(26))+(isCap?65:97)));
		    }
		    else{
		        buf.append((rnd.nextInt(10))); 
		    }
		}
		return buf.toString();
	}
	
	@MessageMapping("/chat/{chatId}")
	@SendTo(value={"/chat/{chatId}", "/chat/supporter"})
	public Msg sendEcho(Msg fromMessage, @DestinationVariable String chatId, @Header("simpSessionId") String sessionId) {
		logger.info("fromMessage={}", fromMessage);
		logger.info("chatId={}", chatId);
		logger.info("sessionId={}", sessionId);
		
		talkService.insertChatLog(fromMessage);
		
		return fromMessage;
	}
	
	@MessageMapping("/lastCheck")
	@SendTo("/chat/supporter")
	public Msg lastCheck(@RequestBody Msg fromMessage) {
		logger.info("fromMessage={}", fromMessage);
		
		talkService.updateLastCheck(fromMessage);

		
		return fromMessage;
	}
	
	
	@RequestMapping("/help/supporter.do")
	public ModelAndView support(ModelAndView mav, HttpSession session) {
		//메소드 파라미터에 차후 추가 : @SessionAttribute(value="memberLoggedIn"), required=false) Member memberLoggedIn
		Member memberLoggedIn = ((Member) session.getAttribute("memberLoggedIn"));
		String memberId = Optional.ofNullable(memberLoggedIn)
                 		.map(Member::getMemberId)
                 		.orElse(session.getId());      
		
		//차후 서포터 아이디로 수정 (mapper에 있는 findRecentList 쿼리도 바꿔줄 것!)
		
		List<Map<String, String>> recentList = talkService.findRecentList();
		logger.info("recentList={}", recentList);
		
		mav.addObject("recentList", recentList);
		mav.setViewName("help/supporterTalk");
		return mav;
	}
}