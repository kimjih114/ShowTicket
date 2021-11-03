package com.kh.showticket.ticketing.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.common.MusicalAndShow;
import com.kh.showticket.common.getApi.getApi;
import com.kh.showticket.common.selenium.Crawling;
import com.kh.showticket.common.selenium.CrawlingShow;
import com.kh.showticket.coupon.model.service.CouponService;
import com.kh.showticket.member.model.service.MemberService;
import com.kh.showticket.member.model.vo.Member;
import com.kh.showticket.member.model.vo.Ticket;
import com.kh.showticket.ticketing.model.service.TicketingService;

import lombok.extern.java.Log;

@Log
@Controller
@SessionAttributes("memberLoggedIn")
@RequestMapping("/ticketing")
public class TicketingController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	CouponService couponService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	TicketingService ticketingService;

	Map<String,Object> ticket = new HashMap<>();
	
	@RequestMapping("/ticketConfirm.do")
	public ModelAndView ticketCheck(ModelAndView mav, @RequestParam String playId,HttpSession session,
			@RequestParam String selectDate, @RequestParam String selectTime, @RequestParam String totalCouponPrice,
			@RequestParam String totalPointPrice, @RequestParam String Rnum,@RequestParam String Snum,
			@RequestParam String s1,@RequestParam String s2) {
	
		logger.debug("예매확인 페이지");
		logger.debug("totalCouponPrice"+totalCouponPrice);
		String memberId  = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();
		MusicalAndShow mas = new getApi().getMusicalAndShow(playId);
		
		//Ticket ticket = new Ticket();
	    
		
		ticket.put("memberId",memberId);
		ticket.put("ticektShowId",mas.getId());
		String priice = mas.getPrice().substring(3,10);
		String priiice = priice.replaceAll(",", "");
		int realPrice = Integer.parseInt(priiice);
		//ticket.setTicketPrice(RealPrice);
//		String priiice = priice.substring(0, priice.lastIndexOf(".")) + priice.substring(priice.lastIndexOf(".")+1);
		ticket.put("ticketPrice", realPrice);
		//logger.debug("priiice={}", priiice);
		//110,000
	
		//String realPrice = mas.getPrice();
		//System.out.println("가격"+mas.getPrice());
		//realPrice = realPrice.replaceAll("[^0-9]", "");
		//int price = Integer.parseInt("110000");
		//System.out.println("RealPrice"+realPrice);
		ticket.put("ticketGrade", "R");
		String date_s = selectDate;
		Date date = null;
	
		SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyy.mm.dd");        
        // Date로 변경하기 위해서는 날짜 형식을 yyyy-mm-dd로 변경해야 한다.
        SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-mm-dd");
        
        java.util.Date tempDate = null;
        
        try {
            // 현재 yyyymmdd로된 날짜 형식으로 java.util.Date객체를 만든다.
            tempDate = beforeFormat.parse(date_s);
        } catch (ParseException e) {
            e.printStackTrace();
        }        
        // java.util.Date를 yyyy-mm-dd 형식으로 변경하여 String로 반환한다.
        String transDate = afterFormat.format(tempDate);
        logger.debug("transDate={}", transDate);
        // 반환된 String 값을 Date로 변경한다.
        date = Date.valueOf(transDate);
        
		ticket.put("ticketDate", date);
		ticket.put("ticketPlace", mas.getHallName());
		ticket.put("ticketCount", 1);
		ticket.put("ticketSeat", s1);
		ticket.put("ticketTime", mas.getTime());
		Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, 2);
        Date d = new Date(cal.getTimeInMillis());
		ticket.put("ticketCancel", d);
		ticket.put("ticketStatus", "N");
		ticket.put("ticketShowName", mas.getName());
		ticket.put("ticketShowId", mas.getId());

		System.out.println("ticket"+ticket);
		logger.debug("예매확인 페이지");

		
		int resultPrice = realPrice - Integer.parseInt(totalCouponPrice) - Integer.parseInt(totalPointPrice) + 1000;
		ticket.put("resultPrice", resultPrice);
		
		
		
		mav.addObject("mas", mas);
		mav.addObject("ticket", ticket);
		mav.addObject("totalCouponPrice",totalCouponPrice);
		mav.addObject("totalPointPrice",totalPointPrice);
		mav.addObject("resultPrice",resultPrice);
		mav.addObject("selectDate", selectDate);
		mav.addObject("selectTime", selectTime);
		mav.setViewName("ticketing/ticketConfirm");


		return mav;
	}
		
	private void ticket(String string, String memberId) {
		// TODO Auto-generated method stub
		
	}

	@RequestMapping("/ticketingPoint.do")
	public ModelAndView ticketCheck2(ModelAndView mav, HttpSession session, @RequestParam String playId, @RequestParam String selectDate,
									@RequestParam String selectTime, @RequestParam String[] seat) {

		String memberId  = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();
		Map<String, String> memAndPlay = new HashMap<>();
		memAndPlay.put("memberId", memberId);
		memAndPlay.put("playId", playId);
		List<Map<String, String>> cList = couponService.selectCouponListbyPlayId(memAndPlay);
		
		String s1 = seat[0];
		String s2 = seat[1];

		int myPoint = ticketingService.selectMyPoint(memberId);
		int Rnum =0;
		int Snum = 0;
		for(int i=0; i<2;i++) {
			if("R석".equals(seat[i].substring(1,3))) {
				++Rnum;
			}else {
				++Snum;
			}
		}
		
		MusicalAndShow mas = new getApi().getMusicalAndShow(playId);
		mav.addObject("mas", mas);
		mav.addObject("Rnum", Rnum);
		mav.addObject("Snum", Snum);
		mav.addObject("selectDate", selectDate);
		mav.addObject("selectTime", selectTime);
		mav.addObject("s1", s1);
		mav.addObject("s2", s2);
		mav.addObject("cList", cList);
		mav.addObject("myPoint", myPoint);
		mav.setViewName("ticketing/ticketingPoint");
		return mav;
	}

	@RequestMapping(value="/ticketingSeat.do", method=RequestMethod.POST)
	public ModelAndView ticketingSeat(ModelAndView mav, @RequestParam String playId, 
			@RequestParam String selectDate, @RequestParam String selectTime, @RequestParam String selectNum) {
		logger.debug("좌석 페이지");
		logger.debug("selectNum={}", selectNum);
		MusicalAndShow mas = new getApi().getMusicalAndShow(playId);
		logger.debug("ModelAndView={}", mas);
		String html= "";
		Ticket ticket = new Ticket();
		String date_s = selectDate;
		Date date = null;
	
		SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyy.mm.dd");        
        // Date로 변경하기 위해서는 날짜 형식을 yyyy-mm-dd로 변경해야 한다.
        SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-mm-dd");
        
        java.util.Date tempDate = null;
        
        try {
            // 현재 yyyymmdd로된 날짜 형식으로 java.util.Date객체를 만든다.
            tempDate = beforeFormat.parse(date_s);
        } catch (ParseException e) {
            e.printStackTrace();
        }        
        // java.util.Date를 yyyy-mm-dd 형식으로 변경하여 String로 반환한다.
        String transDate = afterFormat.format(tempDate);
        // 반환된 String 값을 Date로 변경한다.
        date = Date.valueOf(transDate);
        
		ticket.setTicketDate(date);
		ticket.setTicketTime(selectTime.substring(0,2));
		ticket.setTicketShowId(playId);
		List<Ticket> list;
//		list.
//		int result = memberService.countResult(ticket);
//		if(result > 0)
		logger.debug("ticket={}", ticket);
		
		list = memberService.getTicketList(ticket);
		logger.debug("list={}", list);
		try {
			if(mas.getName().contains("옥탑방")) {
				html = new CrawlingShow().getImg(mas, selectDate, selectNum);
			}
			else {
				
				html = new Crawling().getImg(mas, selectDate, selectNum);
			}
		} catch (NullPointerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String main = html.substring(html.indexOf("http"), html.indexOf(" border")-1);
		logger.debug(main);
		mav.addObject("list", list);
		mav.addObject("html", html);
		mav.addObject("main", main);
		mav.addObject("mas", mas);
		mav.addObject("selectDate", selectDate);
		mav.addObject("selectTime", selectTime);
		mav.addObject("selectNum", selectNum);
		mav.setViewName("ticketing/ticketingSeat");
		return mav;
	}
	
	@RequestMapping("/pay.do")
	public String ticketPay(Model model, @RequestParam String resultPrice) {  // 포인트 , 아이디 
		
		logger.debug("예매결제페이지");
		ticketingService.insertTicket(ticket);
		model.addAttribute("resultPrice", resultPrice);
		
		return "/ticketing/pay";
	}

}

