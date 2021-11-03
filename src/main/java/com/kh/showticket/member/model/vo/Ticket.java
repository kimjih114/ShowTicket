package com.kh.showticket.member.model.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Ticket {

	private int ticketNo;
	private String ticketBuyer;
	private String ticketShowId;
	private int ticketPrice;
	private String ticketGrade;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date ticketDate;
	private String ticketPlace;
	private int ticketCount;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date ticketEnrollDate;
	private String ticketSeat;
	private String ticketTime;
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date ticketCancel;
	private String ticketStatus;
	private int payNo;
	private String ticketShowName;
	
	public Ticket() {
		super();
	}

	public Ticket(int ticketNo, String ticketBuyer, String ticketShowId, int ticketPrice, String ticketGrade,
			Date ticketDate, String ticketPlace, int ticketCount, Date ticketEnrollDate, String ticketSeat,
			String ticketTime, Date ticketCancel, String ticketStatus, int payNo, String ticketShowName) {
		super();
		this.ticketNo = ticketNo;
		this.ticketBuyer = ticketBuyer;
		this.ticketShowId = ticketShowId;
		this.ticketPrice = ticketPrice;
		this.ticketGrade = ticketGrade;
		this.ticketDate = ticketDate;
		this.ticketPlace = ticketPlace;
		this.ticketCount = ticketCount;
		this.ticketEnrollDate = ticketEnrollDate;
		this.ticketSeat = ticketSeat;
		this.ticketTime = ticketTime;
		this.ticketCancel = ticketCancel;
		this.ticketStatus = ticketStatus;
		this.payNo = payNo;
		this.ticketShowName = ticketShowName;
	}

	public int getTicketNo() {
		return ticketNo;
	}

	public void setTicketNo(int ticketNo) {
		this.ticketNo = ticketNo;
	}

	public String getTicketBuyer() {
		return ticketBuyer;
	}

	public void setTicketBuyer(String ticketBuyer) {
		this.ticketBuyer = ticketBuyer;
	}

	public String getTicketShowId() {
		return ticketShowId;
	}

	public void setTicketShowId(String ticketShowId) {
		this.ticketShowId = ticketShowId;
	}

	public int getTicketPrice() {
		return ticketPrice;
	}

	public void setTicketPrice(int ticketPrice) {
		this.ticketPrice = ticketPrice;
	}

	public String getTicketGrade() {
		return ticketGrade;
	}

	public void setTicketGrade(String ticketGrade) {
		this.ticketGrade = ticketGrade;
	}

	public Date getTicketDate() {
		return ticketDate;
	}

	public void setTicketDate(Date ticketDate) {
		this.ticketDate = ticketDate;
	}

	public String getTicketPlace() {
		return ticketPlace;
	}

	public void setTicketPlace(String ticketPlace) {
		this.ticketPlace = ticketPlace;
	}

	public int getTicketCount() {
		return ticketCount;
	}

	public void setTicketCount(int ticketCount) {
		this.ticketCount = ticketCount;
	}

	public Date getTicketEnrollDate() {
		return ticketEnrollDate;
	}

	public void setTicketEnrollDate(Date ticketEnrollDate) {
		this.ticketEnrollDate = ticketEnrollDate;
	}

	public String getTicketSeat() {
		return ticketSeat;
	}

	public void setTicketSeat(String ticketSeat) {
		this.ticketSeat = ticketSeat;
	}

	public String getTicketTime() {
		return ticketTime;
	}

	public void setTicketTime(String ticketTime) {
		this.ticketTime = ticketTime;
	}

	public Date getTicketCancel() {
		return ticketCancel;
	}

	public void setTicketCancel(Date ticketCancel) {
		this.ticketCancel = ticketCancel;
	}

	public String getTicketStatus() {
		return ticketStatus;
	}

	public void setTicketStatus(String ticketStatus) {
		this.ticketStatus = ticketStatus;
	}

	public int getPayNo() {
		return payNo;
	}

	public void setPayNo(int payNo) {
		this.payNo = payNo;
	}

	public String getTicketShowName() {
		return ticketShowName;
	}

	public void setTicketShowName(String ticketShowName) {
		this.ticketShowName = ticketShowName;
	}

	@Override
	public String toString() {
		return "Ticket [ticketNo=" + ticketNo + ", ticketBuyer=" + ticketBuyer + ", ticketShowId=" + ticketShowId
				+ ", ticketPrice=" + ticketPrice + ", ticketGrade=" + ticketGrade + ", ticketDate=" + ticketDate
				+ ", ticketPlace=" + ticketPlace + ", ticketCount=" + ticketCount + ", ticketEnrollDate="
				+ ticketEnrollDate + ", ticketSeat=" + ticketSeat + ", ticketTime=" + ticketTime + ", ticketCancel="
				+ ticketCancel + ", ticketStatus=" + ticketStatus + ", payNo=" + payNo + ", ticketShowName="
				+ ticketShowName + "]";
	}
	
	
}
