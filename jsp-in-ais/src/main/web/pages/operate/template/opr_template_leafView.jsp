<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://fckeditor.net/tags-fckeditor" prefix="FCK"%>

<%-- <s:text id="title" name="'查看审计事项'"></s:text> --%>

<html>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计方案维护事项详细内容查看</title>
		<s:head />
		<style type='text/css'>
			textarea { border-width:0px}
		</style>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#myform").find("textarea").each(function(){
					autoTextarea(this);
				});
			
			});
		</script>
	</head>

	<body class="easyui-layout" style="overflow:auto;" fit='true' border='0'>
		<center>
			<s:form id="myform" onsubmit="return true;" action="/ais/operate/template" method="post">

				<table class="ListTable">
					<tr>
						<td class="EditHead" style="width:20%">
							<font color="red"></font> 事项名称
						</td>
						<td colspan="3" class="editTd">
							<s:property value="audTaskTemplate.taskName" />
						</td>				 
					</tr>
					<tr style='display:none;'>
						<s:if test="'enabled' == '${shenjichengxu}'">
							<td class="EditHead">
							  &nbsp;&nbsp;&nbsp;程序编码
							 </td>
							<td class="editTd" colspan="3">
								<s:property value="audTaskTemplate.taskCode" />
							</td>							 
						</s:if>
						<s:else >
							<td class="EditHead" >
						      &nbsp;&nbsp;&nbsp;事项编码
						    </td>
						    <td class="editTd" colspan="3">
						    	<s:if test="${audTaskTemplate.templateId == null}">
						    		<s:property value="audTaskTemplate.taskCode" />
						    	</s:if>
						    	<s:else>
						    		<s:property value="audTaskTemplate.taskCode" />
						    	</s:else>
							</td>
						</s:else>
					</tr>
					<tr>
						<td class="EditHead">
							审计程序和方法
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" disabled="true" name="audTaskTemplate.taskOther" cssStyle="border-width:0px;width:98%;overflow-y:visible;line-height:150%;color:#000;background:#fff" />
						</td>
					</tr>
				    <tr>
						<td class="EditHead" nowrap>
							相关法律法规和监管规定
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" disabled="true" name="audTaskTemplate.law" cssStyle="border-width:0px;width:98%;overflow-y:visible;line-height:150%;color:#000;background:#fff" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							所需资料
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" disabled="true" name="audTaskTemplate.taskTarget" cssStyle="border-width:0px;width:98%;overflow-y:visible;line-height:150%;color:#000;background:#fff" />
						</td>
					</tr> 
				    <tr>
						<td class="EditHead" style="width:170px">
							审计查证要点
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" disabled="true" name="audTaskTemplate.taskMethod" cssStyle="border-width:0px;width:98%;overflow-y:visible;line-height:150%;color:#000;background:#fff" />
						</td>
					</tr>
					 <tr>
						<td class="EditHead">
							重点关注内容
						</td>
						<td class="editTd" colspan="3">
							<s:textarea cssClass="noborder" disabled="true" name="audTaskTemplate.pointContent" cssStyle="border-width:0px;width:98%;overflow-y:visible;line-height:150%;color:#000;background:#fff" />
						</td>
					</tr>
				</table>
			</s:form>
		</center>
	</body>
</html>
