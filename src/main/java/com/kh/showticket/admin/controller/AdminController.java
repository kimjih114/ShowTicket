package com.kh.showticket.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.admin.model.service.AdminService;
import com.kh.showticket.admin.model.vo.Report;
import com.kh.showticket.member.model.vo.Member;
import com.kh.showticket.review.model.vo.Review;


@RequestMapping("/admin")
@RestController
@SessionAttributes("memberLoggedIn")
public class AdminController {
	
	@Autowired
	AdminService adminService;

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	// 페이징바 변수
	private int startContent = 0;
	private int endContent = 0;
	private int cPage = 0;
	private final int showContent = 10;
	private int pageBarSize = 4;
	private int totalContent = 0;
	private int totalPage = 0;
	private int barStart = 0;
	private int barEnd = 0;
	private int barNo = 0;
	
	Map<String,Object> paging = new HashMap<>();
	
	@RequestMapping("/adminReport.do")
    public ModelAndView adminReport(ModelAndView mav, HttpServletRequest request) {
    	
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			cPage = 1;
		}
		
		startContent = (cPage-1)*showContent + 1;
		endContent = cPage*showContent;
		
		paging.put("startContent",startContent);
		paging.put("endContent",endContent);
		
		List<Report> reportList = adminService.selectAdminReportList(paging);
		
		List<Report> countList = adminService.selectTotalCount();
		totalContent = countList.size();
		totalPage = (int)Math.ceil((double)totalContent/showContent);
				
		barStart = ((cPage -1)/pageBarSize) * pageBarSize +1;
		barEnd = barStart + pageBarSize -1;
		barNo = barStart;
				
		paging.put("barNo",barNo);
		paging.put("barEnd",barEnd);
		paging.put("totalPage",totalPage);
		paging.put("cPage",cPage);
		paging.put("barStart",barStart);
		
		mav.addObject("reportList", reportList);
    	mav.addObject("paging", paging);
    	mav.setViewName("admin/adminReport");
		
    	return mav;
    }
    
    @RequestMapping("/adminMemberList.do")
    public ModelAndView adminMemberList(ModelAndView mav, HttpServletRequest request) {

    	try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			cPage = 1;
		}
		
		startContent = (cPage-1)*showContent + 1;
		endContent = cPage*showContent;
		
		paging.put("startContent",startContent);
		paging.put("endContent",endContent);
		
		List<Member> memberList = adminService.adminMemberList(paging);
		
		List<Report> countList = adminService.selectMemberTotalCount();
		totalContent = countList.size();
		totalPage = (int)Math.ceil((double)totalContent/showContent);
				
		barStart = ((cPage -1)/pageBarSize) * pageBarSize +1;
		barEnd = barStart + pageBarSize -1;
		barNo = barStart;
				
		paging.put("barNo",barNo);
		paging.put("barEnd",barEnd);
		paging.put("totalPage",totalPage);
		paging.put("cPage",cPage);
		
		mav.addObject("memberList", memberList);
		mav.addObject("paging", paging);
		mav.setViewName("admin/adminMList");
		
    	return mav;
    }
    
    @RequestMapping(value="/adminReportDetail.do", method=RequestMethod.POST)
    public ModelAndView adminReportDetail(ModelAndView mav, @RequestParam int cnt, @RequestParam String memberId, @RequestParam int reviewNo, @RequestParam int reportNo) {
    	
    	
    	List<Report> reportList = adminService.selectOneAdminReportList(reportNo);
    	List<Review> reviewList = adminService.selectOneAdminReviewList(reviewNo);
    	
    	mav.addObject("reportList", reportList);
    	mav.addObject("reviewList", reviewList);
    	
    	logger.debug("신고수: ",cnt);
    	logger.debug("신고대상: ",memberId);
    	
    	if(cnt != 0 && memberId != null) {
	    	Map<String, Object> info = new HashMap<>();
	    	info.put("cnt",cnt);
	    	info.put("memberId",memberId);
	    	
	    	int result = adminService.updateReport(info);
    	}
    	
    	mav.setViewName("admin/adminReportDetail");
    	
    	return mav;
    }
        
    @RequestMapping("/adminReportDelete.do")
    public ModelAndView adminReportDelete(ModelAndView mav, @RequestParam int reviewNo) {
    	
    	logger.debug("글 번호: ",reviewNo);
    	
    	int result = adminService.deleteReport(reviewNo);
    	
    	mav.addObject("msg", result>0?"삭제 완료":"삭제 실패");
    	mav.addObject("loc", "/admin/adminReport.do");
    	
    	mav.setViewName("common/msg");
    	
    	return mav;
    }
    @PostMapping("/insertReport.do")
    public Map<String, String> reportInsert(@RequestBody Report report) {
    	logger.info("report={}", report);
    	int check = adminService.checkReport(report);
    	logger.info("check={}", check);
    	Map<String, String> map = new HashMap<>();
    	int result = 0;
    	if(check < 0) {
    		result = adminService.insertReport(report);
    	}
    	if(result> 0) {
    		map.put("msg", "신고되었습니다. 항상 노력하는 쇼티켓이 되겠습니다.");
    	}
    	else map.put("msg", "이미 신고하신 댓글입니다.");
    	return map;
    }
    
    @RequestMapping("/adminMemberDelete.do")
    public ModelAndView adminMemberDelete(ModelAndView mav, @RequestParam String memberId) {

    	logger.debug("탈퇴자 아이디: ",memberId);
    	
    	int result = adminService.deleteMember(memberId);
    	
    	mav.addObject("msg", result>0?"탈퇴 완료":"탈퇴 실패");
    	mav.addObject("loc", "/admin/adminMemberList.do");
    	
    	mav.setViewName("common/msg");
    	
    	return mav;
    }
    
    @RequestMapping("/adminMemberSearch.do")
    public ModelAndView adminMemberSearch(ModelAndView mav, HttpServletRequest request) {
    	
    	String searchType = request.getParameter("searchType");
    	String searchKeyword = request.getParameter("searchKeyword");
    	try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			cPage = 1;
		}
    	startContent = (cPage-1)*showContent + 1;
		endContent = cPage*showContent;
    	
    	List<Member> list = null;
    	List<Member> countList = null;
    	
    	paging.put("searchKeyword",searchKeyword);
    	paging.put("startContent",startContent);
		paging.put("endContent",endContent);
    	
    	switch(searchType) {
    	case "memberId":
			list = adminService.selectMemberByMemberId(paging);
			countList = adminService.FinderSelectTotalContentId(searchKeyword);
			totalContent = countList.size();
			break;
		case "memberName":
			list = adminService.selectMemberByMemberName(paging);
			countList = adminService.FinderSelectTotalContentName(searchKeyword);
			totalContent = countList.size();
			break;
    	}
    	
		totalPage = (int)Math.ceil((double)totalContent/showContent);
				
		barStart = ((cPage -1)/pageBarSize) * pageBarSize +1;
		barEnd = barStart + pageBarSize -1;
		barNo = barStart;
				
		paging.put("barNo",barNo);
		paging.put("barEnd",barEnd);
		paging.put("totalPage",totalPage);
		paging.put("cPage",cPage);
		paging.put("barStart",barStart);
		
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		mav.setViewName("admin/adminMFinder");
		
    	return mav;
    }
}
