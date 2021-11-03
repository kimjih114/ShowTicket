package com.kh.showticket.review.model.service;

import java.util.List;

import com.kh.showticket.review.model.vo.Likes;
import com.kh.showticket.review.model.vo.Review;

public interface ReviewService {

	List<Review> reviewList(String reviewShowId);

	int insertReview(Review review);

	int deleteReview(int reviewNo);

	int checkLikes(Likes likes);

	int downLikes(Likes likes);

	int upLikes(Likes likes);

	int deleteLikes(Likes likes);

	int insertLikes(Likes likes);

	int selectOne(Likes likes);

	List<Likes> likesList(Likes likes);

}
