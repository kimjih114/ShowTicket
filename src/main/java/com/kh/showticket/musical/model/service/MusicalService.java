package com.kh.showticket.musical.model.service;

import java.util.List;
import java.util.Map;

import com.kh.showticket.common.MusicalAndShow;
import com.kh.showticket.coupon.model.vo.Coupon;

public interface MusicalService {

	MusicalAndShow selectOne(String musicalId);

	Map<String, String> selectPlace(String url);

	int insertWait(Map<String, String> userAndMusical);

	List<Coupon> selectCoupon(String musicalId);

	int selectDiscount(String musicalId);

	int totalReview(String musicalId);

}
