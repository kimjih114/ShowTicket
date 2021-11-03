package com.kh.showticket.event.model.vo;

import java.sql.Date;

public class EndDiscount {
	private String showId; 
	private int discountRate; 
	private Date discountStartDate; 
	private Date discountEndDate; 
	private String discountImg;
	private String showName; 
	private String showGenre;
	
	public EndDiscount() {
		super();
		// TODO Auto-generated constructor stub
	}

	public EndDiscount(String showId, int discountRate, Date discountStartDate, Date discountEndDate,
			String discountImg, String showName, String showGenre) {
		super();
		this.showId = showId;
		this.discountRate = discountRate;
		this.discountStartDate = discountStartDate;
		this.discountEndDate = discountEndDate;
		this.discountImg = discountImg;
		this.showName = showName;
		this.showGenre = showGenre;
	}

	public String getShowId() {
		return showId;
	}

	public void setShowId(String showId) {
		this.showId = showId;
	}

	public int getDiscountRate() {
		return discountRate;
	}

	public void setDiscountRate(int discountRate) {
		this.discountRate = discountRate;
	}

	public Date getDiscountStartDate() {
		return discountStartDate;
	}

	public void setDiscountStartDate(Date discountStartDate) {
		this.discountStartDate = discountStartDate;
	}

	public Date getDiscountEndDate() {
		return discountEndDate;
	}

	public void setDiscountEndDate(Date discountEndDate) {
		this.discountEndDate = discountEndDate;
	}

	public String getDiscountImg() {
		return discountImg;
	}

	public void setDiscountImg(String discountImg) {
		this.discountImg = discountImg;
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
		return "EndDiscount [showId=" + showId + ", discountRate=" + discountRate + ", discountStartDate="
				+ discountStartDate + ", discountEndDate=" + discountEndDate + ", discountImg=" + discountImg
				+ ", showName=" + showName + ", showGenre=" + showGenre + "]";
	}
	
	
	
	
	
	
}
