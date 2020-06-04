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
    ProUtil proUtil = new ProUtil("element.properties");


    /**
     *
     */
    public By getLocator(String key){
        String element = properties.getMyProperty(key);
        String elementType = element.split(">")[0];
        String elementValue = element.split(">")[1];
        if(elementType.equals("id")){
            by = By.id(elementValue);
        }if(elementType.equals("className")){
            by = By.className(elementValue);
        }if(elementType.equals("tagName")){
            by = By.tagName(elementValue);
        }if(elementType.equals("name")){
            by = By.name(elementValue);
        }if(elementType.equals("linkText")){
            by = By.linkText(elementValue);
        }if(elementType.equals("xpath")){
            by = By.xpath(elementValue);
        }else{
            System.out.println("element is invalid");
        }
        return by ;

    }
}
