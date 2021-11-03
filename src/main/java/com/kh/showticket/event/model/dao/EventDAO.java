package com.kh.showticket.event.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.showticket.event.model.vo.Event;
import com.kh.showticket.event.model.vo.EventAttachment;

public interface EventDAO {

	List<Map<String, String>> searchEventList(String queryKeyword);

	int insertEAttachment(EventAttachment a);

	int insertEventEnd(Event event);

	List<Event> selectEventList();

	Event selectOneEvent(int eventNo);


}
