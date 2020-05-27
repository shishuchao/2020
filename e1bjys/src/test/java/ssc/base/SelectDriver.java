package ssc.base;

import net.sourceforge.htmlunit.corejs.javascript.ast.TryStatement;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.testng.annotations.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * 根据浏览器识别字符，自动启动相应的driver
 */
public class SelectDriver {

    public WebDriver newDriver(String browerName){
        if(browerName.equalsIgnoreCase("ie")){
            System.setProperty("webdriver.ie.driver","E:\\IEDriverServer.exe");
            System.out.println("it is ie now");

            return new InternetExplorerDriver();

        }if(browerName.equalsIgnoreCase("chrome19")) {
            System.setProperty("webdriver.chrome.driver","E:/chromedriver.exe");
            System.out.println("it si chrome19 now");

            return new ChromeDriver();

        }if(browerName.equalsIgnoreCase("chrome13")){
            System.setProperty("webdriver.chrome.driver","D:/_Projects/chromedriver.exe");
            System.out.println("it is chrome13 now");

            return new ChromeDriver();

        }else{
            System.out.println("your brower spelling is not right");
            return  null;
        }

    }


}
