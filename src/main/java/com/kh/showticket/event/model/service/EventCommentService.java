package com.kh.showticket.event.model.service;

import java.util.List;

import com.kh.showticket.event.model.vo.Event;
import com.kh.showticket.event.model.vo.EventComment;
import com.kh.showticket.event.model.vo.EventVO;

public interface EventCommentService {

	int insertComment(EventComment eventComment);

	List<EventComment> eCommentList(int eventNo);

	int eCommentDelete(int commentNo);

	List<EventVO> selectOneEventJoin(int eventNo); 

	

}
