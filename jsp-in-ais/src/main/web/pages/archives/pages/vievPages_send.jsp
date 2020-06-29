<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:directive.page import="ais.framework.util.NavigationUtil" />
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<base target="_self">
	<!-- 注意：在模态窗口里面提交必须有这个 -->

	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>文书档案编辑</title>
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
			
			
			<!-- 引入dwr的js文件 -->
		<script type='text/javascript' src='/ais/js/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='/ais/dwr/engine.js'></script>
		<script type='text/javascript' src='/ais/dwr/util.js'></script>


		<script type="text/javascript">
function returnBackWindows(){
var pages_type = '<s:property value="pages_type" />';
var url = "${contextPath}/archives/pages/listPages.action?pages_type="+pages_type;
window.location = url;
}

function returnBackWindows_inquire(){
var pages_type = '<s:property value="pages_type" />';
var url = "${contextPath}/archives/pages/listPages_inquire.action?pages_type="+pages_type;
window.location = url;
}
		</script>

	</head>

	<body>

		<center>

			<table width="100%">
				<tr class="listtablehead">
					<td colspan="5" align="left" class="edithead">
						查看发文文书
					</td>
				</tr>
			</table>
			<s:form action="savePages"
				namespace="/archives/pages"  name="myform">

			<center>
			<table id="planTable" cellpadding=0 cellspacing=1 border=0
				bgcolor="#409cce" class="ListTable">
				<tr class="listtablehead">
					<td colspan="4" align="left" class="edithead">
						文书信息
					</td>
				</tr>

				<tr>
					<td class="listtabletr1">
						<font color="red">*</font>文书名称：
					</td>
					<td class="listtabletr22" colspan="3">
					<s:property value="archivesPagesObject.pages_name" />
					</td>
				</tr>
				
				<tr>
					<td class="listtabletr1">
						<font color="red">*</font>文号：
					</td>
					<td class="listtabletr22">
					<s:property value="archivesPagesObject.pages_code" />
					</td>

					<td class="listtabletr1">
						<font color="red">*</font>文书保存年限（年）：
					</td>
					<td class="listtabletr22">
					<s:property value="archivesPagesObject.pages_year" />
					</td>
				</tr>

				<tr>

					<td class="listtabletr1">
						<font color="red">*</font>文书类别：
					</td>
					<td class="listtabletr22">
						<s:property value="archivesPagesObject.pages_kind_name" />
					</td>

					<td class="listtabletr1">
						<font color="red">*</font>归档时间：
					</td>
					<td class="listtabletr22">
					<s:property value="archivesPagesObject.pages_time" />
					</td>
				</tr>



				<tr>


					<td class="listtabletr1">
						<font color="red">*</font>归档人：
					</td>
					<td class="listtabletr22">
					<s:property value="archivesPagesObject.pages_user_name" />
					</td>


					<td class="listtabletr1">
						<font color="red">*</font>归档部门：
					</td>
					<td class="listtabletr22">
					<s:property value="archivesPagesObject.pages_depName" />
					</td>
				</tr>

				<tr>
					<td class="listtabletr1">
					收发文类型：
					</td>
					
					<s:if test="${pages_type=='0'}">
					<td class="listtabletr22">
					收文
					</td>
					
					<td class="listtabletr1">
						<font color="red">*</font>发文部门：
					</td>
					<td class="listtabletr22">
					<s:property value="archivesPagesObject.send_depName" />
					</td>
					
					</s:if>
					<s:else>
					<td class="listtabletr22" colspan="3">
					发文
					</td>
					</s:else>
				</tr>
			</table>
		</center>
		<center>
<br>
					&nbsp;&nbsp;&nbsp;<div id="accelerys" align="left"
								style="margin-left: 10px">
								<s:property escape="false" value="accessoryList_send" />
							</div>
				<br>
				<br>
				</center>

					<center>
				<div align="center" style="width:97%">
				<s:if test="pages_inquire!=null && pages_inquire=='true'">
					<s:button value="返 回" onclick="returnBackWindows_inquire();"></s:button>
				</s:if>
				<s:else>
				<s:button value="返 回" onclick="returnBackWindows();"></s:button>
				</s:else>
					&nbsp;&nbsp;
				</div>
		</center>

<!-- 隐藏字段 -->
				<s:hidden name="pages_type" />
			</s:form>
		</center>
	</body>
</html>




