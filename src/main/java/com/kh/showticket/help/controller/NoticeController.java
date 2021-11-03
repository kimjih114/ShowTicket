package com.kh.showticket.help.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.common.MusicalAndShow;
import com.kh.showticket.common.getApi.getApi;
import com.kh.showticket.help.model.service.NoticeService;
import com.kh.showticket.help.model.vo.Notice;
import com.kh.showticket.member.model.vo.Member;

@RestController
@RequestMapping("/help")
public class NoticeController {

	@Autowired
	NoticeService noticeService;

	Logger logger = LoggerFactory.getLogger(getClass());
	getApi getApi = new getApi();

	@RequestMapping("/notice.do")
	public ModelAndView notice(@RequestParam(value="cPage",defaultValue="1",required=false) int cPage) {
		logger.debug("notice페이지 요청");
		ModelAndView mav = new ModelAndView();
		Notice notice = new Notice();

		List<Notice> list = noticeService.noticeList(notice);

		mav.addObject("list",list);
		mav.addObject("cPage",cPage);
		mav.setViewName("help/notice/notice");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/noticeList.do", method=RequestMethod.POST)
	public List<Notice> noticeList(@RequestBody Notice notice) {
		List<Notice> list = noticeService.noticeList(notice);
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value="/ticketOpenList.do", method=RequestMethod.POST)
	public List<Map<String,String>> ticketOpenList() {
		Calendar c1 = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // 날짜 포맷 
		c1.add(Calendar.DATE, 2); // 오늘날짜
		String today = sdf.format(c1.getTime());
		c1.add(Calendar.DATE, 7); // 오늘날짜로부터 7일
		String nextWeek = sdf.format(c1.getTime());
		
		String url1 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=9f6a9651f5e648ac95d2cc7a210a4587&stdate="+today+"&eddate="+nextWeek+"&cpage=1&rows="+Integer.MAX_VALUE+"&shcate=AAAA&prfstate=01";		
		String url2 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=9f6a9651f5e648ac95d2cc7a210a4587&stdate="+today+"&eddate="+nextWeek+"&cpage=1&rows="+Integer.MAX_VALUE+"&shcate=AAAB&prfstate=01";	
		
		List<Map<String,String>> ticketOpenList = getApi.getConcatList(url1, url2);
		
		return ticketOpenList;
	}

	@RequestMapping("/noticeView.do")
	public ModelAndView noticeView(HttpServletResponse response, @RequestParam int noticeNo
			, ModelAndView mav, @CookieValue(value="boardCookie", required = false) Cookie c) {
		//쿠키검사
		boolean hasRead = false;
		String boardCookieVal = "";
		if(c!=null) {
			String value = c.getValue();
			boardCookieVal = value;
			if(value.contains("|"+noticeNo+"|")) {
				hasRead = true;
			}
		}

		if(!hasRead) {
			logger.debug("noticeNo={}", noticeNo);
			Cookie boardCookie = new Cookie("boardCookie", boardCookieVal+"|"+noticeNo+"|");

			response.addCookie(boardCookie);
			noticeService.increaseReadCount(noticeNo);			
		}
		Notice notice = noticeService.selectOne(noticeNo);
		
		MusicalAndShow mas = getApi.getMusicalAndShow(notice.getPlayId());
		mav.addObject("mas", mas);
		mav.addObject("n",notice);
		mav.setViewName("help/notice/noticeView");
		return mav;
	}

	@RequestMapping("/noticeWrite.do")
	public ModelAndView noticeWrite(ModelAndView mav) {

		mav.setViewName("help/notice/noticeWrite");
		return mav;
	}

	@RequestMapping(value="/noticeWriteEnd.do", method=RequestMethod.POST)
	public ModelAndView noticeWriteEnd(Notice notice, ModelAndView mav) {
		String msg = "";
		String loc = "";
		int result = noticeService.noticeWrite(notice); 
		if(result>0) {
			msg="notice 추가 성공";
			loc="/help/notice.do";
		} 
		else {
			msg="notice 추가 실패";
			loc="/help/noticeWrite.do";
		}


		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;

	}

	@RequestMapping("/noticeUpdate.do")
	public ModelAndView noticeUpdate(@RequestParam int noticeNo, ModelAndView mav) {
		Notice notice = noticeService.selectOne(noticeNo);
		mav.addObject("n", notice);
		mav.setViewName("help/notice/noticeUpdate");
		return mav;
	}

	@RequestMapping(value="/noticeUpdateEnd.do", method=RequestMethod.POST)
	public ModelAndView noticeUpdateEnd(Notice notice, ModelAndView mav) {
		String msg = "";
		String loc = "";
		int result = noticeService.noticeUpdate(notice); 
		if(result>0) {
			msg="notice 수정 성공";
			loc="/help/noticeView.do?noticeNo="+notice.getNoticeNo();
		} 
		else {
			msg="notice 수정 실패";
			loc="/help/noticeUpdate.do?noticeNo="+notice.getNoticeNo();
		}
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}

	@RequestMapping(value="/noticeDelete.do")
	public ModelAndView noticeDelete(@RequestParam int noticeNo, ModelAndView mav) {
		String msg = "";
		String loc = "";
		int result = noticeService.noticeDelete(noticeNo);
		if(result>0) {
			msg="notice 삭제 성공";
			loc="/help/notice.do?noticeNo="+noticeNo;
		} 
		else {
			msg="notic 삭제 실패";
			loc="/help/noticeView.do?noticeNo="+noticeNo;
		}

		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/insertFollow.do")
	public ModelAndView insertFollow(@RequestParam String playId, @RequestParam String noticeNo, ModelAndView mav, HttpSession session) {
		Map<String, String> userAndMusical = new HashMap<>();
		String memberId = ((Member)session.getAttribute("memberLoggedIn")).getMemberId();
		userAndMusical.put("memberId", memberId);
		userAndMusical.put("playId",playId);
		
		int result = noticeService.insertFollow(userAndMusical);

		String msg = "";
		String loc = "/help/noticeView.do?noticeNo="+noticeNo;
		if(result>0) {
			msg="관심공연에 추가되었습니다.";
		}
		else {
			msg="관심공연 추가에 실패했습니다.";
		}
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/getPlayInfo.do")
	@ResponseBody
	public MusicalAndShow getPlayInfo(@RequestParam String playId) {
		logger.debug("ajax 성공");
		MusicalAndShow mas = getApi.getMusicalAndShow(playId);
		return mas;
	}
}
