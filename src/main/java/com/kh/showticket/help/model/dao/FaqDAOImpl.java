package com.kh.showticket.help.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.showticket.help.model.vo.Faq;

@Repository
public class FaqDAOImpl implements FaqDAO {
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int faqWriteEnd(Faq faq) {
		return sqlSession.insert("faq.faqWriteEnd", faq);
	}

	@Override
	public List<Faq> faqTicketList(Faq faq) {
		return sqlSession.selectList("faq.faqTicketList", faq);
	}

	
	@Override
	public List<Faq> faqList() {
		return sqlSession.selectList("faq.faqList");
	}

	@Override
	public Faq selectOne(int faqNo) {
		return sqlSession.selectOne("faq.selectOne", faqNo);
	}

	@Override
	public int faqUpdateEnd(Faq faq) {
		// TODO Auto-generated method stub
		return sqlSession.update("faq.faqUpdateEnd", faq);
	}

	@Override
	public int faqDelete(int faqNo) {
		return sqlSession.delete("faq.faqDelete",faqNo);
	}


}
