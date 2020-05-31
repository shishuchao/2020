package ssc.handle;

import ssc.base.DriverBase;
import ssc.page.HomePage;

/**
 * @auchor 19381
 */
public class HomePageHandle {
    public DriverBase driver;
    public HomePage homePage;

    /**
     *
     */
    public HomePageHandle(DriverBase driver2) {
        this.driver = driver2;
        homePage = new HomePage(driver);

    }
}
