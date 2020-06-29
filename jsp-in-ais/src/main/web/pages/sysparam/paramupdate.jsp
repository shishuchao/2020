<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link href="<%=request.getContextPath()%>/css/blue/ufaud.css"
		rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/styles/main/ais.css"
		rel="stylesheet" type="text/css">

	<link href="<%=request.getContextPath()%>/displaytag/maven-base.css"
		rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/displaytag/maven-theme.css"
		rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/displaytag/site.css"
		rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/displaytag/screen.css"
		rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/displaytag/print.css"
		rel="stylesheet" type="text/css">
	<script language="javascript">
	function doSave(){
		document.forms[0].submit();
		return true;
	}
	function doBack(){
		
	}
</script>
	</head>
	<body>
		<s:form id="dataForm" action="sysParamAction!paramSave" method="post" namespace="/sysparam" theme="simple">
			
			<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" style="width:96%;" class="ListTable">
				<tr class="titletable1">
					<td>
						参数编码
					</td>
					<td>
						${sysParamDetail.fpcode}
					</td>
				</tr>
				<tr class="titletable1">
					<td>
						参数名称
					</td>
					<td>
						${sysParamDetail.fpname}
					</td>
				</tr>
				<tr class="titletable1">
					<td>
					参数值<font color="red">*</font>
					</td>
					<td>
						<s:textfield name="sysParamDetail.frealvalue" />
					</td>
				</tr>
				<tr class="titletable1">
					<td>
						参数说明
					</td>
					<td>
						${sysParamDetail.fpdesc}
					</td>
				</tr>
			</table>
			<s:hidden name="sysParamDetail.fid" />
			<s:hidden name="sysParamDetail.fkid" />
			<table style="width: 97%; border: 0">
				<tr>
					<td>
						<span style="float: right;"> 
						<input type="button" value="保存"  align="right"  onclick="return doSave();"> 
						<input type="button" name="add" value="返回" onclick="goBack();"> 
						</span>
					</td>
				</tr>
			</table>
		</s:form>
	</body>
</html>
