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
     * 接收 打开登录页面请求
     * 接收 打开登录页面元素
     * 执行 点击登录按钮
     */
    public void getLoginPage() {
        WebElement loginElement = homePage.getElement("login");
        System.out.println(loginElement.getText());
        loginElement.click();
    }

    /**
     * 执行 登录
     */
    public void login(String user, String pass) {
        try {
            WebElement username = homePage.getElement("username");
            WebElement password = homePage.getElement("userpass");
            WebElement submitLogin = homePage.getElement("submitLogin");
            WebElement autoSignin = homePage.getElement("autoSignin");

            if(username.isDisplayed()){
                username.sendKeys(user);
                password.sendKeys(pass);
                autoSignin.click();
                Thread.sleep(2000);
                submitLogin.click();
            }

        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }
    /**
     * 判断是否登录页面
     */
    public void isdisplayed(){

    }

}
