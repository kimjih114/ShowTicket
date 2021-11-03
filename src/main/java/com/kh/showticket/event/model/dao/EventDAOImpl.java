package com.kh.showticket.event.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.event.model.vo.Event;
import com.kh.showticket.event.model.vo.EventAttachment;

@Repository
public class EventDAOImpl implements EventDAO {
	
	@Autowired
	SqlSessionTemplate session;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public List<Map<String, String>> searchEventList(String queryKeyword) {
		return session.selectList("event.searchEventList", queryKeyword);
	}

	@Override
	public int insertEAttachment(EventAttachment a) {
		return session.insert("event.insertEAttachment", a);
	}

	@Override
	public int insertEventEnd(Event event) {
		return session.insert("event.insertEventEnd", event);
	}

	@Override
	public List<Event> selectEventList() {
		return session.selectList("event.selectEventList");
	}

	@Override
	public Event selectOneEvent(int eventNo) {
		return session.selectOne("event.selectOneEvent", eventNo);
	}

	

}
