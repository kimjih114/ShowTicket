package com.kh.showticket.musical.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.showticket.coupon.model.vo.Coupon;

public interface MusicalDAO {

	double selectReviewStar(String musicalId);

	int insertWait(Map<String, String> userAndMusical);

	List<Coupon> selectCoupon(String musicalId);

	int selectDiscount(String musicalId);

}
