<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
	    <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<title>错误</title>
		<s:head />
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
	</head>
	<body>
		<center>


			<s:form action="edit" namespace="/archives/borrow" name="form">	

				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="4" align="center" class="edithead">
							信息：<font color="red">&nbsp;对不起！档案借阅流程中，借阅档案没有授权，请授权完毕后再提交。</font>
						</td>
					</tr>

				</table>
				<s:submit  title="返回"  value="返 回" />
				<s:hidden name="crudId" />
				<s:hidden name="taskInstanceId" />
				<s:hidden name="arg_process_id" />
				<s:hidden name="crudObject.formId" />
			</s:form>

		</center>
	</body>
</html>
