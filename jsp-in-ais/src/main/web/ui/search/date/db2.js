function getDateStr(str){
	return "'"+str+"'";
}
function getDateStr2(str){//时间戳
	return "to_date('"+str+" 00:00:00','YYYY-MM-DD HH24:MI:SS')";
}