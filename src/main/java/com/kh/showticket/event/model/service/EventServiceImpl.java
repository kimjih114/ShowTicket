package com.kh.showticket.event.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.showticket.event.model.dao.EventDAO;
import com.kh.showticket.event.model.exception.EventException;
import com.kh.showticket.event.model.vo.Event;
import com.kh.showticket.event.model.vo.EventAttachment;


@Service
public class EventServiceImpl implements EventService {
	
	@Autowired
	EventDAO eventDAO;

	Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public List<Map<String, String>> searchEventList(String queryKeyword) {
		return eventDAO.searchEventList(queryKeyword);
	}

	@Override
	public int insertEventEnd(Event event, List<EventAttachment> eattachList) {
		int result = eventDAO.insertEventEnd(event); 
		
		if(result == 0) {
			throw new EventException("게시글 등록 오류!");
		}
		
		int eventNo = event.getEventNo(); 
		logger.debug("event={}",event);
		
		//첨부파일 등록
		if(eattachList.size() > 0) {
			for(EventAttachment a: eattachList) {
				a.setEventNo(eventNo);
				
				result = eventDAO.insertEAttachment(a);
				if(result == 0) {
					throw new EventException("첨부파일 등록 오류");
				}
				
			}
		}
		
		return result;
	}

	@Override
	public List<Event> selectEventList() {
		return eventDAO.selectEventList(); 
	}

	@Override
	public Event selectOneEvent(int eventNo) {
		return eventDAO.selectOneEvent(eventNo);
	}

	


	

}
