<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:if test="${audTaskTemplate.taskTemplateId==null}">
	<s:text id="title" name="'增加风险事项'"></s:text>
</s:if>
<s:else>
	<s:text id="title" name="'编辑风险事项'"></s:text>
</s:else>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title><s:property value="#title"/></title>
	<s:head />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type='text/javascript' src='/ais/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='/ais/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='/ais/dwr/engine.js'></script>
	<script type='text/javascript' src='/ais/dwr/util.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script language="javascript">
		//关闭窗口
		function closeW(){
			parent.$('#addType_div').window('close');
		}
		
		function onlyNumbers1(s){
			re = /^\d+\d*$/
			var str=s.replace(/\s+$|^\s+/g,"");
			if(str==""){
				return false;
			}
			if(!re.test(str)){
				showMessage1("事项序号只能输入正整数,请重新输入!");
				return true ;   
			}
		}

		//输入项的验证
		function check(){
			var v_3 = "riskTaskTemplate.taskName";//field
			var title_3 = '名称';//field name
			var notNull = 'true';//notnull
			var t=document.getElementsByName(v_3)[0].value;
			if(t.length>128){
				showMessage1("事项名称的长度不能大于128字！");
				document.getElementById(v_3).focus();
				return false;
			}
			return true;
		}

		//保存表单
		function saveFormLeafAgain(){
			var v_3 = "riskTaskTemplate.taskName";//field
			var title_3 = '名称';//field name
			var notNull = 'true';//notnull
			if(document.getElementsByName(v_3)[0].value=="" && notNull=="true"　&& notNull != ""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				document.getElementById(v_3).focus();
				return false;
			}
			if(document.getElementsByName(v_3)[0].value.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_3+"不能为空!");
				bool = false;
				document.getElementById(v_3).focus();
				return false;
			}
			var v_2 =  "riskTaskTemplate.taskOrder"
			var title_2 = '事项序号';//field name
			var notNull = 'true'; //notnull
			if(document.getElementsByName(v_2)[0].value=="" && notNull=="true"　&& notNull != ""){
				showMessage1(title_2+"不能为空!");
				bool = false;
				document.getElementById(v_2).focus();
				return false;
			}
			if(document.getElementsByName(v_2)[0].value.replace(/\s+$|^\s+/g,"")==""){
				showMessage1(title_2+"不能为空!");
				bool = false;
				document.getElementById(v_2).focus();
				return false;
			}
			var s = document.getElementsByName(v_2)[0].value;
			if(onlyNumbers1(s)){
				document.getElementById(v_2).focus();
				return false;
			}
			if(!check()){
				return false;
			}
			$.ajax({
				type:"post",
				data:$('#myform').serialize(),
				url:"${contextPath}/riskManagement/knowledgeBase/riskTemplate/saveTypeAgain.action?template=template&addtype=true&selectedTab=<%=request.getParameter("selectedTab")%>",
				async:false,
				success:function(){
					showMessage1('保存成功！');
					document.getElementsByName("riskTaskTemplate.taskName")[0].value = '';
					document.getElementsByName("riskTaskTemplate.riskDescription")[0].value = '';
					var taskOrder = document.getElementsByName("riskTaskTemplate.taskOrder")[0].value;
					document.getElementsByName("riskTaskTemplate.taskOrder")[0].value = parseInt(taskOrder)+1;
					parent.parent.parent.reloadChildTreeNode();
				}
			});
		}
	</script>
</head>
<body>
	<center>
		<s:form id="myform" onsubmit="return true;" action="/ais/riskManagement/knowledgeBase/riskTemplate" method="post">
			<table class="ListTable">
				<%-- <tr>
					<td class="EditHead" style="width: 20%">
						<font color="red">*</font>&nbsp;编号
					</td>
					<td class="editTd" colspan="3">
						<s:textfield cssClass="noborder" name="riskTaskTemplate.taskCode" id="riskTaskTemplate.taskCode"/>
					</td>
				</tr> --%>
				<tr>
					<td class="EditHead">
						<font color="red">*</font>&nbsp;名称
					</td>
					<td class="editTd" colspan=3>
						<s:textfield cssClass="noborder" name="riskTaskTemplate.taskName" id="riskTaskTemplate.taskName"/>
					</td>
				</tr>
				<tr style='display:none;'>
					<td class="EditHead">
						<font color="red">*</font>&nbsp;事项序号
					</td>
					<td class="editTd" colspan="3">
						<s:textfield name="riskTaskTemplate.taskOrder" cssClass="noborder" maxlength="10" cssStyle='width:150px;'/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						描述
					</td>
					<td class="editTd" colspan="3">
						<s:textarea cssClass="noborder" name="riskTaskTemplate.riskDescription" cssStyle="width:100%;overflow-y:hidden"/>
					</td>
				</tr>
			</table>
			<s:hidden name="riskTaskTemplate.taskId" />
			<s:hidden name="riskTaskTemplate.templateId" />
			<s:hidden name="riskTaskTemplate.taskPid" />
			<s:hidden name="riskTaskTemplate.taskPcode" />
			<s:hidden name="riskTaskTemplate.template_type" value="1" />
			<s:hidden name="templateId" />
			<s:hidden name="taskId" />
			<s:hidden name="type" />
			<s:hidden name="pro_id" />
			<s:hidden name="path" />
			<s:hidden name="node" />
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveFormLeafAgain()">保存并增加</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="closeW()">关闭</a>
		</s:form>
	</center>
</body>
</html>
