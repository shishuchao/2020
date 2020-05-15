package com.mushishi.selenium.page;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.util.getByLocator;

public class CourseListPage extends BasePage{
	public CourseListPage(DriverBase driver) {
		super(driver);
	}
	/**
	 * 获取课程名称element
	 * */
	public WebElement getCourseNameElement(){
		return nodeElement(getByLocator.getLocator("courseBox"),getByLocator.getLocator("courseName"));
	}
	/**
	 * 获取课程外面的boxelement
	 * */
	public WebElement getCourseBoxElement(){
		return element(getByLocator.getLocator("courseList"));
	}
	
	/**
	 * 获取每个课程里面的文字box
	 * */
	public WebElement getCourseNameBoxElement(){
		return nodeElement(getCourseBoxElement(),getByLocator.getLocator("courseName"));
	}
	
	
	/*
	 * 获取所有课程list
	 * **/
	public List<WebElement> getCourseListElement(){
		WebElement element = this.getCourseBoxElement();
		List<WebElement> listElement = elements(element,getByLocator.getLocator("courseBox"));
		return listElement;
	}
	
	

}
