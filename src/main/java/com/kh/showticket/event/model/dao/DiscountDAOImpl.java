package com.kh.showticket.event.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.event.model.vo.Discount;
@Repository
public class DiscountDAOImpl implements DiscountDAO {
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertAddSale(Discount discount) {
		return sqlSession.insert("discount.insertAddSale",discount);
	}

	@Override
	public int checkCnt() {
		return sqlSession.selectOne("discount.checkCnt");
	}

	@Override
	public int deleteAddSale() {
		return sqlSession.delete("discount.deleteAddSale"); 
	}

	@Override
	public List<Discount> selectdcList() {
		return sqlSession.selectList("discount.selectdcList"); 
	}

	@Override
	public Discount selectOneDc(String evtID) {
		return sqlSession.selectOne("discount.selectOneDc", evtID);
	}

	
	
	
}
