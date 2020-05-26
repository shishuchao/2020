package ais.login;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;

/**
 * 初始化driver和首页
 * @author ssc
 * 20200525 17:00
 */

public class Init {
    /**
     * 初始化
     */

    public WebDriver init() {
        System.setProperty("webdriver.ie.driver", "E:\\IEDriverServer.exe");
        WebDriver driver = new InternetExplorerDriver();
        driver.get("http://10.2.112.21:32659/ais/login/loginView.jsp");
        this.sleep(2000);
        return driver;

    }

    /**
     * 设定时间间隔
     */
    public void sleep(long during) {
        try {
            Thread.sleep(during);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

    /**
     * 登录
     */
    public void login(WebDriver driver, String name,String password){
        driver.findElement(By.id("j_username")).sendKeys(name);
        driver.findElement(By.id("j_password")).sendKeys(password);
        this.sleep(2000);
        driver.findElement(By.id("loginSubmit")).click();
        this.sleep(2000);
    }




}