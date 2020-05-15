package com.mushishi.selenium.handle;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.page.orderPayPage;

public class OrderPayPageHandle {
	public DriverBase driver;
	public orderPayPage orderpaypage;
	public OrderPayPageHandle(DriverBase driver){
		this.driver = driver;
		orderpaypage = new orderPayPage(driver);
	}
	/**
	 * 获取订单文字
	 * */
	public String getOrderName(){
		return orderpaypage.getText(orderpaypage.getOrderNumElement());
	}
	/**
	 * 获取课程名称
	 * */
	public String getOrderCourseName(){
		return orderpaypage.getText(orderpaypage.getOrderCourseNameElement());
	}
	/**
	 * 点击支付宝支付
	 * */
	public void clickAliPay(){
		orderpaypage.click(orderpaypage.getAlipayElement());
	}
	/**
	 * 点击立即支付
	 * */
	public void clickPayElement(){
		orderpaypage.click(orderpaypage.getOederPayElement());
	}
}
