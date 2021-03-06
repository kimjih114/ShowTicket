package com.kh.showticket.member.controller;


import static com.kh.showticket.common.getApi.getApi.getList;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.admin.model.vo.Report;
import com.kh.showticket.common.MusicalAndShow;
import com.kh.showticket.common.getApi.getApi;
import com.kh.showticket.common.mailhandler.MailHandler;
import com.kh.showticket.common.mailhandler.TempKey;
import com.kh.showticket.coupon.model.service.CouponService;
import com.kh.showticket.member.model.service.MemberService;
import com.kh.showticket.member.model.vo.Member;
import com.kh.showticket.member.model.vo.MyPoint;
import com.kh.showticket.member.model.vo.Ticket;
import com.kh.showticket.phone.UtilSms;
import com.kh.showticket.phone.controller.AuthPhoneNumber;
import com.kh.showticket.phone.model.request.Message;


@RequestMapping("/member")
@Controller
@SessionAttributes("memberLoggedIn")
public class MemberController {

	@Autowired
	MemberService memberService;

	@Autowired
	CouponService couponService;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	JavaMailSender mailSender;

	private Logger logger = LoggerFactory.getLogger(getClass());

	private final int showContent = 10;

	@RequestMapping("/memberEnroll.do")
	public void memberEnroll() {

		// member/memberEnroll
		// -> ViewNameTransLator????????? view?????? ???????????? ??????.
		System.out.println("?????? ?????? ??? ?????? ?????? ??????!!");

	}

	@RequestMapping("/reservation.do")
	public String reservation(Model model, HttpSession session, HttpServletRequest request) {

		String memberLoggedIn = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();

		// ???????????? ??????
		int startContent = 0;
		int endContent = 0;
		int cPage = 0;
		int pageBarSize = 4;
		int totalContent = 0;
		int totalPage = 0;
		int barStart = 0;
		int barEnd = 0;
		int barNo = 0;

		Map<String,Object> paging = new HashMap<>();

		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			cPage = 1;
		}

		startContent = (cPage-1)*showContent + 1;
		endContent = cPage*showContent;

		paging.put("memberLoggedIn",memberLoggedIn);
		paging.put("startContent",startContent);
		paging.put("endContent",endContent);

		// 1.?????? ??????
		List<Ticket> list = memberService.selectReservationList(paging);
		logger.debug("??????????????? ????????? ?????? :" + memberLoggedIn);

		// ?????? ????????? ?????? ????????? ??? ?????? ????????????
		List<Ticket> countList = memberService.selectRTotalCount();
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

		model.addAttribute("list", list);
		model.addAttribute("paging", paging);

		return "/member/reservation";
	}

	@ResponseBody
	@RequestMapping(value="/reservationTermAjax.do", method=RequestMethod.POST)
	public Map<String,Object> reservationTermAjax(HttpSession session, @RequestParam int num, HttpServletRequest request) {

		String memberLoggedIn = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();

		//		int startContent = s;
		//		int endContent = e;
		int minusNum = num * -1;

		// ???????????? ??????
		int startContent = 0;
		int endContent = 0;
		int cPage = 1;
		int pageBarSize = 4;
		int totalContent = 0;
		int totalPage = 0;
		int barStart = 0;
		int barEnd = 0;
		int barNo = 0;


		Map<String,Object> paging = new HashMap<>();

//		try {
//			cPage = Integer.parseInt(request.getParameter("cPage"));
//		}catch(NumberFormatException e) {
//			cPage = 1;
//		}

		startContent = (cPage-1)*showContent + 1;
		endContent = cPage*showContent;

		paging.put("memberLoggedIn", memberLoggedIn);
		paging.put("num", minusNum);
		paging.put("startContent",startContent);
		paging.put("endContent",endContent);

		List<Ticket> list = new ArrayList<>();
		List<Ticket> countList = new ArrayList<>();

		logger.debug("ajax??? memberLoggedIn :" + memberLoggedIn);

		logger.debug("ajax??? num:" + minusNum);
		logger.debug("ajax??? s:" + startContent);
		logger.debug("ajax??? e:" + endContent);

		if(minusNum == -100){
			list = memberService.selectReservationAll(paging);
			countList = memberService.selectTotalCountA(paging);
			totalContent = countList.size();
		}
		else if(minusNum == -1 || minusNum == -2 || minusNum == -3) {
			list = memberService.selectReservationTerm(paging);
			countList = memberService.selectTotalCountT(paging);
			totalContent = countList.size();
		}
		else if(minusNum == -15) {			
			list = memberService.selectReservationTerm15(paging);
			countList = memberService.selectTotalCount15(paging);
			totalContent = countList.size();
		}

		totalPage = (int)Math.ceil((double)totalContent/showContent);

		barStart = ((cPage -1)/pageBarSize) * pageBarSize +1;

		barEnd = barStart + pageBarSize -1;
		barNo = barStart;

		paging.put("reservationList",list);
		paging.put("barNo",barNo);
		paging.put("barEnd",barEnd);
		paging.put("totalPage",totalPage);
		paging.put("cPage",cPage);
		paging.put("barStart",barStart);

		return paging;
	}


	@RequestMapping("/memberView.do")
	public void memberView() {
		/*
		 * Member member = memberService.selectOneMember(memberId);
		 * model.addAttribute("member", member); return "/member/memberView";
		 */
	}

	@RequestMapping("/myCoupon.do")
	public ModelAndView myCoupon(ModelAndView mav, HttpSession session) {
		//??????
		//@SessionAttribute...
		String memberLoggedIn = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();
		//String memberLoggedIn = "honggd";

		List<Map<String, String>> myCouponList = couponService.selectMyCouponList(memberLoggedIn);

		mav.addObject("myCouponList", myCouponList);
		mav.setViewName("member/myCoupon");

		return mav;
	}

	@RequestMapping("/myPoint.do")
	public ModelAndView myPoint(ModelAndView mav, HttpSession session) {

		String memberLoggedIn = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();

		int totalPoint = 0;

		List<MyPoint> myPointList = memberService.selectMyPointList(memberLoggedIn);

		//????????????????????????
		totalPoint = memberService.selectOneMember(memberLoggedIn).getPoint();

		mav.addObject("myPointList", myPointList);
		mav.addObject("totalPoint", totalPoint);
		mav.setViewName("member/myPoint");

		return mav;
	}

	@RequestMapping("/myStandBy.do")
	public ModelAndView myStandBy(ModelAndView mav, HttpSession session) {

		//??????
		String memberLoggedIn = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();

		List<String> standByList = memberService.selectMyStandByList(memberLoggedIn);
		List<Map<String, String>> myStandByList = null;
		List<Map<String, String>> myStandByMList = new ArrayList<>();
		List<Map<String, String>> myStandBySList = new ArrayList<>();

		if(standByList.size()>0) {
			for(String showId : standByList) {
				String url = "http://kopis.or.kr/openApi/restful/pblprfr/"+showId+"?service=3127d89913494563a0e9684779988063";
				myStandByList = getList(url);	
			}	
		}

		if(myStandByList != null) {
			for(Map<String, String> map : myStandByList) {
				if(map.get("genrenm").equals("?????????")) {
					myStandByMList.add(map);
				}
				if(map.get("genrenm").equals("??????")) {
					myStandBySList.add(map);
				}
			}
		}


		mav.addObject("myStandByMList", myStandByMList);
		mav.addObject("myStandBySList", myStandBySList);

		mav.setViewName("member/myStandBy");
		return mav;
	}

	@RequestMapping("/deleteStandBy.do")
	public ModelAndView deleteMyStandBy(ModelAndView mav,
			@RequestParam String showId, HttpSession session) {
		logger.debug("showId={}", showId);

		String memberLoggedIn = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();

		memberService.deleteMyStandBy(memberLoggedIn, showId);

		String msg = "????????? ?????????????????????.";
		String loc = "/member/myStandBy.do";

		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");

		return mav;
	}


	@RequestMapping("/myFollow.do")
	public ModelAndView myFollow(HttpSession session, ModelAndView mav) {
		String memberId = ((Member)session.getAttribute("memberLoggedIn")).getMemberId();

		List<String> follows = memberService.selectFollow(memberId);
		List<MusicalAndShow> masList = new ArrayList<>();
		getApi getApi = new getApi();
		for(String follow: follows) {
			masList.add(getApi.getMusicalAndShow(follow));
		}
		mav.addObject("masList", masList);
		mav.setViewName("/member/myFollow");
		return mav;
	}

	@RequestMapping("/deleteFollow.do")
	public ModelAndView deleteFollow(HttpSession session, ModelAndView mav, @RequestParam String playId) {
		String memberId = ((Member)session.getAttribute("memberLoggedIn")).getMemberId();
		Map<String, String> follow = new HashMap<>();
		follow.put("memberId", memberId);
		follow.put("playId",playId);
		memberService.deleteFollow(follow);

		String msg = "??????????????? ?????????????????????.";
		String loc = "/member/myFollow.do";

		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");

		return mav;
	}

	@RequestMapping(value="/memberUpdate.do")
	public String updateMember(Member member, Model model) {
		//		logger.debug("memberId="+member.getMemberId());
		logger.debug("member="+member);

		int result = memberService.updateMember(member);


		model.addAttribute("memberLoggedIn", member);

		// 2. view??? ??????
		model.addAttribute("msg", result>0?"?????? ?????? ?????? ??????!":"?????? ?????? ?????? ??????!");
		model.addAttribute("loc", "/member/memberView.do");

		return "common/msg";
	}
	@RequestMapping(value="/deleteMember.do")
	public String deleteMember(@RequestParam String memberId,
			Model model,
			SessionStatus sessionStatus) {
		logger.info("memeberId="+memberId);
		logger.debug("memeberId="+memberId);
		int result = memberService.deleteMember(memberId);
		if(!sessionStatus.isComplete())
			sessionStatus.setComplete(); 
		// 2. view??? ??????
		model.addAttribute("msg", result>0?"?????? ?????? ??????!":"?????? ?????? ??????!");
		model.addAttribute("loc", "/");

		return "common/msg";

	}
	@RequestMapping("/memberEnrollEnd.do")
	public String memberEnrollEnd(Member member, Model model) {

		// 0. ???????????? ?????????
		String rawPassword = member.getPassword();
		System.out.println("????????? ???:"+ rawPassword);
		String encodedPassword = passwordEncoder.encode(rawPassword);
		System.out.println("????????? ???:"+ encodedPassword);
		// ???????????? ??????????????? member?????? ??????
		member.setPassword(encodedPassword);

		// 1. ???????????? ??????
		int result = memberService.insertMember(member);

		// 2. view??? ??????
		model.addAttribute("msg", result>0?"?????? ?????? ??????!":"?????? ?????? ??????!");
		model.addAttribute("loc", "/");

		return "common/msg";
	}

	/* ????????? ?????? ?????? ?????? */
	@RequestMapping("/sendMail.do")
	@ResponseBody
	public String joinPost(@RequestParam String email, Model model) throws Exception {
		logger.info("member email: " + email);
		String authKey = memberService.createMail(email);


		return authKey;
	}
	/*????????? ?????? ?????? ?????? ???*/

	@RequestMapping(value="/memberLogin.do", method=RequestMethod.POST)
	public String memberLogin(@RequestParam String memberId,
			@RequestParam String password,
			Model model) {

		// 1.???????????? : ?????? ?????? ????????????
		Member member = memberService.selectOneMember(memberId);

		String msg = "";

		// 1. ???????????? ???????????? ?????? ??????
		if(member == null) {
			msg = "???????????? ???????????? ????????????.";
		}
		else {
			// 2. ????????? ??????
			if(passwordEncoder.matches(password, member.getPassword())) {
				msg = "????????? ??????!";

				// memberLoggedIn ?????? ????????? ??????
				// model??? ????????? ????????? requestScope ????????? ?????????.
				model.addAttribute("memberLoggedIn", member);

			}
			// 3. ??????????????? ?????? ??????
			else {
				msg = "??????????????? ???????????? ????????????.";
			}
		}

		// 2. view??? ??????
		model.addAttribute("msg", msg);
		model.addAttribute("loc", "/");

		return "common/msg";		
	}

	/**
	 * ?????? ???????????????
	 * session.setAttribute("memberLoggedIn", member)
	 * -> session.invalidate()
	 * 
	 * @SessionAttributes("memberLoggedIn")
	 * model.addAttribute("memberLoggedIn",member)
	 * -> SessionStatus.setComplete()
	 */
	@RequestMapping("/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus) {

		if(!sessionStatus.isComplete())
			sessionStatus.setComplete();

		// ??????????????? ?????? ???????????? ?????????
		return "redirect:/";
	}

	/**
	 * 
	 * ????????????(html??????)  + data(xml, json) 
	 * 
	 * REST API
	 * Representational State Transfer API 
	 * 
	 * @ResponseBody: ??????????????? xml/json???????????? ???????????? ??????
	 * 		- ??????????????? ??????
	 * @RequestBody: ?????????????????? ????????? xml/json????????? ??????????????? ???????????? ??????????????? ??????
	 */
	@ResponseBody
	@RequestMapping("/checkIdDuplicate.do")
	public Map<String,Object> checkIdDuplicate(@RequestParam String memberId) {
		logger.debug("id????????????: @ResponseBody ????????????");

		boolean isUsable = memberService.selectOneMember(memberId)==null?
				true:false;
		Map<String, Object> map = new HashMap<>();
		map.put("isUsable", isUsable);

		return map;

	}


	/*????????? ?????? ?????? ?????? ?????? */
	@RequestMapping("/memberIdFind.do")
	public String memberIdFinder() {



		return "/member/memberIdFind";
	}

	@RequestMapping("/memberPwdFind.do")
	public String memberPwdFinder() {



		return "/member/memberPwdFind";
	}

	/*-----------------*/	


	//	/*????????????????????? ?????????*/
	//    @ResponseBody
	//    @RequestMapping("/adminpage.do")
	//    public ModelAndView adminPage(ModelAndView mav) {
	//        mav.setViewName("member/adminreport");
	//        return mav;
	//    }
	//    
	//    @ResponseBody
	//    @RequestMapping("/adminmList.do")
	//    public ModelAndView adminmemberList(ModelAndView mav) {
	//        mav.setViewName("member/adminmList");
	//        return mav;
	//    }



	@RequestMapping(value="/updatePwd.do",method=RequestMethod.GET)
	public String changePasswd(@RequestParam String memberId, Model model) {

		model.addAttribute("Member",memberService.selectOneMember(memberId));
		return "member/updatePwd";
	}


	@RequestMapping(value="/updatePasswordEnd.do",method=RequestMethod.POST)
	public String changePassword(@RequestParam String memberId,
			@RequestParam String password,
			@RequestParam String password_new, Model model) {
		// 1.???????????? : ?????? ?????? ????????????
		Member member = memberService.selectOneMember(memberId);
		String pwd =member.getPassword();

		System.out.println("????????? ??????:"+password);

		String newpassword = passwordEncoder.encode(password_new); //????????????
		int result =0;

		String msg = "";
		String loc="";
		if(passwordEncoder.matches(password,pwd)==true) {
			//??????????????? ????????? 
			member.setPassword(newpassword);

			result =memberService.updatePwd(member); 

			if(result>0) {
				msg="???????????? ????????????";
				String script="self.close();";
				model.addAttribute("script",script);

			}else {
				msg="????????????";
			}
		}
		// 3. ??????????????? ?????? ??????
		else {
			msg = "??????????????? ???????????? ????????????.";
			loc="/member/updatePwd.do?memberId="+memberId;
		}



		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc); 

		return "common/msg";

	}
	@RequestMapping("/chkEmailUsable.do")
	@ResponseBody
	public String chkEmailUsable(@RequestParam String email){


		int cnt = 0;
		String authCode = null;

		cnt = memberService.chkEmailUsable(email);
		logger.debug("cnt={}", cnt);

		//????????? ????????????
		if(cnt==0) {
			String key = new TempKey().getKey(6, false); //6?????? ?????? ??????

			MailHandler sendMail;

			try {
				sendMail = new MailHandler(mailSender);

				sendMail.setSubject("[ShowTicket] ????????? ?????????????????????.");
				sendMail.setText(new StringBuffer().append("<h1>???????????????</h1>")
						.append("??????????????? ")
						.append("<strong>"+key+"</strong>")
						.append("?????????.")
						.toString());

				sendMail.setFrom("showticket77@gmail.com", "(???)?????????");
				sendMail.setTo(email);
				sendMail.send();

			} catch (MessagingException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}

			authCode = key;

		}

		//result.put("cnt", Integer.toString(cnt));
		//result.put("authCode", authCode);


		return authCode;
	}

	@RequestMapping(value="/reservationCancel.do",method=RequestMethod.POST)
	public String reservationCancle(Model model, @RequestParam int cancelTNo, HttpSession session) {

		String memberLoggedIn = ((Member) session.getAttribute("memberLoggedIn")).getMemberId();

		logger.debug("????????? ????????????: "+cancelTNo);
		logger.debug("????????? ?????????: "+memberLoggedIn);

		Map<String, Object> cancel = new HashMap<>();
		cancel.put("cancelTNo",cancelTNo);
		cancel.put("memberLoggedIn",memberLoggedIn);

		int result = memberService.updateReservation(cancel);

		model.addAttribute("msg", result>0?"?????? ?????? ??????":"?????? ?????? ??????!");
		model.addAttribute("loc", "/member/reservation.do?cPage="+1);

		return "common/msg";
	}

	@RequestMapping(value="/phone.do", method=RequestMethod.POST)
	@ResponseBody

	public String phone(Model model, @RequestParam String phone) {

		AuthPhoneNumber ap = new AuthPhoneNumber();
		String authPhone = ap.excuteGenerate();

		Message message = new Message(phone, "01099377714", "[" + authPhone + "] ????????? ??????????????? ??????????????????.");
		UtilSms.sendMessage(message);

		return authPhone;
	}


	@RequestMapping(value="/findIdByEmail.do", method=RequestMethod.POST)
	public ModelAndView findIdByEmail(ModelAndView mav, @RequestParam String memNm, @RequestParam String memEmail) {   
		Map<String, String> memInfo = new HashMap<>();
		memInfo.put("memNm", memNm);
		memInfo.put("memEmail", memEmail);

		String memberId = memberService.findIdByEmail(memInfo);

		mav.addObject("memberId", memberId);
		mav.setViewName("member/memberIdFindEnd");
		return mav;
	}

	@RequestMapping(value="/findIdByPhone.do", method=RequestMethod.POST)
	public ModelAndView findIdByPhone(ModelAndView mav, @RequestParam String memNm, @RequestParam String inputHp) {
		Map<String, String> memInfo = new HashMap<>();
		memInfo.put("memNm", memNm);
		memInfo.put("inputHp", inputHp);

		String memberId = memberService.findIdByPhone(memInfo);

		mav.addObject("memberId", memberId);
		mav.setViewName("member/memberIdFindEnd");
		return mav;
	}

	@RequestMapping(value="/findPwdByEmail.do", method=RequestMethod.POST)
	public ModelAndView findPwdByEmail(ModelAndView mav, @RequestParam String memNm, @RequestParam String memId, @RequestParam String memEmail) throws Exception {   
		Map<String, String> memInfo = new HashMap<>();
		memInfo.put("memNm", memNm);
		memInfo.put("memEmail", memEmail);

		String memberId = memberService.findIdByEmail(memInfo);

		String authKey = "";
		if(memberId.equals(memId)) {
			authKey = memberService.createMail(memEmail);
		}
		mav.addObject("memberId", memberId);
		mav.addObject("authKey", authKey);
		mav.setViewName("member/memberPwdFindEnd");
		return mav;
	}

	@RequestMapping(value="/findPwdByPhone.do", method=RequestMethod.POST)
	public ModelAndView findPwdByPhone(ModelAndView mav, @RequestParam String memNm, @RequestParam String memId, @RequestParam String inputHp) {
		Map<String, String> memInfo = new HashMap<>();
		memInfo.put("memNm", memNm);
		memInfo.put("inputHp", inputHp);

		String memberId = memberService.findIdByPhone(memInfo);

		String authKey = "";
		if(memberId.equals(memId)) {
			AuthPhoneNumber ap = new AuthPhoneNumber();
			authKey = ap.excuteGenerate();

			Message message = new Message(inputHp, "01099377714", "[" + authKey + "] ????????? ??????????????? ??????????????????.");
			UtilSms.sendMessage(message);
		}
		mav.addObject("memberId", memberId);
		mav.addObject("authKey", authKey);
		mav.setViewName("member/memberPwdFindEnd");
		return mav;
	}

	@RequestMapping(value="/updatePwdByFind.do",method=RequestMethod.POST)
	public String updatePwdByFind(@RequestParam String memberId, @RequestParam String password_new, Model model) {
		// 1.???????????? : ?????? ?????? ????????????
		Member member = memberService.selectOneMember(memberId);


		String newpassword = passwordEncoder.encode(password_new); //????????????

		System.out.println("????????? ??????:"+newpassword);
		String msg = "";
		String loc= "member/memberPwdFindEnd";
		member.setPassword(newpassword);

		int	result =memberService.updatePwd(member); 

		if(result>0) {
			msg="???????????? ????????????";
			String script="self.close();";
			model.addAttribute("script",script);

		}else {
			msg="????????????";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc); 

		return "common/msg";

	}

	@RequestMapping("/updatePt.do") 
	public String updatePoint (Model model ,@RequestParam String memberId ) {

		int result = memberService.updatePoint(memberId);

		model.addAttribute("msg",result>0?"???????????? ?????????????????????.":"????????? ????????? ?????????????????????.");
		model.addAttribute("loc","/member/reservation.do?memberId="+memberId+"&cPage="+1);
		return "common/msg"; 
	}

}

