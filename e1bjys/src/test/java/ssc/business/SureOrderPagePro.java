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
     * @param driver
     */
    public SureOrderPagePro(DriverBase driver) {
        this.driver = driver;
        sureOrderHandle = new SureOrderHandle((driver));
    }
}
