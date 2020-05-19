package ssc;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;

import java.util.List;

/**
 * corp ssc
 * author 19381
 * date 20200518
 */
public class ActionSelenium {
    public WebDriver driver = null;
    public String windowsHandle = null;

    public static void main(String[] args) {
        ActionSelenium as = new ActionSelenium();
        // 初始化
        as.initDriver();
        // 登录
        as.operateInputBox();
        as.oparateButton();

        as.operateUploadFile();
        //as.operateRadioBox();
        //as.driver.close();
    }

    /**
     * 初始化driver
     */
    public void initDriver(){
        System.setProperty("webdriver.chrome.driver","E:/chromedriver.exe");
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
            if(selected == false){
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
        ((HtmlUnitDriver)driver).setJavascriptEnabled(true);
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

}
