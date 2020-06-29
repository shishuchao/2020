
/**
 * @author wangyuan
 */
 
//验证是否选择记录
function delOrEdit(checkboxName,name){
	var entries = document.getElementsByName(checkboxName);
	var count = 0;
	for(var i=0; i<entries.length; i++){
		if(entries[i].checked == true)
			count++;
	}
	if(count == 0){
		 alert("没有选择要删除的" + name+"!");
		 return false;			 	 		 	
	}
	if(count>0 && confirm("确定删除吗？")){
		return true;
	}else{
		return false;
	}
	return true;
}

//全选 反选
function selall_inform(name, selected){
	var checkbox = document.getElementsByName(name);
	for(var i=0; i<checkbox.length; i++){
		checkbox[i].checked = selected;
	}
}
