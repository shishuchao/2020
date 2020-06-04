package ssc.page;


import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import ssc.base.DriverBase;
import ssc.util.Locator;

/**
 * @auchor 19381
 */
public class HomePage extends BasePage{

    public Locator locator = new Locator();

    /**
     *
     */
    public HomePage(DriverBase driver) {
        super(driver);
    }

    /**
     * 返回登录元素
     */
    public WebElement getElement(String key) {
        By loginLocator = locator.getLocator(key);
        WebElement loginElement = driver.findElement(loginLocator);
        return loginElement;
    }
}
