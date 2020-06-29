<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<s:text id="title" name="'会议通知查看'"></s:text>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
		<s:head />
	</head>
	<body>
		<center>
			<table>
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						&nbsp;
						<s:property value="#title" />
					</td>
				</tr>
			</table>

			<s:form id="myform" action="view.action" namespace="/plan/meeting">
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="titletable1">
						<td>
							起草人:
						</td>
						<td>
							<s:property value="crudObject.draftsmanName" />
							<s:hidden name="crudObject.draftsmanId"></s:hidden>
						</td>
						<td>
							发布日期:
						</td>
						<td>
							<s:property value="crudObject.pubDate" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>
							召开日期:
						</td>
						<td>
							<s:property value="crudObject.callDate" />
						</td>
						<td>
							开始时间:
						</td>
						<td>
							<s:property value="crudObject.startTime" />
						</td>

					</tr>

					<tr class="titletable1">
						<td>
							结束日期:
						</td>
						<td>
							<s:property value="crudObject.endDate" />
						</td>
						<td>
							结束时间:
						</td>
						<td>
							<s:property value="crudObject.endTime" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>
							召集单位:
						</td>
						<td>
							<s:property value="crudObject.sumUnit" />
						</td>
						<td>
							主持人:
						</td>
						<td>
							<s:property value="crudObject.compereName" />
							<s:hidden name="crudObject.compereId" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>
							地点:
						</td>
						<td colspan="3">
							<s:property value="crudObject.locate" />
						</td>

					</tr>
					<tr class="titletable1">
						<td>
							参加人员:
						</td>
						<td colspan="3">
							<s:property value="crudObject.joiner" />
						</td>
					</tr>
					<tr class="titletable1">
						<td>
							会议名称:
						</td>
						<td colspan="3">
							<s:property value="crudObject.meetingName" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							会议议题:
						</td>
						<td colspan="3">
							<s:property value="crudObject.meetingTitle" />
						</td>
					</tr>


<!--					<tr class="titletable1">
						<td>
							任务状态:
						</td>
						<td>
							<s:property value="crudObject.taskStats" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							处理人意见:
						</td>
						<td>
							<s:property value="crudObject.handerSuggest" />
						</td>
					</tr>
-->
				</table>
				<s:button value="关闭" onclick="javascript:window.close();" />
			</s:form>
		</center>
	</body>
</html>
