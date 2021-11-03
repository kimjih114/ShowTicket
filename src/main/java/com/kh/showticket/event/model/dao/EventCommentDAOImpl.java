package com.kh.showticket.event.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.event.model.vo.EventComment;
import com.kh.showticket.event.model.vo.EventVO;

@Repository
public class EventCommentDAOImpl implements EventCommentDAO {
	@Autowired 
	SqlSessionTemplate session;

	@Override
	public int insertComment(EventComment eventComment) {
		return session.insert("eventcomment.insertComment", eventComment);
	}

	@Override
	public List<EventComment> eCommentList(int eventNo) {
		return session.selectList("eventcomment.eCommentList", eventNo);
	}

	@Override
	public int eCommentDelete(int commentNo) {
		return session.delete("eventcomment.eCommentDelete", commentNo);
	}

	@Override public List<EventVO> selectOneEventJoin(int eventNo) { 
		return session.selectList("eventcomment.selectOneEventJoin", eventNo);
	}

	
	
}
