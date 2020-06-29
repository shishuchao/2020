<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link href="<%=request.getContextPath()%>/resources/css/site.css"
			rel="stylesheet" type="text/css">
		<%--<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">--%>
		<title></title>
		<SCRIPT type="text/javascript">
	function mchange(){
		var s=document.getElementsByName('paraIds')[0];
		//document.getElementsByName('paraIds')[0].value=s.value.replace("，",",");
		s.value=s.value.replace("，",",");
		document.forms[0].submit();
	}
	function doClose(){
	window.parent.close();
		//window.parent.parent.hidePopWin(false);
	}
</SCRIPT>
	</head>
	<body>
		<s:form action="saveToAum" namespace="/system"
			>
			<s:if test="${empty(view) or user.floginname=='admin'}">
				 <table border=0 cellspacing=1 cellpadding=1 width=95% >
	<tr>
	<td width=60%>
	<td>
	<div id="select" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/save.gif" Background="#D2E9FF" Text="保存" onclick="mchange()"></div>
	</td>
	<td width=10 nowrap></td>
	<td>
	<div id="cancel1" class="imgbtn" Imgsrc="<%=request.getContextPath()%>/resources/images/cancel.gif" Background="#D2E9FF" Text="取消" onclick="doClose()"></div>
	</td>
	<td width=10 nowrap></td>
	<td>						
	</td>
	</tr>
	</table>
</s:if>
			
			<table width="100%" class="ListTable" border=0 cellpadding=1
				cellspacing=1>
				<tr class="titletable1">
					<td style="vertical-align: middle; text-align: center;" nowrap="nowrap">
						授权数据
					</td>
					<td style="vertical-align: middle;" nowrap="nowrap">
						<s:if test="${empty(view) or user.floginname=='admin'}">
							<input type="text" name="paraIds" value="<s:property value="paraIds"/>">
						</s:if>
						<s:else>
						<input type="text" name="paraIds" value="<s:property value="paraIds"/>" disabled="disabled">
						</s:else>
						<a href="javascript:;" title="多个数据要用英文逗号分割">&nbsp;&nbsp;&nbsp;&nbsp;<font
							color="blue">提示</font>
						</a>
					</td>
				</tr>
				
			</table>
			
			<s:hidden name="fmoduleId"></s:hidden>
			<s:hidden name="selectedLoginName"></s:hidden>
			<s:hidden name="companyId" value="${companyId}"></s:hidden>
			<s:hidden name="fscopecode" value="${fscopecode}"></s:hidden>
		</s:form>
	</body>
</html>