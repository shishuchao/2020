package ssc;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.Select;

import javax.swing.*;
import java.util.List;

/**
 * corp ssc
 * author 19381
 * date 20200518
 */
public class ActionSelenium {
    public WebDriver driver = null;
    public String windowsHandle = null;



    /**
     * 初始化driver
     */
    public void initDriver(){
        System.setProperty("webdriver.chrome.driver","D:/_Projects/chromedriver.exe");
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        driver.get("http://www.imooc.com");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }


    }
    /**
     * 输入框
     */
    public void operateInputBox(){
        driver.findElement(By.id("js-signin-btn")).click();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        driver.findElement(By.name("email")).sendKeys("13283155237");
        driver.findElement(By.name("password")).sendKeys("QWER_1234");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * 按钮
     */
    public void oparateButton(){
        WebElement button = driver.findElement(By.className("xa-login"));
        System.out.println(button.isEnabled());
        button.click();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * 单选框
     */

    public void operateRadioBox(){
        driver.get("http://www.imooc.com/user/setprofile");
        driver.findElement(By.className("pull-right")).click();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        //List<WebElement> list = driver.findElements(By.xpath(".//*[@id='profile']/div[4]/div/label//input"));
        List<WebElement> list = driver.findElements(By.xpath(".//*[@id=\"profile\"]/div[4]/div/label//input"));
        for(WebElement element : list){
            boolean selected = element.isSelected();
            System.out.println(selected);
            if(!selected){
                System.out.println("点击");
                element.click();
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                break;
            }else {
                System.out.println("已经选中");
            }

        }
        driver.findElement(By.id("profile-submit")).click();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * 复选框
     */
    public void operateCheckBox(){
        WebElement element = driver.findElement(By.id("auto-signin"));
        element.isEnabled();
        element.isSelected();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        element.clear();
        element.click();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

    /**
     *  上传图片
     */
    public void operateUploadFile(){
        String jsString = "document.getElementsByClassName('update-avator')[0].style.bottom = '0' ;";
        String filePath = "C:\\Users\\19381\\Desktop\\业务公式项.png";
        //Store the ID of the original window
        String originalWindow = driver.getWindowHandle();

        //Check we don't have other windows open already
        assert driver.getWindowHandles().size() == 1;

        //Click the link which opens in a new window
        //driver.findElement(By.linkText("new window")).click();

        // Opens a new tab and switches to new tab
        //driver.switchTo().newWindow(WindowType.TAB);
        driver.get("http://www.imooc.com/user/setprofile");

        /**
         * driver.navigate().back();
         * try {
         *     Thread.sleep(2000);
         * } catch (InterruptedException e) {
         *     e.printStackTrace();
         * }
         * driver.navigate().forward();
         */


        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        //((HtmlUnitDriver)driver).setJavascriptEnabled(true);
        JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
        jsExecutor.executeScript(jsString);

        driver.findElement(By.className("js-avator-link")).click();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        driver.findElement(By.id("upload")).sendKeys(filePath);
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * 下拉框
     */
    public void operateComboList(){
        driver.get("http://www.imooc.com/user/setprofile");
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        driver.findElement(By.className("pull-right")).click();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        WebElement nick = driver.findElement(By.id("nick"));
        WebElement profile = driver.findElement(By.id("profile"));
        Select select = new Select(profile.findElement(By.name("job")));
        // 索引从 0 开始
        select.selectByIndex(0);
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }
    /**
     * 封装等待
     */
    public void sleep(long idleTime){
        try {
            Thread.sleep(idleTime);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    /**
     * 鼠标事件
     */
    public void operateMouse(){
        Actions actions = new Actions(driver);
        WebElement element = driver.findElement(By.className("menuContent"));
        List<WebElement> elements = element.findElements(By.className("item"));
        actions.moveToElement(elements.get(1)).perform();
        driver.findElement(By.linkText("HTML/CSS")).click();
        //WebElement loginButton = driver.findElement(By.id("js-signin-btn"));
        //actions.click(loginButton).perform(); // 单击
        //actions.doubleClick(loginButton).perform(); // 双击
        //this.sleep(2000);
        //actions.contextClick().perform();

//        WebElement element = driver.findElement(By.className("menuContent")).findElements(By.className("item")).get(1);
//        actions.moveToElement(element).perform(); // 悬停
//        actions.contextClick(); //右击

        this.sleep(2000);
    }

    /**
     *
     */
    public static void main(String[] args) {
        ActionSelenium as = new ActionSelenium();
        // 初始化
        as.initDriver();
        // 登录
        //as.operateMouse();
        //as.operateInputBox();
        //as.oparateButton();

        //as.operateComboList();
        as.operateUploadFile();
        //as.operateRadioBox();
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // 关闭当前页签
        //as.driver.close();
        // 关闭浏览器
        as.driver.quit();
    }


}
