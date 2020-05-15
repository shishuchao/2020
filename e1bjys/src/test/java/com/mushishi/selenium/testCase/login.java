package com.mushishi.selenium.testCase;

import java.util.concurrent.TimeUnit;

import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.business.CourseListPagePro;
import com.mushishi.selenium.business.CoursePagePro;
import com.mushishi.selenium.business.HomePagePro;
import com.mushishi.selenium.business.LoginPro;
import com.mushishi.selenium.business.OrderPayPagePro;
import com.mushishi.selenium.business.SureOrderPagePro;


public class login extends CaseBase{
	public DriverBase driver;
	public LoginPro loginpro;
	public HomePagePro homepagepro;
	public CoursePagePro cpp;
	public OrderPayPagePro opp;
	public CourseListPagePro clpp;
	public SureOrderPagePro sopp;
	
	@BeforeClass
	public void loginTest(){
		this.driver = InitDriver("chrome");
		driver.driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		loginpro = new LoginPro(driver);
		homepagepro = new HomePagePro(driver);
		cpp = new CoursePagePro(driver);
		opp = new OrderPayPagePro(driver);
		clpp = new CourseListPagePro(driver);
		sopp = new SureOrderPagePro(driver);
	}

	@Test
	public void testLoginHome(){
		driver.get("http://coding.imooc.com/");
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		homepagepro.clickLoginButton();
	}
	@Test(dependsOnMethods={"testLoginHome"})
	@Parameters({"username","pass"})
	public void testLogin(String username,String pass){
		loginpro.login(username, pass);
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		driver.get("http://coding.imooc.com/class/74.html");
	}
	
	/**
	 * 立即购买
	 * */
	@Test(dependsOnMethods={"testLogin"})
	public void TestAddCart(){
		cpp.buyNow();
	}
	/**
	 * 提交订单
	 * */
	@Test(dependsOnMethods={"TestAddCart"})
	public void TestSureOrder(){
		sopp.sureOrder();
	}
	/**
	 * 跳转支付页面
	 * */
	@Test(dependsOnMethods={"TestSureOrder"})
	public void TestGoPay(){
		opp.orderPayPro();
	}
	
	@AfterClass
	public void clodse(){
		driver.close();
	}

	/**
	 * 遍历课程
	 * */
	//@Test
	public void TestListCourse(){
		clpp.clickEverCourse();
		
	}

/*	
	
	
	*//**
	 * 下单
	 * *//*
	@Test(dependsOnMethods={"testLogin"})
	public void downOrder(){
		driver.get("http://coding.imooc.com/class/74.html");
		String currentText = this.buyCourseNow();
		System.out.println("当前的课程信息"+currentText);
		this.sureOrder();
		this.getOrder();
		String orderCourseText = this.getOrderCourse();
		System.out.println("支付页面的课程信息"+orderCourseText);
		if(currentText.equals(orderCourseText)){
			System.out.println("下单成功");
		}
	}

	*//**
	 * 获取课程信息
	 * *//*
	public String getCourseText(WebElement element){
		return element.getText();
	}
	
	 * 获取element
	 * 
	 * *
	public WebElement getElement(By by){
		return driver.findElement(by);
	}
	
	*//**
	 * 通过父节点获取子节点
	 * *//*
	public WebElement getElement(WebElement element,By by){
		return element.findElement(by);
	}
	*//**
	 * 添加购物车流程
	 * 返回课程信息
	 * *//*
	public String buyCourseNow(){
		WebElement element = this.getElement(getByLocator.getLocator("courseInfo"));
		WebElement elementNode = this.getElement(element, getByLocator.getLocator("courseInfoText"));
		String currentText = this.getCourseText(elementNode);
		driver.click(this.getElement(getByLocator.getLocator("buyNow")));
		return currentText;
	}
	*//**
	 * 确定订单页面
	 * *//*
	public void sureOrder(){
		driver.click(this.getElement(getByLocator.getLocator("sureOrder")));
	}
	
	*//**
	 * 支付中心返回订单
	 * *//*
	public String getOrder(){
		String orderText = this.getCourseText(this.getElement(getByLocator.getLocator("order")));
		return orderText;
	}
	*//**
	 * 获取支付中心商品信息
	 * *//*
	public String getOrderCourse(){
		WebElement element = this.getElement(getByLocator.getLocator("orderCourse"));
		WebElement elementNode = this.getElement(element, getByLocator.getLocator("orderCourseNode"));
		return this.getCourseText(elementNode);
	}*/
	

}
