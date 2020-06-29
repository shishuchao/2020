window.attachEvent("onload",m_init)
function m_init(){
	document.forms[0].attachEvent("onsubmit",disbtn);
}
function disbtn(){
	if(!frmCheck(document.forms[0], "tt")){
		return false;
	}
	var obj1=document.getElementsByName("register.order")[0];
	if(!isPlusInteger(obj1.value)){
		var ss=" 所在位置";
		alert(ss+" 为正数");
		return false;
	}
	obj1=document.getElementById("accelerys");
	if(obj1.innerHTML){ 
		var trs=obj1.getElementsByTagName("tr");
		if(trs.length>3){
			alert("只支持一个zip附件");
			return false;
		}
		obj1=trs[2].getElementsByTagName("td")[0];
		if(obj1.innerText.indexOf(".zip")==-1){
			alert("只支持一个zip附件");
			return false;
		}
		return true;
	}else{
		alert("需要一个zip附件");
			return false;
	}
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