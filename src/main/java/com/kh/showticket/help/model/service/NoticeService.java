package com.kh.showticket.help.model.service;

import java.util.List;
import java.util.Map;

import com.kh.showticket.help.model.vo.Notice;

public interface NoticeService {

	int NUM_PER_PAGE = 15;
	
	List<Notice> selectNoticeTicketOpenList(int cPage);

	Notice selectOne(int noticeNo);

	int noticeWrite(Notice notice);

	int noticeUpdate(Notice notice);

	int noticeDelete(int noticeNo);

	int increaseReadCount(int noticeNo);

	List<Notice> noticeList(Notice notice);

	int insertFollow(Map<String, String> userAndMusical);

	List<Notice> selectList();

}
