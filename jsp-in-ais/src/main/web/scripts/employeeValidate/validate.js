/**
 * @author wangyuan
 */
 
//验证日期规则
function validateDate(){
	var birthday = document.getElementById("employeeInfo.birthday").value;
	var graduate = document.getElementById("employeeInfo.graduateDate").value;
	var joinCorp = document.getElementById("employeeInfo.joinCorpDate").value;
	var beginWork = document.getElementById("employeeInfo.beginWorkDate").value;
	var leaveCorp = document.getElementById("employeeInfo.dimissionDate").value;
	var arr = new Array();
	//arr[0] = new Array(birthday, graduate, joinCorp, beginWork, leaveCorp);
	//arr[1] = new Array("出生日期", "毕业时间", "入司时间", "入职时间", "离职时间");
	arr[0] = new Array(birthday, leaveCorp);
	arr[1] = new Array("出生日期", "离职时间");
	var len = arr[0].length;
	if(leaveCorp == null || leaveCorp == ""){//如果离职时间为空则不进行比较�գ��򲻽��бȽ�
		len--;
	}
	for(var i=0; i<len-1; i++){
		for(var j=i+1; j<len; j++){
		   		if(i==1&&j==2){
		   			if(arr[0][i] > arr[0][j]){
						alert(arr[1][i] + " 不能大于 " + arr[1][j] + "!");
						return false;
					}else{
						continue;
					}	
		   		}
				if(arr[0][i] >= arr[0][j]){
					alert(arr[1][i] + " 不能大于等于 " + arr[1][j] + "!");
					return false;
				}	
		}
	}
	return true;
}

//验证
function numValidate(){
	var pas = document.getElementById("employeeInfo.pas");
	var mobile = document.getElementById("employeeInfo.mobileTelephone");
	var identityCard = document.getElementById("employeeInfo.identityCard");
	var email = document.getElementById("employeeInfo.email");
	if(pas != null && pas.value != null && pas.value != '' && !isNum(pas.value)){
		alert("小灵通必须是数字！");
		pas.focus();
		return false;
	}
	if(mobile != null && mobile.value != null && mobile.value != '' && !isNum(mobile.value)){
		alert("手机号码必须是数字！");
		mobile.focus();
		return false;
	}
	if(identityCard != null && identityCard.value != null && identityCard.value != '' && !isNum(identityCard.value)){
		alert("身份证号必须是数字！");
		identityCard.focus();
		return false;
	}
	if(identityCard != null && identityCard.value != null && identityCard.value != '' && identityCard.value.length != 15 && identityCard.value.length != 18){
		alert("身份证号必须是15或18位！");
		identityCard.focus();
		return false;
	}
/*	else{
		var card = identityCard.value;
		if(!isNum(card)){
			var prefix = card.substring(0,card.length-1);
			if(!isNum(prefix)){
				alert("身份证号必须是数字");
				identityCard.focus();
				return false;
			}
			var tag = card.substring(card.length-1,card.length);
			if(tag!="X"){
				alert("身份证号尾数必须是X或者数字！");
				identityCard.focus();
				return false;
			}
		}
	}*/
	if(email != null && email.value != null && email.value != ''){
		var re = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
		if(!re.test(email.value)){
			alert("电子邮箱地址不正确！");
			email.focus();
			return false;
		}else{
			return true;
		}
	}
	return true;	
}

function isNum(s){
	var re = /^[0-9]+$/;
	return re.test(s);
}

//清空文本框
function clearAll(){
	var inputs = document.getElementsByTagName("INPUT");
	var selects = document.getElementsByTagName("SELECT");
	for(var i=0; i<inputs.length; i++){
		if(inputs[i].getAttribute("type") == "text"){
			inputs[i].value = "";
		}
	}
	for(var i=0; i<selects.length; i++){
		selects[i].value = "";
	}
}
