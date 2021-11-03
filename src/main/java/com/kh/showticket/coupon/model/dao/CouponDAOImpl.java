package com.kh.showticket.coupon.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.coupon.model.vo.Coupon;
import com.kh.showticket.coupon.model.vo.MyCoupon;

@Repository
public class CouponDAOImpl implements CouponDAO {
	
	@Autowired
	SqlSessionTemplate session;
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public List<Coupon> selectCouponList() {
		return session.selectList("coupon.selectCouponList");
	}
	
	@Override
	public Coupon selectCoupon(int couponNo) {
		return session.selectOne("coupon.selectCoupon", couponNo);
	}

	@Override
	public void couponDownload(Coupon coupon, String memberLoggedIn) {
		Map<String, Object> param = new HashMap<>();
		param.put("coupon", coupon);
		param.put("memberLoggedIn", memberLoggedIn);
		session.insert("coupon.couponDonwlod", param);
	}

	@Override
	public List<Map<String, String>> selectMyCouponList(String memberLoggedIn) {
		return session.selectList("coupon.selectMyCouponList", memberLoggedIn);
	}

	@Override
	public int insertCouponAdd(Map<String, Object> addMap) {
		return session.insert("coupon.insertCouponAdd", addMap);
	}

	@Override
	public int updateEditCoupon(Map<String, Object> addMap) {
		return session.update("coupon.updateEditCoupon", addMap);
	}

	@Override
	public int deleteCoupon(int couponNo) {
		return session.delete("coupon.deleteCoupon", couponNo);
	}

	@Override
	public List<Map<String, String>> selectCouponListbyPlayId(Map<String, String> memAndPlay) {
		return session.selectList("coupon.couponListbyPlayId",memAndPlay);
	}

	

}
