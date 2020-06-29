<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title></title>
</head>
<body onload="reWin()">

</body>
<script type="text/javascript">
function reWin(){
//window.opener.parent.location.reload();window.close()
//window.returnValue="这里存放返回的结果";
var arg=window.dialogArguments;
arg.win.refreshWindow();
window.close();
}
</script>
</html>