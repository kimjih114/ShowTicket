package com.kh.showticket.event.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.showticket.event.model.dao.EventCommentDAO;
import com.kh.showticket.event.model.vo.EventComment;
import com.kh.showticket.event.model.vo.EventVO;



@Service
public class EventCommentServiceImpl implements EventCommentService {

	@Autowired 
	EventCommentDAO  eventCommentDAO;

	@Override
	public int insertComment(EventComment eventComment) {
		return eventCommentDAO.insertComment(eventComment); 
	}

	@Override
	public List<EventComment> eCommentList(int eventNo) {
		return eventCommentDAO.eCommentList(eventNo);
	}

	@Override
	public int eCommentDelete(int commentNo) {
		return eventCommentDAO.eCommentDelete(commentNo);
	}

	
    @Override public List<EventVO> selectOneEventJoin(int eventNo) {
		 return eventCommentDAO.selectOneEventJoin(eventNo);
	}
	 

	
	
}
