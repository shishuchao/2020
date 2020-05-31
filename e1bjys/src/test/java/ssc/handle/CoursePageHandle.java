package ssc.handle;

import ssc.base.DriverBase;
import ssc.page.CoursePage;

/**
 * selenium
 * AUTHOR 13283
 * DATE 2020-05-31
 */

public class CoursePageHandle {
    public DriverBase driver;
    public CoursePage coursePage;

    /**
     *
     */
    public CoursePageHandle(DriverBase driver2) {
        this.driver = driver2;
        coursePage = new CoursePage(driver);
    }
}