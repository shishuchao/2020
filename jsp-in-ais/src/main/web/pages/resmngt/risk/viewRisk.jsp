<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<s:text id="title" name="查看风险报告"></s:text>
<html>
	<head>
		<title><s:property value="title"/></title> 
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
</head>
	<body leftmargin="0" topmargin="0" bottommargin="0">
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
			class="ListTable" width="100%" align="center">
			<tr class="listtablehead">
				<td colspan="4" class="edithead"
					style="text-align: left; width: 100%;">
					<div style="display: inline; width: 80%;">
						<s:property escape="false"
							value="@ais.framework.util.NavigationUtil@getNavigation('/ais/resmngt/risk/index4view.action')" />-->
							<s:property value="title"/>
					</div>
					<div style="display: inline; width: 20%; text-align: right;">
						<a href="javascript:;" onclick="triggerSearchTable();">&nbsp;</a>
					</div>
				</td>
			</tr>
		</table>
		<center>
				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable" id="mytable">
					<tr>
						<td class="listtabletr11" nowrap="nowrap">
							年度
							<font color="red">*</font>
						</td>
						<td class="listtabletr22">
							<s:property value="risk.year"/>
						</td>
						<td class="listtabletr11">
							风险报告名称<font color="red">*</font>
						</td>
						<td class="listtabletr22">
							<s:property value="risk.title"/>
						</td>
					</tr>
					<tr>
						<%--<td class="listtabletr11" nowrap="nowrap">
							风险因素
							<font color="red">*</font>
						</td>
						<td class="listtabletr22">
							<s:property value="risk.sourceType"/>：<s:property value="risk.reason"/>
						</td>
						--%><td class="listtabletr11">
							上传时间
						</td>
						<td class="listtabletr22" id="effect">
							${fn:substring(risk.uploadTime,0,10)}
						</td>
						<td class="listtabletr11">
							风险报告人
						</td>
						<td class="listtabletr22">
							<s:property value="risk.uploaderName"/> 
						</td>
					</tr>	
					<tr>
						<td class="listtabletr11" >
							单位
						</td>
						<td class="listtabletr22">
							<s:property value="risk.uploadDeptName"/>
						</td>
						<td class="listtabletr11">
						</td>
						<td class="listtabletr22">
						</td>
					</tr>
				</table>
				<div id="accelerys" align="center">
					<s:property escape="false" value="accessoryList" />
				</div>
				<br>				
				<table style="width:97%;border:0" >
					<tr>
						<td>
							<span style="float:right;">
								<input type="button" name="back" value="返回" onclick="javascript:document.location='${contextPath}/resmngt/risk/index4view.action?helper.risk.riskType=${riskTypeId}'">
							</span>
						</td>
					</tr>
				</table>
		</center>
	</body>

</html>