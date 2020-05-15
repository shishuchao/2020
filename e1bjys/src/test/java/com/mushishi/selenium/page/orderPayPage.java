package com.mushishi.selenium.page;

import org.openqa.selenium.WebElement;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.util.getByLocator;

public class orderPayPage extends BasePage{
	public orderPayPage(DriverBase driver){
		super(driver);
	}
	
	/**
	 * 获取订单号element
	 * */
	public WebElement getOrderNumElement(){
		return element(getByLocator.getLocator("order"));
	}
	/**
	 * 返回课程名称element
	 * */
	public WebElement getOrderCourseNameElement(){
		return nodeElement(getByLocator.getLocator("orderCourse"),getByLocator.getLocator("orderCourseNode"));
	}
	/**
	 * 返回支付宝element
	 * */
	public WebElement getAlipayElement(){
		return element(getByLocator.getLocator("alipay"));
	}
	/**
	 * 获取点击立即支付element
	 * */
	public WebElement getOederPayElement(){
		return element(getByLocator.getLocator("orderpay"));
	}
}
