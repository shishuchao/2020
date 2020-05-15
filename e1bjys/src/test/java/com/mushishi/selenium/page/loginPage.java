package com.mushishi.selenium.page;

import org.openqa.selenium.WebElement;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.util.getByLocator;

public class loginPage extends BasePage{
	public loginPage(DriverBase driver){
		super(driver);
	}
	/**
	 * 获取用户名输入框
	 * */
	public WebElement getUserElement(){
		return element(getByLocator.getLocator("username"));
	}
	
	/**
	 * 获取密码输入框Element
	 * */
	public WebElement getPasswordElement(){
		return element(getByLocator.getLocator("userpass"));
	}
	/**
	 * 获取登陆按钮element
	 * */
	public WebElement getLoginButtonElement(){
		return element(getByLocator.getLocator("loginbutton"));
	}
	/**
	 * 获取自动登陆element
	 * */
	public WebElement getAutoSigninElement(){
		return element(getByLocator.getLocator("autoSignin"));
	}
}
