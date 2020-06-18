package ais;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * @auchor 19381
 */
public class SSCUtils {
    WebDriver driver ;

    public SSCUtils(WebDriver driver1){
        this.driver = driver1;

    }

    /**
     *  DateWidget
     */
    public void dateWidget(List<WebElement> divs,int index){
        List<WebElement> as= divs.get(index).findElements(By.tagName("a"));
        for(WebElement a : as ){
            if(a.getText().equals("今天")){
                a.click();
                break;
            }

        }
    }
}
