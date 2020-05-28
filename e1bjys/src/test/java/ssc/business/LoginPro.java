package ssc.business;

import ssc.base.DriverBase;
import ssc.handle.loginPageHandle;

/**
 *
 */
public class LoginPro {
    public DriverBase driver;
    public ssc.handle.loginPageHandle loginPageHandle;
    /**
     *
     */
    public LoginPro(DriverBase driver){
       this.driver = driver;
       loginPageHandle = new loginPageHandle();
    }
}
