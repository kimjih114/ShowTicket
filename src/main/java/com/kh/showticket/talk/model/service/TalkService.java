package com.kh.showticket.talk.model.service;

import java.util.List;
import java.util.Map;

import com.kh.showticket.talk.model.vo.ChatRoom;
import com.kh.showticket.talk.model.vo.Msg;

public interface TalkService {

	String findChatIdByMemberId(String memberId);
	
	int insertChatRoom(List<ChatRoom> list);
	
	void insertChatLog(Msg fromMessage);

	void updateLastCheck(Msg fromMessage);

	List<Map<String,String>> findChatListByChatId(String chatId);

	List<Map<String, String>> findRecentList();
}
