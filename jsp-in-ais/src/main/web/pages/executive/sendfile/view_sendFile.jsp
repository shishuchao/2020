<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<s:text id="title" name="'行政发文查看'"></s:text>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><s:property value="#title" /></title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<s:head />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css">
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

			<s:form id="myform" action="view"
				namespace="/executive/sendfile">
				<table cellpadding=1 cellspacing=1 border=0 bgcolor="#409cce" class="ListTable">
					<tr class="titletable1">
						<td>
							签发人:
						</td>
						<td>
							<s:property value="crudObject.signerName" />
							<s:hidden name="crudObject.signerId"></s:hidden>
						</td>
						<td>
							拟稿人:
						</td>
						<td>
							<s:property value="crudObject.writerName" />
							<s:hidden name="crudObject.writerId"></s:hidden>
						</td>
					</tr>
					<tr class="titletable1">
						<td>
							签发人意见:
						</td>
						<td>
							<s:property value="crudObject.signerSuggest" />
						</td>
						<td>
							拟稿人部门:
						</td>
						<td>
							<s:property value="crudObject.writerDept" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>
							发文字号:
						</td>
						<td colspan="3">
							<s:property value="crudObject.sendFileNO" />
						</td>
					</tr>
					<tr class="titletable1">
						<td>
							编号日期:
						</td>
						<td>
							<s:property value="crudObject.refeDate" />
						</td>
						<td>
							签发日期:
						</td>
						<td>
							<s:property value="crudObject.signerDate" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>
							紧急程度:
						</td>
						<td>
							<s:property value="crudObject.emergencyLevel" />
						</td>
						<td>
							保密等级:
						</td>
						<td>
							<s:property value="crudObject.securityLevel" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>
							主送:
						</td>
						<td colspan="3">
							<s:property value="crudObject.mainSend" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							抄送:
						</td>
						<td colspan="3">
							<s:property value="crudObject.copySend" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							标题:
						</td>
						<td colspan="3">
							<s:property value="crudObject.title" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							主题词:
						</td>
						<td colspan="3">
							<s:property value="crudObject.mainWord" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							文种:
						</td>
						<td colspan="3">
							<s:property value="crudObject.recordType" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							附注:
						</td>
						<td colspan="3">
							<s:property value="crudObject.annotations" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							阅读范围:
						</td>
						<td colspan="3">
							<s:property value="crudObject.readScope" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							印发单位:
						</td>
						<td colspan="3">
							<s:property value="crudObject.publishUnit" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							创建时间:
						</td>
						<td colspan="3">
							<s:property value="crudObject.createTime" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							送达时间:
						</td>
						<td colspan="3">
							<s:property value="crudObject.endTime" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							备注:
						</td>
						<td colspan="3">
							<s:property value="crudObject.backup" />
						</td>
					</tr>

<!-- 
					<tr class="titletable1">
						<td>
							当前任务:
						</td>
						<td>
							<s:property value="crudObject.currentTask" />
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


					<tr class="titletable1">
						<td>
							阅件用户:
						</td>
						<td>
							<s:property value="crudObject.readUser" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							已阅人员:
						</td>
						<td>
							<s:property value="crudObject.readedPerson" />
						</td>
					</tr>
 -->
				</table>
				
				<div id="fjList" align="left">
					<s:property escape="false" value="accessoryList" />
				</div>
				<s:hidden name="crudObject.fjid"></s:hidden>
				
				<s:hidden name="crudObject.id" />
				<s:button value="关闭" onclick="javascript:window.close();" />
			</s:form>

		</center>
	</body>
</html>
