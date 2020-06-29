<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<frameset rows="*" cols="15%,85%" frameborder="NO" border="0"  framespacing="0">
	<frame frameborder="0" id="left" name="left" src="<%=request.getContextPath()%>/report/apply/regAction!tree.action?apply=${apply}">
	<frame frameborder="0" id="right" name="right" width="100%" src="">
</frameset>
<noframes><body>
对不起，您的浏览器不支持框架。请采用IE6.0以上版本浏览器进行浏览......
</body></noframes>
</html>