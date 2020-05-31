package ssc.base;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;

import java.net.InetAddress;
import java.net.NetworkInterface;

/**
 * 列举可选浏览器类型
 */
public enum  Brower {

    CHROME19("",""),CHROME13("",""),IE("","");

    private String driver;
    private String path;

    Brower(String webdriver, String path){
        this.driver = driver;
        this.path = path;
    }
    public String getDriver(){
        return driver;
    }
    public String getPath(){
        return path;

    }

}
