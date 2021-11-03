package com.kh.showticket.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DescendingByPrfpdfrom implements Comparator<Map<String, String>> {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public int compare(Map<String, String> m1, Map<String, String> m2) {
		String prfpdfrom1 = m1.get("prfpdfrom");
		String prfpdfrom2 = m2.get("prfpdfrom");
		
		//logger.debug("prfpdfrom1={}",prfpdfrom1 );
		
		SimpleDateFormat stringToDate = new SimpleDateFormat("yyyy.MM.dd");

		Date prfpdfrom1_ = null;
		Date prfpdfrom2_ = null;
		
		try {
			prfpdfrom1_ = stringToDate.parse(prfpdfrom1);
			prfpdfrom2_ = stringToDate.parse(prfpdfrom2);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		//logger.debug("prfpdfrom1={}",prfpdfrom1 );

		return prfpdfrom2_.compareTo(prfpdfrom1_);
	}
}
