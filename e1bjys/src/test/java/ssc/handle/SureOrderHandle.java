package ssc.handle;

import ssc.base.DriverBase;
import ssc.page.SureOrderPage;

/**
 * @auchor 19381
 */
public class SureOrderHandle {

    public DriverBase driver;
    public SureOrderPage sureOrderPage;
    /**
     *
     * @param driver
     */
    public SureOrderHandle(DriverBase driver) {
        this.driver = driver;
        sureOrderPage = new SureOrderPage(driver);
    }



}
