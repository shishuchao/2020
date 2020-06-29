
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<s:text id="title" name="'工作总结查看'"></s:text>





<html>
	<script language="javascript">
function backList(){
//返回上级list页面
	var url = "${contextPath}/plan/worksummarize/list.action";
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
			<s:form id="myform" action="view" namespace="/plan/worksummarize">

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
							标题:
						</td>
						<td>
							<s:property value="workSummarize.title" />
						</td>
					</tr>
					<tr class="titletable1">
						<td>
							总结类别:
						</td>
						<td>
							<s:property value="workSummarize.summarizeType" />
						</td>
					</tr>
					<tr class="titletable1">
						<td>
							提交时间:
						</td>
						<td>
							<s:property value="workSummarize.submitTime" />
						</td>
					</tr>

				</table>
				<div id="fjList" align="left">
					<s:property escape="false" value="accessoryList" />
				</div>
				<s:hidden name="personalProgramme.fjid"></s:hidden>
				<s:hidden name="workSummarize.id" />
				<s:button value="关闭" onclick="javascript:window.close();" />
			</s:form>

		</center>
	</body>
</html>
