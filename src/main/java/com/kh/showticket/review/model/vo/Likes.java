package com.kh.showticket.review.model.vo;

public class Likes {
	private int likesNo;
	private String likesId;
	private int reviewNo;
	
	public Likes() {}

	public Likes(int likesNo, String likesId, int reviewNo) {
		super();
		this.likesNo = likesNo;
		this.likesId = likesId;
		this.reviewNo = reviewNo;
	}

	public int getLikesNo() {
		return likesNo;
	}

	public void setLikesNo(int likesNo) {
		this.likesNo = likesNo;
	}

	public String getLikesId() {
		return likesId;
	}

	public void setLikesId(String likesId) {
		this.likesId = likesId;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	@Override
	public String toString() {
		return "Likes [likesNo=" + likesNo + ", likesId=" + likesId + ", reviewNo=" + reviewNo + "]";
	}
	
	
}
