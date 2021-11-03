package com.kh.showticket.event.controller;

import static com.kh.showticket.common.getApi.getApi.getConcatList;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.showticket.common.util.HelloSpringUtils;
import com.kh.showticket.event.model.exception.EventException;
import com.kh.showticket.event.model.service.DiscountService;
import com.kh.showticket.event.model.service.EndDiscountService;
import com.kh.showticket.event.model.service.EventCommentService;
import com.kh.showticket.event.model.service.EventService;
import com.kh.showticket.event.model.service.PrizeWinnerService;
import com.kh.showticket.event.model.vo.Discount;
import com.kh.showticket.event.model.vo.EndDiscount;
import com.kh.showticket.event.model.vo.Event;
import com.kh.showticket.event.model.vo.EventAttachment;
import com.kh.showticket.event.model.vo.EventComment;
import com.kh.showticket.event.model.vo.EventVO;
import com.kh.showticket.event.model.vo.Prizewinner;

@Controller
@RequestMapping("/event")
public class EventController {

	@Autowired
	DiscountService discountService;

	@Autowired
	EndDiscountService enddiscountService;

	@Autowired
	EventService eventService;

	@Autowired
	EventCommentService eventCommentService;
	
	@Autowired 
	PrizeWinnerService prizeWinnerService;

	Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping("/eventList.do")
	public ModelAndView event(ModelAndView mav) {
		logger.debug("event페이지 요청");

		List<Discount> dcList = discountService.selectdcList();
		List<Event> eventList = eventService.selectEventList();

		mav.setViewName("event/eventList");
		mav.addObject("dcList", dcList);
		mav.addObject("eventList", eventList);

		return mav;
	}

	@RequestMapping("/endEventList.do")
	public ModelAndView endEvent(ModelAndView mav) {
		logger.debug("endEvent페이지 요청");
		List<EndDiscount> EdcList = enddiscountService.selectEdcList();

		mav.addObject("EdcList", EdcList);
		mav.setViewName("event/endEventList");
		return mav;
	}

	@RequestMapping("/prizewinner.do")
	public ModelAndView prizewinner(ModelAndView mav) {
		logger.debug("prizewinner페이지 요청");

		List<Event> eventList = eventService.selectEventList();

		mav.addObject("eventList", eventList);
		mav.setViewName("event/prizewinner");
		return mav;
	}

	@RequestMapping("/addSaleEvent.do")
	public ModelAndView addSaleEvent(ModelAndView mav) {

		String url1 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=61b91b2730084f47a2c5304ed87d2294&stdate=20190623&eddate=20191021&cpage=1&rows=20&shcate=AAAA";
		String url2 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=61b91b2730084f47a2c5304ed87d2294&stdate=20190623&eddate=20191021&cpage=1&rows=20&shcate=AAAB";

		mav.setViewName("/event/addSaleEvent");

		mav.addObject("evt", getConcatList(url1, url2));

		return mav;
	}

	@RequestMapping("/prizewinnerWrite.do")
	public String writeprizewinner(Model model , @RequestParam int eventNo ) {

		List<EventVO>wList = eventCommentService.selectOneEventJoin(eventNo) ;

		model.addAttribute("prize", eventService.selectOneEvent(eventNo));
		model.addAttribute("wList",wList);
		
		return "/event/writeprizewinner";
	}

	@RequestMapping("/eventWrite.do")
	public ModelAndView eventWrite(ModelAndView mav) {
		logger.debug("eventWrite페이지 요청");

		String url1 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=61b91b2730084f47a2c5304ed87d2294&stdate=20190623&eddate=20191025&cpage=1&rows=3&shcate=AAAA";
		String url2 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=61b91b2730084f47a2c5304ed87d2294&stdate=20190623&eddate=20191025&cpage=1&rows=3&shcate=AAAB";

		mav.addObject("loc", "/event/eventWrite.do");
		mav.addObject("eventList", getConcatList(url1, url2));
		return mav;
	}

	@RequestMapping("/addSaleView.do")
	public String addSaleView(Model model, @RequestParam String showId) {
		logger.debug("특가 상세보기페이지 요청");

		model.addAttribute("dcList", discountService.selectOneDc(showId));

		return "event/addSaleView";
	}

	@RequestMapping("/insertAddSale.do")
	public String insertAddSale(Discount discount, Model model) {

		logger.info("특가 할인 입력 기능 요청");
		int result = 0;
		int rst = 0;
		int cnt = discountService.checkCnt();

		if (cnt < 4) {
			result = discountService.insertAddSale(discount);

		} else {
			rst = discountService.deleteAddSale();
			if (rst > 0) {

				result = discountService.insertAddSale(discount);
			}
		}

		// 2. view단 처리
		model.addAttribute("msg", result > 0 ? "할인 등록성공" : "할인 등록 실패");
		model.addAttribute("loc", "/event/eventList.do");

		return "common/msg";
	}

	@RequestMapping("/insertEvent.do")
	public void insertEvent() {
		logger.debug("이벤트 작성페이지 요청!!");
	}

	@RequestMapping("/insertEventEnd.do")
	public String insertEvent(Event event, Model model, HttpServletRequest request, MultipartFile[] upFile) {

		try {
			// 파일업로드:서버에 파일저장
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/event");
			System.out.println("saveDirectory>>" + saveDirectory);
			// db에 파일 메타정보
			List<EventAttachment> eattachList = new ArrayList<>();

			// MultipartFile 다루기
			for (MultipartFile f : upFile) {
				// 파일 유효성 검사
				if (!f.isEmpty()) {
					// renamedFileName
					String originalFileName = f.getOriginalFilename();
					String renamedFileName = HelloSpringUtils.getRenamedFileName(originalFileName);

					try {
						// 파일 실제 저장
						f.transferTo(new File(saveDirectory + "/" + renamedFileName));
					} catch (Exception e) {
						e.printStackTrace();
					}

					EventAttachment eattach = new EventAttachment();
					eattach.setOriginalFileName(originalFileName);
					eattach.setRenamedFileName(renamedFileName);
					eattachList.add(eattach);

				}

			}

			int result = eventService.insertEventEnd(event, eattachList);
			String msg = result > 0 ? "이벤트 등록성공" : "이벤트 등록 실패";

			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/event/eventList.do");
		} catch (Exception e) {
			logger.error("이벤트 등록 오류", e);

			throw new EventException("이벤트 등록 오류", e);
		}

		return "common/msg";
	}

	@RequestMapping("/prizewinnerView.do")
	public String prizewinnerView(Model model, @RequestParam int eventNo) {
		model.addAttribute("prize", eventService.selectOneEvent(eventNo));
		model.addAttribute("winner",prizeWinnerService.selectWinner(eventNo));
		System.out.println("프라이즈위너"+prizeWinnerService.selectWinner(eventNo));
		return "event/prizewinnerView";
	}

	@PostMapping("/eventCommentInsert")
	@ResponseBody
	public Map<String, String> eventCommnetInsert(@RequestBody EventComment eventComment) {
		logger.info("댓글 기능 ");

		int result = eventCommentService.insertComment(eventComment);

		Map<String, String> map = new HashMap<>();
		map.put("msg", result > 0 ? "댓글 등록 성공!" : "댓글 등록 실패!");
		return map;
	}
	
	@RequestMapping("/eventView.do")
	public String eventView(Model model, @RequestParam int eventNo) {
		logger.debug("전체이벤트 상세보기페이지 요청");

		model.addAttribute("eventList", eventService.selectOneEvent(eventNo));
		return "event/eventView";
	}

	
	
	  @RequestMapping("/list") //댓글 리스트
	  @ResponseBody
	  private List<EventComment> eCommentList(Model model,@RequestParam int eventNo) throws Exception{

		  
		  return eventCommentService.eCommentList(eventNo);
	  }
	 
	 
	  @RequestMapping("/delete/{commentNo}")
	  @ResponseBody
	  private int eCommentDelete (@PathVariable int commentNo) throws Exception{
		
		 return eventCommentService.eCommentDelete(commentNo); 
	  }
	  
	  @RequestMapping("/winnerprize.do")
	  public String winnerPrize(Prizewinner prize,Model model) {
		  
		  
		  System.out.println("prizew>>>>"+prize);
		  int result=prizeWinnerService.winnerPrize(prize) ;
		  
		  model.addAttribute("msg",result > 0 ? "당첨자 등록성공" : "당첨자 등록 실패");
		  model.addAttribute("loc", "/event/prizewinner.do");

			return "common/msg";
	  }
	  

}
