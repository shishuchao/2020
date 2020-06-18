package ais;

import org.openqa.selenium.*;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.sql.DatabaseMetaData;
import java.sql.SQLOutput;
import java.text.SimpleDateFormat;
import java.util.*;

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
            driver.get("http://10.2.112.21:30302/ais/login/loginView.jsp");
            Thread.sleep(2000);
            driver.findElement(By.id("j_username")).sendKeys("shiscsj");
            driver.findElement(By.id("j_password")).sendKeys("123");
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

            System.out.println("testLogin 开始");
            driver.get("http://10.2.112.21:30302/ais/portal/simple/http/ais//portal/simple/simple-firstPageAction!menu.action?parentMenuId=10");
            Thread.sleep(2000);
            driver.findElement(By.id("menu1010")).click();
            Thread.sleep(500);
            driver.findElement(By.id("_easyui_tree_3")).click();
            Thread.sleep(1000);

            WebElement iframe = driver.findElement(By.id("101050id"));
            driver.switchTo().frame(iframe);
            driver.findElement(By.id("search")).click();
            Thread.sleep(500);
            driver.findElement(By.xpath("//*[@id=\"dlgSearch\"]/div[2]/div/a[2]")).click();
            Thread.sleep(500);
            driver.findElement(By.xpath("//*[@id=\"dlgSearch\"]/div[2]/div/a[1]")).click();
            Thread.sleep(500);
            List<WebElement> plans = driver.findElements(By.className("datagrid-cell-c2-status_name"));
            for(WebElement plan : plans){
                if(plan.getText().equals("正在执行")){
                    plan.click();
                    break;
                }
            }
            Thread.sleep(500);
            driver.findElement(By.id("adjust")).click();
            Thread.sleep(500);
            //driver.findElement(By.tagName("li")).getAttribute("class").equals("tabs-selected");
            List<WebElement> lis = driver.findElements(By.tagName("li"));
            for(WebElement li : lis) {
                if(li.getAttribute("class").equals("tabs-selected") && li.findElement(By.className("tabs-title")).getText().equals("预选项目")){
                    break;
                }else if(li.getAttribute("class").equals("tabs-selected") && li.findElement(By.className("tabs-title")).getText().equals("基本信息")){
                    List<WebElement> elements = li.findElements(By.className("tabs-title"));
                    for(WebElement element : elements){
                        if(element.getText().equals("预选项目")){
                            element.click();
                            break;
                        }
                    }
                    Thread.sleep(500);
                    break;
                }
            }
            WebElement iframe2 = driver.findElement(By.id("yuxuan"));
            driver.switchTo().frame(iframe2);
            driver.findElement(By.id("add")).click();
            Thread.sleep(500);
            System.out.println("testLogin 结束");


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
     * 新增预选项目计划
     */
    @Test(dependsOnMethods = {"testLogin","testModifyPlan"})
    public void testCeatePlan(){

        try {
            driver.switchTo().defaultContent();
            Thread.sleep(500);
            WebElement iframe = driver.findElement(By.xpath("//*[@id=\"mainLayout\"]/div[22]/div[2]/iframe"));
            Thread.sleep(2000);

//            List<WebElement> elements = element1.findElements(By.xpath("*"));
//            for(WebElement element : elements){
//                System.out.println(elements.indexOf(element)+" "+element.getTagName()+" " +element.getAttribute("class"));
//                List<WebElement> elements1 = element.findElements(By.xpath("*"));
//                for(WebElement element11 : elements1){
//
//                    System.out.println("    "+elements1.indexOf(element11)+" "+element11.getTagName()+" " +element11.getAttribute("class"));
//                    List<WebElement> elements11 = element11.findElements(By.xpath("*"));
//                    for(WebElement element111 : elements11){
//
//                        System.out.println("        "+elements11.indexOf(element111)+" "+element111.getTagName()+" " +element111.getAttribute("class"));
//                    }
//                }
//
//            }

            driver.switchTo().frame(iframe);
            System.out.println("进入预选项目新增表单");

            // 月份 下拉单选框
            System.out.println("月份");
//            String aClass = driver.findElement(By.xpath("//*[@id=\"w_plan_month\"]/..")).getAttribute("class");
//            System.out.println(aClass);
            List<WebElement> spans1 = driver.findElements(By.className("textbox-addon"));
            spans1.get(0).click();
            Thread.sleep(500);
            int month = Calendar.getInstance().get(Calendar.MONTH) ;
            driver.findElement(By.id("_easyui_combobox_i2_"+month)).click();
            Thread.sleep(500);

            // 审计单位 单选
            System.out.println("审计单位");

            // 项目类型 iframe
            System.out.println("项目类型");
            List<WebElement> imgs = driver.findElements(By.tagName("img"));
            for(WebElement img : imgs ){
                String onclick = img.getAttribute("onclick").substring(0, 7);
                System.out.println(onclick);
                if(onclick.equals("getItem")){
                    img.click();
                    Thread.sleep(1000);
                    break;
                }

            }
            WebElement iframe1 = driver.findElement(By.id("item_ifr"));
            System.out.println("before "+iframe1.getAttribute("src"));
            driver.switchTo().frame(iframe1);
            driver.findElement(By.id("_easyui_tree_3")).click();

            driver.switchTo().parentFrame();
            List<WebElement> spans = driver.findElement(By.id("subwindow")).findElements(By.className("l-btn-text"));
            for(WebElement span : spans){
                System.out.println(span.getText());
                if(span.getText().equals("确定")){
                    span.click();
                    break;
                }
            }

            //被审计单位 多选
            System.out.println("被审计单位");


            // 计划等级 下拉框 单选
            System.out.println("计划等级");
            spans1.get(1).click();
            Thread.sleep(500);
            //  (int)(Math.random()*100）+1    返回1到100之间的随机整数，前面返回0到99之间的随机数，加1就成了1到100之间的随机数。
            int panGrade = (int) (Math.random() * 2) + 1;
            driver.findElement(By.id("_easyui_combobox_i1_"+panGrade)).click();
            Thread.sleep(500);

            // 审计方式 下拉框 单选
            // 默认勾选 “自主审计”，待 “全外包”时，再定位

            // 项目名称
            System.out.println("项目名称");
            Date date = new Date();
            SimpleDateFormat format = new SimpleDateFormat("yyMMdd-hhmmss");
            driver.findElement(By.id("w_plan_name")).sendKeys(format.format(date)+"石树超");

            //时间处理
//            String js = "$('input:eq(0)').attr('readonly',false)";
//            JavascriptExecutor jsExecutor = (JavascriptExecutor)driver;
//            jsExecutor.executeScript(js);
            List<WebElement> divs = driver.findElements(By.className("datebox-button"));
            SSCUtils utils = new SSCUtils(driver);

            // 项目开始时间
            System.out.println("几个时间");
            //driver.findElement(By.id("pro_starttime")).click();
            spans1.get(3).click();
            utils.dateWidget(divs,0);
            //项目结束时间
            //driver.findElement(By.id("pro_endtime")).click();
            spans1.get(4).click();
            utils.dateWidget(divs,1);
            //审计开始时间
            //driver.findElement(By.id("audit_start_time")).click();
            spans1.get(5).click();
            utils.dateWidget(divs,2);
            //审计结束时间
            //driver.findElement(By.id("audit_end_time")).click();
            spans1.get(6).click();
            utils.dateWidget(divs,3);

            // 立项依据 大文本框
            driver.findElement(By.id("content")).sendKeys(format.format(date)+"石树超 "+" 立项依据");

            // 审计目的
            driver.findElement(By.id("audit_purpose")).sendKeys(format.format(date)+"石树超 "+" 审计目的");

            // 审计安排
            driver.findElement(By.id("audArrange")).sendKeys(format.format(date)+"石树超 "+" 审计安排");

            // 审计重点
            driver.findElement(By.id("audEmphasis")).sendKeys(format.format(date)+"石树超 "+" 审计重点");

            // 备注
            driver.findElement(By.id("plan_remark")).sendKeys(format.format(date)+"石树超 "+" 备注");

            // 上传附件
            // By.id("fujian")
            System.out.println("上传附件");
            List<WebElement> fujians = driver.findElement(By.id("fujian")).findElements(By.className("l-btn-text"));
            for(WebElement fujian : fujians){
                System.out.println(fujian.getText());
                if(fujian.getText().equals("添加")){
                    fujian.click();
                    break;
                }
            }
            driver.switchTo().parentFrame();
            driver.findElement(By.className("icon-addFile")).click();
//todo
            //driver.findElement(By.className("icon-addFile")).sendKeys("C:\\Users\\19381\\Desktop\\科目说明.docx");

            // 保存
            WebElement saveButton = driver.findElement(By.id("saveButton"));
            List<WebElement> spans2 = saveButton.findElements(By.tagName("span"));
            for(WebElement span2 : spans2){
                System.out.println(span2.getText());
            }

            Thread.sleep(500);
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
        assert driver.getCurrentUrl().equals( "http://news.baidu.com");

    }
    @Test
    public void testTemp(){


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
