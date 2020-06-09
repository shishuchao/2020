package ais;

import org.openqa.selenium.*;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.sql.SQLOutput;
import java.util.List;
import java.util.Set;

public class ActionSelenium {
    public WebDriver driver;


    @BeforeClass
    public void testInit(){
        System.setProperty("webdriver.ie.driver","E:\\IEDriverServer.exe");
        driver = new InternetExplorerDriver() ;
    }
    @Test
    public void testLogin() {
        try {
            driver.get("http://10.2.112.21:32659/ais/login/loginView.jsp");
            Thread.sleep(2000);
            driver.findElement(By.id("j_username")).sendKeys("shiscsj");
            driver.findElement(By.id("j_password")).sendKeys("123");
            ;
            Thread.sleep(1000);
            driver.findElement(By.id("loginSubmit")).click();
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @Test(dependsOnMethods = {"testLogin"})
    public void testModifyPlan(){
        try {

            driver.get("http://10.2.112.21:32659/ais/portal/simple/http/ais//portal/simple/simple-firstPageAction!menu.action?parentMenuId=10");
            Thread.sleep(2000);
            driver.findElement(By.id("menu1010")).click();
            Thread.sleep(2000);
            driver.findElement(By.id("_easyui_tree_3")).click();
            Thread.sleep(2000);

            WebElement iframe = driver.findElement(By.id("101050id"));
            driver.switchTo().frame(iframe);
            driver.findElement(By.id("search")).click();
            Thread.sleep(2000);
            driver.findElement(By.xpath("//*[@id=\"dlgSearch\"]/div[2]/div/a[2]")).click();
            Thread.sleep(1000);
            driver.findElement(By.xpath("//*[@id=\"dlgSearch\"]/div[2]/div/a[1]")).click();
            Thread.sleep(2000);
            List<WebElement> plans = driver.findElements(By.className("datagrid-cell-c2-status_name"));
            for(WebElement plan : plans){
                if(plan.getText().equals("正在执行")){
                    plan.click();
                    break;
                }
            }
            Thread.sleep(1000);
            driver.findElement(By.id("adjust")).click();
            Thread.sleep(1000);
            //driver.findElement(By.tagName("li")).getAttribute("class").equals("tabs-selected");
            List<WebElement> lis = driver.findElements(By.tagName("li"));
            System.out.println("begin");
            for(WebElement li : lis) {

                System.out.println(li.getAttribute("class"));
                System.out.println(li.findElement(By.className("tabs-title")).getText());

                if(li.getAttribute("class").equals("tabs-selected") && li.findElement(By.className("tabs-title")).getText().equals("预选项目")){
                    break;
                }else if(li.getAttribute("class").equals("tabs-selected") && li.findElement(By.className("tabs-title")).getText().equals("基本信息")){
                    li.findElement(By.className("预选项目")).click();
                    Thread.sleep(500);

                    break;
                }
            }
            System.out.println("end");
            WebElement iframe2 = driver.findElement(By.id("yuxuan"));
            driver.switchTo().frame(iframe2);
            driver.findElement(By.id("add")).click();
            Thread.sleep(500);


//           driver.findElement(By.id("datagrid-row-r2-2-0")).click();
//           Thread.sleep(2000);
//           driver.findElement(By.id("adjust")).click();
//           Thread.sleep(2000);
//           String jsDriver = "var a = document.getElementById('datagrid-row-r3-2-0').innerHTML;";
//           JavascriptExecutor jsExecutor = (JavascriptExecutor) driver;
//           String jsString = (String) jsExecutor.executeScript(jsDriver);
//           System.out.println(jsString);
//            WebElement webElement2 = driver.findElement(By.className("datagrid-view2"));
//            List<WebElement> tr = webElement2.findElements(By.tagName("tr"));
//            for (int i = 0; i <= tr.size(); i ++) {
//                System.out.println(tr.get(i).getAttribute("filed") + "/"
//                        + tr.get(i).getText());
//                if(tr.get(i).getAttribute("field").equals("status_name")){
//                    if(tr.get(i).getText().equals("正在执行")){
//                        System.out.println(tr.get(i).getAttribute("filed") + "/"
//                                + tr.get(i).getText());
//                        driver.findElement(By.id("adjust")).click();
//                        break;
//                    }
//                }
//            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

    /**
     *  by.linkText
     */
    @Test
    public void testGetLinkText(){
        try {
//            driver.manage().window().maximize();
            driver.get("https://www.baidu.com");
//            By linkText 查找元素
            driver.findElement(By.linkText("新闻")).click();
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

//        判断打开页面是不是百度新闻，这里用url作为验证
        assert driver.getCurrentUrl() == "http://news.baidu.com";

    }
    @Test
    public void testTemp(){
        String s ="asdfghjkl";
        char[] chars = s.toCharArray();

        for(int i = 0;i<chars.length;i++){
            for(int j = 0 ;j < i;j++){
                if(chars[i]<chars[j]){
                    char temp = chars[i];
                    chars[i]= chars[j];
                    chars[j]=temp;

                }
            }

        }

    }

    @AfterClass
    public void testClose(){
        try {
            Thread.sleep(3000);
            driver.quit();

        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

}
