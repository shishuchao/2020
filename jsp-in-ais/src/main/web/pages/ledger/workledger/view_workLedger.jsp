
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'审计工作台帐==>工作台帐查看'"></s:text>
<html>
	<script language="javascript">
function backList(){
//返回上级list页面
	var url = "${contextPath}/ledger/workLedger/list.action";
	myform.action = url;
	myform.submit();

}
</script>
	<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
		type="text/css">
	<head>
		<title><s:property value="#title" />
		</title>
		<s:head />
	</head>

	<body>
		<center>
			<s:form id="myform" action="view"
				namespace="/ledger/workLedger">

				<table>
					<tr class="listtablehead">
						<td colspan="5" align="left" class="edithead">
							&nbsp;
							<s:property value="#title" />
						</td>
					</tr>
				</table>



				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="titletable1">
						<td>
							工作名称
						</td>
						<td>
							<s:property value="workLedger.work_name" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>
							工作开始日期
						</td>
						<td>
							<s:property value="workLedger.work_startday" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							工作结束日期
						</td>
						<td>
							<s:property value="workLedger.work_endday" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>
							工作人
						</td>
						<td>
							<s:property value="workLedger.w_creator_name" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>
							工作部门名称
						</td>
						<td>
							<s:property value="workLedger.w_dept_name" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							记录时间
						</td>
						<td>
							<s:property value="workLedger.work_time" />
						</td>
					</tr>
					
					<tr class="titletable1">
						<td>
							工作描述
						</td>
						<td>
							<s:property value="workLedger.work_desc" />
						</td>
					</tr>
					
					<tr class="titletable1">
					<td>
					附件：
					</td>
					<td>
					<div id="fjList" align="left">
						<s:property escape="false" value="accessoryList" />
					</div>
					</td>
					</tr>
					<s:hidden name="workLedger.fjid"></s:hidden>
				</table>

				<s:hidden name="workLedger.id" />
				<s:button value="关闭" onclick="javascript:window.close();" />
			</s:form>

		</center>
	</body>
</html>
