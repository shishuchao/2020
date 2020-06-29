<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title>新增审计通知书编号</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script type="text/javascript">
		$(function(){
			var json = eval('(${projectTypeList})');
			$('#pro_type').combobox({
				data:json.projectTypeList,
				valueField:'code',
				panelHeight:'200',
				textField:'name',
				multiple:true,
				editable:false
			});
			if('${code}'!=null&&'${code}'!=''){
				$('#pro_type').combobox('setValues','${code}'.split(','));
				$('#pro_type').combobox('setText','${typeName}');
			}
			var state_name = '${codeRule.state_name}';
			$('#cbb').combobox("setText",state_name);
			var report_state = '${codeRule.report_state}';
			$('#cbb').combobox("setValue",report_state);
		});
		</script>
	</head>
	<body class="layout">
		<div id="addReportCode" title="新增通知书编号" region="north">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead">审计通知书编号名称:</td>
					<td class="editTd">
						<input type="text" class="noborder" value="${moName}" id="moName" name="moName" style="width:450px;"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">适用项目类别:</td>
					<td class="editTd">
						<input id="pro_type" style="width:450px;"/>
						<input type="hidden" id="code" name="code" value="${code}"/>
						<input type="hidden" id="typeName" name="typeName" value="${typeName}"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">是否启用:</td>
					<td class="editTd">
						<s:select list="#@java.util.LinkedHashMap@{'qy':'启用','dj':'不启用'}" listKey="key"
								  listValue="value" id="cbb" name="report_state" cssClass="easyui-combobox"></s:select>
					</td>
				</tr>
			</table>
		</div>
		<div region="south" style="text-align:center;padding:60px 20px 20px 100px;">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onClick="saveForm()" >保存</a>
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onClick="cancel()" >取消</a>
		</div>
		<script type="text/javascript">
		function saveForm(){
			var id = '${id}';
			//判断不能为空
			var name = $('#moName').val();
			if(name == null || name == ''){
				showMessage1(" 审计通知书编号名称不能为空!");
				return false;
			}
			var text = $('#pro_type').combobox('getText');
			if(text == null || text == ''){
				showMessage1("适用类别不能为空!");
				return false;
			}
			var value = $('#pro_type').combobox('getValues');
			$('#code').val(value);
			var code = $('#code').val();
			var report_state = $('#cbb').combobox('getValue');
			var state_name = $('#cbb').combobox('getText');
			$('#typeName').val(text);
			$.ajax({
				url:"<%=request.getContextPath()%>/code/rule/codeRule/saveCode.action?id="+id,
				type:'post',
				data:{"name":name,"text":text,"code":code,"report_state":report_state,"state_name":state_name},
				dataType:'text',
				success:function(data){
					if(data == 'success'){
						showMessage1("保存成功!");
						window.parent.location.reload();
					}else if(data == 'exist'){
						showMessage1("所选类型已选,请重新选择!");
					}else{
						showMessage1("保存失败!");
					}
				},
			error:function(data){
				showMessage1('请求失败,请检查网络是否通畅或者与管理员联系！');
			}
			});
		}
		
		function cancel(){
			window.parent.closeWin();
		}
		</script>
	</body>
</html>