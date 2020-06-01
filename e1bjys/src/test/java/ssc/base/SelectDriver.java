package ssc.base;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * 根据浏览器识别字符，自动启动相应的driver
 */
public class SelectDriver {

    /**
     * 初始化 driver
     */
    public WebDriver newDriver() {
        if (getHostName().equals("LAPTOP-HJJ9G12H")) {
            System.setProperty("webdriver.chrome.driver", "E:/chromedriver.exe");
            System.out.println("it is chrome19 now");
            return new ChromeDriver();
        }
        if (getHostName().equals("LAPTOP-K9MH4579")) {
            System.setProperty("webdriver.chrome.driver", "D:/_Projects/chromedriver.exe");
            System.out.println("it is chrome13 now");
            return new ChromeDriver();
        } else {
            System.out.println("your brower is invalid");
            return null;
        }
    }

    /**
     * 获取 hostname
     * chrome19 LAPTOP-HJJ9G12H
     * chrome13
     */
    public String getHostName() {
        InetAddress inetAddress = null;
        try {
            inetAddress = InetAddress.getLocalHost();
            return inetAddress.getHostName();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return null;
    }
}
