package ssc.testCase;

import ssc.base.DriverBase;

public class CaseBase {

    public DriverBase initdriver(String brower){
        return new DriverBase(brower);
    }
}
