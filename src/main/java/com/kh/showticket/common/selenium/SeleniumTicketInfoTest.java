package com.kh.showticket.common.selenium;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SeleniumTicketInfoTest {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	 
    public static void main(String[] args) {
 
    	SeleniumTicketInfoTest selTest = new SeleniumTicketInfoTest();
        selTest.crawl();
        
    }
 
    
    //WebDriver
    private WebDriver driver;
    
    private WebElement webElement;
	  private static WebDriverWait wait;

    
    //Properties
//    public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
//    public static final String WEB_DRIVER_PATH = "C:\\Users\\sukhyun\\Downloads\\chrome\\chromedriver.exe";
    
    //크롤링 할 URL
    private String base_url;
    
	public SeleniumTicketInfoTest() {
		super();
		
		// System Property SetUp
//		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
//		System.setProperty("webdriver.chrome.driver", "C:\\Users\\sukhyun\\Downloads\\chrome\\chromedriver.exe");
		System.setProperty("webdriver.chrome.driver", "C:\\dev\\chromedriver.exe");

		// Driver SetUp
		ChromeOptions options = new ChromeOptions();
		options.setCapability("ignoreProtectedModeSettings", true);
//		options.addArguments("headless");
        options.addArguments("window-size=1200x600");
		driver = new ChromeDriver(options);
	    wait=new WebDriverWait(driver, 60);

		//인터파크 로그인 페이지
		base_url = "https://ticket.interpark.com/Gate/TPLogin.asp?CPage=B&MN=Y&tid1=main_gnb&tid2=right_top&tid3=login&tid4=login";

	}
 
    public void crawl() {
 
        try {
            //get page (= 브라우저에서 url을 주소창에 넣은 후 request 한 것과 같다)
            driver.get(base_url);
            
            logger.debug("로그인!");
            //iframe으로 구성된 곳은 해당 프레임으로 전환시킨다.
            driver.switchTo().defaultContent();
		    driver.switchTo().frame(0);
			
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
			
//	    driver.findElement(By.id("Nav_SearchWord")).click();
	    driver.findElement(By.id("Nav_SearchWord")).sendKeys("벤허");
	    driver.findElement(By.id("Nav_SearchWord")).sendKeys(Keys.ENTER);
	    WebElement dateCheck;
            logger.debug("특정공연의 공연일 선택");
            driver.switchTo().frame(driver.findElement(By.id("ifrCalendar")));
            webElement = driver.findElement(By.cssSelector("#CellPlayDate2 a"));//선택가능한 첫 날짜 선택
//    	    webElement = driver.findElement(By.linkText("13"));

            webElement.click();
            Thread.sleep(500);
            
            //예매하기 버튼 클릭을 위해 이전 부모frame으로 전환
            logger.debug("예매버튼 클릭");
            driver.switchTo().parentFrame();
            webElement = driver.findElement(By.cssSelector(".tk_dt_btn_TArea a"));//예매하기 버튼 
            webElement.click();
            
            //회원유형선택 팝업창로 이동
            //자바스크립트 함수 검색(console.dir(함수명)을 통해 작성된 js파일 검색후 함수 몸통확인)해서 팝업창 name값 확인
//            logger.debug("회원유형선택 팝업창 이동");
//            driver.switchTo().window("TiKiDiscount");
//            List<WebElement> memberTypeBtn = driver.findElements(By.cssSelector(".btns a"));
//            memberTypeBtn.get(1).click();

            //예매 팝업 이동: 기존팝업창 닫고, opener의 Booking함수 호출
            logger.debug("예매 팝업창 이동 및 예매하기 버튼 클릭");
            driver.switchTo().window("wndBooking");
            
            logger.debug("예매안내다이얼로그 닫기");
            driver.findElement(By.cssSelector("#divBookNoticeLayer a.closeBtn")).click();
            
            
            driver.findElement(By.id("LargeNextBtn")).click();
            
            //경고창 이동 및 확인
            logger.debug("경고창 이동 및 확인");
            driver.switchTo().alert().accept();
            
            //예매정보 가져오기
            logger.debug("좌석선택창 이동");
            driver.switchTo().frame(driver.findElement(By.id("ifrmSeat")))
            	  .switchTo().frame(driver.findElement(By.id("ifrmSeatDetail")));
            List<WebElement> seats = driver.findElements(By.cssSelector("#TmgsTable img"));
            for(WebElement s: seats) {
            	if(s.getAttribute("seatinfo") != null)
            		logger.info("예매가능 티켓정보: {}", s.getAttribute("seatinfo"));
            }
            
            
        } catch (Exception e) {
            
            e.printStackTrace();
        
        } finally {
 
            driver.close();
            logger.info("-------------- 크롤링 종료 -----------------");
        }
 
    }
 
}