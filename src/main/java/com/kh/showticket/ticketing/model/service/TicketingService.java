package com.kh.showticket.ticketing.model.service;

import java.util.Map;

public interface TicketingService {

	int selectMyPoint(String memberId);

	void insertTicket(Map<String, Object> ticket);

}
