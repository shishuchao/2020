package com.mushishi.selenium.testCase;

import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.business.CoursePagePro;
import com.mushishi.selenium.util.HandleCookie;

public class SuiteTestBuy extends CaseBase{
	public DriverBase driver;
	public CoursePagePro cpp;
	public HandleCookie handleCookie;
	@BeforeClass
	public void beforeClass(){
		this.driver = InitDriver("chrome");
		cpp = new CoursePagePro(driver);
		handleCookie = new HandleCookie(driver);
		driver.get("http://coding.imooc.com/class/101.html");
		handleCookie.setCookie();
		driver.get("http://coding.imooc.com/class/101.html");
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@AfterClass
	public void afterClass(){
		driver.close();
	}
	@Test
	public void testBuy(){
		cpp.buyNow();
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
