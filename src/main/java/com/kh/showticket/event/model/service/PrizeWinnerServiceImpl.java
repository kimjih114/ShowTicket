package com.kh.showticket.event.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.showticket.event.model.dao.PrizeWinnerDAO;
import com.kh.showticket.event.model.vo.Prizewinner;

@Service
public class PrizeWinnerServiceImpl implements PrizeWinnerService {
	@Autowired
	PrizeWinnerDAO prizewinnerDAO;

	@Override
	public int winnerPrize(Prizewinner prize) {
		return prizewinnerDAO.winnerPrize(prize);
	}

	@Override
	public List<Prizewinner> selectWinner(int eventNo) {
		return prizewinnerDAO.selectWinner(eventNo);
	}
	
}
