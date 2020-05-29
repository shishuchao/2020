package ssc.business;

import ssc.base.DriverBase;
import ssc.handle.HomePageHandle;

/**
 *
 */
public class HomePagePro {
//    public DriverBase driver;
    public HomePageHandle homePageHandle;
    /**
     *
     * @param driver
     */
    public HomePagePro(DriverBase driver) {
//        this.driver = driver;
        homePageHandle = new HomePageHandle(driver);

    }

    public void clickLoginButton() {
    }
}
