package com.kh.showticket.common.postconstruct;

import static com.kh.showticket.common.getApi.getApi.getDetailList;
import static com.kh.showticket.common.getApi.getApi.getList;
import static com.kh.showticket.common.getApi.getApi.getBoxList;
import static com.kh.showticket.common.getApi.getApi.getConcatList;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

@Controller
public class PostConstructing {
	
	Logger logger = LoggerFactory.getLogger(getClass());

	//裕ㅼ�而�, �뿰洹� �쟾泥�(�긽�꽭) 由ъ뒪�듃
	public static List<Map<String,String>> musicalDetailList;
	public static List<Map<String,String>> showDetailList;
	
	//寃��깋由ъ뒪�듃
	public static List<Map<String,String>> mTicketResult;
	public static List<Map<String,String>> sTicketResult;
	public static List<Map<String,String>> eventResult;

	//裕ㅼ�而�/�뿰洹� 踰좎뒪�듃
	public static List<Map<String,String>> mBestList;
	public static List<Map<String,String>> sBestList;
	
	//�떚耳� �삤�뵂 由ъ뒪�듃
	public static List<Map<String,String>> ticketOpenList;
	
	//�씪媛� �옲�궧 由ъ뒪�듃
	public static List<Map<String,String>> dayRankList1;
	public static List<Map<String,String>> dayRankList2;

	//연극 리스트
	public static List<Map<String,String>> showList;
	
	
	@PostConstruct
	public void postConstruct() {
		//�쟾泥� 裕ㅼ�而� 由ъ뒪�듃
		String url = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate=20190923&eddate=20191031&cpage=1&rows="+Integer.MAX_VALUE+"&shcate=AAAB";	
		List<Map<String,String>> musicalAllList = getList(url);
		musicalDetailList = new ArrayList<>();
		
		for(Map<String,String> map : musicalAllList) {
			url = "http://www.kopis.or.kr/openApi/restful/pblprfr/"+map.get("mt20id")+"?service=3127d89913494563a0e9684779988063";
			musicalDetailList.add(getDetailList(url));
		}
		//logger.debug("musicalDetailList={}",musicalDetailList);
		
		//�쟾泥� �눥 由ъ뒪�듃
		url = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate=20190923&eddate=20191031&cpage=1&rows="+Integer.MAX_VALUE+"&shcate=AAAA";	
		List<Map<String,String>> showAllList = getList(url);
		
		showDetailList = new ArrayList<>();

		for(Map<String,String> map : showAllList) {
			url = "http://www.kopis.or.kr/openApi/restful/pblprfr/"+map.get("mt20id")+"?service=3127d89913494563a0e9684779988063";
			showDetailList.add(getDetailList(url));
		}
		
		
		//踰좎뒪�듃 裕ㅼ�而�/�뿰洹� 由ъ뒪�듃
		Calendar c1 = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd"); // �궇吏� �룷留� 
		c1.add(Calendar.DATE, -1); // �삤�뒛�궇吏쒕줈遺��꽣 -1
		String yesterday = sdf.format(c1.getTime());
		c1.add(Calendar.DATE, 1); // 오늘날짜로부터 -1
		String today = sdf.format(c1.getTime());
		c1.add(Calendar.DATE, 30); // 오늘날짜로부터 30
		String nextMonth = sdf.format(c1.getTime());
		String url1 = "http://kopis.or.kr/openApi/restful/boxoffice?service=9f6a9651f5e648ac95d2cc7a210a4587&ststype=month&date="+yesterday+"&catecode=AAAB";
		
		mBestList = getBoxList(url1);
		
		url1 = "http://kopis.or.kr/openApi/restful/boxoffice?service=9f6a9651f5e648ac95d2cc7a210a4587&ststype=month&date="+yesterday+"&catecode=AAAA";
		
		sBestList= getBoxList(url1);
		
		//�떚耳� �삤�뵂 由ъ뒪�듃
		String url3 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=9f6a9651f5e648ac95d2cc7a210a4587&stdate="+yesterday+"&eddate="+nextMonth+"&rows=5&cpage=1&shcate=AAAA";		
		String url4 = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=9f6a9651f5e648ac95d2cc7a210a4587&stdate="+yesterday+"&eddate="+nextMonth+"&rows=5&cpage=1&shcate=AAAB";		
		
		ticketOpenList = getConcatList(url3,url4);
		
		
		//�씪媛� �옲�궧 由ъ뒪�듃
		url1 = "http://kopis.or.kr/openApi/restful/boxoffice?service=3127d89913494563a0e9684779988063&catecode=AAAB&ststype=day&date="+yesterday;
		String url2 = "http://kopis.or.kr/openApi/restful/boxoffice?service=3127d89913494563a0e9684779988063&catecode=AAAA&ststype=day&date="+yesterday;
		
		dayRankList1 = getBoxList(url1);
		dayRankList2 = getBoxList(url2);
		
		//연극 리스트

		c1.add(Calendar.DATE,-30);
		String monthBefore = sdf.format(c1.getTime());
		
		url = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate="+monthBefore+"&eddate="+today+"&shcate=AAAA&rows="+Integer.MAX_VALUE+"&cpage=1";
		
		showList = getList(url);
	}

}
