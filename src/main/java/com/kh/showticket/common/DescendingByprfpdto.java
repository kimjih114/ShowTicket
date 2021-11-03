package com.kh.showticket.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DescendingByprfpdto implements Comparator<Map<String, String>> {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public int compare(Map<String, String> m1, Map<String, String> m2) {
		String prfpdto = m1.get("prfpdto");
		String prfpdto2 = m2.get("prfpdto");
		
		//logger.debug("prfpdfrom1={}",prfpdfrom1 );
		
		Date prfpdfto1_ = null;
		Date prfpdfto2_ = null;
		
		try {
			SimpleDateFormat stringToDate = new SimpleDateFormat("yyyy.MM.dd");
			prfpdfto1_ = stringToDate.parse(prfpdto);
			prfpdfto2_ = stringToDate.parse(prfpdto2);
			
		} catch (ParseException e) {
			e.printStackTrace();
			
		}
		//logger.debug("prfpdfrom1={}",prfpdfrom1 );
		
		return prfpdfto2_.compareTo(prfpdfto1_);
	}

	
}