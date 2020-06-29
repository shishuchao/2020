<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%
	//总体方案页面，也就是审计方案模板的根节点页面
	String pb = (String) request.getParameter("refresh");
	String taskId = (String) request.getParameter("taskId");
	String templateId = (String) request.getParameter("templateId");
%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>风险库维护：总体风险修改</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>

	<script language="javascript">
		$(function (){
			showWin('addType_div','增加事项类别');
			setTextareaAuto();
            if("${param.isView}"=="Y"){
                document.getElementById("templateCode").readOnly=true;
                document.getElementById("templateName").readOnly=true;
            }
		});
	  
		function setTextareaAuto(){
			$("#myform").find("textarea").each(function(){
				autoTextarea(this);
			});
		}
		function reload(){
			window.location.reload();
		}
		//生成
		function generateType(){
		    var taskId="<%=request.getParameter("taskId")%>";
		    if(taskId == null || taskId == "" || taskId =="null"){
				taskId = document.getElementById("taskId").value;
		    }
		    var url ="${contextPath}/riskManagement/knowledgeBase/riskTemplate/addType.action?taskId="+taskId+"&templateId=<%=request.getParameter("templateId")%>&selectedTab=<%=request.getParameter("selectedTab") %>";
		   	showWinIf('addType_div',url,'增加事项类别',$(window).width()-100,$(window).height()-100); 
		}

		//模板生成----------保存表单
		function saveFormRoot(){
			var v_3 = "riskTemplate.templateName";//field
			var title_3 = '名称';//field name
			if(document.getElementsByName(v_3)[0].value==""){
				showMessage1(title_3+"不能为空!");
				return false;
			}
			$.ajax({
				type:"post",
				data:$('#myform').serialize(),
				url:"${contextPath}/riskManagement/knowledgeBase/riskTemplate/saveRoot.action",
				async:false,
				success:function(){
					showMessage1('保存成功！');
					parent.parent.reloadChildTreeNode();
				}
			});
		}
	
		//刷新页面
		function again(){
			if(<%=pb%>==null||<%=pb%>=='null'||<%=pb%>==''){
				window.location="${contextPath}/operate/template/showContentRoot.action?selectedTab=main&taskId=<%=taskId%>&templateId=<%=templateId%>&refresh=1"
			} 
		}

		function xg(){  
			//setTimeout("again()",100); 
		}

	</script>
</head>
<body onload="xg()" style="margin: 0;padding: 0;overflow-y:auto;" >
	<s:form id="myform" onsubmit="return true;" action="view" method="post">
		<table class="ListTable" align="center">
			<input type="hidden" name="refreshCode">
			<tr>
				<td class="EditHead">
					<font color="red">*</font>&nbsp;编号
				</td>
				<td class="editTd">
					<s:textfield cssClass="noborder" id="templateCode" name="riskTemplate.templateCode"/>
				</td>

				<td class="EditHead">
					<font color="red">*</font>&nbsp;名称
				</td>
				<td class="editTd">
					<s:textfield cssClass="noborder" id="templateName" name="riskTemplate.templateName"/>
				</td>
			</tr>
<%-- 			<tr>
				<td class="EditHead">
					描述
				</td>
				<td class="editTd" colspan="3">
					<s:textarea cssClass="noborder" name="riskTemplate.risk_description" cssStyle="width:100%;overflow-y:hidden"/>
				</td>
			</tr> --%>
		</table>
		<s:hidden name="riskTemplate.templateId" />
		<s:hidden name="riskTemplate.year" />
		<s:hidden name="riskTemplate.tradePlate" />
		<s:hidden name="riskTemplate.version" />
		<s:hidden name="riskTaskTemplate.taskId" id="taskId" />
		<s:hidden name="riskTaskTemplate.taskPid" />
		<s:hidden name="templateId" />
		<s:hidden name="taskId" />
		<s:hidden name="type" />
		<s:hidden name="pro_id" />
		<s:hidden name="path" />
		<s:hidden name="node" />
		<s:if test="${isView != 'Y'}">
			<div style="margin-top: 10px; margin-bottom: 40px; padding-right: 18px; text-align:right;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="generateType()">增加类别</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormRoot()">保存</a>
			</div>
		</s:if>
	</s:form>
	<div id="addType_div"></div>
</body>
</html>
