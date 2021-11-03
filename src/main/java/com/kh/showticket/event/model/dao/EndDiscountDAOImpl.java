package com.kh.showticket.event.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.event.model.vo.EndDiscount;

@Repository
public class EndDiscountDAOImpl implements EndDiscountDAO {
	@Autowired 
	SqlSessionTemplate sqlSession;

	@Override
	public List<EndDiscount> selectEdcList() {
		return sqlSession.selectList("enddiscount.selectEdcList");
	} 
	
	
	
}
