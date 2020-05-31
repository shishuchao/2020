package ssc.base;

import net.sourceforge.htmlunit.corejs.javascript.ast.TryStatement;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.testng.annotations.Test;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.HashMap;
import java.util.Map;

/**
 * 根据浏览器识别字符，自动启动相应的driver
 */
public class SelectDriver {

    /**
     *
     */
    public WebDriver newDriver(){
        if(getMac().equals(" ")){
            System.setProperty("webdriver.ie.driver","E:\\IEDriverServer.exe");
            System.out.println("it is ie now");
            return new InternetExplorerDriver();
        }if(getMac().equals(" ")) {
            System.setProperty("webdriver.chrome.driver","E:/chromedriver.exe");
            System.out.println("it si chrome19 now");
            return new ChromeDriver();
        }if(getMac().equals("00-50-56-C0-00-08")){
            System.setProperty("webdriver.chrome.driver","D:/_Projects/chromedriver.exe");
            System.out.println("it is chrome13 now");
            return new ChromeDriver();
        }else {
            System.out.println("your brower is invalid");
            return null;
        }
    }

    /**
     *
     */


    /**
     * 获取 MAC 地址
     */
    public String getMac() {
        String macStr = null;
        try {
            InetAddress ip = InetAddress.getLocalHost();
            NetworkInterface network = NetworkInterface.getByInetAddress(ip);
            byte[] mac = network.getHardwareAddress();
            System.out.print("Current MAC address : ");
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < mac.length; i++) {
                sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
            }
            macStr = sb.toString();
            System.out.println(sb.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return macStr;
    }

}
