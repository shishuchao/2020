package ssc.handle;

import ssc.base.DriverBase;
import ssc.page.CourseListPage;

/**
 * selenium
 * AUTHOR 13283
 * DATE 2020-05-31
 */

public class CourseListPageHandle {
    public DriverBase driver;
    public CourseListPage courseListPage;

    /**
     *
     */
    public CourseListPageHandle(DriverBase driver2) {
        this.driver =driver2;
        courseListPage = new CourseListPage(driver);
    }
}