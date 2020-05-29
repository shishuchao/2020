package ssc.base;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 *
 */

public class DriverBase {

    public WebDriver driver;

    public DriverBase(String brower) {
        SelectDriver driver2 = new SelectDriver();
        this.driver = driver2.newDriver(brower);
    }

    // get 封装
    public void get(String s) {
        driver.get(s);
    }

    // findElement 封装
    public WebElement findElement(By by){
        return driver.findElement(by);
    }
    // findElements 封装
    public List<WebElement> findElements(By by){
        return driver.findElements(by);
    }

}
