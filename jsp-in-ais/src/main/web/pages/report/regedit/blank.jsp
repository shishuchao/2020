<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
			<s:if test="${flush}">
				function flushLeft(){
					window.parent.left.location.reload();
				}
				flushLeft();
			</s:if>
		</script>
		<title></title>
	</head>
	<body>

	</body>
</html>