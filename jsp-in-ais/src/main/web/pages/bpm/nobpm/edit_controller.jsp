<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<s:text id="title" name="'添加流程定义'"></s:text>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>
			<s:property value="#title" />
		</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	</head>

	<body class="easyui-layout" style="overflow: auto;">
		<center>
			<s:form action="saveController" theme="simple" id="MyForm">
				<table cellpadding=1 cellspacing=1 border=0  class="ListTable">
					<tr >
						<td colspan="5"  class="edithead">
							<font style="float: left;">&nbsp;表单名称：<s:property value="noBpmDefinition.name"/></font>
						</td>
					</tr>
					<tr>
						<td class="EditHeadCenter">
							字段编码
						</td>
						<td class="EditHeadCenter">
							字段名称
						</td>
						<td class="EditHeadCenter">
							必填
							<input name="FieldReequired1" type="checkbox"
								id="FieldReequired1" onclick="CheckAll('FieldRequired',this,1)"
								value="checkbox" title="全部选中|全部取消">
						</td>
						<td class="EditHeadCenter">
							写入
							<input name="FieldWrite1" type="checkbox" id="FieldWrite1" 
								onclick="CheckAll('FieldWrite',this,1)" value="checkbox"
								title="全部选中|全部取消">
						</td>
						<td class="EditHeadCenter">
							查看
							<input name="FieldRead1" type="checkbox" id="FieldRead1"
								onclick="CheckAll('FieldRead',this,1)" value="checkbox"
								title="全部选中|全部取消">
						</td>
					</tr>
					<s:iterator value="noBpmFormControllerList" status="index">
						<tr>
							<td class="editTd" >
								<%-- <s:property value="%{code}" />
								<s:hidden name="noBpmFormControllerList[%{#index.index}].code"
									value="%{code}"></s:hidden> --%>
								<s:textfield name="noBpmFormControllerList[%{#index.index+1}].code"
									value="%{code}"></s:textfield>
							</td>
							<td class="editTd" >
								<%-- <s:property value="%{name}" />
								<s:hidden name="noBpmFormControllerList[%{#index.index}].name"
									value="%{name}"></s:hidden> --%>
								<s:textfield name="noBpmFormControllerList[%{#index.index+1}].name"
									value="%{name}"></s:textfield>
							</td>
							<td class="editTd" >
								<s:checkbox
									name="noBpmFormControllerList[%{#index.index+1}].required"
									value="%{required}"></s:checkbox>
							</td>
							<td class="editTd" >
								<s:checkbox
									name="noBpmFormControllerList[%{#index.index+1}].write"
									value="%{write}"></s:checkbox>
							</td>
							<td class="editTd" >
								<s:checkbox name="noBpmFormControllerList[%{#index.index+1}].read"
									value="%{read}"></s:checkbox>
							</td>
						</tr>
					</s:iterator>
				</table>
				<s:hidden name="noBpmDefinition.id" />
				<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="ToSave()">保存</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-undo'"
					onclick="javascript:window.location='<s:url action="list" includeParams="none"></s:url>'">返回</a>
			</s:form>
		</center>
		<script type="text/javascript">
			function CheckAll(chkAll,chkAll_var,cheOrclear){  //三个参数，chkAll是需要选中的checkbox ，chkAll_var是全选和不全选的控制  ，cheOrclear是1 负责选中
				var listSize = '<s:property value="noBpmFormControllerList.size"/>';//获得列表的长度-listSize
				var ische = cheOrclear;
				//alert(chkAll_var.checked);
				for (var i=0;i<listSize;i++)  //用来历遍form中所有控件,
				{
					var flag="";
					if(chkAll=='FieldRequired')
						flag="required";
					if(chkAll=='FieldWrite')
						flag="write";
					if(chkAll=='FieldRead')
						flag="read";
					var e = document.getElementsByName("noBpmFormControllerList["+i+"]."+flag)[0];
					if (e.Type="checkbox")					//当是checkbox时才执行下面
					{				
						if(ische==1 && chkAll_var.checked)
						{
							if(!e.checked)						//当是checkbox未被选取时才执行下面
							{
								e.checked=true;					
							}
						}else{	
							if(!e.checked)						//当是checkbox未被选取时才执行下面
							{
								e.checked=true;		
							}else{
								e.checked=false;
							}
								
						}
		
					}
				}

			}
			function ToSave(){
				MyForm.submit();
			}
		</script>
	</body>
</html>
