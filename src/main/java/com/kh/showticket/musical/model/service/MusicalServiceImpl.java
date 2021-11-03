package com.kh.showticket.musical.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.showticket.common.MusicalAndShow;
import com.kh.showticket.common.getApi.getApi;
import com.kh.showticket.coupon.model.vo.Coupon;
import com.kh.showticket.musical.model.dao.MusicalDAO;
import com.kh.showticket.review.model.dao.ReviewDAO;

@Service
public class MusicalServiceImpl implements MusicalService {
	
	@Autowired
	MusicalDAO musicalDAO;
	@Autowired
	ReviewDAO reviewDAO;
	
	getApi getApi = new getApi();
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public MusicalAndShow selectOne(String musicalId) {
		MusicalAndShow musical = getApi.getMusicalAndShow(musicalId);
		
		musical.setReviewStar(reviewDAO.selectReviewStar(musicalId));
		
		logger.debug(musical.toString());
		
		return musical;
	}

	@Override
	public Map<String, String> selectPlace(String url) {
		Map<String, String> map = getApi.getPlaceList(url);
		
		return map;
	}

	@Override
	public int insertWait(Map<String, String> userAndMusical) {
		return musicalDAO.insertWait(userAndMusical);
	}

	@Override
	public List<Coupon> selectCoupon(String musicalId) {
		return musicalDAO.selectCoupon(musicalId);
	}

	@Override
	public int selectDiscount(String musicalId) {
		return musicalDAO.selectDiscount(musicalId);
	}

	@Override
	public int totalReview(String musicalId) {
		return reviewDAO.totalReview(musicalId);
	}

}
