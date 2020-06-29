<!DOCTYPE HTML>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		
		<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script language="javascript">
			function CheckSubmit(){
				if(!frmCheck(document.forms[0], "tab1"))
				return false;
				<s:if test="ftype==1">
				document.forms[0].action = "${contextPath}/report/sjryChartReportAction!diplomaChart.action";
				</s:if>
				<s:if test="ftype==2">
				document.forms[0].action = "${contextPath}/report/sjryChartReportAction!techPostChart.action";	
				</s:if>
				<s:if test="ftype==3">
				document.forms[0].action = "${contextPath}/report/sjryChartReportAction!specialityChart.action";	
				</s:if>
				<s:if test="ftype==4">
				document.forms[0].action = "${contextPath}/report/sjryChartReportAction!competenceChart.action";
				</s:if>
				document.forms[0].target = "showreport";
				document.forms[0].submit();
			}
			 var num=Math.random();
		     var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="north" title="查询条件" data-options="split:false" style="height:120px;overflow:hidden;">
		<s:form name="form">
		<table id="tab1"  class="ListTable">
				<tr >
					<td align="left" class="EditHead">
						审计单位：<FONT color=red>*</FONT>
					</td>
					<td align="left" class="editTd">
							<s:buttonText2 cssClass="noborder"
								name="fcompanyname" cssStyle="width:80%;"
								hiddenName="fcompanyid" 
								doubleOnclick="showSysTree(this,
									{ url:'${contextPath}/systemnew/orgListByAsyn.action',
									  title:'请选择审计单位',
									  param:{
	                                    'p_item':1,
	                                    'orgtype':1
	                                  }
									})"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" maxlength="100" />
						</td>

					<td align="left" class="EditHead">
						输出格式：
					</td>
					<td align="left" class="editTd">
						<s:select id ="reporttype" name="reporttype" cssClass="easyui-combobox" list="#@java.util.LinkedHashMap@{'bar':'柱形图','pie':'饼图'}" required="true"></s:select>
					</td>
				</tr>
<%--				<tr >--%>
<%--				<td align="left" class="EditHead">--%>
<%--						--%>
<%--						新窗口显示--%>
<%--					</td>--%>
<%--					<td align="left" class="editTd">--%>
<%--						<input type="checkbox" name="ismax">--%>
<%--					</td>--%>
<%--					<td></td><td></td>--%>
<%--				</tr>--%>
				<tr >
					<td colspan="6" align="right" class="EditHead">
						<div align="right"><a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="CheckSubmit()">查询</a>
						</div>
					</td>
				</tr>
		</table>
		</s:form>
		</div>
		<div region="center" >
		<table class="its" width="100%">
			<tr>
				<td align="center">
					<iframe allowtransparency="true" align="center"  name="showreport" src="<%=request.getContextPath()%>/blank.jsp" frameborder="0" scrolling="auto" width="100%" height="400"></iframe>
				</td>
			</tr>
		</table>
		</div>
	</body>
</html>
