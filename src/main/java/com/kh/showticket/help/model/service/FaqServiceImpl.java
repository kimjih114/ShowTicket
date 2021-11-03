package com.kh.showticket.help.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.kh.showticket.help.model.dao.FaqDAO;
import com.kh.showticket.help.model.vo.Faq;


@Transactional(propagation=Propagation.REQUIRED,
isolation=Isolation.READ_COMMITTED,
rollbackFor=Exception.class)
@Service
public class FaqServiceImpl implements FaqService {
	@Autowired
	FaqDAO faqDAO;

	@Override
	public int faqWriteEnd(Faq faq) {
		return faqDAO.faqWriteEnd(faq);
	}

	@Override
	public List<Faq> faqTicketList(Faq faq) {
		return faqDAO.faqTicketList(faq);
	}



	@Override
	public List<Faq> faqList() {
		// TODO Auto-generated method stub
		return faqDAO.faqList();
	}

	@Override
	public Faq selectOne(int faqNo) {
		// TODO Auto-generated method stub
		return faqDAO.selectOne(faqNo);
	}

	@Override
	public int faqUpdateEnd(Faq faq) {
		// TODO Auto-generated method stub
		return faqDAO.faqUpdateEnd(faq);
	}

	@Override
	public int faqDelete(int faqNo) {
		return faqDAO.faqDelete(faqNo);
	}

	
	
}
