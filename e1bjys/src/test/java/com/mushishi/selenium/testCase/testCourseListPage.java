package com.mushishi.selenium.testCase;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.testng.annotations.Test;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.util.getByLocator;

public class testCourseListPage extends CaseBase{
	public DriverBase driver;
	public testCourseListPage(){
		this.driver = InitDriver("chrome");
	}
	
	@Test
	public void CourseList(){
		driver.get("http://coding.imooc.com/");
		List<String> listString = this.listElement();
		for(int i=0;i<listString.size();i++){
			this.getElement(By.xpath("//*[contains(text(),'"+listString.get(i)+"')]")).click();
			String currentText =  this.buyCourseNow();
			try {
				Thread.sleep(5000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			this.sureOrder();
			String orderText = this.getOrder();
			if(orderText != null){
				String orderCourseText = this.getOrderCourse();
				if(currentText.equals(orderCourseText)){
					System.out.print("下单成功");
				}
			}
			driver.back();
		}

	}
	
	/**
	 * 获取所有课程的list
	 * */
	public List<String> listElement(){
		List<String> listString = new ArrayList<String>();
		WebElement element = driver.findElement(By.className("shizhan-course-list"));
		List<WebElement> listElement = element.findElements(By.className("shizhan-course-box"));
		for(WebElement el:listElement){
			listString.add(el.findElement(By.className("shizan-desc")).getText());
		}
		return listString;
	}
	/**
	 * 获取课程信息
	 * */
	public String getCourseText(WebElement element){
		return element.getText();
	}
	
	/**
	 * 获取element
	 * */
	public WebElement getElement(By by){
		return driver.findElement(by);
	}
	
	/**
	 * 通过element进行定位
	 * 子父节点定位
	 * */
	public WebElement getElement(WebElement element,By by){
		return element.findElement(by);
	}
	/**
	 * 添加购物车流程
	 * 返回课程详情页面课程信息
	 * @return String 
	 * */
	public String buyCourseNow(){
		String currentText = this.getCourseText(this.getElement(getByLocator.getLocator("courseInfo")));
		driver.click(this.getElement(getByLocator.getLocator("buyNow")));
		return currentText;
	}
	
	/**
	 * 确认订单页面
	 * */
	public void sureOrder(){
		driver.click(this.getElement(getByLocator.getLocator("sureOrder")));	
	}
	
	/**
	 * 支付中心
	 * 返回订单
	 * @return String
	 * */
	public String getOrder(){
		String orderText = this.getCourseText(this.getElement(getByLocator.getLocator("order")));
		return orderText;
	}
	/**
	 * 支付中心课程信息
	 * */
	public String getOrderCourse(){
		WebElement element = this.getElement(getByLocator.getLocator("orderCourse"));
		WebElement elementNode = this.getElement(element, getByLocator.getLocator("orderCourseNode"));
		String orderCourseText = elementNode.getText();
		return orderCourseText;
	}
}
