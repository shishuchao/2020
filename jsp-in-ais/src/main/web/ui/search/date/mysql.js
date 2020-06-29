function getDateStr(str){
	return "'"+str+"'";
}
function getDateStr2(str){//时间戳
	return "DATE_FORMAT('"+str+"','%y-%m-%d %H:%i:%S')";
}