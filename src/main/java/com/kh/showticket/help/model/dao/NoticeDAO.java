package com.kh.showticket.help.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.showticket.help.model.vo.Notice;

public interface NoticeDAO {

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
