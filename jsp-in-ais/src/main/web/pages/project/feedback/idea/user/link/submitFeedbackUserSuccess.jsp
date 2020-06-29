<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
			<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	
		<title>成功</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<SCRIPT type="text/javascript"
			src="${contextPath}/scripts/calendar.js"></SCRIPT>
			
			
			
			<script>
			
			function winClose(){
			
			window.opener.refresh();
			
			window.close();//关闭窗口
			
			}
			</script>

	</head>
	<body>
		<center>


			<s:form action="submitIdea" namespace="/project/report">
			<!-- 引入项目的信息 -->

				<table cellpadding=0 cellspacing=1 border=0 bgcolor="#409cce"
					class="ListTable">
					<tr class="listtablehead">
						<td colspan="4" align="center" class="edithead">
							<font color="red">&nbsp;提交成功!请确认.</font>
						</td>
					</tr>
					
					</table>
					
					<s:button  title="关闭本窗口！"  value="确 认"  onclick="winClose()"  />

			</s:form>

		</center>
	</body>
</html>
