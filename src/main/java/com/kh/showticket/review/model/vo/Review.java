package com.kh.showticket.review.model.vo;



import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Review {
	private int reviewNo;
	private String reviewShowId;
	private String reviewWriter;
	private String reviewContent;
	private int reviewLike;
	private double reviewStar;
	 @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MMM-dd HH:mm:ss")
	private Date reviewDate;
	
	public Review() {}

		
	public Review(int reviewNo, String reviewShowId, String reviewWriter, String reviewContent, int reviewLike,
			double reviewStar, Date reviewDate) {
		super();
		this.reviewNo = reviewNo;
		this.reviewShowId = reviewShowId;
		this.reviewWriter = reviewWriter;
		this.reviewContent = reviewContent;
		this.reviewLike = reviewLike;
		this.reviewStar = reviewStar;
		this.reviewDate = reviewDate;
	}


	public int getReviewNo() {
		return reviewNo;
	}

	public String getReviewShowId() {
		return reviewShowId;
	}

	public String getReviewWriter() {
		return reviewWriter;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public int getReviewLike() {
		return reviewLike;
	}

	public double getReviewStar() {
		return reviewStar;
	}

	public Date getReviewDate() {
		return reviewDate;
	}

	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", reviewShowId=" + reviewShowId + ", reviewWriter=" + reviewWriter
				+ ", reviewContent=" + reviewContent + ", reviewLike=" + reviewLike + ", reviewStar=" + reviewStar
				+ ", reviewDate=" + reviewDate + "]";
	}
	
	
}
