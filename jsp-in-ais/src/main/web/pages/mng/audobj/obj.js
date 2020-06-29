/* 引用了 /scripts/validate.js */
//--method--
function chkObj() {
	var temp=$_value("auditingObject.initCapital");
//	if(!isMoneyNum(temp)){alert("注册资本 只能是数字和小数点!");return false;}
	temp=$_value("auditingObject.postCode");
	if(temp.length!=0)
	if(!isDigit(temp)||temp.length!=6){alert("邮政编码 只能是数字且长度为6位!");return false;}
	temp=$_value("auditingObject.officePhone");
	if(temp.length!=0)
	if(!isPhone(temp)){alert("办公电话只能是6-8位数字 或 型如：xxx-xxxxxxxx!");return false;}
	temp=$_value("auditingObject.faxCode");
	if(temp.length!=0)
	if(!isDigit(temp)||temp.length>20){alert("传真 只能为数字且长度不能超过20位!");return false;}
	temp=$_value("auditingObject.employeesNum");
	if(temp.length!=0)
	if(!isPlusInteger(temp)||temp.length>5){alert("单位人数 只能是数字且不超过5位!");return false;}
	temp=$_value("auditingObject.departmentName");
	if(temp.length==0){alert("所属审计单位 不能为空!");return false;}
	return true;
}

//--util--
function $_name(name) {
	return document.getElementsByName(name)[0];
}
function $_value(name) {
	return document.getElementsByName(name)[0].value;
}
