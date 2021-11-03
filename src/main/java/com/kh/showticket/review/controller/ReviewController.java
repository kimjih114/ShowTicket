package com.kh.showticket.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.showticket.review.model.service.ReviewService;
import com.kh.showticket.review.model.vo.Likes;
import com.kh.showticket.review.model.vo.Review;

@RestController
@RequestMapping("/review")
@SessionAttributes("memberLoggedIn")
public class ReviewController {

	@Autowired
	ReviewService reviewService;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	
	@GetMapping(value="/reviewList.do")
	public List<Review> reviewList(@RequestParam("reviewShowId") String reviewShowId) {
		logger.debug("get로 넘어온 .Review:"+reviewShowId);
		List<Review> list = reviewService.reviewList(reviewShowId);
		logger.debug("reviewList="+list);
		return list;
	}
	
	@PostMapping(value="/insertReview.do")
	public Map<String, String> insertReview(@RequestBody Review review){
		logger.info("review=", review);
		int result = reviewService.insertReview(review);
		Map<String, String> map = new HashMap<>();
		map.put("msg", "댓글을 등록하셨습니다!");
		return map;
	}
	@DeleteMapping(value="/deleteReview.do")
	public Map<String, String> deleteReview(@RequestBody Review review){
		logger.info("reviewNo:"+review.getReviewNo());
		int reviewNo = review.getReviewNo();
		Map<String, String> map = new HashMap<>();
		int result = reviewService.deleteReview(reviewNo);
		
		map.put("msg", "댓글을 삭제하셨습니다!");
		return map;
	}
	@RequestMapping(value="/reviewLikes.do", method=RequestMethod.POST)
	public int updateLikes(@RequestBody Likes likes){
		//댓글 번호 아이디 받아옴 리뷰넘버
		int check = reviewService.checkLikes(likes);
		//1. 좋아요 누른경우
		if( check > 0) {
			//좋아요 테이블에서 아이디 삭제
			   int del = reviewService.deleteLikes(likes);
			//좋아요 -1
			   int result = reviewService.downLikes(likes);
		}
		//2. 좋아요 안누른 경우
		else {
			 int ins = reviewService.insertLikes(likes);
			 int result = reviewService.upLikes(likes);
		}
		int total = reviewService.selectOne(likes);
		return total;
	}
	@RequestMapping(value="/likesList.do", method=RequestMethod.POST)
	public List<Likes> likesList(@RequestBody Likes likes){
		List<Likes> list = reviewService.likesList(likes);
		
		return list;
	}
}
