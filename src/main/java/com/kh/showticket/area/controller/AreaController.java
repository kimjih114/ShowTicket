package com.kh.showticket.area.controller;

import static com.kh.showticket.common.getApi.getApi.getConcatList;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/area")
public class AreaController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping("/area.do")
	public ModelAndView areaList(ModelAndView mav) {

		String url1="http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate=20190923&eddate=20191030&cpage=1&rows=6&shcate=AAAA";
		String url2="http://www.kopis.or.kr/openApi/restful/pblprfr?service=3127d89913494563a0e9684779988063&stdate=20190923&eddate=20191030&cpage=1&rows=6&shcate=AAAB";

		mav.setViewName("area/area");
		mav.addObject("concatList", getConcatList(url1,url2));
		return mav;
	}

	@RequestMapping("/areaAjax.do")
	public List<Map<String,String>> getAreaList(@RequestParam String url1, @RequestParam String url2) {
		return getConcatList(url1,url2);
	}



}
