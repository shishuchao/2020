function isEmpty(str) {
	if (str == null || str == "") {
		return true;
	}
	return false;
}
/**
* 功能：校验是否为财务金额
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isMoneyNum(str){
	return (new RegExp( /(^-?(?:(?:\d{0,3}(?:,\d{3})*)|\d*))(\.\d{1,2})?$/).test(str));
}
/**
* 功能：校验是否为财务金额,排斥逗号
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isMoneyNum1(str){
	return (new RegExp( /(^-?(?:(?:\d{0,3})|\d*))(\.\d{1,2})?$/).test(str));
}

/**
* 功能：校验是否为正数
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isPlus(str) {
	return (new RegExp(/(^\+?|^\d?)\d*\.?\d+$/).test(str));
}
/**
* 功能：校验是否为负数
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isMinus(str) {
	return (new RegExp(/^-\d*\.?\d+$/).test(str));
}
/**
* 功能：校验是否是整数
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isInteger(str) {
	return (new RegExp(/^(-|\+)?\d+$/).test(str));
}
/**
* 功能：校验是否为正整数
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isPlusInteger(str) {
	return (new RegExp(/^([+]?)(\d+)$/).test(str));
}
/**
* 功能：校验是否为负整数
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isMinusInteger(str) {
	return (new RegExp(/^-(\d+)$/).test(str));
}
/**
* 功能：校验是否为浮点数
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isFloat(str) {
	return (new RegExp(/^([+-]?)\d*\.\d+$/).test(str));
}
/**
* 功能：校验是否为正浮点数
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isPlusFloat(str) {
	return (new RegExp(/^([+]?)\d*\.\d+$/).test(str));
}
/**
* 功能：校验是否为负浮点数
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isMinusFloat(str) {
	return (new RegExp(/^-\d*\.\d+$/).test(str));
}
/**
* 功能：校验是否全是数字
*
* 参数str：输入值
* 返回值：true：是 false：否
*/
function isDigit(str) {
	return (new RegExp(/^\d+$/).test(str));
}
/**
* 功能：针对所有类型的数字验证
*
* 参数str：输入值
* 验证标记flag：+ 正数 – 负数 i 整数 +i 正整数 –i 负整数 f 浮点数 +f 正浮点数 –f 负浮点数
* 返回值：true：合法false：非法
*/
function isNumeric(str, flag) {
	if (isNaN(str)) {
		return false;
	}
	switch (flag) {
	  case null:
	  case "":
		return true;
	  case "+":
		return isPlus(str);
	  case "-":
		return isMinus(str);
	  case "i":
		return isInteger(str);
	  case "+i":
		return isPlusInteger(str);
	  case "-i":
		return isMinusInteger(str);
	  case "f":
		return isFloat(str);
	  case "+f":
		return isPlusFloat(str);
	  case "-f":
		return isMinusFloat(str);
	  default:
		return true;
	}
}
/**
* 功能：判断是否包含汉字
*
* 参数str：输入值
* 返回值：true：包含 false：不包含
*/
function isExistChinese(str) {
	if (/[^\x00-\xff]/g.test(str)) {
		return true;
	} else {
		return false;
	}
}
/**
	* 功能：IP地址格式校
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isIP(str) {
	return (new RegExp(/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])(\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])){3}$/).test(str));
}
/**
	* 功能：电子邮件格式校
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isMail(str) {
	return (new RegExp(/^[\w-]+@[\w-]+(\.[\w-]+)+$/).test(str));
}
/**
	* 功能：判断是否为汉字
	*
	* 参数str：输入值
	* 返回值：true：是false：否
	*/
function isChinese(str) {
	return (new RegExp(/^[\u0391-\uFFE5]+$/).test(str));
}
/**
	* 功能：身份证号校
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isIdCard(str) {
	return (new RegExp(/^\d{15}(\d{2}[A-Za-z0-9])?$/).test(str));
}
/**
	* 功能：URL地址校
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isURL(str) {
	return (new RegExp(/^http[s]?:\/\/[\w-]+(\.[\w-]+)+([\w-\.\/?%&=]*)?$/).test(str));
}
/**
	* 功能：校验是否仅ACSII字符
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isAcsii(str) {
	return (new RegExp(/^[\x00-\xFF]+$/).test(str));
}
/**
	* 功能：校验手机号码
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isMobile(str) {
	return (new RegExp(/^0?1((3[0-9]{1})|(59)){1}[0-9]{8}$/).test(str));
}
/**
	* 功能：校验电话号码
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isPhone(str) {
	return (new RegExp(/^(0[\d]{2,3})?-?\d{6,8}(-\d{3,4})?$/).test(str));
}
/**
	* 功能：校验邮政编码
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isZipCode(str) {
	return (new RegExp(/^\d{6}$/).test(str));
}
/**
	* 功能：校验合法日期 格式如(2007-02-27、2007/02/28、2007.02.28)
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isDate(str) {
	if (!/\d{4}(\.|\/|\-)\d{1,2}(\.|\/|\-)\d{1,2}/.test(str)) {
		return false;
	}
	var r = str.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	}
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d.getDate() == r[2]);
}
/**
	* 功能：校验合法长时间 格式如(2007-02-27 13:04:06)
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isDateTime(str) {
	var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/;
	var r = str.match(reg);
	if (r == null) {
		return false;
	}
	var d = new Date(r[1], r[3] - 1, r[4], r[5], r[6], r[7]);
	return (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[3] && d.getDate() == r[4] && d.getHours() == r[5] && d.getMinutes() == r[6] && d.getSeconds() == r[7]);
}
/**
	* 功能：校验字符串：只能输入6-20个字母、数字、下划线(常用校验用户名和密码)
	*
	* 参数str：输入值
	* 返回值：true：合法 false：非法
	*/
function isString6_20(str) {
	return (new RegExp(/^(\w){6,20}$/).test(str));
}
