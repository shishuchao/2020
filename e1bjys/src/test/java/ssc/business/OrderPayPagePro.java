package ssc.business;

import ssc.base.DriverBase;
import ssc.handle.OrderPayPageHandle;

/**
 *
 */
public class OrderPayPagePro {
    public DriverBase driver;
    public OrderPayPageHandle orderPayPageHandle;

    /**
     *
     */
    public OrderPayPagePro(DriverBase driver2) {
        this.driver = driver2;
        orderPayPageHandle = new OrderPayPageHandle(driver);
    }
}
