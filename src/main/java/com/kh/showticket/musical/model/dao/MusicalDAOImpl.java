
package com.kh.showticket.musical.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.coupon.model.vo.Coupon;

@Repository
public class MusicalDAOImpl implements MusicalDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public double selectReviewStar(String musicalId) {
		String ans = sqlSession.selectOne("musical.selectReviewStar", musicalId);
		if(ans==null) {
			return -1.0;
		}
		else {
			return Double.parseDouble(ans);
		}
	}

	@Override
	public int insertWait(Map<String, String> userAndMusical) {
		return sqlSession.insert("musical.insertWait", userAndMusical);
	}

	@Override
	public List<Coupon> selectCoupon(String musicalId) {
		return sqlSession.selectList("musical.selectCoupon", musicalId);
	}

	@Override
	public int selectDiscount(String musicalId) {
		String ans = sqlSession.selectOne("musical.selectDiscount", musicalId);
		if(ans==null) {
			return 0;
		}
		else {
			return Integer.parseInt(ans);
		}
	}
	
	
}
