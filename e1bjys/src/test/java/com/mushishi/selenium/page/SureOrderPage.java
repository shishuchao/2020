package com.mushishi.selenium.page;

import org.openqa.selenium.WebElement;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.util.getByLocator;

public class SureOrderPage extends BasePage{

	public SureOrderPage(DriverBase driver) {
		super(driver);
	}
	/**
	 * 获取提交订单按钮
	 * */
	public WebElement getSubOrderElement(){
		return element(getByLocator.getLocator("sureOrder"));
	}

}
