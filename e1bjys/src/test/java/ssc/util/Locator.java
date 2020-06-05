package ssc.util;

import com.mushishi.selenium.util.ProUtil;
import org.openqa.selenium.By;

import java.util.Properties;

/**
 * @auchor 19381
 */
public class Locator {
    public By by;
    MyProperties properties = new MyProperties("element.properties");


    /**
     * 接收 key
     * 返回 By
     */
    public By getLocator(String key){
        String element = properties.getMyProperty(key);
        String elementType = element.split(">")[0];
        String elementValue = element.split(">")[1];
        if(elementType.equals("id")){
            by = By.id(elementValue);
        }else if(elementType.equals("className")){
            by = By.className(elementValue);
        }else if(elementType.equals("tagName")){
            by = By.tagName(elementValue);
        }else if(elementType.equals("name")){
            by = By.name(elementValue);
        }else if(elementType.equals("linkText")){
            by = By.linkText(elementValue);
        }else if(elementType.equals("xpath")){
            by = By.xpath(elementValue);
        }else{
            System.out.println("element is invalid");
        }
        return by ;

    }
}
