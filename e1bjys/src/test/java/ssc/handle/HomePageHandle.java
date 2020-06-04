package ssc.handle;

import org.openqa.selenium.WebElement;
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

    /**
     * 接收登录请求
     * 操作返回的登录元素
     */
    public void login() {
        WebElement loginElement = homePage.getElement("login");
        loginElement.click();
    }
}
