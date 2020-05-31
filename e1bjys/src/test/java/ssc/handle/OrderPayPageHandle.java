package ssc.handle;

import ssc.base.DriverBase;
import ssc.page.OrderPayPage;

/**
 * @auchor 19381
 */
public class OrderPayPageHandle {
    public DriverBase driver;
    public OrderPayPage orderPayPage;

    /**
     *
     */
    public OrderPayPageHandle(DriverBase driver2) {
        this.driver = driver2;
        orderPayPage = new OrderPayPage(driver);
    }
}
