
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<s:text id="title" name="'个人计划查看'"></s:text>





<html>
	<script language="javascript">
function backList(){
//返回上级list页面
	var url = "${contextPath}/plan/personalProgramme/personalProgramme/list.action";
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
				namespace="/plan/personalProgramme/personalProgramme">

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
							<s:property value="personalProgramme.title" />
						</td>
					</tr>
					<tr class="titletable1">
						<td>
							开始时间:
						</td>
						<td>
							<s:property value="personalProgramme.startTime" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							结束时间:
						</td>
						<td>
							<s:property value="personalProgramme.endTime" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							参与人:
						</td>
						<td>
							<s:property value="personalProgramme.parter" />
						</td>
					</tr>


					<tr class="titletable1">
						<td>
							是否提醒:
						</td>
						<td>
							<s:if test="${personalProgramme.isRemind == 'Y'}">
								是
							</s:if>
							<s:elseif test="${personalProgramme.isRemind == 'N'}">
								否
							</s:elseif>
							<s:else>
								<s:property value="personalProgramme.isRemind" />
							</s:else>
						</td>
					</tr>
					
					<tr class="titletable1">
						<td>
							提醒时间:
						</td>
						<td>
							<s:property value="personalProgramme.remindTime" />
						</td>
					</tr>

					<tr class="titletable1">
						<td>
							计划内容:
						</td>
						<td>
							<s:property value="personalProgramme.programmeContent" />
						</td>
					</tr>

				</table>
				<div id="fjList" align="left">
					<s:property escape="false" value="accessoryList"/>
				</div>
					<s:hidden name="personalProgramme.fjid"></s:hidden>		
				</table>
				<s:hidden name="personalProgramme.id" />
				<s:button value="关闭" onclick="javascript:window.close();" />
			</s:form>

		</center>
	</body>
</html>
