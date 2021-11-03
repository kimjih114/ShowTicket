package com.kh.showticket.member.model.dao;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.member.model.vo.Member;
import com.kh.showticket.member.model.vo.MyPoint;
import com.kh.showticket.member.model.vo.Ticket;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertMember(Member member) {
		return sqlSession.insert("member.insertMember", member);
	}

	@Override
	public Member selectOneMember(String memberId) {
		return sqlSession.selectOne("member.selectOneMember", memberId);
	}

	@Override
	public int deleteMember(String memberId) {
		return sqlSession.delete("member.deleteMember", memberId);
	}

	@Override
	public int updateMember(Member member) {
		return sqlSession.update("member.updateMember", member);
	}

	@Override
	public int updatePwd(Member member) {
		return sqlSession.update("member.updatePwd",member); 
	}

	@Override
	public List<Ticket> selectReservationList(Map<String, Object> paging) {
		return sqlSession.selectList("member.selectReservationList", paging);
	}
	
	@Override
	public int chkEmailUsable(String email) {
		return sqlSession.selectOne("member.chkEmailUsable", email);
	}

	@Override
	public List<MyPoint> selectMyPointList(String memberLoggedIn) {
		return sqlSession.selectList("member.selectMyPointList", memberLoggedIn);
	}

	@Override
	public List<String> selectMyStandByList(String memberLoggedIn) {
		return sqlSession.selectList("member.selectStandByList", memberLoggedIn);
	}

	@Override
	public void deleteMyStandBy(String memberLoggedIn, String showId) {
		Map<String, String> param = new HashMap<>();
		param.put("memberLoggedIn", memberLoggedIn);
		param.put("showId", showId);	
		sqlSession.delete("member.deleteMyStandBy", param);
	}

	public List<Ticket> selectReservationTerm(Map<String, Object> paging) {
		return sqlSession.selectList("member.selectReservationTerm", paging);
	}

	@Override
	public List<Ticket> selectReservationTerm15(Map<String, Object> paging) {
		return sqlSession.selectList("member.selectReservationTerm15", paging);
	}

	@Override
	public List<Ticket> selectReservationAll(Map<String, Object> paging) {
		return sqlSession.selectList("member.selectReservationAll", paging);
	}

	@Override
	public int updateReservation(Map<String, Object> cancel) {
		return sqlSession.update("member.updateReservation", cancel);
	}

	@Override
	public Map<String, String> selectOneTicketByNo(int ticketNo) {
		return sqlSession.selectOne("member.selectOneTicketByNo", ticketNo);
	}

	@Override
	public List<String> selectFollow(String memberId) {
		return sqlSession.selectList("member.selectFollow", memberId);
	}

	@Override
	public int deleteFollow(Map<String, String> follow) {
		return sqlSession.delete("member.deleteFollow", follow);
	}

	@Override
	public List<Ticket> selectRTotalCount() {
		return sqlSession.selectList("member.selectRTotalCount");
	}
	
	@Override
	public int updatePoint(String memberId) {
		return sqlSession.update("member.updatePoint", memberId);
	}


	@Override
	public List<Ticket> selectTotalCountA(Map<String,Object> paging) {
		return sqlSession.selectList("member.selectTotalCountA", paging);
	}

	@Override
	public List<Ticket> selectTotalCountT(Map<String,Object> paging) {
		return sqlSession.selectList("member.selectTotalCountT", paging);
	}

	@Override
	public List<Ticket> selectTotalCount15(Map<String,Object> paging) {
		return sqlSession.selectList("member.selectTotalCount15", paging);
	}

	@Override
	public String findIdByEmail(Map<String, String> memInfo) {
		return sqlSession.selectOne("member.findIdByEmail", memInfo);
	}
	
	@Override
	public String findIdByPhone(Map<String, String> memInfo) {
		return sqlSession.selectOne("member.findIdByPhone", memInfo);
	}

	@Override
	public List<String> selectWaitingIdListByShowId(String ticketShowId) {
		return sqlSession.selectList("member.selectWaitingIdListByShowId", ticketShowId);
	}

	@Override
	public int insertTicket(Ticket ticket) {
		return sqlSession.insert("member.insertTicket",ticket);
	}

	@Override
	public int countResult(Ticket ticket) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.countResult", ticket);
	}

	@Override
	public List<Ticket> getTicketList(Ticket ticket) {
		return sqlSession.selectList("member.getTicketList", ticket);
	}


}
