package com.kh.showticket.common.selenium;

import java.util.Map;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kh.showticket.common.MusicalAndShow;

public class Crawling {
	
	
	  private static WebDriver driver;
	  private static Map<String, Object> vars;
	  JavascriptExecutor js;
	  private static WebDriverWait wait;
	  
		private Logger logger = LoggerFactory.getLogger(getClass());

		
	  public String  getImg(MusicalAndShow mas,String selectDate, String selectNum)  throws InterruptedException, NullPointerException{

	
		//SSl certificates 보안쪽 방지용
// 헤드리스 크롬용
//		Desired capabilities=
//		general chrome profile
//		DesiredCapabilities ch=DesiredCapabilities.chrome();
//		ch.acceptInsecureCerts();
//		ch.setCapability(CapabilityType.ACCEPT_INSECURE_CERTS, true);
//		ch.setCapability(CapabilityType.ACCEPT_SSL_CERTS, true);

		//Belows to your local browser
//		ChromeOptions c= new ChromeOptions();
//		c.merge(ch);
		
//		System.setProperty("webdriver.chrome.driver", "C:\\Users\\sukhyun\\Downloads\\chrome\\chromedriver.exe");
		System.setProperty("webdriver.chrome.driver", "C:\\dev\\chromedriver.exe");
//		Map<String, Object> vars = new HashMap<String, Object>();
//		ChromeOptions options = new ChromeOptions();
//	    options.addArguments("headless");


//		WebDriver driver = new ChromeDriver();
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--headless");
		options.addArguments("lang=ko_KR");
		options.addArguments("disable-gpu");
		options.addArguments("window-size=1920x1080");
//		options.addArguments("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36");
		options.setCapability("ignoreProtectedModeSettings", true);
		DesiredCapabilities capabilities = new DesiredCapabilities();
		capabilities.setCapability(ChromeOptions.CAPABILITY, options);
		options.merge(capabilities);
		
//		options.setPageLoadStrategy(PageLoadStrategy.NONE); // https://www.skptricks.com/2018/08/timed-out-receiving-message-from-renderer-selenium.html
//        options.addArguments("start-maximized"); // https://stackoverflow.com/a/26283818/1689770
//        options.addArguments("enable-automation"); // https://stackoverflow.com/a/43840128/1689770
//        options.addArguments("--headless"); // only if you are ACTUALLY running headless
//        options.addArguments("--no-sandbox"); //https://stackoverflow.com/a/50725918/1689770
//        options.addArguments("--disable-infobars"); //https://stackoverflow.com/a/43840128/1689770
//        options.addArguments("--disable-dev-shm-usage"); //https://stackoverflow.com/a/50725918/1689770
//        options.addArguments("--disable-browser-side-navigation"); //https://stackoverflow.com/a/49123152/1689770
//        options.addArguments("--disable-gpu"); //https://stackoverflow.com/questions/51959986/how-to-solve-selenium-chromedriver-timed-out-receiving-message-from-renderer-exc
		
		
		
		ChromeDriver driver = new ChromeDriver(options);
		
		
		
		
		
//		  htmlunitDriver는 실패!!!
//		WebDriver driver = new HtmlUnitDriver(true);
		  
		  
//		  팬텀js 용
//		  File file = new File("C:\\Users\\sukhyun\\Downloads\\phantomjs-2.1.1-windows\\bin\\phantomjs.exe");
//		  WebDriver driver = new PhantomJSDriver();	
//          System.setProperty("phantomjs.binary.path", file.getAbsolutePath());		
		JavascriptExecutor  js = (JavascriptExecutor) driver;
	    wait=new WebDriverWait(driver, 60);
	    

//		driver.manage().window().maximize();
		//쿠키 세션 삭제
//		driver.manage().deleteAllCookies();
		//인터파크 로그인 사이트 ㄱㄱ
//		driver.get("https://ticket.interpark.com/Gate/TPLogin.asp?CPage=B&MN=Y&tid1=main_gnb&tid2=right_top&tid3=login&tid4=login");
		//        driver.get("https://ticket.interpark.com/Gate/TPLogin.asp?CPage=B&MN=Y&tid1=main_gnb&tid2=right_top&tid3=login&tid4=login");
		// 8 | click | css=li:nth-child(1) > .styleInput |  |
		  driver.get("https://ticket.interpark.com/Gate/TPLogin.asp?CPage=B&MN=Y&tid1=main_gnb&tid2=right_top&tid3=login&tid4=login");
			driver.switchTo().defaultContent();
		    driver.switchTo().frame(0);
		    logger.debug("로그인시작");
			
			//아이디에 접근
			// 9 | click | id=userId |  | 
			driver.findElement(By.id("userId")).click();
//			자기 "아이디" 넣어주세요
			driver.findElement(By.id("userId")).sendKeys("jsghak9824");
			

			driver.switchTo().defaultContent();
			driver.switchTo().frame(0);
			driver.findElement(By.id("userPwd")).click();
			
//			자기 "비밀번호" 넣어주세요~~~
			driver.findElement(By.id("userPwd")).sendKeys("!nterpark12");

			driver.findElement(By.id("btn_login")).click();
			
//		driver.switchTo().defaultContent();
			WebElement guru99seleniumlink;
			guru99seleniumlink = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("Nav_SearchWord")));
			guru99seleniumlink.click();
			
		logger.debug("검색시작");
//	    driver.findElement(By.id("Nav_SearchWord")).click();
	    driver.findElement(By.id("Nav_SearchWord")).sendKeys(mas.getName());
	    driver.findElement(By.id("Nav_SearchWord")).sendKeys(Keys.ENTER);
	    logger.debug("검색성공");
	    WebElement dateCheck;
	    dateCheck = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".Poster:nth-child(1) img")));
	    dateCheck.click();
//	    driver.switchTo().frame(0);
//	    driver.findElement(By.cssSelector(".Poster:nth-child(1) img")).click();
	    Thread.sleep(3000);
	    WebElement guru99;
	    guru99 = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//a[contains(text(),\'달력\')]")));
//	    guru99 = wait.until(ExpectedConditions.visibilityOfElementLocated(By.linkText("20")));
	    guru99.click();
	    
	    driver.switchTo().frame(7);
	    
	    
	    driver.findElement(By.linkText(selectDate.substring(selectDate.lastIndexOf(".")+1))).click();
//	    driver.findElement(By.xpath("html/body/div/div[2]/table/tbody/tr[5]/td[1]/a")).click();
//	    driver.findElement(By.id("CellPlayDate10")).click();
	    driver.switchTo().defaultContent();
	    driver.findElement(By.cssSelector(".myValue")).click();
	    
	    logger.debug("시간시작");
	    int i = 1;
	    if(selectNum == "1") {
	    	driver.findElement(By.cssSelector("li:nth-child(2) > label")).click();
	    	
	    }
	    if(selectNum == "2") {
	    	driver.findElement(By.cssSelector("li:nth-child(3) > label")).click();
	    	
	    }
	    {
	      WebElement element = driver.findElement(By.tagName("body"));
	      Actions builder = new Actions(driver);
	      builder.moveToElement(element, 0, 0).perform();
	    }
	    logger.debug("예매하기");
	    WebElement win = driver.findElement(By.cssSelector(".tk_dt_btn_TArea a"));//예매하기 버튼 
        win.click();
//	    driver.switchTo().defaultContent();
        // Loop through all handles
//	    String parentWinHandle = driver.getWindowHandle();
//	    Set<String> winHandles = driver.getWindowHandles();
//        for(String handle: winHandles) {
//        	System.out.println(handle);
//            if(!handle.equals(parentWinHandle)){
//            driver.switchTo().window(handle);
//            }
//        }
	    logger.debug("화면이동");
	    Thread.sleep(500);
        driver.switchTo().window("wndBooking");
//		driver.switchTo().defaultContent();
//		driver.getWindowHandle();
//	    driver.switchTo().window(vars.get("win3725").toString());
//	    driver.switchTo().window("CDwindow-2016925B4F24FAD7919681851AF56C38");
	    
//	    vars.put("win3725", waitForWindow(4000));
//	   	wait.until(ExpectedConditions.visibilityOf(closeWin));
//        Thread.sleep(5000);
//        driver.findElement(By.cssSelector("#divBookNoticeLayer > div.layerWrap > div.titleArea > a"));
//	    WebElement exit = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id=\"divBookNoticeLayer\"]/div[2]/div[1]/a")));
//	    WebElement exit = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector("#divBookNoticeLayer > div.layerWrap > div.titleArea > a"));
//	    exit.click();
	    logger.debug("좌석페이지이동");

	    WebElement next = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("LargeNextBtnImage")));
	    next.click();
//	    driver.findElement(By.cssSelector("#divBookNoticeLayer > div.layerWrap > div.titleArea > a")).click();
//	    driver.findElement(By.id("LargeNextBtnImage")).click();
//	        WebElement element = driver.findElement(By.tagName("body"));
//	        Actions builder = new Actions(driver);
//	        builder.moveToElement(element, 0, 0).perform();
	    driver.switchTo().frame(1);
	    driver.switchTo().frame(0);
	    WebElement table = wait.until(ExpectedConditions.visibilityOfElementLocated(By.tagName("table")));
//	    String innerText = driver.findElement(By.tagName("table"));
//	    String innerText = driver.findElement(By.id("TmgsTable")).getText();
	    String str = driver.getPageSource();
	    String html = str.substring(str.indexOf("<img id="), str.indexOf("</td"));
	    
	    
		driver.quit(); 	
		return html;
	  }
	  
	
}