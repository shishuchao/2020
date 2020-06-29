/*引用 /scripts/validate.js*/
//---methods--
function chkFunds(){//AssetsFunds.jsp
	var years=ADDEDYEARS.split(",");
	var year=document.getElementsByName("funds.year")[0].value;
	if(year.length==0){alert("年度不能为空!");return false;}
	for(var i=0;i<years.length;i++){
		if(years[i]==year){
			alert("该年度已经添加,请选择其它年度!");
			return false;
		}
	}
	var bb=$_money("funds.assets","资产")&&$_money("funds.indebted","负债")&&$_money("funds.equities","权益")&&$_money("funds.pl","损益")&&$_money("funds.planFund","计划")&&$_money("funds.pracFund","实际");
	if(!bb) return false;
	bb=$_num("funds.comNo","分公司数量")&&$_num("funds.subNo","子公司数量");
	if(!bb) return false;
	var s1=$_name("funds.assets");
	var s2=$_name("funds.indebted");
	var s3=$_name("funds.equities");
	if($_empty(s1)) s1.value=0;
	if($_empty(s2)) s2.value=0;
	if($_empty(s3)) s3.value=0;
	if(s1.value*1!=s2.value*1+s3.value*1){alert("资产!=负债+权益 请输入正确数据!");return false;}
	return true;
}
function chkBaseInfo(){//baseInfo.jsp
	if(frmCheck(document.forms[0], 'tab1')){
	var bb=$_num("baseInfo.totalNo","编制人数")&&$_num("baseInfo.realNo","实有人数")&&$_num("baseInfo.fullTimeNo","专职审计人数")&&$_num("baseInfo.partTimeNo","兼职审计人数")&&$_num("baseInfo.innerAuthNo","内审岗位资格人数");
	if(!bb) return false;
	//bb=$_phone("baseInfo.officePhone","办公电话")&&$_phone("baseInfo.fax","传真")&&$_phone("baseInfo.telephone","联系电话");
	//if(!bb) return false;
	bb=$_email("baseInfo.email1","内网邮箱")&&$_email("baseInfo.email2","外网邮箱");
	if(!bb) return false;
	}else{return false;}
	return true;
}
function chkDeptInfo(){//deptInfo.jsp
	var bb=$_postCode("deptInfo.postCode","邮政编码");
	if(!bb) return false;
	//bb=$_phone("deptInfo.contactPhone","联系电话")&&$_phone("deptInfo.contactPhone2","联系电话");
	//if(!bb) return false;
	return true;
}
//--func--
function $_name(name){return document.getElementsByName(name)[0];}
function $_empty(obj){return obj.value.length==0;}
function $_money(name,tip){
	var obj=$_name(name);
	if(!$_empty(obj)){
		if(!isMoneyNum(obj.value)){
			alert(tip+" 只能是数字和两位小数!");
			obj.focus();
			return false;
		}
	}
	return true;
}
function $_num(name,tip){
	var obj=$_name(name);
	if(!$_empty(obj)){
		if(!isInteger(obj.value)){
			alert(tip+" 只能是整数!");
			obj.focus();
			return false;
		}
	}
	return true;
}
function $_phone(name,tip){
	var obj=$_name(name);
	if(!$_empty(obj)){
		if(!isPhone(obj.value)){
			alert(tip+" 只能是数字和'-'或格式不正确!");
			obj.focus();
			return false;
		}
	}
	return true;
}
function $_email(name,tip){
	var obj=$_name(name);
	if(!$_empty(obj)){
		if(!isMail(obj.value)){
			alert(tip+" 格式不正确!例如acb@xxx.com");
			obj.focus();
			return false;
		}
	}
	return true;
}
function $_postCode(name,tip){
	var obj=$_name(name);
	if(!$_empty(obj)){
		if(!isDigit(obj.value)){
			alert(tip+" 为数字!");
			obj.focus();
			return false;
		}
	}
	return true;
}
function $_length(name,len){
	return document.getElementsByName(name)[0].value.length>len;
}
function abc(){//测试使用
	alert("abc");
}
