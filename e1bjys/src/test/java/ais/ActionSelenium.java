package ais;

import ais.login.Init;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.annotations.Test;

public class ActionSelenium {
    Init init = new Init();
    WebDriver driver = null ;

    @Test
    public void testInit(){
       try{
           driver = init.init();
           init.login(driver,"shiscsj","123");
           init.sleep(2000);
           driver.get("http://10.2.112.21:32659/ais/portal/simple/http/ais//portal/simple/simple-firstPageAction!menu.action?parentMenuId=10");
           init.sleep(2000);
           driver.findElement(By.id("menu1010")).click();
           init.sleep(2000);
           driver.findElement(By.id("_easyui_tree_3")).click();
           init.sleep(3000);
           WebElement iframe = driver.findElement(By.id("101050id"));
           driver.switchTo().frame(iframe);
           driver.findElement(By.id("search")).click();
           init.sleep(2000);
           driver.findElement(By.xpath("//*[@id=\"dlgSearch\"]/div[2]/div/a[2]/span/span[1]")).click();
           init.sleep(1000);
           driver.findElement(By.xpath("//*[@id=\"dlgSearch\"]/div[2]/div/a[1]")).click();
           init.sleep(2000);




       }finally {
           init.sleep(3000);
           driver.close();

       }




    }

}
