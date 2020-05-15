package com.mushishi.selenium.testCase;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.mushishi.selenium.base.SelectDriver;
import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.util.ProUtil;
import com.mushishi.selenium.util.getByLocator;

public class testLogin extends DriverBase {
	public testLogin(String browser) {
		super(browser);
	}
	
	public testLogin() {
		super("firefox");
	}

	public void loginScript(String username,String userpass) throws Exception{
		String url = "http://www.imooc.com";
		driver.get(url);
		driver.manage().window().maximize();
		driver.findElement(By.id("js-signin-btn")).click();
		Thread.sleep(2000);
		WebElement user = this.findElement(getByLocator.getLocator("username"));
		user.isDisplayed();
		WebElement password = this.findElement(getByLocator.getLocator("userpass"));
		password.isDisplayed();
		WebElement loginButton = this.findElement(getByLocator.getLocator("loginbutton"));
		loginButton.isDisplayed();
		user.sendKeys(username);
		password.sendKeys(userpass);
		loginButton.click();
		Thread.sleep(3000);
		WebElement header = this.findElement(getByLocator.getLocator("header"));
		header.isDisplayed();
		Actions actions = new Actions(driver);
		actions.moveToElement(header).perform();
		String userInfo = this.findElement(getByLocator.getLocator("nameInfo")).getText();
		System.out.println(userInfo);
		if(userInfo.equals("mushishi_xu1")){
			System.out.println("登陆成功");
		}else{
			System.out.println("登陆失败");
			
		}
		driver.close();
	}
	

	
	@Test
	@Parameters({"username","pass"})
	public void loginpage(String username,String pass) throws Exception{
		this.loginScript(username, pass);
	}
}
