package com.kh.showticket.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.admin.model.vo.Report;
import com.kh.showticket.member.model.vo.Member;
import com.kh.showticket.review.model.vo.Review;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Report> selectAdminReportList(Map<String,Object> paging) {
		return sqlSession.selectList("admin.selectAdminReportList",paging);
	}

	@Override
	public List<Report> selectOneAdminReportList(int reportNo) {
		return sqlSession.selectList("admin.selectOneAdminReportList",reportNo);
	}

	@Override
	public List<Review> selectOneAdminReviewList(int reviewNo) {
		return sqlSession.selectList("admin.selectOneAdminReviewList", reviewNo);
	}

	@Override
	public int updateReport(Map<String, Object> info) {
		return sqlSession.update("admin.updateReport", info);
	}

	@Override
	public List<Member> adminMemberList(Map<String,Object> paging) {
		return sqlSession.selectList("admin.adminMemberList", paging);
	}

	@Override
	public int deleteReport(int reviewNo) {
		return sqlSession.delete("admin.deleteReport", reviewNo);
	}

	@Override
	public int deleteMember(String memberId) {
		return sqlSession.delete("admin.deleteMember", memberId);
	}

	@Override
	public List<Report> selectTotalCount() {
		return sqlSession.selectList("admin.selectTotalCount");
	}

	@Override
	public List<Report> selectMemberTotalCount() {
		return sqlSession.selectList("admin.selectMemberTotalCount");
	}

	@Override
	public List<Member> selectMemberByMemberId(Map<String,Object> paging) {
		return sqlSession.selectList("admin.selectMemberByMemberId", paging);
	}

	@Override
	public List<Member> selectMemberByMemberName(Map<String, Object> paging) {
		return sqlSession.selectList("admin.selectMemberByMemberName", paging);
	}

	@Override
	public List<Member> FinderSelectTotalContentId(String searchKeyword) {
		return sqlSession.selectList("admin.FinderSelectTotalContentId", searchKeyword);
	}

	@Override
	public List<Member> FinderSelectTotalContentName(String searchKeyword) {
		return sqlSession.selectList("admin.FinderSelectTotalContentName", searchKeyword);
	}

	@Override
	public int insertReport(Report report) {
		return sqlSession.insert("admin.insertReport", report);
	}

	@Override
	public int checkReport(Report report) {
		return sqlSession.selectOne("admin.checkReport", report);
	}


}
