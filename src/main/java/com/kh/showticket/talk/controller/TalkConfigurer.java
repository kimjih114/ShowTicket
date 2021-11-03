package com.kh.showticket.talk.controller;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Configuration
@EnableWebSocketMessageBroker
public class TalkConfigurer implements WebSocketMessageBrokerConfigurer {
	
	/**
	 * stomp로 접속한 경우의 connectEndPoint설정: client단의 'Stomp.over(socket)'에 대응함.
	 * 내부적으로 SockJS를 통해, websocket, xhr-streaming, xhr-polling 중에 가장 적합한 transport를 찾음.
	 */
	
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/stomp")
				.withSockJS()
				.setInterceptors(new HttpSessionHandshakeInterceptor());
				//이 인터셉터를 통해 HttpSession객체에 접근할 수 있다.
	}
	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		//핸들러 메소드의 @SendTo에 대응함. 여기에 등록된 url을 subscribe하는 client에게 전송
		registry.enableSimpleBroker("/chat", "/lastCheck");
		
		//prefix로 contextPath를 달고 @Controller의 핸들러메소드 @MessageMapping을 찾는다.
		registry.setApplicationDestinationPrefixes("/showticket"); //contextPath
	}

}
