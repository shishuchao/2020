package ssc.handle;

import ssc.base.DriverBase;
import ssc.page.LoginPage;

/**
 *
 */
public class loginPageHandle {
    public DriverBase driver;
    public LoginPage loginPage;
    /**
     *
     */
    public loginPageHandle(DriverBase driver2) {
        this.driver = driver2;
        loginPage = new LoginPage(driver);

    }
}
