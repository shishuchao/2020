package com.mushishi.selenium;

import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;


public class ActionSelenium {
	public WebDriver driver;
	public String windowsHandle;
	
	
	/**
	 * 初始化driver，并且打开地址
	 * */
	public void InitDriver(){
		System.setProperty("webdriver.chrome.driver", "D:\\java\\chromedriver_win32\\chromedriver.exe");
		//System.setProperty("webdriver.firefox.marionette","D:\\java\\geckodriver\\geckodriver-v0.14.0-win64\\geckodriver.exe");
		driver = new ChromeDriver();
		//driver = new FirefoxDriver();
		driver.get("http://www.imooc.com");
		driver.manage().window().maximize();
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void inputBox(){
		driver.findElement(By.id("js1-signin-btn")).click();
		try {
			Thread.sleep(8000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.findElement(By.name("email")).sendKeys("18513199586");
		driver.findElement(By.name("password")).sendKeys("111111");
	}
	public void radiobox(){
		driver.get("http://www.imooc.com/user/setprofile");
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.findElement(By.className("pull-right")).click();
		//driver.findElement(By.xpath(".//*[@id='profile']/div[4]/div/label[3]/input")).click();
		List<WebElement> radioList = driver.findElements(By.xpath(".//*[@id='profile']/div[4]/div/label//input"));
		System.out.println(radioList.size()+"\n");
		for(WebElement sex:radioList){
			boolean flag = sex.isSelected();
			System.out.println(flag+"\n");
			if(flag == false){
				System.out.println("点");
				sex.click();
				try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			}else{
				System.out.println("已经选中了");
			}
		}
		driver.findElement(By.className("profile-submit")).click();
		

		//driver.close();
	}
	
	
	/**
	 * 多选框
	 * */
	public void checkBox(){
		WebElement box = driver.findElement(By.id("auto-signin"));
		//是否可用
		System.out.println(box.isEnabled());
		//是否被选中
		System.out.println(box.isSelected());
		//是否清除
		
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//box.clear();
		//选择
		box.click();
	}
	
	/**
	 * 按钮
	 * */
	public void button(){
		WebElement buttonLogin = driver.findElement(By.className("btn-red"));
		//是否可用
		System.out.println(buttonLogin.isEnabled());
		//点击
		buttonLogin.click();
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void upFile(){
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.get("http://www.imooc.com/user/setprofile");
		String jsString = "document.getElementsByClassName('update-avator')[0].style.bottom='0';";
		//((HtmlUnitDriver) driver).setJavascriptEnabled(true);
        //JavascriptExecutor js = (JavascriptExecutor) driver;
       // js.executeScript(jsString);
		
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		driver.findElement(By.className("js-avator-link")).click();
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String filePath = "C:\\Users\\KYB\\Desktop\\test.jpg";
		driver.findElement(By.id("upload")).sendKeys(filePath);
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 下拉框操作
	 * */
	public void dropDownList1(){
		driver.get("http://www.imooc.com/user/setprofile");
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.findElement(By.className("pull-right")).click();
		WebElement user = driver.findElement(By.id("nick"));

		WebElement form = driver.findElement(By.id("profile"));
		Select downList = new Select(form.findElement(By.name("job")));
		downList.selectByIndex(3);

	}
	/**
	 * 鼠标事件
	 * */
	public void mouseAction(){
		WebElement web = driver.findElement(By.className("menuContent")).findElements(By.className("item")).get(1);
		Actions actions = new Actions(driver);
		//actions.moveToElement(web).perform();
		//actions.doubleClick(web).perform();
		//actions.click(web).perform();
		actions.contextClick(web).perform();
		this.sleep(2000);
	}
	/**
	 * 等待
	 * */
	public void sleep(int sleeptime){
		try {
			Thread.sleep(sleeptime);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public void webForm(){
		driver.get("xxxxx");
		driver.findElement(By.id("signup-form")).submit();
	}
	
	
	/**
	 *上传文件
	 * */
	public void upHeader(){
		driver.get("http://www.imooc.com/user/setbindsns");
		this.sleep(2000);
		String jsString = "document.getElementsByClassName('update-avator')[0].style.bottom='0';";
		JavascriptExecutor js = (JavascriptExecutor) driver;
		js.executeScript(jsString);
		this.sleep(2000);
		
		
		driver.findElement(By.className("js-avator-link")).click();
		driver.findElement(By.id("upload")).sendKeys("C:\\Users\\KYB\\Desktop\\test.jpg");
	}
	
	
	/**
	 * 下拉框操作
	 * */
	public void dowmsSlectBox(){
		driver.get("http://www.imooc.com/user/setprofile");
		driver.findElement(By.className("pull-right")).click();
		this.sleep(1000);
		WebElement formElement = driver.findElement(By.id("profile"));
		
		WebElement job = formElement.findElement(By.id("job"));
		Select downList = new Select(job);
		//downList.selectByIndex(2);
		//downList.selectByValue("1");
		downList.selectByIndex(2);
		List<WebElement> List = downList.getAllSelectedOptions();
		for(WebElement option:List){
			System.out.println(option.getText());
		}
		System.out.println(downList.getFirstSelectedOption().getText());
		
	}
	
	/**
	 *鼠标事件 
	 */
	public void moseAction(){
		WebElement login= driver.findElement(By.className("menuContent")); 
		List<WebElement> item = login.findElements(By.className("item"));
		Actions actions = new Actions(driver);
		//actions.click(login).perform();
		//actions.doubleClick(login).perform();
		//this.sleep(2000);
		//contextClick(login).perform();
		actions.moveToElement(item.get(0)).perform();
		windowsHandle = driver.getWindowHandle();
		driver.findElement(By.linkText("HTML/CSS")).click();
		
	}
	
	/**
	 * iframe切换
	 * */
	public void iframe(){
		driver.get("http://www.imooc.com/wiki/create");
		WebElement iframeElement = driver.findElement(By.id("ueditor_0"));
		driver.switchTo().frame(iframeElement);
		driver.findElement(By.tagName("body")).sendKeys("this is test");
	}
	
	/**
	 * 窗口
	 * */
	public void windowsHandle(){
		Set<String> handles = driver.getWindowHandles();
		for(String s:handles){
			if(s.equals(windowsHandle)){
				continue;
			}
			System.out.println(s);
			driver.switchTo().window(s);
		}
		driver.findElement(By.linkText("案例")).click();
	}
	/**
	 * 等待
	 * */
	public void waitforElement(){
		//隐式等待
		//driver.manage().timeouts().implicitlyWait(20, TimeUnit.SECONDS);
		WebDriverWait wait = new WebDriverWait(driver,10);
		wait.until(ExpectedConditions.presenceOfElementLocated(By.id("test")));
	}
	
	


	
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ActionSelenium as = new ActionSelenium();
		as.InitDriver();
		as.waitforElement();
		as.inputBox();
		//as.button();
		//as.upHeader();
		//as.dowmsSlectBox();
		//as.moseAction();
		//as.iframe();
		//as.windowsHandle();
		//as.waitforElement();


	}

}
