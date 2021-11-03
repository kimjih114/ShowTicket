package com.kh.showticket.event.model.service;

import java.util.List;

import com.kh.showticket.event.model.vo.Prizewinner;

public interface PrizeWinnerService {

	int winnerPrize(Prizewinner prize);

	List<Prizewinner> selectWinner(int eventNo);

}
