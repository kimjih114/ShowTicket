package com.kh.showticket.review.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.review.model.vo.Likes;
import com.kh.showticket.review.model.vo.Review;

@Repository
public class ReviewDAOImpl implements ReviewDAO{
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Review> reviewList(String reviewShowId) {
		return sqlSession.selectList("review.reviewList",reviewShowId);
	}

	@Override
	public int insertReview(Review review) {
		return sqlSession.insert("review.insertReview", review);
	}

	@Override
	public double selectReviewStar(String playId) {
		String ans = sqlSession.selectOne("review.selectReviewStar", playId);
		if(ans==null) {
			return -1.0;
		}
		else {
			return Double.parseDouble(ans);
		}
		//return sqlSession.selectOne("review.selectReviewStar", musicalId)==null?-1:sqlSession.selectOne("review.selectReviewStar", musicalId);
	}

	@Override
	public int deleteReview(int reviewNo) {
		return sqlSession.delete("review.deleteReview", reviewNo);
	}

	@Override
	public int checkLikes(Likes likes) {
		return sqlSession.selectOne("review.checkLikes", likes);
	}

	@Override
	public int downLikes(Likes likes) {
		return sqlSession.update("review.downLikes", likes);
	}

	@Override
	public int upLikes(Likes likes) {
		return sqlSession.update("review.upLikes", likes);
	}

	@Override
	public int deleteLikes(Likes likes) {
		return sqlSession.delete("review.deleteLikes", likes);
	}
	
	@Override
	public int insertLikes(Likes likes) {
		return sqlSession.insert("review.insertLikes", likes);
	}

	@Override
	public int selectOne(Likes likes) {
		return sqlSession.selectOne("review.selectOne", likes);
	}

	@Override
	public List<Likes> likesList(Likes likes) {
		return sqlSession.selectList("review.likesList", likes);
	}

	@Override
	public int totalReview(String musicalId) {
		return sqlSession.selectOne("review.totalReview", musicalId);
	}
}
