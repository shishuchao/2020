package com.mushishi.selenium.business;

import java.util.List;

import org.openqa.selenium.WebElement;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.handle.CourseListPageHandle;

public class CourseListPagePro {
	public DriverBase driver;
	public CourseListPageHandle courseListPageHandle;
	public CourseListPagePro(DriverBase driver){
		this.driver = driver;
		courseListPageHandle = new CourseListPageHandle(driver);
	}
	/**
	 * 点击每个课程
	 * */
	public void clickEverCourse(){
		List<WebElement> elements = courseListPageHandle.getCourseListName();
		for(int i =0;i<elements.size()-1;i++){
			elements.get(i).click();
			driver.back();
			elements = courseListPageHandle.getCourseListName();
		}
	}
}
