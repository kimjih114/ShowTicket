package com.kh.showticket.common.getApi;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class ApiTest {
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
	public static void main(String[] args) {

try {
			
			String url = "http://www.kopis.or.kr/openApi/restful/pblprfr/PF148915?service=3127d89913494563a0e9684779988063";			
			documentBuilder = factory.newDocumentBuilder();
			doc = documentBuilder.parse(url);

			System.out.println(url);
			
			doc.getDocumentElement().normalize();
			NodeList nodeList = doc.getElementsByTagName("db");
			//logger.debug("파싱할 리스트 수 : {}", nodeList.getLength());  // 파싱할 리스트 수 :  8
		
//			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy.MM.dd");
//			transFormat.parse(getTagValue("prfpdfrom", element))
			
		
//			for(int i=0; i<nodeList.getLength(); i++){
			Node node = nodeList.item(0);
			if(node.getNodeType() == Node.ELEMENT_NODE){
				
				Element element = (Element)node;
				
				//mas.setUrls(getTagValue("styurl", element));
				NodeList styurls = element.getElementsByTagName("styurl");
				
				NodeList nodeList2 = element.getElementsByTagName("styurl").item(0).getChildNodes();
				NodeList nodeList3 = element.getElementsByTagName("styurl").item(1).getChildNodes();
				NodeList nodeList4 = element.getElementsByTagName("styurl").item(2).getChildNodes();
				Node value1 = (Node)nodeList2.item(0);
				Node value2 = (Node)nodeList3.item(0);
				Node value3 = (Node)nodeList4.item(0);
				
				NodeList nl = element.getElementsByTagName("styurl");
				
				NodeList urlList;
				for(int i=0;i<nl.getLength();i++) {
					urlList = nl.item(i).getChildNodes();
					Node value = (Node)urlList.item(0);
					
					System.out.println(value.getNodeValue());
				}
				
				
//				NodeList styurls = getTagValue("styurl",element);
				//System.out.println(styurls.getLength());
//				for(int i=0;i<styurls.getLength();i++) {
//					Node styurl = styurls.item(i);
//					Element urlElement = (Element)styurl;
//					System.out.println(getTagValue("styurl",urlElement));
//				}
//				System.out.println(getTagValues("styurl", element));			
			}
//			}
		} catch (Exception e) {
		
		}
	
	
	}

}
