package ais;

import org.openqa.selenium.WebDriver;
import org.testng.ITestResult;
import org.testng.TestListenerAdapter;

import java.io.IOException;

/**
 * @auchor 19381
 */
public class AisListener extends TestListenerAdapter {
    SSCUtils sscUtils ;

    @Override
    public void onTestSuccess(ITestResult iTestResult) {
        try {
            super.onTestSuccess(iTestResult);
            ActionSelenium instance = (ActionSelenium) iTestResult.getInstance();
            sscUtils = new SSCUtils(instance.driver);
            sscUtils.screenShot("listenerShot");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onTestFailure(ITestResult iTestResult) {
        super.onTestFailure(iTestResult);
    }


}
