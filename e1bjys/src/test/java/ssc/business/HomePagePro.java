package ssc.business;

import ssc.base.DriverBase;
import ssc.handle.HomePageHandle;

/**
 *
 */
public class HomePagePro {
    public DriverBase driver;
    public HomePageHandle homePageHandle;

    /**
     *
     */
    public HomePagePro(DriverBase driver2) {
        this.driver = driver2;
        homePageHandle = new HomePageHandle(driver);

    }

    /**
     * 调用登录
     */
    public void clickLoginButton() {
        homePageHandle.login();
    }
}
