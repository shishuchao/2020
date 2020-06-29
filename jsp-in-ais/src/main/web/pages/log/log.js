function chkSearchLog(){
	var obj=$_name("log2.orgName");
	if(obj.value.length>0)
		if(!check_zh(obj)){ alert("组织机构 只能输入汉字!"); return false;}
	obj=$_name("log2.chiname");
	if(obj.value.length>0){
		if(obj.value.length>28){alert("操作人员 数据超长!");return false;}
	}
	obj=$_name("log2.oppType");
	if(obj.value.length>0)
		if(!check_zh(obj)){ alert("操作类型 只能输入汉字!");return false;}
	obj=$_name("ipAddress");
	/*
	obj=$_name("ipMask");
	if(obj.value.length>0){
		var reg=/^[0-9]{1,2}$/;
		if(!(reg.test(obj.value)&&obj.value<32&&obj.value>0)){alert("子网掩码 请输入0~31之间的数字");return false;}
	}
	if(obj.value.length>0){
		var reg=/^[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}$/;
		if(!reg.test(obj.value)||obj.split(".")[0]==0){alert("子网掩码 格式为 255.255.255.0!");return false;}
	}
	*/
	obj=$_name("log2.description");
	if(obj.value.length>20){alert("描述信息 的内容不要超过20个字!");return false;}
	return true;
}
function bindClick(obj,func){
	var trs=obj.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
	var tds;
	var temp;
	for(var i=0;i<trs.length;i++){
		tds=trs[i].getElementsByTagName("td");
		for(var j=0;j<tds.length;j++){
			tds[j].onclick=function(){
				if(temp) temp.style.color="";
				this.style.color="red";
				temp=this;
				func(this);
			}
			tds[j].onmouseover=function(){
				var tdss=this.parentNode.getElementsByTagName("td");
				if(tdss.length>1){
					this.title="ip:"+tdss[tdss.length-2].innerHTML;
					this.title+="\r\n描述信息:\r\n   "+tdss[tdss.length-1].innerHTML;
				}
				
			}
		}
	}
}
function showMessage(){
	var tds=arguments[0].parentNode.getElementsByTagName("td");
	$_id("jsip").value=tds[tds.length-2].innerHTML;
	$_id("jsDes").value=tds[tds.length-1].innerHTML;
	arguments[0].parentNode.title="888888";
}
function chkFixInfo(isSearch,tableId,showinfo,hiddenInfo){
	if(isSearch){
		fixInfo(tableId,showinfo,hiddenInfo);
		return true;
	}else{
		alert("请先查询之后在进行结果汇总!");
		return false;
	}
}
//查询结果汇总
function fixInfo(){
	var trs=$_id(arguments[0]).getElementsByTagName("tr");
	var tds;
	var info_view="";
	var info_hidden="";
	var temp_text;
	var temp;
	for(var i=0;i<trs.length;i++){
		tds=trs[i].getElementsByTagName("td");
		for(var j=0;j<tds.length;j++){
			if(j%2==0){
				temp_text=tds[j].innerHTML;
			}else{
				temp=tds[j].firstChild.value;
				if(temp.length<1) continue;			
				info_hidden+=tds[j].firstChild.name;
				info_hidden+=":"+temp+";";
				if(info_view.length>1) info_view+=" 并且 ";
				info_view+=temp_text+' 为 "'+temp+'"';
			}
		}
	}
	$_id(arguments[1]).value=info_view;
	//$_id(arguments[2]).value=info_hidden.substring(0,info_hidden.length-1);
}
function check_zh(obj){
	if (/^[\u4e00-\u9fa5]+$/.test(obj.value)) {return true;}
	return false;
}
function check_IP(obj) { 
    var re=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/; //匹配IP地址的正则表达式
	if(re.test( obj.value )){
		if( RegExp.$1 <256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256) return true;
	}
	return false; 
}

function $_id(id){
	return document.getElementById(id);
}
function $_name(name){
	return document.getElementsByName(name)[0];
}
//全选
function selAll(name){
	var objs=document.getElementsByName(name);
	for(var n=0;n<objs.length;n++){
		objs[n].checked=true;
	}
}