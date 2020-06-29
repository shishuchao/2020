/*
只能是数字
*/
function isDigit(obj){ 
			var o = document.getElementById(obj);
			var s = o.value;
			var patrn=/^[0-9]{1,20}$/; 
			if (!patrn.exec(s)) {
				showMessage1('代码（编号）只允许是数字！请重新输入');
				o.value='';
				o.focus();
				return false 
			}
			return true 
} 

/*
判断长度
*/	
function lengthVal(obj, len){
		var tmp = document.getElementById(obj);
		if(tmp.value.length != len){
			showMessage1('代码（编号）长度只能是'+len+ '位');
			tmp.focus();
			return false;
		}
		return true;
}
