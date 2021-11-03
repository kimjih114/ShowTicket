package com.kh.showticket.event.model.vo;

import java.sql.Date;

public class Discount {
	
	private String showId;
	private int disCountRate; 
	private Date disCountStartDate;
	private Date disCountEndDate;
	private String disCountImg;
	private String showName; 
	private String showGenre;
	
	public Discount() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Discount(String showId, int disCountRate, Date disCountStartDate, Date disCountEndDate, String disCountImg,
			String showName, String showGenre) {
		super();
		this.showId = showId;
		this.disCountRate = disCountRate;
		this.disCountStartDate = disCountStartDate;
		this.disCountEndDate = disCountEndDate;
		this.disCountImg = disCountImg;
		this.showName = showName;
		this.showGenre = showGenre;
	}

	public String getShowId() {
		return showId;
	}

	public void setShowId(String showId) {
		this.showId = showId;
	}

	public int getDisCountRate() {
		return disCountRate;
	}

	public void setDisCountRate(int disCountRate) {
		this.disCountRate = disCountRate;
	}

	public Date getDisCountStartDate() {
		return disCountStartDate;
	}

	public void setDisCountStartDate(Date disCountStartDate) {
		this.disCountStartDate = disCountStartDate;
	}

	public Date getDisCountEndDate() {
		return disCountEndDate;
	}

	public void setDisCountEndDate(Date disCountEndDate) {
		this.disCountEndDate = disCountEndDate;
	}

	public String getDisCountImg() {
		return disCountImg;
	}

	public void setDisCountImg(String disCountImg) {
		this.disCountImg = disCountImg;
	}

	public String getShowName() {
		return showName;
	}

	public void setShowName(String showName) {
		this.showName = showName;
	}

	public String getShowGenre() {
		return showGenre;
	}

	public void setShowGenre(String showGenre) {
		this.showGenre = showGenre;
	}
	

	@Override
	public String toString() {
		return "Discount [showId=" + showId + ", disCountRate=" + disCountRate + ", disCountStartDate="
				+ disCountStartDate + ", disCountEndDate=" + disCountEndDate + ", disCountImg=" + disCountImg
				+ ", showName=" + showName + ", showGenre=" + showGenre + "]";
	}

	
	
	
	
}
