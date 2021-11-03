package com.kh.showticket.ticketing.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.showticket.ticketing.model.dao.TicketingDAO;

@Service
public class TicketingServiceImpl implements TicketingService {

	@Autowired
	TicketingDAO ticketingDAO;
	
	@Override
	public int selectMyPoint(String memberId) {
		return ticketingDAO.selectMyPoint(memberId);
	}

	@Override
	public void insertTicket(Map<String, Object> ticket) {
		ticketingDAO.insertTicket(ticket);
		
	}

}
