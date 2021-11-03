package com.kh.showticket.event.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.showticket.event.model.dao.EndDiscountDAO;
import com.kh.showticket.event.model.vo.EndDiscount;

@Service
public class EndDiscountServiceImpl implements EndDiscountService {

	@Autowired
	EndDiscountDAO enddiscountDAO; 
		
	@Override
	public List<EndDiscount> selectEdcList() {
		return enddiscountDAO.selectEdcList(); 
	}

}
