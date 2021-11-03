package com.kh.showticket.help.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.help.model.service.NoticeService;
import com.kh.showticket.help.model.vo.Notice;
@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<Notice> selectNoticeTicketOpenList(int cPage) {
	
		int offset = (cPage-1)*NoticeService.NUM_PER_PAGE;
		int limit = NoticeService.NUM_PER_PAGE;
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		
		return sqlSession.selectList("notice.selectNoticeTicketOpenList",null,rowBounds);
	}

	@Override
	public Notice selectOne(int noticeNo) {
		return sqlSession.selectOne("notice.selectOne", noticeNo);
	}

	@Override
	public int noticeWrite(Notice notice) {
		return sqlSession.insert("notice.noticeWrite", notice);
	}

	@Override
	public int noticeUpdate(Notice notice) {
		return sqlSession.update("notice.noticeUpdate", notice);
	}

	@Override
	public int noticeDelete(int noticeNo) {
		return sqlSession.delete("notice.noticeDelete", noticeNo);
	}

	@Override
	public int increaseReadCount(int noticeNo) {
		return sqlSession.update("notice.increaseReadCount", noticeNo);
	}

	@Override
	public List<Notice> noticeList(Notice notice) {
		return sqlSession.selectList("notice.noticeList", notice);
	}

	@Override
	public int insertFollow(Map<String, String> userAndMusical) {
		return sqlSession.insert("notice.insertFollow", userAndMusical);
	}

	@Override
	public List<Notice> selectList() {
		return sqlSession.selectList("notice.selectList");
	}

}
