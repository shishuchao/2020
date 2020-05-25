package ais;

import ais.login.Init;
import org.openqa.selenium.WebDriver;
import org.testng.annotations.Test;

import java.lang.annotation.Target;

public class ActionSelenium {
    Init init = new Init();
    WebDriver driver = null ;

    @Test
    public void testInit(){
        init.init(driver);
        init.login(driver,"shiscsj","123");
    }
}
