<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
	contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>通过邮件发送</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
     	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
   		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript">	
		if('${mess}'=='success'){
			parent.closeMailUi();
			$("#manualEmail").val("");
			$("#innerMsg.bodyText").val("");
			$("#innerMsg.bodyText").val("");
			//alert('发送成功!');
			window.parent.$.messager.show({
				title:"提示信息",
				msg:"发送成功！",
				timeout:5000,
			});
		}
		function myCheck(){
			me=document.getElementById("manualEmail");
	       	if(me.value==""){
	       		window.parent.$.messager.show({
					title:"提示信息",
					msg:"收件人不能为空，请完善信息！",
					timeout:5000,
				}); 
	    		return false;
	       	}else if(!inputemailValidate("manualEmail")){
		        		return false;
		    }
			obj=document.getElementById("innerMsg.subject");
			 if(obj.value==""){
				 $.messager.confirm('确认对话框', '标题为空，确认要提交吗？', function(r){
						if (r){
							innerMsgForm.submit();
						}else{
							obj=document.getElementById("innerMsg.bodyText");
							 if(obj.value==""){
								 $.messager.confirm('确认对话框', '内容为空，确认要提交吗？', function(r){
										if (r){
											innerMsgForm.submit();
										}
									});
							 }
						}
					});
			 }else{
				 innerMsgForm.submit();
			 }
			 
			 //innerMsgForm.submit();
		 }
		function afterSave(){
			if('${mess}'=='success'){
				parent.closeMailUi();
				window.parent.$.messager.show({
					title:"提示信息",
					msg:"发送成功！",
					timeout:5000,
				});
			}
		}
	</script>
</head>
<body style="overflow-y:hidden;">
	<s:form action="sendMail" id="innerMsgForm" name="innerMsgForm"	namespace="/msg" theme="simple" method="post">
		<s:hidden name="isSendMsg" value="false"></s:hidden>
		<s:hidden name="isSendSms" value="false"></s:hidden>
		<s:hidden name="isSendMail" value="true"></s:hidden>
		<s:hidden name="innerMsg.attachmentsId"></s:hidden>
		<table align="center" class="ListTable">
			<tr >
				<td colspan="4" align="left" class="topTd">
					邮件信息
				</td>
			</tr>			
			<tr>
				<td class="EditHead"><b>收件人：</b></td>
				<td class="editTd">
					<input type="text" name="manualEmail" id="manualEmail" value="${manualEmail}" maxlength="200" style="width:100%"/>
				</td>	
			</tr>
			<tr>
				<td class="EditHead" style="width:18%"><b>标题：</b></td>
				<td class="editTd" style="width:82%">
				<s:textfield id="innerMsg.subject"  maxlength="200"
					name="innerMsg.subject" cssStyle="width:100%"
					value="${innerMsg.subject}" />
				</td>	
			</tr>
			<tr>
				<td class="EditHead"><b>内容：
				</b></td>
				<td class="editTd">
				<s:textarea id="innerMsg.bodyText" 
					name="innerMsg.bodyText" cssStyle="width:100%;height:200px;"
					value="${innerMsg.bodyText}" />
				</td>
			</tr>
			<tr>
				<td colspan="4" align="left" class="topTd" style="border:0px;text-align:center;">
					</br>
					<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="myCheck()">发送</a>&nbsp;
					<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="parent.closeMailUi();">关闭</a>
				</td>
			</tr>	
		</table>
	</s:form>
</body>
</html>
