package com.kh.showticket.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.showticket.admin.model.dao.AdminDAO;
import com.kh.showticket.admin.model.vo.Report;
import com.kh.showticket.member.model.vo.Member;
import com.kh.showticket.review.model.vo.Review;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public List<Report> selectAdminReportList(Map<String,Object> paging) {
		return adminDAO.selectAdminReportList(paging);
	}

	@Override
	public List<Report> selectOneAdminReportList(int reportNo) {
		return adminDAO.selectOneAdminReportList(reportNo);
	}

	@Override
	public List<Review> selectOneAdminReviewList(int reviewNo) {
		return adminDAO.selectOneAdminReviewList(reviewNo);
	}

	@Override
	public int updateReport(Map<String, Object> info) {
		return adminDAO.updateReport(info);
	}

	@Override
	public List<Member> adminMemberList(Map<String,Object> paging) {
		return adminDAO.adminMemberList(paging);
	}

	@Override
	public int deleteReport(int reviewNo) {
		return adminDAO.deleteReport(reviewNo);
	}

	@Override
	public int deleteMember(String memberId) {
		return adminDAO.deleteMember(memberId);
	}

	@Override
	public List<Report> selectTotalCount() {
		return adminDAO.selectTotalCount();
	}

	@Override
	public List<Report> selectMemberTotalCount() {
		return adminDAO.selectMemberTotalCount();
	}

	@Override
	public List<Member> selectMemberByMemberId(Map<String,Object> paging) {
		return adminDAO.selectMemberByMemberId(paging);
	}

	@Override
	public List<Member> selectMemberByMemberName(Map<String, Object> paging) {
		return adminDAO.selectMemberByMemberName(paging);
	}

	@Override
	public List<Member> FinderSelectTotalContentId(String searchKeyword) {
		return adminDAO.FinderSelectTotalContentId(searchKeyword);
	}

	@Override
	public List<Member> FinderSelectTotalContentName(String searchKeyword) {
		return adminDAO.FinderSelectTotalContentName(searchKeyword);
	}

	@Override
	public int insertReport(Report report) {
		return adminDAO.insertReport(report);
	}

	@Override
	public int checkReport(Report report) {
		return adminDAO.checkReport(report);
	}



}
