package seleniuminstances;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.remote.DesiredCapabilities;

public class SeleniumInstance01 {
    public static void main(String[] args) {
        SeleniumInstance01 s = new SeleniumInstance01();
        s.seleniumTest1();

    }
    public void seleniumTest1(){
        // IEDriverServer.exe的文件存放路径
        System.setProperty("webdriver.ie.driver","E:\\IEDriverServer.exe");
        // 解决IE安全设置提示的
        DesiredCapabilities ieCapabilities = DesiredCapabilities.internetExplorer();
        ieCapabilities.setCapability(InternetExplorerDriver.INTRODUCE_FLAKINESS_BY_IGNORING_SECURITY_DOMAINS,true);
        // new一个webdriver对象
        @Deprecated
        WebDriver driver = new InternetExplorerDriver(ieCapabilities);

        // 通过webdriver的get方法调用浏览器，打开网页
        driver.get("http://10.2.112.21:30302/ais/login/loginView.jsp");
        // 最大化浏览器窗口
        driver.manage().window().maximize();
        // 通过页面元素的name=j_username定位到 输入框
        WebElement element = driver.findElement(By.name("j_username"));
        // 在输入框输入‘ ’
        element.sendKeys("shiscsj");
        // 通过页面元素的name=j_password定位到 输入框
        WebElement element2 = driver.findElement(By.name("j_password"));
        // 在输入框输入‘ ’
        element2.sendKeys("123");

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        WebElement element3 =  driver.findElement(By.id("loginSubmit"));
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // 提交查询
        // element3.submit();


        element3.click();

        // 输出当前页面的title
        System.out.println("Page title is: " + driver.getTitle());
        // 关闭所有webdriver进程，退出
        driver.quit();
    }

    /**
     * By.id(id);
     * By.className(id);
     * By.cssSelector(id);
     * By.linkText(id);
     * By.name(id);
     * By.partialLinkText(id);
     * By.tagName(id);
     * String xpathExpression = null;
     * By.xpath(xpathExpression);
     *
     * 常用的查找元素方法：
     * find_element_by_name
     * find_element_by_id
     * find_element_by_xpath
     * find_element_by_link_text
     * find_element_by_partial_link_text
     * find_element_by_tag_name
     * find_element_by_class_name
     * find_element_by_css_selector
     *
     * 按钮
     * 	click
     * 	isenabled
     * 表单
     * 	submit
     * 上传文件
     * 	sendkeys
     * 输入框
     * 	sendkeys
     * 	clear
     * 	getAttribute
     * 单选框
     * 	click
     * 	clear
     * 	isselected
     * 多选框
     * 	click
     * 	clear
     * 	isselected
     * 	isenabled
     */


}
