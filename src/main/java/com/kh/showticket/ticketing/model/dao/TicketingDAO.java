package com.kh.showticket.ticketing.model.dao;

import java.util.Map;

public interface TicketingDAO {

	int selectMyPoint(String memberId);

	void insertTicket(Map<String, Object> ticket);

}
