package com.mushishi.selenium.handle;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.page.loginPage;

public class loginPageHandle {
	public DriverBase driver;
	public loginPage lp;
	public loginPageHandle(DriverBase driver){
		this.driver = driver;
		lp = new loginPage(driver);
	}
	
	/**
	 * 输入用户名
	 * */
	public void sendKeysUser(String username){
		lp.sendkeys(lp.getUserElement(), username);
	}
	
	/**
	 * 输入密码
	 * */
	public void sendKeysPassword(String password){
		lp.sendkeys(lp.getPasswordElement(), password);
	}
	/**
	 * 点击登陆
	 * */
	public void clickLoginButton(){
		lp.click(lp.getLoginButtonElement());
	}
	/**
	 * 点击自动登陆
	 * */
	public void clickAutoSignin(){
		lp.click(lp.getAutoSigninElement());
	}
	/**
	 * 判断是否是登陆页面
	 * */
	public boolean assertLoginPage(){
		return lp.assertElementIs(lp.getUserElement());
	}
}
