package com.kh.showticket.show.controller;

import static com.kh.showticket.common.getApi.getApi.getList;
import static com.kh.showticket.common.getApi.getApi.getBoxList;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.common.MusicalAndShow;
import com.kh.showticket.common.getApi.getApi;
import com.kh.showticket.common.postconstruct.PostConstructing;
import com.kh.showticket.coupon.model.vo.Coupon;
import com.kh.showticket.member.model.vo.Member;
import com.kh.showticket.musical.model.service.MusicalService;

@RestController
@RequestMapping("/show")
public class ShowController {
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	MusicalService musicalService;
	
	List<Map<String, String>> showList = PostConstructing.showList;
	List<Map<String, String>> showDetailList = PostConstructing.showDetailList;

	@RequestMapping("/show.do")
	public ModelAndView show(ModelAndView mav) {
		
		 Calendar c1 = Calendar.getInstance(); SimpleDateFormat sdf = new
		 SimpleDateFormat("yyyyMMdd"); c1.add(Calendar.DATE, -1); String yesterday =
		 sdf.format(c1.getTime()); c1.add(Calendar.DATE,-30); String monthBefore =
		 sdf.format(c1.getTime());
		 
		// String url =
		// "http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate="+monthBefore+"&eddate="+yesterday+"&cpage=1&rows=8&shcate=AAAA";
		String url2 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=ebfe5d2574de4631b6eda133b56b1297&stdate="+ monthBefore + "&eddate=" + yesterday + "&cpage=1&rows=5&shcate=AAAA&prfstate=02";

		List<Map<String, String>> recentShowList = getList(url2);

		mav.addObject("showList", showList);
		mav.addObject("recentShowList", recentShowList);
		mav.setViewName("menu/show");
		return mav;
	}

	@RequestMapping("/showAjax.do")
	public List<Map<String, String>> showAjax(@RequestParam int cpage) {

		String url = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate=20190923&eddate=20190923&cpage="
				+ cpage + "&rows=8&shcate=AAAA";

		return getList(url);

	}
	
	@RequestMapping("/showDetail.do")
	public ModelAndView showDetail(ModelAndView mav, @RequestParam String showId) {
	
		MusicalAndShow show = musicalService.selectOne(showId);
		
//		String url = "http://www.kopis.or.kr/openApi/restful/prfplc?service=3127d89913494563a0e9684779988063";
		List<Coupon> coupon = musicalService.selectCoupon(showId);
		int discount = musicalService.selectDiscount(showId); 
		int total = musicalService.totalReview(showId);
		//		String url = "http://www.kopis.or.kr/openApi/restful/prfplc?service=3127d89913494563a0e9684779988063";
		String url = "http://www.kopis.or.kr/openApi/restful/prfplc/"+show.getHallId()+"?service=3127d89913494563a0e9684779988063";
		Map<String, String> address = musicalService.selectPlace(url);
		logger.debug("showAll"+ show);
		logger.info("showAddress"+ address);
		mav.addObject("total", total);
		mav.addObject("show", show);
		mav.addObject("coupon", coupon);
		mav.addObject("discount", discount);
		mav.addObject("address", address);
		mav.setViewName("show/showDetail");
		return mav;
	}

	@RequestMapping("/showSearch.do")
	public List<Map<String, String>> showSearch(ModelAndView mav, @RequestParam String cate,
			@RequestParam String srchKeyword, @RequestParam int cpage) {
		// cate : searchAll / searchTitle / searchActor
		// srchKeyword : String
		// cpage

		final int numPerPage = 8;

		// logger.debug("cate={}", cate);
		// logger.debug("srchKeyword={}", srchKeyword);

		List<Map<String, String>> result = new ArrayList<>();
		List<Map<String, String>> resultPaged = new ArrayList<>(8);

		if (cate.equals("searchAll")) {
			for (Map<String, String> map : showDetailList) {
				if (map.get("prfnm").contains(srchKeyword) || map.get("prfcast").contains(srchKeyword)) {
					result.add(map);
				}
			}

		} else if (cate.equals("searchTitle")) {
			for (Map<String, String> map : showDetailList) {
				if (map.get("prfnm").contains(srchKeyword)) {
					result.add(map);
				}
			}
		} else if (cate.equals("searchActor")) {
			for (Map<String, String> map : showDetailList) {
				if (map.get("prfcast").contains(srchKeyword)) {
					result.add(map);
				}
			}
		}

		int startPage = (cpage - 1) * numPerPage;

		int endPage = startPage + numPerPage;

		if (endPage >= result.size())
			endPage = result.size();

		for (int i = startPage; i < endPage; i++) {
			resultPaged.add(result.get(i));
		}

		return resultPaged;
	}

	@RequestMapping("/showrankAjax.do")
	public List<Map<String, String>> showrankAjax(@RequestParam String url1) {

		return getBoxList(url1);
		
	}
	

	@RequestMapping("/showNewAjax.do")
	public List<Map<String, String>> showNewAjax(@RequestParam String url1) {
		
		List<Map<String,String>> dayList = getApi.getOrderedListByDate2(getList(url1));
		
		return dayList;
	}
	
	@RequestMapping("/insertWait.do")		
	public ModelAndView insertWait(@RequestParam String showId, ModelAndView mav, HttpSession session) {		
		Map<String, String> userAndShow = new HashMap<>();	
		String memberId = ((Member)session.getAttribute("memberLoggedIn")).getMemberId();	
		userAndShow.put("memberId", memberId);	
		userAndShow.put("showId",showId);	
		int result = musicalService.insertWait(userAndShow);	


		String msg = "";			
		String loc = "/show/showDetail.do?showId="+showId;	
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
