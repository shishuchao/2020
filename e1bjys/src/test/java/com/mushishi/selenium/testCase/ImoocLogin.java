package com.mushishi.selenium.testCase;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.remote.DesiredCapabilities;

public class ImoocLogin {
	
	public static void main(String[] args){
		WebDriver driver;
		System.setProperty("webdriver.chrome.driver","E:\\chromedriver.exe");
		driver = new ChromeDriver();
		// IEDriverServer.exe的文件存放路径
//		System.setProperty("webdriver.ie.driver","E:\\IEDriverServer.exe");
		// 解决IE安全设置提示的
//		DesiredCapabilities ieCapabilities = DesiredCapabilities.internetExplorer();
//		ieCapabilities.setCapability(InternetExplorerDriver.INTRODUCE_FLAKINESS_BY_IGNORING_SECURITY_DOMAINS,true);
		// new一个webdriver对象
//		@Deprecated
//		WebDriver driver = new InternetExplorerDriver(ieCapabilities);
		driver.get("http://www.imooc.com");
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.findElement(By.id("js-signin-btn")).click();
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.findElement(By.name("email")).sendKeys("18513199586");
		driver.findElement(By.name("password")).sendKeys("111111");
		driver.findElement(By.className("btn-red")).click();
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.get("http://coding.imooc.com/class/109.html");

		driver.findElement(By.id("buy-trigger")).click();
		driver.findElement(By.linkText("提交订单")).click();
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.findElement(By.className("pay-summary-submit")).click();
	}
}
