package ssc.business;

import ssc.base.DriverBase;
import ssc.handle.CourseListPageHandle;

/**
 *
 */
public class CourseListPagePro {
    public DriverBase driver;
    public CourseListPageHandle courseListPageHandle;

    /**
     *
     */
    public CourseListPagePro(DriverBase driver2) {
        this.driver = driver2;
        courseListPageHandle = new CourseListPageHandle(driver);
    }
}
