package ais;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @auchor 19381
 */
public class testInstance {

     WebDriver driver;

    @BeforeClass
    public void testInit(){
        System.setProperty("webdriver.ie.driver","E:\\IEDriverServer.exe");
        driver = new InternetExplorerDriver() ;
    }

    /**
     * 寻找元素测试 ，地址  E:\IDEA2\ais\web\pages\plan\month\edit_workplan - 副本.jsp
     */

    @Test
    public void testIns(){
        try {
            driver.get("E:\\IDEA2\\ais\\web\\pages\\plan\\month\\edit_workplan - 副本.jsp");
            Thread.sleep(500);

            WebElement element = driver.findElement(By.name("All"));
            List<WebElement> childElements = element.findElements(By.xpath("div"));
            for(WebElement childElement : childElements){
                System.out.println(childElement.getAttribute("class")+" "+childElement.getText());
            }
            System.out.println(element.getText());
            WebElement parentElement = element.findElement(By.xpath(".."));
            System.out.println(parentElement.getAttribute("id"));

        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @org.junit.Test
    public void test审计(){
        String 审计方法 = "汉字审计方法shenjifangfa";
        int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
        Date date = new Date();
        SimpleDateFormat ft = new SimpleDateFormat("yyMMdd-hhmmss");
        System.out.println(ft.format(date));

    }




    @AfterClass
    public void testClose(){
        try {
            Thread.sleep(500);
            driver.quit();

        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }
}
