package com.kh.showticket.musical.controller;

import static com.kh.showticket.common.getApi.getApi.getBoxList;
import static com.kh.showticket.common.getApi.getApi.getList;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.common.MusicalAndShow;
import com.kh.showticket.common.getApi.getApi;
import com.kh.showticket.common.postconstruct.PostConstructing;
import com.kh.showticket.help.model.vo.Faq;
import com.kh.showticket.coupon.model.vo.Coupon;
import com.kh.showticket.member.model.vo.Member;
import com.kh.showticket.musical.model.service.MusicalService;


@RestController
@RequestMapping("/musical")
public class MusicalController {
	static Logger logger = LoggerFactory.getLogger("com.kh.showticket.musical.controller.MusicalController");
	
	@Autowired
	MusicalService musicalService;
	
	List<Map<String,String>> musicalDetailList = PostConstructing.musicalDetailList;
	

	@RequestMapping("/musical.do")
	public ModelAndView musical(ModelAndView mav) {
		//logger.debug("뮤지컬리스트페이지");
		
		String url = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate=20190923&eddate=20191031&cpage=1&rows=8&shcate=AAAB";
		String url2 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=ebfe5d2574de4631b6eda133b56b1297&stdate=20190928&eddate=20191031&cpage=1&rows=5&shcate=AAAB&prfstate=02";
		
		List<Map<String,String>> musicalList = getList(url);
		List<Map<String,String>> recentMusicalList = getList(url2);
		
		mav.addObject("musicalList", musicalList);
		mav.addObject("recentMusicalList", recentMusicalList);
		mav.setViewName("menu/musical");
		return mav;
	}
	@RequestMapping("/starRating.do")
	public ModelAndView starRating(ModelAndView mav) {
		mav.setViewName("musical/starRating");
		return mav;
	}
	
	@RequestMapping("/musicalAjax.do")
	@ResponseBody
	public List<Map<String,String>> musicalAjax(@RequestParam int cpage) {
		//logger.debug("전체뮤지컬 AJAX");
		//logger.debug("cpage={}", cpage);

		
		String url = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate=20190923&eddate=20191031&cpage="+cpage+"&rows=8&shcate=AAAB";

		return getList(url);
	}


	@RequestMapping("/musicalDetail.do")
	public ModelAndView musicalDetail(ModelAndView mav, @RequestParam String musicalId) {
	
		//logger.debug("뮤지컬상세페이지");
		//logger.debug("musicalId={}",musicalId);

		MusicalAndShow musical = musicalService.selectOne(musicalId);
		
//		String url = "http://www.kopis.or.kr/openApi/restful/prfplc?service=3127d89913494563a0e9684779988063";
		List<Coupon> coupon = musicalService.selectCoupon(musicalId);
		int discount = musicalService.selectDiscount(musicalId); 
		int total = musicalService.totalReview(musicalId);
		//		String url = "http://www.kopis.or.kr/openApi/restful/prfplc?service=3127d89913494563a0e9684779988063";
		String url = "http://www.kopis.or.kr/openApi/restful/prfplc/"+musical.getHallId()+"?service=3127d89913494563a0e9684779988063";
		Map<String, String> address = musicalService.selectPlace(url);
		logger.debug("musicalAll"+ musical);
		logger.info("musicalAddress"+ address);
		mav.addObject("total", total);
		mav.addObject("musical", musical);
		mav.addObject("coupon", coupon);
		mav.addObject("discount", discount);
		mav.addObject("address", address);
		mav.setViewName("musical/musicalDetail");
		return mav;
	}

	
	
	@RequestMapping("/musicalSearch.do")
	public List<Map<String,String>> musicalSearch(ModelAndView mav, @RequestParam String cate, @RequestParam String srchKeyword, @RequestParam int cpage) {
		//cate : searchAll / searchTitle / searchActor
		//srchKeyword : String
		//cpage

		final int numPerPage = 8;
		
		logger.debug("cate={}", cate);
		logger.debug("srchKeyword={}", srchKeyword);
		
		List<Map<String, String>> result = new ArrayList<>();
		List<Map<String, String>> resultPaged = new ArrayList<>(8);
		
		
		if(cate.equals("searchAll")) {
			for(Map<String, String> map : musicalDetailList) {
				if(map.get("prfnm").contains(srchKeyword) || map.get("prfcast").contains(srchKeyword)) {
					result.add(map);
				}
			}

		}
		else if(cate.equals("searchTitle")) {
			for(Map<String, String> map : musicalDetailList) {
				if(map.get("prfnm").contains(srchKeyword)) {
					result.add(map);
				}
			}
		}
		else if(cate.equals("searchActor")) {
			for(Map<String, String> map : musicalDetailList) {
				if(map.get("prfcast").contains(srchKeyword)) {
					result.add(map);
				}
			}
		}
		
		int startPage = (cpage-1)*numPerPage;
	
		int endPage = startPage+numPerPage;
		
		if(endPage>=result.size()) endPage = result.size();
		
		for(int i=startPage; i<endPage; i++) {
			resultPaged.add(result.get(i));
		}
		


		return resultPaged;
	}
	
	
	

	@RequestMapping("/musicalrankAjax.do")
	public List<Map<String, String>> musicalrankAjax(@RequestParam String url1) {

		return getBoxList(url1);

	}

	@RequestMapping("/musicalNewAjax.do")
	public List<Map<String, String>>musicalNewAjax(@RequestParam String url1) {

		List<Map<String,String>> dayList = getApi.getOrderedListByDate2(getList(url1));

		return dayList;
	}


	@RequestMapping("/insertWait.do")		
	public ModelAndView insertWait(@RequestParam String musicalId, ModelAndView mav, HttpSession session) {		
		Map<String, String> userAndMusical = new HashMap<>();	
		String memberId = ((Member)session.getAttribute("memberLoggedIn")).getMemberId();	
		userAndMusical.put("memberId", memberId);	
		userAndMusical.put("musicalId",musicalId);	
		int result = musicalService.insertWait(userAndMusical);	


		String msg = "";			
		String loc = "/musical/musicalDetail.do?musicalId="+musicalId;	
		if(result>0) {	
			msg="대기공연에 추가되었습니다.";	
		}	
		else {	
			msg="대기공연 추가에 실패했습니다.";	
		}	


		mav.addObject("msg", msg);	
		mav.addObject("loc", loc);	
		mav.setViewName("common/msg");	
		return mav;	
	}

}
