<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
</head>
<body>

<script type="text/javascript">
	
	/**
	*	Cell插件是否已经安装
	*/
	function isCellInstalled(){
		try{
			var cell = new ActiveXObject('Cell.Cell50Ctrl.1');
			var cellWeb = new ActiveXObject('CELLWEB5.CellWebCtrl.1');
			var cellMenu = new ActiveXObject('MENU.MenuCtrl.1');
			return true;
		}catch(e){
			return false;
		}
	}

	alert(isCellInstalled());
	
	/**
	*	金格插件是否已经安装
	*/
	function isIWebOfficeInstalled(){
		try{
			var iWebOffice = new ActiveXObject('iWebOffice2003.iWebOffice');
			return true;
		}catch(e){
			return false;
		}
	}

	alert(isIWebOfficeInstalled());
	
</script>

</body>
</html>