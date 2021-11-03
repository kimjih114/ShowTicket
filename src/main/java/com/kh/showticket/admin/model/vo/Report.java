package com.kh.showticket.admin.model.vo;

public class Report {

	private int reportNo;
	private String reportReason;
	private String reportMemberId;
	private String receiveMemberId;
	private int reviewNo;
	
	public Report() {
		super();
	}

	public Report(int reportNo, String reportReason, String reportMemberId, String receiveMemberId, int reviewNo) {
		super();
		this.reportNo = reportNo;
		this.reportReason = reportReason;
		this.reportMemberId = reportMemberId;
		this.receiveMemberId = receiveMemberId;
		this.reviewNo = reviewNo;
	}

	public int getReportNo() {
		return reportNo;
	}

	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}

	public String getReportReason() {
		return reportReason;
	}

	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}

	public String getReportMemberId() {
		return reportMemberId;
	}

	public void setReportMemberId(String reportMemberId) {
		this.reportMemberId = reportMemberId;
	}

	public String getReceiveMemberId() {
		return receiveMemberId;
	}

	public void setReceiveMemberId(String receiveMemberId) {
		this.receiveMemberId = receiveMemberId;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	@Override
	public String toString() {
		return "Report [reportNo=" + reportNo + ", reportReason=" + reportReason + ", reportMemberId=" + reportMemberId
				+ ", receiveMemberId=" + receiveMemberId + ", reviewNo=" + reviewNo + "]";
	}

	
}
