<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
<title>通用控件树形配置</title>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">	
<script type="text/javascript" src="/ais/easyui/boot.js"></script>   
<script type="text/javascript" src="/ais/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="/ais/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="/ais/resources/js/jquery-fileUpload.js"></script>

<script type="text/javascript">

</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' fit='true' border='0'>
	<div region='center' border='0' style='padding:10px; overflow:hidden;' title="树形配置">	
		<div id="qtab" class="easyui-tabs"  fit="true" border="0">  
			<div title='配置' id='tab1' border="0" style='overflow:hidden;'>
				<form>
					<table class="ListTable" align="center" style='table-layout:fixed;'>
						<tr>
							<td class="EditHead" style="width:20%;"><font color=red>*</font>树形对象</td>
							<td class="editTd" style='min-width:150px;width:30%;'>
								<input type="text" id="container" name="container" class="noborder" style='width:80%;'/>
							</td>
							<td class="EditHead" style="width:20%;"><font color=red>*</font>目标容器ID</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="targetId" name="targetId" class="noborder" style='width:80%;'/>
							</td>
						</tr>
					</table>
					<table class="ListTable" align="center" style='table-layout:fixed;'>	
		
						
						<tr>
							<td class="EditHead" style="width:100%; text-align:left;" colspan="4">树形配置参数</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;">树形对象</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="beanName" name="param_beanName" class="noborder" style='width:80%;'/>
							</td>
							<td class="EditHead" style="width:15%;"><font color=red>*</font>节点ID字段</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="treeId" name="param_treeId" class="noborder" style='width:80%;'/>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;"><font color=red>*</font>节点名称字段</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="treeText" name="param_treeText" class="noborder" style='width:80%;'/>
							</td>
							<td class="EditHead" style="width:15%;"><font color=red>*</font>节点父ID字段</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="treeParentId" name="param_treeParentId" class="noborder" style='width:80%;'/>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;">排序字段</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="order" name="param_order" class="noborder" style='width:80%;'/>
							</td>
							<td class="EditHead" style="width:15%;">组件ID</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="plugId" name="param_plugId" class="noborder" style='width:80%;'/>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;">是否使用服务器缓存</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='serverCache' name='param_serverCache' data-options="editable:false"
									class="easyui-combobox editElement" panelHeight='60px'>
									<option value="true">使用</option>
									<option value="false">禁用</option>
								</select>
							</td>
							<td class="EditHead" style="width:15%;">是否使用Oracle特性</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='isOracle' name='param_isOracle' data-options="editable:false"
									class="easyui-combobox editElement" panelHeight='60px'>
									<option value="true">使用</option>
									<option value="false">禁用</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;">自定义查询条件</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="whereHql" name="param_whereHql" class="noborder" style='width:80%;'/>
							</td>
							<td class="EditHead" style="width:15%;">节点附带属性</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="treeAtrributes" name="ptreeAtrributes" class="noborder" style='width:80%;'/>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;">末级节点判断条件</td>
							<td class="editTd" style='min-width:150px;' colspan='3'>
								<input type="text" id="leafCondition" name="param_leafCondition" class="noborder" style='width:80%;'/>
							</td>
						</tr>
					</table>
				</form>
			
			</div>
			<div title='测试' id='tab2' border="0" style='overflow:hidden;'>
			
			</div>
		</div>	
	</div> 
</body>
</html>