package com.mushishi.selenium.business;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.handle.loginPageHandle;
import com.mushishi.selenium.page.CoursePage;

public class LoginPro {
	public loginPageHandle lph;
	public DriverBase driver;
	public LoginPro(DriverBase driver){
		this.driver = driver;
		lph = new loginPageHandle(driver);
	}
	public void login(String username,String password){
		if(lph.assertLoginPage()){
			lph.sendKeysUser(username);
			lph.sendKeysPassword(password);
			lph.clickAutoSignin();
			lph.clickLoginButton();
		}else{
			System.out.println("页面不存在或者状态不正确。");
		}
	}
	
}
