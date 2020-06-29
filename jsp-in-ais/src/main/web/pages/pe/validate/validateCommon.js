//$import("../../script/validate.js");


//function $import(path){
//	var i, base, src = "validateCommon.js", scripts = document.getElementsByTagName("script");
//	for (i=0; i<scripts.length; i++){if (scripts[i].src.match(src)){ base = scripts[i].src.replace(src, "");break;}}
//	document.write("<" + "script src=\"" + base + path + "\"></" + "script>");
//}

function nullValidate(obj){
	if(obj.value==''){
		alert("请输入数据！");
		return ;
	}
}

function noValidate(obj){
	var fieldValue=obj.value;
	if(fieldValue!=null&&fieldValue!=''){
			if(isNaN(fieldValue)){//非数字
				alert("请输入数字！");
				obj.select();
				obj.focus();
			}
		}	
}


//校验输入的字符是否是数字
//
function numberValidate(fieldName){
	var objs=document.getElementsByName(fieldName);
	if(objs.length>0){
		var fieldValue=objs[0].value;
		if(fieldValue!=null&&fieldValue!=''){
			if(isNaN(fieldValue)){//非数字
				alert("请输入数字！");
				objs[0].select();
				objs[0].focus();
				return false;
			}else{
				return true;
			}
		}	
	}
}
//校验不能太大
function numberValidate_out(fieldName,value,lable_name){
    
	var objs=document.getElementsByName(fieldName);
	
	if(objs.length>0){
		var fieldValue=objs[0].value;
		
		if(fieldValue.length>value){
			
				alert("["+lable_name+"]输入长度不能超过"+value+"位!");
				objs[0].select();
				objs[0].focus();
				return false;
			
		}else{
			return true;
		}	
	}
}

//总和小于100
//名称列表
//当前对象
function sumUnder100Validate(nameList,objname){
	var arr=new Array();
	arr=nameList;
	var allValue=0;
	for(var i=0;i<arr.length;i++){
		var tmp=document.getElementsByName(arr[i])[0].value;
		if(!isNaN(tmp)){
			allValue+=new Number(tmp);
		}
	}
	if(allValue>100){
		alert("总分不能大于100!");
		document.getElementsByName(objname)[0].select();
		document.getElementsByName(objname)[0].focus();
	}
}

function sumValidate(nameList,objname){

	var arr=nameList.split(',');
	var allValue=0;
	for(var i=0;i<arr.length;i++){		
		var tmp=document.getElementsByName(arr[i]+'-a')[0].value;	
		if(!isNaN(tmp)){
			allValue+=new Number(tmp);
		}		
	document.getElementsByName(objname)[0].value=allValue;	
		
	}
}

function sumValidate_feng(weightNameList,nameList,objname){
alert('--');
alert('-weightNameList-'+weightNameList);
alert('-nameList-'+nameList);
alert('-objname-'+objname);
	var arr=nameList.split(',');
	var allValue=0;
	for(var i=0;i<arr.length;i++){		
		var tmp=document.getElementsByName(arr[i])[0].value;		    
			allValue+=new Number(tmp)*new Number(weightNameList[i]);			
	        document.getElementsByName(objname)[0].value=allValue/100;		
	}
}




//校验是否是合法的邮编 /^[a-zA-Z0-9]{3,12}$/
function postCodeValidate(fieldName){
	var objs=document.getElementsByName(fieldName);
	if(objs.length>0){
		var fieldValue=objs[0].value;
		var patrn = /^\d{6}$/;
		if(fieldValue!=null&&fieldValue!=''){
			if(!patrn.test(fieldValue)){
				alert("邮政编码输入错误，请重新输入！");
				objs[0].select();
				objs[0].focus();
			}
		}
	}
		
}


//校验输入的数字是否是正确的电话号
//校验的不细致，太笼统
function phoneNumberValidate(fieldName){
	var objs=document.getElementsByName(fieldName);
	if(objs.length>0){
		var fieldValue=objs[0].value;
		var patrnPhone = /^(0[\d]{2,3}-)?\d{6,8}(-\d{3,4})?$/;
		var patrnMobile=/^0?1((3[0-9]{1})|(59)){1}[0-9]{8}$/;
		if(fieldValue!=null&&fieldValue!=''){
			if(!patrnPhone.test(fieldValue)&&!patrnMobile.test(fieldValue)){
				alert("电话号码输入错误，请重新输入！");
				objs[0].select();
				objs[0].focus();
			}
		}	
	}	
}

//统计总和
//nameList 是需要累加的名称的数组
//result 是这次的返回值的id
function stat(nameList,result){
	var arr=new Array();
	arr=nameList;
	var allValue=0;
	for(var i=0;i<arr.length;i++){
		var tmp=document.getElementsByName(arr[i])[0].value;
		if(!isNaN(tmp)){
			allValue+=new Number(tmp);
		}
	}
	document.getElementsByName(result)[0].value=allValue;
}

//开始时间必须小于结束时间
function dateCompare(beginName,endName){
	var begin=document.getElementsByName(beginName)[0].value;
	var end=document.getElementsByName(endName)[0].value;
	if(begin==null||begin==''||end==null||end=='')
		return true;
	if(begin>end){
		alert("结束时间必须大于开始时间！");	
		document.getElementsByName(endName)[0].select();
		document.getElementsByName(endName)[0].focus();
		return false;
	}
	return true;
}



//输入的是否是正确的钱 
//copy
function isMoneyNum(str){
	return (new RegExp( /(^-?(?:(?:\d{0,3}(?:,\d{3})*)|\d*))(\.\d{1,2})?$/).test(str));
}