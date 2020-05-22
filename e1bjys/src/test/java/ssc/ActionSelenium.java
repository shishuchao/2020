package ssc;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;
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
    public void initDriver(String brower){
        if(brower.equalsIgnoreCase("ie")){
            System.setProperty("webdriver.ie.driver","E:\\IEDriverServer.exe");
            driver = new InternetExplorerDriver();
        }if(brower.equalsIgnoreCase("chrome19")) {
            System.setProperty("webdriver.chrome.driver","E:/chromedriver.exe");
            driver = new ChromeDriver();
            driver.get("http://www.imooc.com");
        }if(brower.equalsIgnoreCase("chrome13")){
            System.setProperty("webdriver.chrome.driver","D:/_Projects/chromedriver.exe");
            driver = new ChromeDriver();
            driver.get("http://www.imooc.com");
        }else{
            System.out.println("指定是浏览器类型不对");
        }
        driver.manage().window().maximize();

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
        //assert driver.getWindowHandles().size() == 1;

        //Click the link which opens in a new window
        //driver.findElement(By.linkText("new window")).click();

        // Opens a new tab and switches to new tab
        //driver.switchTo().newWindow(WindowType.TAB);
        driver.get("http://www.imooc.com/user/setprofile");

        /**
         * 上一个页面 / 下一个页面
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
     * 改进 上传图片
     */
    public void operateUploadFile2(){
    String jsString = "document.getElementsByClassName('update-avator')[0].style.bottom = '0';";
    String filePath = "C:\\Users\\19381\\Desktop\\业务公式项.png";
    driver.get("http://www.imooc.com/user/setprofile");
    this.sleep(2000);
    JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
    jsExecutor.executeScript(jsString);


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
     * 切换到iframe
     */
    public void operateIframe(){
        // 通过webdriver的get方法调用浏览器，打开网页
        driver.get("http://10.2.112.21:30302/ais/login/loginView.jsp");
        // 最大化浏览器窗口
        driver.manage().window().maximize();
        this.sleep(1000);
        // 通过页面元素的name=j_username定位到 输入框
        WebElement name = driver.findElement(By.name("j_username"));
        // 在输入框输入‘ ’
        name.sendKeys("shiscsj");
        // 通过页面元素的name=j_password定位到 输入框
        WebElement pass = driver.findElement(By.name("j_password"));
        // 在输入框输入‘ ’
        pass.sendKeys("123");
        this.sleep(1000);
        driver.findElement(By.id("loginSubmit")).click();

        // 进入 综合管理系统
        driver.get("http://10.2.112.21:30302/ais/portal/simple/simple-firstPageAction!menu.action?parentMenuId=10&fromPortal=1");
        // 进入 计划管理
        driver.findElement(By.id("menu1010")).click();
        this.sleep(1000);
        // 进入 年度计划制定
        driver.findElement(By.id("_easyui_tree_1")).click();
        this.sleep(1000);
        // 进入 iframe
        WebElement iframe = driver.findElement(By.id("101030id"));
        driver.switchTo().frame(iframe);
        driver.findElement(By.id("newYear")).click();
        // 切换出frame
        //driver.switchTo().defaultContent();
        this.sleep(2000);
        driver.quit();

    }

    /**
     * 窗口
     *
     */
    public void operateWindows(){
        //driver.getWindowHandle();
        //driver.getWindowHandles();

    }

    public static void main(String[] args) {
        ActionSelenium as = new ActionSelenium();
        try{
            // 初始化
            as.initDriver("ie");

            // -----鼠标-----
//          as.operateMouse();
            // -----上传图片-----
//          as.operateInputBox();
//          as.oparateButton();
//          as.operateUploadFile();
//          as.operateUploadFile2();
            // -----  -----
//          as.operateInputBox();
//          as.oparateButton();
//          as.operateComboList();
            // -----   -----
//          as.operateInputBox();
//          as.oparateButton();
//          as.operateRadioBox();
            // -----    -----
            as.operateIframe();
            Thread.sleep(3000);

        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            // 关闭当前页签
            //as.driver.close();
            // 关闭浏览器
            as.driver.quit();
        }


    }


}
