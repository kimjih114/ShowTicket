package com.kh.showticket.ranking.controller;

import static com.kh.showticket.common.getApi.getApi.getBoxList;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.common.postconstruct.PostConstructing;


@RestController
@RequestMapping("/ranking")  
public class RankingController {

	List<Map<String,String>> dayBoxList1 = PostConstructing.dayRankList1;
	List<Map<String,String>> dayBoxList2 = PostConstructing.dayRankList2;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/ranking.do")
	public ModelAndView ranking(ModelAndView mav) {
		logger.debug("랭킹페이지");
		
		mav.addObject("dayBoxList1",dayBoxList1);
		mav.addObject("dayBoxList2",dayBoxList2);
		mav.setViewName("ranking/ranking");
		return mav;
	}
	
	@RequestMapping("/rankAjax.do")
	public List<Map<String,String>> getRankList(@RequestParam String url1){
	
		return getBoxList(url1);
	}

}
