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
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>   
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript">
$(function(){

	$('#showType').combobox({
		onSelect:function(record){
			var val = record.value;
			$('#targetTree2').css('display', val == '0' ? 'none' : 'block');
			$('#targetTree').css('display',val == '0'? 'block' : 'none');
			$('#container').val(val == '0' ? 't1' : 't2');
		}
	});
	
	$('#beanName').combobox({
		onSelect:function(record){
			var val = record.value;
			var beanName,rootId, treeId, treeText, treeParentId, treeOrder;
			beanName = val;
			switch(val){
				case 'AuditingObjectTree':
					$('#plugId').val(beanName);
					$('#rootId').val("1");
					$('#treeId').val("id");
					$('#treeText').val("name");
					$('#treeParentId').val("parentId");
					$('#treeOrder').val("currentCode");
					break;
				case 'UOrganizationTree':
					$('#plugId').val(beanName);
					$('#rootParentId').val("0");
					$('#treeId').val("fid");
					$('#treeText').val("fname");
					$('#treeParentId').val("fpid");
					$('#treeOrder').val("fcode");
					break;				
			}
		}
	});
	$('#showType').combobox('setValue', "");
	$('#beanName').combobox('setValue', "");
	$('#genTreeParam').bind('click', genTreeParam);
	$('#clearParam').bind('click', function(){
		window.location.reload();
	});
	$('#chkRef').hide();

});

function genTreeParam(){
	try{
		
		var paramJson = {
			param:{}
		};
		var targetId = $('#container').val();
		var targetObj = $('#'+targetId)[0];
		var showType = "0";
		var str = $("#configForm").serialize();
		if(str){
			var arr = str.split("&");
			for(var i = 0; i < arr.length; i++){
				var s = arr[i];
				if(s){
					var arr2 = s.split("=");
					if(arr2.length == 2){
						var key = arr2[0];
						var value = arr2[1];
						if(key == "" || key == "container" || key == undefined || value == "" || value == undefined) continue;
						if(key == 'showType'){
							showType = value;
							continue;
						}
						if(key.lastIndexOf('param_') != -1){
							var keyArr = key.split("_");
							paramJson.param[keyArr[1]] = value == "true" ? true :(value=="false" ? false : value);
						}else{
							paramJson[key] = value == "true" ? true :(value=="false" ? false : value);
						}
					}
				}
			}
			//alert('showType='+showType)
			if(showType == "1"){
				//alert(0)
				
				$(targetObj).unbind('click').bind('click', function(){
					//var pa = paramJson.param;
					//for(var p in pa) alert(p +"="+pa[p])
					showSysTree(targetObj,paramJson);
				});
				$(targetObj).trigger('click');
			}else{
				paramJson['container'] = targetObj;
				//alert(2)
				showSysTree(targetObj,paramJson);
			}
			//$("#results").val(QUtil.object2string(paramJson).replace(/''/gi,"'"));
			top.$.messager.alert("提示信息","生成成功！", 'info', function(){
				$('#qtab').tabs('select', 1);
			});
		}
	}catch(e){
		//alert('genTreeParam:'+e.message);
		top.$.messager.alert("提示信息",'genTreeParam:'+e.message, 'info', function(){
			
		});
	}
} 

function changeChk(ele){
	try{
		var val = ele.value;
		$('#chkRef').css('display', QUtil.string2boolean(val) ? "" : "none" );
	}catch(e){
		//alert('genTreeParam:'+e.message);
		top.$.messager.alert("提示信息",'changeChk:'+e.message, 'info', function(){
			
		});
	}
}

</script>
</head>
<body style='padding:0px;margin:0px;overflow:hidden;' class='easyui-layout' fit='true' border='0'>
	<div region='center' border='0' style='padding:10px; overflow:hidden;' title="树形配置">	
		<div id="qtab" class="easyui-tabs"  fit="true" border="0">  
			<div title='配置' id='tab1' border="0" style='overflow:hidden;'>
				<form id='configForm'>
					<table class="ListTable" align="center" style='table-layout:fixed;'>	
						<tr>
							<td class="EditHead" style="width:100%; text-align:left;" colspan="4">
								<div style="float:right;">
									<a id='genTreeParam' class="easyui-linkbutton" iconCls="icon-ok" >生成预览</a>
									<a id='clearParam' class="easyui-linkbutton" iconCls="icon-reload" >刷新</a>
								</div>
								<div style="float:left;">树形配置参数</div>
							
							</td>
						</tr>

						<tr>
							<td class="EditHead" style="width:20%;"><font color=red>*</font>展示形式</td>
							<td class="editTd" style='min-width:150px;width:30%;'>
								<select  id='showType' name='showType' data-options="editable:false"
									class="easyui-combobox"  >
									<option value="">-请选择-</option>
									<option value="0">嵌入式</option>
									<option value="1">弹出式</option>
								</select>
							</td>
							<td class="EditHead" style="width:20%;"><font color=red>*</font>目标容器ID</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="container" name="container" class="noborder"
								 value="t1" style='width:80%;'/>
							</td>
						</tr>	
						<tr>
							<td class="EditHead" style="width:15%;"><font color=red>*</font>树形对象</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='beanName' name='param_beanName' data-options="editable:false"
									class="easyui-combobox"  >
									<option value="">-请选择-</option>
									<option value="AuditingObjectTree">被审计单位</option>
									<option value="UOrganizationTree">审计单位</option>
									<option value="AudTaskTree">审计事项</option>
									<option value="AssistSuportLawslibMenu">法规分类</option>
									<option value="CodeAndNameTree">代码表</option>
								</select>
							</td>
							<td class="EditHead" style="width:15%;"><font color=red>*</font>节点ID字段</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="treeId" name="param_treeId" class="noborder"  style='width:80%;'/>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;"><font color=red>*</font>根节点ID值</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="rootId" name="param_rootId" class="noborder" style='width:80%;'/>
							</td>
							<td class="EditHead" style="width:15%;"><font color=red>*</font>根父节点ID值</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="rootParentId" name="param_rootParentId" class="noborder" style='width:80%;'/>
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
								<input type="text" id="treeOrder" name="param_treeOrder" class="noborder" style='width:80%;'/>
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
									class="easyui-combobox " panelHeight='60px'>
									<option value="true">使用</option>
									<option value="false">禁用</option>
								</select>
							</td>
							<td class="EditHead" style="width:15%;">是否使用Oracle特性</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='isOracle' name='param_isOracle' data-options="editable:false"
									class="easyui-combobox " panelHeight='60px'>
									<option value="true">使用</option>
									<option value="false">禁用</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;">是否展开第一级根节点</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='expandFirstRoot' name='expandFirstRoot'>
									<option value="true">是</option>
									<option value="false">否</option>
								</select>
							</td>
							<td class="EditHead" style="width:15%;">展开当前节点下的所有节点（为了性能默认展开节点不超过4层）</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='cascadeExpand' name='cascadeExpand'>
									<option value="false">否</option>
									<option value="true">是</option>
								</select>
							</td>
							
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;">是否多选</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='checkbox' name='checkbox' onchange="changeChk(this)">
									<option value="false">否</option>
									<option value="true">是</option>
								</select>
							</td>
							<td class="EditHead" style="width:15%;">是否级联选择</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='cascadeCheck' name='cascadeCheck' data-options="editable:false"
									class="easyui-combobox " panelHeight='60px'>
									<option value="false">否</option>
									<option value="true">是</option>
								</select>
							</td>
						</tr>
						<tr id="chkRef">
							<td class="EditHead" style="width:15%;">多选时-选择本级本上级</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='cascadePrior' name='cascadePrior'>
									<option value="false">否</option>
									<option value="true">是</option>
								</select>
							</td>
							<td class="EditHead" style="width:15%;">多选时-选择本级本下级</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='cascadeJunior' name='cascadeJunior' >
									<option value="false">否</option>
									<option value="true">是</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width:15%;">是否使显示查询条</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='treeQueryBox' name='treeQueryBox' data-options="editable:false"
									class="easyui-combobox " panelHeight='60px'>
									<option value="true">使用</option>
									<option value="false">禁用</option>
								</select>
							</td>
							<td class="EditHead" style="width:15%;">只能点击末级节点</td>
							<td class="editTd" style='min-width:150px;'>
								<select  id='onlyLeafClick' name='onlyLeafClick' data-options="editable:false"
									class="easyui-combobox " panelHeight='60px'>
									<option value="false">否</option>
									<option value="true">是</option>
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
						<tr>
							<td class="EditHead" style="width:15%;">树形tab页名称</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="treeTabTitle1" name="treeTabTitle1" class="noborder" style='width:80%;'/>
							</td>
							<td class="EditHead" style="width:15%;">树形tab页名称2</td>
							<td class="editTd" style='min-width:150px;'>
								<input type="text" id="treeTabTitle2" name="treeTabTitle2" class="noborder" style='width:80%;'/>
							</td>
						</tr>
					</table>
				</form>
			
			</div>
			<div title='测试' id='tab2' border="0" style='overflow:hidden;'>
					<div class='easyui-layout' fit='true' border='0'>	
						<div id="targetTree" region="west" border='0' split="true" style='overflow:hidden;width:330px;' title=''>
							<div id='t1'></div>		
					    </div>
					    <div id="targetTree2" region="center" border='0'>
								<input type='text'  readonly='readonly' style='width:80%;'  class="noborder"
								value="上海铁路局淮北车务段,兰州铁路局">
								<input type='hidden' class="noborder" 
								value="9C3EE14C-F922-9ACB-9E04-0462CAA72F61,8a813e4f4b529a34014b5365b968013d">
			                    <a class="easyui-linkbutton"  iconCls="icon-search" id='t2'></a>
					    </div>
					    <div  region="south" border='0'>
							<textarea id="results" style='width:100%;height:100px;'></textarea>
						</div>
				    </div>	
			</div>
		</div>	
	</div> 
</body>
</html>