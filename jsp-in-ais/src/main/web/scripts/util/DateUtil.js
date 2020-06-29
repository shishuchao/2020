
/*
	校验两个日期大小顺序
 */
function validateDate(beginDateId, endDateId,title) {
	var s1 = $('#' + beginDateId);
	var e1 = $('#' + endDateId);
	if (s1 && e1) {
		var s = s1.datebox('getValue');
		var e = e1.datebox('getValue');
		if (s != '' && e != '') {
			var s_date = new Date(s.replace("-", "/"));
			var e_date = new Date(e.replace("-", "/"));
			if (s_date.getTime() > e_date.getTime()) {
				$.messager.alert("错误", title);
				return false;
			}
		}
	}
	return true;
}

function getCurrentDate() {
	var now = new Date();
	var year = now.getFullYear();       //年
	var month = now.getMonth() + 1;     //月
	var day = now.getDate();            //日
	var clock = year + "-";
	if(month < 10)
		clock += "0";
	clock += month + "-";
	if(day < 10)
		clock += "0";
	clock += day;
	return clock;
}