package com.kh.showticket.event.model.vo;

import java.sql.Date;
import java.util.List;

import com.kh.showticket.member.model.vo.Member;

public class EventVO extends EventComment{
	
	private List<Member> memberList;

	public EventVO() {
		super();
	}

	public EventVO(int commentNo, int eventNo, String memberId, String commentContent, Date commentDate,
			List<Member> memberList) {
		super(commentNo, eventNo, memberId, commentContent, commentDate);
		this.memberList = memberList;
	}

	public List<Member> getMemberList() {
		return memberList;
	}

	public void setMemberList(List<Member> memberList) {
		this.memberList = memberList;
	}

	@Override
	public String toString() {
		return "EventVO [memberList=" + memberList + ", commentNo=" + commentNo + ", eventNo=" + eventNo + ", memberId="
				+ memberId + ", commentContent=" + commentContent + ", CommentDate=" + CommentDate + "]";
	}

	
	


	
	
	
	
}
