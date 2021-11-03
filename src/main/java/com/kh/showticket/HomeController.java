package com.kh.showticket;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.common.postconstruct.PostConstructing;
import com.kh.showticket.help.model.service.NoticeService;
import com.kh.showticket.help.model.vo.Notice;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	NoticeService noticeService;

	List<Map<String,String>> BoxlistM = PostConstructing.mBestList;
	List<Map<String,String>> BoxlistP = PostConstructing.sBestList;
	List<Map<String,String>> ticketOpen = PostConstructing.ticketOpenList;
	List<Map<String,String>> dayBoxList1 = PostConstructing.dayRankList1;
	List<Map<String,String>> dayBoxList2 = PostConstructing.dayRankList2;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, ModelAndView model,@RequestParam(value="cPage",defaultValue="1",required=false) int cPage) {
		
		List<Notice> list = noticeService.selectNoticeTicketOpenList(cPage);
	
		logger.debug("List---->>>"+list);
		
		model.addObject("list",list);
		
		model.addObject("BoxlistM", BoxlistM);
		model.addObject("BoxlistP", BoxlistP);
		model.addObject("ticketOpen",ticketOpen);
		model.addObject("BoxlistT1", dayBoxList1);
		model.addObject("BoxlistT2", dayBoxList2);
		model.addObject("cPage",cPage);	
		model.setViewName("forward:/index.jsp");

		return model;
	}
	
	
	
}