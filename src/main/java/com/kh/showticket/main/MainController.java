package com.kh.showticket.main;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.common.postconstruct.PostConstructing;
import com.kh.showticket.event.model.service.EventService;


@Controller
@RequestMapping("/main")
public class MainController {

	@Autowired
	EventService eventService;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	List<Map<String,String>> musicalDetailList = PostConstructing.musicalDetailList;
	List<Map<String,String>> showDetailList = PostConstructing.showDetailList;
	
	@RequestMapping("/search.do")
	public ModelAndView searchResult(HttpServletRequest request, ModelAndView mav, @RequestParam(value="queryKeyword") String queryKeyword) {
	
		final int numPerPage = 5;
	
		List<Map<String,String>> mTicketResult = new ArrayList<>();
		List<Map<String,String>> sTicketResult = new ArrayList<>();
		List<Map<String,String>> eventResult = new ArrayList<>();
		
		int mTotalContents = 0;
		int sTotalContents = 0;
		int eTotalContents = 0;
		
		int mTotalPages = 0;
		int sTotalPages = 0;
		//int eTotalPages = 0;
		
		int mCPage = 1;
		int sCPage = 1;
		try {
			mCPage = Integer.parseInt(request.getParameter("mCPage"));
			sCPage = Integer.parseInt(request.getParameter("sCPage"));
		} catch(NumberFormatException e) {
			
		}
		
		logger.debug("통합검색결과");
		
		//1.검색 키워드
		logger.debug("queryKeyword="+queryKeyword);
		//2.티켓 검색
		for(Map<String,String> map : musicalDetailList) {
			if(map.get("prfnm").contains(queryKeyword) || map.get("prfcast").contains(queryKeyword)) {
				mTicketResult.add(map);
				logger.debug("mticket:"+ mTicketResult);
			}
		}
		
		for(Map<String,String> map : showDetailList) {
			if(map.get("prfnm").contains(queryKeyword) || map.get("prfcast").contains(queryKeyword)) {
				sTicketResult.add(map);
			}
		}
		
		//totalContents
		mTotalContents = mTicketResult.size();
		sTotalContents = sTicketResult.size();
		
		List<Map<String, String>> mTicketResultEnd = new ArrayList<>();
		List<Map<String, String>> sTicketResultEnd = new ArrayList<>();
		
		int mEndContent = (mCPage)*(numPerPage);
		int sEndContent = (sCPage)*(numPerPage);
		
		//0~4
		//5~9
		mEndContent = mEndContent>mTotalContents  ? mTotalContents : mEndContent;
		sEndContent = sEndContent>mTotalContents  ? sTotalContents : sEndContent;
	
		for(int i=(mCPage-1)*numPerPage; i<mEndContent; i++) {
			mTicketResultEnd.add(mTicketResult.get(i));
		}
		for(int j=(sCPage-1)*numPerPage; j<sEndContent; j++) {
			sTicketResultEnd.add(sTicketResult.get(j));
		}
		
		
 		
		//3.이벤트 검색
		eventResult = eventService.searchEventList(queryKeyword);
		
		eTotalContents = eventResult.size();
		
		mTotalPages = (int)(Math.ceil(mTotalContents/(numPerPage*1.0)));
		sTotalPages = (int)(Math.ceil(sTotalContents/(numPerPage*1.0)));
		//eTotalPages = (int)(Math.ceil(eTotalContents/(numPerPage*1.0)));
		
		
		//페이징 - 뮤지컬
		String mPageBar = "";
		int mPageBarSize = numPerPage;
		
		int mPageStart = ((mCPage-1)/mPageBarSize)*mPageBarSize + 1;
		int mPageEnd = mPageStart+mPageBarSize-1;
		
		int mPageNo = mPageStart;
		
		if(mPageEnd <= mPageBarSize) {
			//pageBar += "<span>[이전]</span>";
		}
		else {
			mPageBar += "<a href='"+request.getContextPath()+"/main/search.do?queryKeyword="+queryKeyword+"&mCPage="+(mPageNo-1)+"'>[이전]</a>";
		}
		
		while(mPageNo<=mPageEnd && mPageNo<=mTotalPages) {
			if(mPageNo == mCPage) {
				mPageBar += "<span class='cPage'>"+mPageNo+"</span>";
			}
			else {
				mPageBar += "<a href='"+request.getContextPath()+"/main/search.do?queryKeyword="+queryKeyword+"&mCPage="+(mPageNo)+"'>"+mPageNo+"</a>";
			}
			
			mPageNo++;
		}
		
		if(mPageEnd >= mTotalPages) {
			//mPageBar += "<span>[다음]</span>";
		}
		else {
			mPageBar += "<a href='"+request.getContextPath()+"/main/search.do?queryKeyword="+queryKeyword+"&mCPage="+(mPageNo)+"'>[다음]</a>";
		}
		
		//페이징 - 연극
		String sPageBar = "";
		int sPageBarSize = numPerPage;
		
		int sPageStart = ((sCPage-1)/sPageBarSize)*sPageBarSize + 1;
		int sPageEnd = sPageStart+sPageBarSize-1;
		
		int sPageNo = sPageStart;
		
		if(sPageEnd <= sPageBarSize) {
			//pageBar += "<span>[이전]</span>";
		}
		else {
			sPageBar += "<a href='"+request.getContextPath()+"/main/search.do?queryKeyword="+queryKeyword+"&sCPage="+(sPageNo-1)+"'>[이전]</a>";
		}
		
		while(sPageNo<=sPageEnd && sPageNo<=sTotalPages) {
			if(sPageNo == sCPage) {
				sPageBar += "<span class='cPage'>"+sPageNo+"</span>";
			}
			else {
				sPageBar += "<a href='"+request.getContextPath()+"/main/search.do?queryKeyword="+queryKeyword+"&sCPage="+(sPageNo)+"'>"+sPageNo+"</a>";
			}
			
			sPageNo++;
		}
		
		if(sPageEnd >= sTotalPages) {
			//sPageBar += "<span>[다음]</span>";
		}
		else {
			sPageBar += "<a href='"+request.getContextPath()+"/main/search.do?queryKeyword="+queryKeyword+"&sCPage="+(sPageNo)+"'>[다음]</a>";
		}
		
		
	
		mav.addObject("mPageBar", mPageBar);
		mav.addObject("sPageBar", sPageBar);
		mav.addObject("mTotalContents", mTotalContents);
		mav.addObject("sTotalContents", sTotalContents);
		mav.addObject("eTotalContents", eTotalContents);
		mav.addObject("mTicketResultEnd",mTicketResultEnd);
		mav.addObject("sTicketResultEnd",sTicketResultEnd);
		mav.addObject("eventResult",eventResult);
		
		mav.setViewName("main/search");
		return mav;
	}
	

	
}
