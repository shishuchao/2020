package ssc.business;

import ssc.base.DriverBase;
import ssc.handle.SureOrderHandle;

/**
 *
 */
public class SureOrderPagePro {
    public DriverBase driver;
    public SureOrderHandle sureOrderHandle;

    /**
     *
     */
    public SureOrderPagePro(DriverBase driver2) {
        this.driver = driver2;
        sureOrderHandle = new SureOrderHandle(driver);
    }
}
