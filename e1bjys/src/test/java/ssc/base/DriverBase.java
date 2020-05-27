package ssc.base;

import org.openqa.selenium.WebDriver;

/**
 *
 */

public class DriverBase {

    public WebDriver driver;

    public DriverBase(String brower) {
        SelectDriver driver2 = new SelectDriver();
        this.driver = driver2.newDriver(brower);
    }

    /**
     *
     */

}
