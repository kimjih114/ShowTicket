package com.kh.showticket.common.getApi;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.kh.showticket.common.DescendingByPrfpdfrom;
import com.kh.showticket.common.DescendingByprfpdto;
import com.kh.showticket.common.MusicalAndShow;


public class getApi {
	static Logger logger = LoggerFactory.getLogger("com.kh.showticket.common.getApi.getApi");
	static DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	static DocumentBuilder documentBuilder;
	static Document doc;
	
	public static String getTagValue(String tag, Element element) {
		NodeList nodeList = element.getElementsByTagName(tag).item(0).getChildNodes();
		Node value = (Node)nodeList.item(0);

		if(value==null) {
			return null;
		}

		return value.getNodeValue();
	}
	
	
	public static NodeList getTagValues(String tag, Element element) {
		NodeList nodeList = element.getElementsByTagName(tag).item(0).getChildNodes();
		NodeList values = (NodeList)nodeList.item(0);

		if(values==null) {
			return null;
		}

		return values;
	}

	//理쒖떊�닚 �젙�젹
	public static List<Map<String, String>> getOrderedListByDate(List<Map<String,String>> list){
		Collections.sort(list, new DescendingByPrfpdfrom());
		//logger.debug("�젙�젹寃곌낵 : {}", list);
		return list;
	}

	public static List<Map<String, String>> getOrderedListByDate2(List<Map<String,String>> list){
		Collections.sort(list, new DescendingByprfpdto());
		logger.debug("�젙�젹寃곌낵 : {}", list);
		return list;
	}
	//裕ㅼ�而�/�뿰洹밸떒�씪紐⑸줉議고쉶
	public static List<Map<String, String>> getList(String url){
		List<Map<String,String>> list = new ArrayList<>();	

		try {
			documentBuilder = factory.newDocumentBuilder();
			doc = documentBuilder.parse(url);

			doc.getDocumentElement().normalize();
			//logger.debug("Root element: {} ", doc.getDocumentElement().getNodeName()); // Root element: dbs

			NodeList nodeList = doc.getElementsByTagName("db");
			//logger.debug("�뙆�떛�븷 由ъ뒪�듃 �닔 : {}", nodeList.getLength());  // �뙆�떛�븷 由ъ뒪�듃 �닔 :  8

			for(int i=0; i<nodeList.getLength(); i++){
				Node node = nodeList.item(i);
				if(node.getNodeType() == Node.ELEMENT_NODE){

					Element element = (Element)node;

					//logger.debug("=================================");
					//logger.debug("怨듭뿰ID: {}", getTagValue("mt20id", element));
					//logger.debug("怨듭뿰紐�: {}", getTagValue("prfnm", element));
					//logger.debug("怨듭뿰�떆�옉�씪: {}", getTagValue("prfpdfrom", element));
					//logger.debug("怨듭뿰醫낅즺�씪: {}", getTagValue("prfpdto", element));
					//logger.debug("�룷�뒪�꽣�씠誘몄�寃쎈줈: {}", getTagValue("poster", element));
					//logger.debug("怨듭뿰�옣紐� : {}", getTagValue("fcltynm", element));
					//logger.debug("怨듭뿰�옣�옣瑜� : {}", getTagValue("genrenm", element));
					Map<String, String> map = new HashMap<>();

					//怨듭뿰ID
					map.put("mt20id", getTagValue("mt20id", element));
					//怨듭뿰紐�
					map.put("prfnm", getTagValue("prfnm", element));
					//怨듭뿰�떆�옉�씪
					map.put("prfpdfrom", getTagValue("prfpdfrom", element));
					//怨듭뿰醫낅즺�씪
					map.put("prfpdto", getTagValue("prfpdto", element));
					//�룷�뒪�꽣�씠誘몄�寃쎈줈
					map.put("poster", getTagValue("poster", element));
					//怨듭뿰�옣紐�
					map.put("fcltynm", getTagValue("fcltynm", element));
					//怨듭뿰�옣瑜�
					map.put("genrenm", getTagValue("genrenm", element));
					
					map.put("prfstate", getTagValue("prfstate", element));
					
					list.add(map);

				}

			}
		} catch (Exception e) {

		}

		return list;

	}

	//裕ㅼ�而�/�뿰洹뱁넻�빀紐⑸줉議고쉶
	public static List<Map<String, String>> getConcatList(String url1, String url2){
		List<Map<String,String>> showList = getList(url1);
		List<Map<String,String>> musicalList = getList(url2);

		List<Map<String,String>> concatList = new ArrayList<>(showList);
		concatList.addAll(musicalList);

		return concatList;

	}

	//諛뺤뒪�삤�뵾�뒪
	public static List<Map<String, String>> getBoxList(String url){
		List<Map<String,String>> Blist = new ArrayList<>();	

		try {
			documentBuilder = factory.newDocumentBuilder();
			doc = documentBuilder.parse(url);

			doc.getDocumentElement().normalize();
			//logger.debug("Root element: {} ", doc.getDocumentElement().getNodeName()); // Root element: boxofs

			NodeList nodeList = doc.getElementsByTagName("boxof");
			//logger.debug("�뙆�떛�븷 由ъ뒪�듃 �닔 : {}", nodeList.getLength());  // �뙆�떛�븷 由ъ뒪�듃 �닔 :  14

			for(int i=0; i<nodeList.getLength(); i++){
				Node node = nodeList.item(i);
				if(node.getNodeType() == Node.ELEMENT_NODE){

					Element element = (Element)node;

					//logger.debug("=================================");
					//logger.debug("怨듭뿰紐�: {}", getTagValue("prfnm", element));
					//logger.debug("怨듭뿰湲곌컙: {}", getTagValue("prfpd", element));
					//logger.debug("怨듭뿰吏��뿭: {}", getTagValue("area", element));
					//logger.debug("�룷�뒪�꽣�씠誘몄�寃쎈줈: {}", getTagValue("poster", element));
					//logger.debug("怨듭뿰�옣瑜�: {}", getTagValue("cate", element));
					//logger.debug("=================================");
					
					
					Map<String, String> Mmap = new HashMap<>();

					//怨듭뿰 Id
					Mmap.put("mt20id", getTagValue("mt20id", element));
					//怨듭뿰紐�
					Mmap.put("prfnm", getTagValue("prfnm", element));
					//怨듭뿰湲곌컙
					Mmap.put("prfpd", getTagValue("prfpd", element));
					//怨듭뿰吏��뿭
					Mmap.put("area", getTagValue("area", element));
					//�룷�뒪�꽣�씠誘몄�寃쎈줈
					Mmap.put("poster", getTagValue("poster", element));
					//怨듭뿰�옣瑜�
					Mmap.put("cate", getTagValue("cate", element));
					//怨듭뿰�옣
					Mmap.put("prfplcnm",getTagValue("prfplcnm",element));

					Blist.add(Mmap);
				}
			}
		} catch (Exception e) {

		}
		return Blist;
	}
	
	//怨듭뿰�긽�꽭議고쉶 : �븘�슂�븳 �빆紐⑹씠 �엳�떎硫� 異붽� 諛붾엺
	public static Map<String, String> getDetailList(String url){
		
		Map<String, String> map = new HashMap<>();
		
		try {
			documentBuilder = factory.newDocumentBuilder();
			doc = documentBuilder.parse(url);

			
		doc.getDocumentElement().normalize();
		//logger.debug("Root element: {} ", doc.getDocumentElement().getNodeName()); // Root element: dbs
		
		NodeList nodeList = doc.getElementsByTagName("db");
		//logger.debug("�뙆�떛�븷 由ъ뒪�듃 �닔 : {}", nodeList.getLength());  // �뙆�떛�븷 由ъ뒪�듃 �닔 :  8
			
	
		for(int i=0; i<nodeList.getLength(); i++){
			Node node = nodeList.item(i);
			if(node.getNodeType() == Node.ELEMENT_NODE){
									
			Element element = (Element)node;
					
			//logger.debug("=================================");
			//logger.debug("怨듭뿰ID: {}", getTagValue("mt20id", element));
			//logger.debug("怨듭뿰紐�: {}", getTagValue("prfnm", element));
			//logger.debug("怨듭뿰�떆�옉�씪: {}", getTagValue("prfpdfrom", element));
			//logger.debug("怨듭뿰醫낅즺�씪: {}", getTagValue("prfpdto", element));
			//logger.debug("�룷�뒪�꽣�씠誘몄�寃쎈줈: {}", getTagValue("poster", element));
			//logger.debug("怨듭뿰�옣紐� : {}", getTagValue("fcltynm", element));
					
			//怨듭뿰ID
			map.put("mt20id", getTagValue("mt20id", element));
			//怨듭뿰紐�
			map.put("prfnm", getTagValue("prfnm", element));
			//怨듭뿰�떆�옉�씪
			map.put("prfpdfrom", getTagValue("prfpdfrom", element));
			//怨듭뿰醫낅즺�씪
			map.put("prfpdto", getTagValue("prfpdto", element));
			//�룷�뒪�꽣�씠誘몄�寃쎈줈
			map.put("poster", getTagValue("poster", element));
			//怨듭뿰�옣紐�
			map.put("fcltynm", getTagValue("fcltynm", element));
			//怨듭뿰異쒖뿰吏�
			map.put("prfcast", getTagValue("prfcast", element));
			//怨듭뿰�젣�옉吏� : prfcrew
			//怨듭뿰�윴���엫 : prfruntime
			//怨듭뿰 愿��엺 �뿰�졊 : prfage	
			//�젣�옉�궗 :entrpsnm
			//�떚耳볤�寃�
			map.put("pcseguidance", getTagValue("pcseguidance", element));
			//以꾧굅由�(null�씪�닔�엳�쓬) : sty
			//�옣瑜� : genrenm
			//�냼媛쒖씠誘몄�紐⑸줉 : styurls - styurl
			//怨듭뿰�떆媛� : dtguidance
			
				
			}
		}
			} catch (Exception e) {
		
		}
		
		return map;
	}
	
	
	//裕ㅼ�而�/�뿰洹� 諛뺤뒪�삤�뵾�뒪 �넻�빀紐⑸줉議고쉶
	public static List<Map<String, String>> getTotalBoxList(String url1, String url2){
		List<Map<String,String>> showList = getBoxList(url1);
		List<Map<String,String>> musicalList = getBoxList(url2);

		List<Map<String,String>> totalBoxList = new ArrayList<>();
		totalBoxList.addAll(musicalList);
		totalBoxList.addAll(showList);
		//logger.debug("totalBoxListFromGetAPI"+totalBoxList);

		return totalBoxList;

	}
	
	//怨듭뿰 �긽�꽭議고쉶
	public MusicalAndShow getMusicalAndShow(String id) {
		MusicalAndShow mas = new MusicalAndShow();
		
		try {
			
			String url = "http://www.kopis.or.kr/openApi/restful/pblprfr/"+id+"?service=3127d89913494563a0e9684779988063";			
			documentBuilder = factory.newDocumentBuilder();
			doc = documentBuilder.parse(url);

			System.out.println(url);
			
			doc.getDocumentElement().normalize();
			NodeList nodeList = doc.getElementsByTagName("db");
			//logger.debug("�뙆�떛�븷 由ъ뒪�듃 �닔 : {}", nodeList.getLength());  // �뙆�떛�븷 由ъ뒪�듃 �닔 :  8

//			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy.MM.dd");
//			transFormat.parse(getTagValue("prfpdfrom", element))
			
		
//			for(int i=0; i<nodeList.getLength(); i++){
			Node node = nodeList.item(0);
			
			if(node.getNodeType() == Node.ELEMENT_NODE){
				
				Element element = (Element)node;
				
				mas.setId(getTagValue("mt20id", element));
				mas.setName(getTagValue("prfnm", element));
				mas.setStartDate(getTagValue("prfpdfrom", element));			
				mas.setEndDate(getTagValue("prfpdto", element));			
				mas.setHallId(getTagValue("mt10id", element));
				mas.setHallName(getTagValue("fcltynm", element));
				mas.setCast(getTagValue("prfcast", element));
				mas.setRuntime(getTagValue("prfruntime", element));
				mas.setAge(getTagValue("prfage", element));
				mas.setPrice(getTagValue("pcseguidance", element));
				mas.setPoster(getTagValue("poster", element));
				mas.setGenre(getTagValue("genrenm", element));
				mas.setState(getTagValue("prfstate", element));
				
				NodeList nl = element.getElementsByTagName("styurl"); NodeList urlList;
				String[] arr = new String[nl.getLength()]; 
				for(int i=0;i<nl.getLength();i++)
				{ 
					  urlList = nl.item(i).getChildNodes();
					  Node value = (Node)urlList.item(0);
					  arr[i] = value.getNodeValue();
					  
					  System.out.println("arr:"+ arr[i]);
//					  System.out.println(value.getNodeValue()); 
				} 
				 
				
				
				mas.setUrls(arr);
				mas.setTime(getTagValue("dtguidance", element));
				
			}
		} catch (Exception e) {
		
		}
		
		
		return mas;
	}
	
	
	//怨듭뿰�긽�꽭議고쉶 : �븘�슂�븳 �빆紐⑹씠 �엳�떎硫� 異붽� 諛붾엺
	public static Map<String, String> getPlaceList(String url){
		
		Map<String, String> map = new HashMap<>();
		
		try {
			documentBuilder = factory.newDocumentBuilder();
			doc = documentBuilder.parse(url);
			
			
			doc.getDocumentElement().normalize();
			//logger.debug("Root element: {} ", doc.getDocumentElement().getNodeName()); // Root element: dbs
			
			NodeList nodeList = doc.getElementsByTagName("db");
			//logger.debug("�뙆�떛�븷 由ъ뒪�듃 �닔 : {}", nodeList.getLength());  // �뙆�떛�븷 由ъ뒪�듃 �닔 :  8
			
			
			for(int i=0; i<nodeList.getLength(); i++){
				Node node = nodeList.item(i);
				if(node.getNodeType() == Node.ELEMENT_NODE){
					
					Element element = (Element)node;
					
					//logger.debug("=================================");
					//logger.debug("怨듭뿰ID: {}", getTagValue("mt20id", element));
					//logger.debug("怨듭뿰紐�: {}", getTagValue("prfnm", element));
					//logger.debug("怨듭뿰�떆�옉�씪: {}", getTagValue("prfpdfrom", element));
					//logger.debug("怨듭뿰醫낅즺�씪: {}", getTagValue("prfpdto", element));
					//logger.debug("�룷�뒪�꽣�씠誘몄�寃쎈줈: {}", getTagValue("poster", element));
					//logger.debug("怨듭뿰�옣紐� : {}", getTagValue("fcltynm", element));
					
					//以꾧굅由�(null�씪�닔�엳�쓬) : sty
					//�옣瑜� : genrenm
					//�냼媛쒖씠誘몄�紐⑸줉 : styurls - styurl
					//怨듭뿰�떆媛� : dtguidance
					//�븘�뱶紐�	�꽕紐�	�깦�뵆�뜲�씠�꽣
					map.put("fcltynm",getTagValue("fcltynm", element));
					//fcltynm	怨듭뿰�떆�꽕紐�	�삱由쇳뵿怨듭썝
					map.put("mt10id",getTagValue("mt10id", element));
					//mt10id	怨듭뿰�떆�꽕ID	FC001247
					//mt13cnt	怨듭뿰�옣 �닔	9
					//fcltychartr	�떆�꽕�듅�꽦	湲고�(怨듦났)
					//opende	媛쒓��뿰�룄	1986
					//seatscale	媛앹꽍 �닔	32349
					//telno	�쟾�솕踰덊샇	02-410-1114
					map.put("telno",getTagValue("telno", element));
					//relateurl	�솃�럹�씠吏�	http://www.olympicpark.co.kr/
					//adres	二쇱냼	�꽌�슱�듅蹂꾩떆 �넚�뙆援� 諛⑹씠�룞
					map.put("adres",getTagValue("adres", element));
					//la	�쐞�룄	37.52112
					map.put("la",getTagValue("la", element));
					map.put("lo",getTagValue("lo", element));
					//lo	寃쎈룄	127.12836360000005
					
					
				}
			}
		} catch (Exception e) {
			
		}
		
		return map;
	}

	
}
