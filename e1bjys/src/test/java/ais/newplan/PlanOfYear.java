package ais.newplan;

import ais.login.Init;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

/**
 * 进入年度计划
 * 创建年度计划
 * 提交年度计划
 */
public class PlanOfYear {
    public WebDriver driver;
    public Init init;
    public PlanOfYear(WebDriver driver){
         this.driver = driver;

    }
    public void intoPlanOfYear(){
        driver.get("http://10.2.112.21:32659/ais/portal/simple/http/ais//portal/simple/simple-firstPageAction!menu.action?parentMenuId=10");
        init.sleep(2000);
        driver.findElement(By.id("menu1010")).click();
        init.sleep(2000);
        driver.findElement(By.id("_easyui_tree_3")).click();
        init.sleep(2000);

    }

    public void createPlanOfYear(){

    }

    public void submitPlanOfYear(){

    }
}
