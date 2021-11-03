package com.kh.showticket.help.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.help.model.service.FaqService;
import com.kh.showticket.help.model.service.NoticeService;
import com.kh.showticket.help.model.vo.Faq;
import com.kh.showticket.help.model.vo.Notice;

@RestController
@RequestMapping("/help")
@SessionAttributes("memberLoggedIn")
public class HelpController {
	
	@Autowired
	FaqService faqService;
	
	@Autowired
	NoticeService noticeService;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	
	@RequestMapping("/main.do")
	public ModelAndView main(ModelAndView mav) {
//		logger.debug("help페이지 요청");
		
		List<Notice> noticeList = noticeService.selectList();
		mav.addObject("noticeList", noticeList);
		mav.setViewName("help/main");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/faq.do")
	public ModelAndView faq(ModelAndView mav) {
//		logger.debug("help페이지 요청");
		
		 List<Faq> faqTicketList = faqService.faqList();
		 logger.debug("faqTicketList="+faqTicketList); 
		 mav.addObject("list",faqTicketList);
		 
		mav.setViewName("help/faq/faq");
		return mav;
	}
	@RequestMapping("/faqWrite.do")
	public ModelAndView faqWrite(ModelAndView mav) {
//		logger.debug("help페이지 요청");
		
		mav.setViewName("help/faq/faqWrite");
		return mav;
	}
	@RequestMapping(value="/faqWriteEnd.do", method=RequestMethod.POST)
	public ModelAndView faqWriteEnd(Faq faq, Model model, ModelAndView mav) {
//		logger.debug("faq"+ faq);
		
		String msg = "";
		String loc="";
		int result = faqService.faqWriteEnd(faq); 
			if(result>0) {
				msg="faq 추가 성공";
				loc="/help/faq.do";
			} 
			else {
				msg="변경실패";
				loc="/help/faqWrite.do";
			}
			
	
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
			return mav;
		
	}
	/*LIST 가지고옴*/
	@ResponseBody
	@RequestMapping(value="/faqTicketList.do", method=RequestMethod.POST)
	public List<Faq> faqTicketList(@RequestBody Faq faq) {
		logger.debug("post로 넘어온 help.faq:"+faq);
		List<Faq> list = faqService.faqTicketList(faq);
//		logger.debug("faqTicketList="+list);
		return list;
	}
	@RequestMapping("faqView.do")
	public ModelAndView faqView(@RequestParam int faqNo, ModelAndView mav) {
		
		Faq faq = faqService.selectOne(faqNo);
		
		mav.addObject("faq",faq);
		mav.setViewName("help/faq/faqView");
		return mav;
	}
	
	@RequestMapping("/faqUpdate.do")
	public ModelAndView faqUpdate(@RequestParam int faqNo, ModelAndView mav) {
//		logger.debug("help페이지 요청");
		Faq faq = faqService.selectOne(faqNo);
		mav.addObject("faq", faq);
		mav.setViewName("help/faq/faqUpdate");
		return mav;
	}
	
	
	
	@RequestMapping(value="/faqUpdateEnd.do", method=RequestMethod.POST)
	public ModelAndView faqUpdateEnd(Faq faq, Model model, ModelAndView mav) {
//		logger.debug("faq"+ faq);
		
		String msg = "";
		String loc="";
		int result = faqService.faqUpdateEnd(faq); 
			if(result>0) {
				msg="faq 수정 성공";
				loc="/help/faqView.do?faqNo="+faq.getfaqNo();
			} 
			else {
				msg="변경실패";
				loc="/help/faqUpdate.do?faqNo="+faq.getfaqNo();
			}
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
			return mav;
		
		
	}

	@RequestMapping(value="/faqDelete.do")
	public ModelAndView faqDelete(@RequestParam int faqNo, ModelAndView mav) {
		logger.debug("help페이지 요청");
		int result = faqService.faqDelete(faqNo);
		String msg = "";
		String loc="";
			if(result>0) {
				msg="faq 삭제 성공";
				loc="/help/faq.do?faqNo="+faqNo;
			} 
			else {
				msg="변경실패";
				loc="/help/faqView.do?faqNo="+faqNo;
			}
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			mav.setViewName("common/msg");
			return mav;
	}
	
	@RequestMapping(value="/mainSearch.do")
	public ModelAndView mainSearch(Faq faq, ModelAndView mav) {
		logger.debug("mainSearch로 넘어온 help.faq:"+faq);
		List<Faq> list = faqService.faqTicketList(faq);
//		logger.debug("main="+list);
		mav.addObject("list", list);
		mav.setViewName("help/faq/faq");
		return mav;
	}
}
