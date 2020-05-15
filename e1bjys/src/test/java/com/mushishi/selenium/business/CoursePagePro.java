package com.mushishi.selenium.business;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.mushishi.selenium.base.DriverBase;
import com.mushishi.selenium.handle.CoursePageHandle;

public class CoursePagePro {
	public DriverBase driver;
	public CoursePageHandle coursePageHandle;
	public CoursePagePro(DriverBase driver){
		this.driver = driver;
		coursePageHandle = new CoursePageHandle(driver);
	}
	/**
	 * 添加购物车
	 * */
	public void addCart(){
		int beforeNum;
		int afterNum;
		String aftercourseNum;
		String courseNum = coursePageHandle.getShopCartNum();
		try{
			beforeNum = Integer.valueOf(courseNum);
			System.out.println(beforeNum);
		}catch(Exception e){
			beforeNum= 0;
		}
		coursePageHandle.clickAddCart();
		try{
			driver.switchToMode();
			coursePageHandle.clickBuyNow();
		}catch(Exception e){
			
		}

		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		aftercourseNum =coursePageHandle.getShopCartNum();
		try{
			afterNum = Integer.valueOf(aftercourseNum);
			System.out.println(afterNum);
		}catch(Exception e){
			afterNum=beforeNum;
		}
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(afterNum == beforeNum+1){
			System.out.println("添加购物车成功");
			coursePageHandle.clickShopCart();
			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			coursePageHandle.clickGoPay();
			
		}else if(afterNum>0){
			coursePageHandle.clickShopCart();
			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			coursePageHandle.clickGoPay();
		}else{
			coursePageHandle.clickShopCart();
			try {
				Thread.sleep(5000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			List<String> it = driver.getWindowsHandles();
			driver.switchWindows(it.get(1));
			System.out.println(driver.getTitle());
			coursePageHandle.clickGoPay();
		}
	}
	
	/**
	 * 点击立即购买
	 * */
	public void buyNow(){
		coursePageHandle.clickBuyNow();
	}
}
