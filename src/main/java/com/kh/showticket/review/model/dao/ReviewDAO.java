package com.kh.showticket.review.model.dao;

import java.util.List;

import com.kh.showticket.review.model.vo.Likes;
import com.kh.showticket.review.model.vo.Review;

public interface ReviewDAO {

	List<Review> reviewList(String reviewShowId);

	int insertReview(Review review);

	double selectReviewStar(String playId);

	int deleteReview(int reviewNo);

	int checkLikes(Likes likes);

	int downLikes(Likes likes);

	int upLikes(Likes likes);

	int deleteLikes(Likes likes);

	int insertLikes(Likes likes);

	int selectOne(Likes likes);

	List<Likes> likesList(Likes likes);

	int totalReview(String musicalId);

}
