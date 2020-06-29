<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<title></title>
		<link href="<%=request.getContextPath()%>/styles/main/ais.css"
			rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css"
			rel="stylesheet" type="text/css">
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript"
			src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/calendar.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<script language="javascript">
		
			function CheckSubmit(){
				if(!frmCheck(document.forms[0], "tab1"))
					return false;
				document.forms[0].action = "${contextPath}/report/jasper!auditCommission14.action";	
				if(document.all.ismax.checked){
					showreport.location.href = "${contextPath}/blank.jsp";
					document.forms[0].target = "_blank";
					document.forms[0].submit();
       			}else{
					document.forms[0].target = "showreport";
					document.forms[0].submit();
				}
			}

		</script>
	</head>
	<body>
		<table 
			class="ListTable">
			<tr class="listtablehead">
				<td align="left" class="edithead">
					<s:property
						escape="false" value="@ais.framework.util.NavigationUtil@getNavigation('/ais/report/jasper!enterAuditCommission14.action')" />
				</td>
			</tr>
		</table>
		<table id="tab1" class="ListTable">
			<s:form name="form">

				<tr class="listtablehead">
					<td class="listtabletr11">
						选择年度
						<FONT color=red>*</FONT>
					</td>
					<td align="left" class="ListTableTr22">
						<s:select name="year"
							list="#@java.util.LinkedHashMap@{'':'','2005':'2005','2006':'2006','2007':'2007','2008':'2008','2009':'2009','2010':'2010','2011':'2011','2012':'2012','2013':'2013','2014':'2014','2015':'2015'}"
							required="true"></s:select>
					</td>
					<td align="left" class="listtabletr11">
						输出格式：
					</td>
					<td align="left" class="ListTableTr22">
						<s:select name="reportType" list="#@java.util.LinkedHashMap@{'htm':'HTML','xls':'EXCEL'}"
							required="true"></s:select>
					</td>
					<td align="left" class="listtabletr11">
						新窗口显示
					</td>
					<td class="ListTableTr22" style='width:30%;'>
						<input type="checkbox" name="ismax">
					</td>
				</tr>
				<tr class="listtablehead" align="right">
					<td colspan="6" align="right" class="ListTableTr22">
						<div align="right">
							<s:button value="明细查询" onclick="return CheckSubmit();"></s:button>
						</div>

					</td>
				</tr>
			</s:form>
		</table>
		<table class="its">
			<tr>
				<td>
					<iframe allowtransparency="true" style="z-Index: 1"
						name="showreport" src="<%=request.getContextPath()%>/blank.jsp"
						frameborder="0" scrolling="auto" width="100%" height="400"></iframe>
				</td>
			</tr>
		</table>
	</body>
</html>
