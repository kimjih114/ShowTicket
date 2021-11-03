package com.kh.showticket.review.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.showticket.review.model.dao.ReviewDAO;
import com.kh.showticket.review.model.vo.Likes;
import com.kh.showticket.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	ReviewDAO reviewDAO;

	@Override
	public List<Review> reviewList(String reviewShowId) {
		return reviewDAO.reviewList(reviewShowId);
	}

	@Override
	public int insertReview(Review review) {
		return reviewDAO.insertReview(review);
	}

	@Override
	public int deleteReview(int reviewNo) {
		return reviewDAO.deleteReview(reviewNo);
	}

	@Override
	public int checkLikes(Likes likes) {
		return reviewDAO.checkLikes(likes);
	}

	@Override
	public int downLikes(Likes likes) {
		return reviewDAO.downLikes(likes);
	}

	@Override
	public int upLikes(Likes likes) {
		return reviewDAO.upLikes(likes);
	}

	@Override
	public int deleteLikes(Likes likes) {
		return reviewDAO.deleteLikes(likes);
	}

	@Override
	public int insertLikes(Likes likes) {
		return reviewDAO.insertLikes(likes);
	}

	@Override
	public int selectOne(Likes likes) {
		return reviewDAO.selectOne(likes);
	}

	@Override
	public List<Likes> likesList(Likes likes) {
		return reviewDAO.likesList(likes);
	}
}
