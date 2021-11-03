package com.kh.showticket.event.model.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.showticket.event.model.dao.DiscountDAO;
import com.kh.showticket.event.model.vo.Discount;

@Service
public class DiscountServiceImpl implements DiscountService {

	@Autowired 
	DiscountDAO discountDAO;

	@Override
	public int insertAddSale(Discount discount) {
		return discountDAO.insertAddSale(discount);
	}

	@Override
	public int checkCnt() {
		return discountDAO.checkCnt(); 
	}

	@Override
	public int deleteAddSale() {
		return discountDAO.deleteAddSale(); 
	}

	@Override
	public List<Discount> selectdcList() {
		return discountDAO.selectdcList(); 
	}

	@Override
	public Discount selectOneDc(String evtID) {
		return discountDAO.selectOneDc(evtID);
	}

}
