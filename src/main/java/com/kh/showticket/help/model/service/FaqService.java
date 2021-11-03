package com.kh.showticket.help.model.service;

import java.util.List;

import com.kh.showticket.help.model.vo.Faq;

public interface FaqService {

	int faqWriteEnd(Faq faq);

	List<Faq> faqTicketList(Faq faq);


	List<Faq> faqList();

	Faq selectOne(int faqNo);

	int faqUpdateEnd(Faq faq);

	int faqDelete(int faqNo);

}
