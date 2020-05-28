package ssc.base;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;

/**
 * 列举可选浏览器类型
 */
public class Brower {
    public static final String CHROME = "webdriver.chrome.driver";
    public static final String IE = "\"webdriver.ie.driver";

    public WebDriver setChrome13(){
        System.setProperty(CHROME,"D:/_Projects/chromedriver.exe");
        System.out.println("it is chrome13 now");

        return new ChromeDriver();
    }
    public WebDriver setChrome19(){
        System.setProperty(CHROME,"E:/chromedriver.exe");
        System.out.println("it si chrome19 now");

        return new ChromeDriver();
    }
    public WebDriver setIE() {
        System.setProperty(IE, "E:\\IEDriverServer.exe");
        System.out.println("it is ie now");

        return new InternetExplorerDriver();
    }
}
