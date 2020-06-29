<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">
			<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	
		<title>管理系统-下载公司制度</title>
		<s:head />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ais_functions.js"></script>

	<body>
		<center>
             <s:form action="mutualGeneralToWork" namespace="/interact/interactProxyToWork"   id="myform">
             			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						<s:property
							escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/interact/interactProxyToWork/generalDownLoad.action')" />
					</td>
				</tr>
			</table>

             <br>
              <s:submit  value="下载公司制度" />
              
            <br><br><br>
			<div align="center">
			<FIELDSET style="width:550" ><LEGEND><font color="blue">系统提示：</font></LEGEND>
			<font color="blue">请下载您所在公司以及经过授权公司的公司制度 </font>
			</FIELDSET>
			</div>
               
			</s:form>
		</center>
	</body>
</html>
