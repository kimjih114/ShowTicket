package com.kh.showticket.event.model.dao;

import java.util.List;

import com.kh.showticket.event.model.vo.Prizewinner;

public interface PrizeWinnerDAO {

	int winnerPrize(Prizewinner prize);

	List<Prizewinner> selectWinner(int eventNo);

}
