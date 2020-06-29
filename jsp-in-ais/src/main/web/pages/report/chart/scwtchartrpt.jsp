<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title></title>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
			<link rel="stylesheet" type="text/css"
			href="${contextPath}/resources/csswin/subModal.css" />
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script language="javascript">
		
			function CheckSubmit(){
				if(!frmCheck(document.forms[0], "tab1"))
					return false;
					<s:if test="ftype==1">
				document.forms[0].action = "${contextPath}/report/scwtChartReportAction!tongJiChart.action";	
				</s:if>
				<s:if test="ftype==2">
				document.forms[0].action = "${contextPath}/report/scwtChartReportAction!tongQiChart.action";	
				</s:if>
				<s:if test="ftype==3">
				document.forms[0].action = "${contextPath}/report/scwtChartReportAction!gouChengChart.action";	
				</s:if>
				
				if(document.all.ismax.checked){
					showreport.location.href = "${contextPath}/blank.jsp";
					document.forms[0].target = "_blank";
					document.forms[0].submit();
       			}else{
					document.forms[0].target = "showreport";
					document.forms[0].submit();
				}
			}
			function setfmid(obj,name){
			var str;
			str=obj.options[obj.selectedIndex].text;
			document.getElementsByName(name)[0].value=str;
			}
		</script>
	</head>
	<body>
		<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
			<tr class="listtablehead">
				<td  align="left" class="edithead">
					<s:property escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/scwtChartReportAction!ChartCfg.action?ftype=${ftype}')"/>
				</td>
			</tr>
		</table>
		<table id="tab1" cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
			<s:form name="form">
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						审计单位：
						<FONT color=red>*</FONT>
					</td>
					<td align="left" class="ListTableTr22">
			<s:buttonText name="fcompanyname"
								cssStyle="width:90%" hiddenName="fcompanyid"
								doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/systemnew/orgList.action&p_item=1&orgtype=1&paraname=fcompanyname&paraid=fcompanyid&param='+rnm,600,350,'所属单位')"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true"
								/>
					</td>
					<td class="listtabletr1">被审计单位：
						<FONT color=red>*</FONT></td>
					<td class="ListTableTr22">
					<s:buttonText name="faudobjname"
								cssStyle="width:90%" hiddenName="faudobjid"
								doubleOnclick="showPopWin('/pages/system/search/searchdata.jsp?url=/mng/audobj/object/objselecttree.action&paraname=faudobjname&paraid=faudobjid&showRootNode=_show',600,350,'所属单位')"
								doubleSrc="/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true"
								/>
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						审计时间：<FONT color=red>*</FONT>
					</td>
					<td align="left" class="ListTableTr22">
					<s:if test="ftype==2">
						<s:select name="fyear" list="{'2007','2008','2009','2010'}" cssStyle="width:20%" emptyOption="true"></s:select>年
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<s:select name="fmonth" list="#@java.util.LinkedHashMap@{'0':'全年','1':'1季度','2':'2季度','3':'3季度','4':'4季度'}" required="true"></s:select>季度
					</s:if>
					<s:else>
					<s:select name="fyear" list="{'2007','2008','2009','2010'}" cssStyle="width:20%" emptyOption="true"></s:select>年
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<s:select name="fmonth" list="#@java.util.LinkedHashMap@{'0':'全年','1':'1月','2':'2月','3':'3月','4':'4月','5':'5月','6':'6月','7':'7月','8':'8月','9':'9月','10':'10月','11':'11月','12':'12月'}" required="true"></s:select>月
					</s:else>
					</td>
					<td class="listtabletr1">审计问题：
						<FONT color=red>*</FONT></td>
					<td class="ListTableTr22">
					<s:select  name="fpcode"
								list="problemList" listKey="code" emptyOption="true"
								listValue="name" display="true" theme="ufaud_simple"
								templateDir="/strutsTemplate" onchange="setfmid(this,'fpname');"/>
						<s:hidden name="fpname"/>
					</td>
				</tr>
				<tr class="listtablehead">
					<td align="left" class="listtabletr1">
						<input type="checkbox" name="ismax">
						新窗口显示
					</td>
					<td align="left" class="ListTableTr22">
					</td>
					<td class="listtabletr1"></td>
					<td class="ListTableTr22"></td>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="ListTableTr22">
						<div align="right">
							<s:button  value="查询" onclick="return CheckSubmit();"></s:button>
						</div>
					</td>
				</tr>
			</s:form>
		</table>
		<table class="its">
			<tr>
				<td>
					<iframe allowtransparency="true" align="center"  name="showreport" src="<%=request.getContextPath()%>/blank.jsp" frameborder="0" scrolling="auto" width="100%" height="400"></iframe>
				</td>
			</tr>
		</table>
	</body>
</html>
