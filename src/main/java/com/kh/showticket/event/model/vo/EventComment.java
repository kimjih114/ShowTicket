package com.kh.showticket.event.model.vo;

import java.sql.Date;

public class EventComment {
	protected int commentNo; 
	protected int eventNo; 
	protected String memberId; 
	protected String commentContent; 
	protected Date CommentDate;
	
	public EventComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public EventComment(int commentNo, int eventNo, String memberId, String commentContent, Date commentDate) {
		super();
		this.commentNo = commentNo;
		this.eventNo = eventNo;
		this.memberId = memberId;
		this.commentContent = commentContent;
		CommentDate = commentDate;
	}

	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getEventNo() {
		return eventNo;
	}
	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public Date getCommentDate() {
		return CommentDate;
	}
	public void setCommentDate(Date commentDate) {
		CommentDate = commentDate;
	}
	@Override
	public String toString() {
		return "EventComment [commentNo=" + commentNo + ", eventNo=" + eventNo + ", memberId=" + memberId
				+ ", commentContent=" + commentContent + ", CommentDate=" + CommentDate + "]";
	} 
	
	
	
}
