package ssc.business;

import ssc.base.DriverBase;
import ssc.handle.CoursePageHandle;

/**
 *
 */
public class CoursePagePro {
    public DriverBase driver;
    public CoursePageHandle coursePageHandle;

    /**
     *
     */
    public CoursePagePro(DriverBase driver2) {
        this.driver = driver2;
        coursePageHandle = new CoursePageHandle(driver);

    }
}
