package com.mushishi.selenium.page;

import org.openqa.selenium.WebElement;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.util.getByLocator;

public class HomePage extends BasePage{
	public HomePage(DriverBase driver){
		super(driver);
	}
	/**
	 * 获取点击登陆element
	 * */
	public WebElement getLoginElement(){
		return element(getByLocator.getLocator("login"));
	}
	/**
	 * 获取实战element
	 * */
	public WebElement getCodingElement(){
		return nodeElement(getByLocator.getLocator("tophead"),getByLocator.getLocator("coding"));
	}
	
	/**
	 * 获取用户名信息element
	 * */
	public WebElement getUserNameElement(){
		action(element(getByLocator.getLocator("header")));
		return element(getByLocator.getLocator("nameInfo"));
	}

	
}
