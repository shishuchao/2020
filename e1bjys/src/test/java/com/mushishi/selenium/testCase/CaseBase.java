package com.mushishi.selenium.testCase;

import com.mushishi.selenium.base.DriverBase;

public class CaseBase {
	public DriverBase InitDriver(String browser){
		return new DriverBase(browser);
	}

}
