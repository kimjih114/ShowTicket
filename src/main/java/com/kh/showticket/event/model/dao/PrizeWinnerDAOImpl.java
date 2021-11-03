package com.kh.showticket.event.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.event.model.vo.Prizewinner;

@Repository
public class PrizeWinnerDAOImpl implements PrizeWinnerDAO {
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int winnerPrize(Prizewinner prize) {
		return sqlSession.insert("prizewinner.winnerPrize", prize);
	}

	@Override
	public List<Prizewinner> selectWinner(int eventNo) {
		return sqlSession.selectList("prizewinner.selectWinner", eventNo);
	}
	
	
}
