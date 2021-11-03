package com.kh.showticket.help.model.dao;

import java.util.List;

import com.kh.showticket.help.model.vo.Faq;

public interface FaqDAO {

	int faqWriteEnd(Faq faq);

	List<Faq> faqTicketList(Faq faq);

	List<Faq> faqList();

	Faq selectOne(int faqNo);

	int faqUpdateEnd(Faq faq);

	int faqDelete(int faqNo);

}
