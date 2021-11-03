package com.kh.showticket.event.model.dao;

import java.util.List;

import com.kh.showticket.event.model.vo.Discount;

public interface DiscountDAO {

	int insertAddSale(Discount discount);

	int checkCnt();

	int deleteAddSale();

	List<Discount> selectdcList();

	Discount selectOneDc(String evtID);



}
