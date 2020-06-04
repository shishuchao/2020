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
     * 调用 打开登录页面
     */
    public void getLoginPage() {
        homePageHandle.getLoginPage();
    }

    /**
     * 调用 登录系统
     */
    public void login(String user, String pass) {

        homePageHandle.login(user,pass);
    }
}
