package ssc.business;

import ssc.base.DriverBase;
import ssc.handle.loginPageHandle;

/**
 *
 */
public class LoginPro {
    public DriverBase driver;
    public loginPageHandle loginPageHandle;
    /**
     *
     */
    public LoginPro(DriverBase driver2){
       this.driver = driver2;
       loginPageHandle = new loginPageHandle(driver);
    }
}
