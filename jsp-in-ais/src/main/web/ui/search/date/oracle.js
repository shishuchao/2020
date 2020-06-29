function getDateStr(str){
	return "to_date('"+str+"','yyyy-mm-dd')";
}
function getDateStr2(str){//时间戳
	return "to_date('"+str+"','yyyy-MM-dd HH24:mi:ss')" ;
}