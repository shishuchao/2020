package com.mushishi.selenium.testCase;

import java.util.concurrent.TimeUnit;

import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.business.HomePagePro;
import com.mushishi.selenium.business.LoginPro;
import com.mushishi.selenium.util.HandleCookie;
import com.mushishi.selenium.util.ProUtil;

public class SuiteTestLogin extends CaseBase{
	public DriverBase driver;
	public LoginPro loginpro;
	public HomePagePro homepagepro;
	public ProUtil pro;
	public HandleCookie handcookie;
	
	@BeforeClass
	public void beforeClass(){
		this.driver = InitDriver("chrome");
		pro = new ProUtil("loginTest.properties");
		driver.driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		loginpro = new LoginPro(driver);
		handcookie = new HandleCookie(driver);
		homepagepro = new HomePagePro(driver);
		driver.get(pro.getPro("url"));
	}
	@Test
	public void testLogin(){
		String username = pro.getPro("username");
		String password = pro.getPro("passwd");
		loginpro.login(username, password);
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(homepagepro.AssertLogin(pro.getPro("yq"))){
			System.out.println("登陆成功"+username);
			handcookie.writeCookie();
		}
	}
	@AfterClass
	public void afterClass(){
		driver.close();
	}
}
