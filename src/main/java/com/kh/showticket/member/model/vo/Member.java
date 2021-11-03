package com.kh.showticket.member.model.vo;

import java.sql.Date;

public class Member {

	private String memberId;
	private String password;
	private String memberName;
	private String email;
	private String phone;
	private int member119Count;
	private Date enrollDate;
	private int point;
	private String memberGrade;
	private Date birth;
	private int emailAuthstatus;
	
	public Member() {
		super();
	}

	public Member(String memberId, String password, String memberName, String email, String phone, int member119Count,
			Date enrollDate, int point, String memberGrade, Date birth, int emailAuthstatus) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.memberName = memberName;
		this.email = email;
		this.phone = phone;
		this.member119Count = member119Count;
		this.enrollDate = enrollDate;
		this.point = point;
		this.memberGrade = memberGrade;
		this.birth = birth;
		this.emailAuthstatus = emailAuthstatus;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getMember119Count() {
		return member119Count;
	}

	public void setMember119Count(int member119Count) {
		this.member119Count = member119Count;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getMemberGrade() {
		return memberGrade;
	}

	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public int getEmailAuthstatus() {
		return emailAuthstatus;
	}

	public void setEmailAuthstatus(int emailAuthstatus) {
		this.emailAuthstatus = emailAuthstatus;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", password=" + password + ", memberName=" + memberName + ", email="
				+ email + ", phone=" + phone + ", member119Count=" + member119Count + ", enrollDate=" + enrollDate
				+ ", point=" + point + ", memberGrade=" + memberGrade + ", birth=" + birth + ", emailAuthstatus="
				+ emailAuthstatus + "]";
	}

}
