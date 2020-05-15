package com.mushishi.selenium.handle;

import org.openqa.selenium.WebElement;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.page.CoursePage;

public class CoursePageHandle {
	public DriverBase driver;
	public CoursePage coursepage;
	public CoursePageHandle(DriverBase driver){
		this.driver = driver;
		coursepage = new CoursePage(driver);
	}
	/**
	 * 点击立即购买按钮
	 * */
	public void clickBuyNow(){
		coursepage.click(coursepage.getBuytriggerElement());
	}
	/**
	 * 点击添加购物车按钮
	 * */
	public void clickAddCart(){
		coursepage.click(coursepage.getAddCartElement());
	}
	/**
	 * 点击右上角购物车
	 * */
	public void clickShopCart(){
		coursepage.click(coursepage.getShopCartElement());
	}
	/**
	 * 获取购物车数量
	 * */
	public String getShopCartNum(){
		WebElement element = coursepage.getShopCartNumElement();
		return coursepage.getText(element);
	}
	/**
	 * 获取课程名称
	 * */
	public String getCourseName(){
		WebElement element = coursepage.getCourseNameElement();
		return coursepage.getText(element);
	}
	/**
	 * 去结算
	 * */
	public void clickGoPay(){
		coursepage.click(coursepage.getGoPayElement());
	}
	/**
	 * 点击已经购买弹窗的确定按钮
	 * */
	public void clickReadBuy(){
		coursepage.click(coursepage.getReadyBuy());
	}
	
}
