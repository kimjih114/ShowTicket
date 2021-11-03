package com.kh.showticket.help.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.showticket.help.model.dao.NoticeDAO;
import com.kh.showticket.help.model.vo.Notice;

@Transactional(propagation=Propagation.REQUIRED,
isolation=Isolation.READ_COMMITTED,
rollbackFor=Exception.class)
@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDAO noticeDAO;
	
	@Override
	public List<Notice> selectNoticeTicketOpenList(int cPage) {
		return noticeDAO.selectNoticeTicketOpenList(cPage);
	}

	@Override
	public Notice selectOne(int noticeNo) {	
		return noticeDAO.selectOne(noticeNo);
	}

	@Override
	public int noticeWrite(Notice notice) {
		return noticeDAO.noticeWrite(notice);
	}

	@Override
	public int noticeUpdate(Notice notice) {
		return noticeDAO.noticeUpdate(notice);
	}

	@Override
	public int noticeDelete(int noticeNo) {
		return noticeDAO.noticeDelete(noticeNo);
	}

	@Override
	public int increaseReadCount(int noticeNo) {
		return noticeDAO.increaseReadCount(noticeNo);		
	}

	@Override
	public List<Notice> noticeList(Notice notice) {
		return noticeDAO.noticeList(notice);
	}

	@Override
	public int insertFollow(Map<String, String> userAndMusical) {
		return noticeDAO.insertFollow(userAndMusical);
	}

	@Override
	public List<Notice> selectList() {
		return noticeDAO.selectList();
	}
	
}
