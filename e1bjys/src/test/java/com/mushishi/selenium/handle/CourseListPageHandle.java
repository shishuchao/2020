package com.mushishi.selenium.handle;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.WebElement;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.page.CourseListPage;

public class CourseListPageHandle {
	public DriverBase driver;
	public CourseListPage courseListPage;
	public CourseListPageHandle(DriverBase driver){
		this.driver = driver;
		courseListPage = new CourseListPage(driver);
	}
	/**
	 * 获取课程名称
	 * */
	public String getCourseName(){
		return courseListPage.getText(courseListPage.getCourseNameElement());
	}
	/**
	 * 点击课程
	 * */
	public void clickCourseName(){
		courseListPage.click(courseListPage.getCourseNameElement());
	}
	
	/**
	 * 获取所有课程的名称
	 * */
	public List<WebElement> getCourseListName(){
		List<WebElement> elements = courseListPage.getCourseListElement();
		return elements;
	}
	/**
	 * 获取当前页面title
	 * */
	public String getCourseTitle(){
		return courseListPage.getTitle();
	}
}
