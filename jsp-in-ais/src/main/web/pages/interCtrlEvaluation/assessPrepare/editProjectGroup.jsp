<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>内控评价-项目分组-添加、编辑、查看</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type="text/javascript">
$(function(){
	var isView = "${view}" == true || "${view}" == "true" ? true : false;
	//设置编辑或者查看
	isView ?  $('.editElement').remove() : $('.viewElement').remove();

	$('#gSaveBtn').bind('click', function(){
		saveGroup();
	})
	$('#gCloseBtn').bind('click', function(){
		aud$closeTab();
	})
	
	//检查分组名称是否重复
	$("#pmg_groupName").bind('change', function(){
		var pGroupName = $(this).val();
		if(pGroupName){
			var tabWin = aud$parentDialogWin();
			var groupWin = tabWin.$('#sureTeam').get(0).contentWindow;
			if(groupWin){
				var rows = groupWin.$('#groupList').datagrid('getRows');
				if(rows && rows.length){
					for(var i = 0; i < rows.length; i++){
						var row = rows[i];
						if(pGroupName == row['groupName']){
							top.$.messager.alert("提示信息","【"+pGroupName+"】已经存在，不能重复添加","error");
							break;
						}
					}
				}
			}
		}
	});
	
	setTimeout(function(){
		var groupId = $('#pmg_groupId').val();
		aud$checkZhengti();
		$('#pmg_groupType').combobox({
			onSelect:function(rec){
				$('#pmg_groupTypeName').val(rec.text);
			}
		});
		if(groupId){
			$('#pmg_groupType').combobox('setValue', '${pmg.groupType}');
		}else{		
			$('#pmg_groupTypeName').val($('#pmg_groupType').combobox('getText'));
		}
	},0);
	
	function saveGroup(){
		try{
			aud$saveForm('groupForm', "${contextPath}/intctet/prepare/assessScheme/saveProjectGroup.action", function(data){
				if(data){
					data.msg ? showMessage1(data.msg) : null;	
					if(data.type == 'info'){
		  				var tabWin = aud$parentDialogWin();
		  				var sureWin = tabWin.$('#sureTeam').get(0).contentWindow;
		  				sureWin.$('#curGroupId').val(data.groupId);
		  				sureWin.$('#curGroupName').val(data.groupName);
		  				sureWin.$('#curGroupType').val(data.groupType);
		  				sureWin.$('#curGroupTypeName').val(data.groupTypeName);
		  				sureWin.refresh();
		  				if(data.reloadMem){
		  					sureWin.memberList.refresh();
		  				}
		  				$('#gCloseBtn').trigger('click');
					}
		 		}
		    });
		}catch(e){
			alert("saveGroup:\n"+e.message);
		}
	}

});

//检查整体组是否已经添加
function aud$checkZhengti(){
	try{
		if('${pmg.groupType}' != "zhengti"){			
			var tabWin = aud$parentDialogWin();
			var groupWin = tabWin.$('#sureTeam').get(0).contentWindow;
			if(groupWin){
				var rows = groupWin.$('#groupList').datagrid('getRows');
				if(rows && rows.length){
					var rowLen = rows.length;
					//整体组是否存在，如果有了只能添加分组
					$.each(rows, function(m, row){
						if(row.groupType == "zhengti"){
							//alert($('#pmg_groupType').find("option[value='zhengti']").length)
							$('#pmg_groupType').find("option[value='zhengti']").remove();
							return false;
						}
					});
				}
			}
		}else{
			$('#pmg_groupName').css('border-width','0px').attr('readonly','readonly').get(0).blur();
			$('#pmg_groupType').find("option[value='fenbu']").remove();
		}
	}catch(e){
		alert("aud$checkZhengti:\n"+e.message);
	}
}

//检查被评价单位是否已经添加了分组
function aud$CheckUnit(curContext, dms, mcs){
	try{
		var isExists = false;
		if(dms && dms.length){
			var tabWin = aud$parentDialogWin();
			var groupWin = tabWin.$('#sureTeam').get(0).contentWindow;
			if(groupWin){
				var rows = groupWin.$('#groupList').datagrid('getRows');
				if(rows && rows.length){
					var rowLen = rows.length;
					var subLen = dms.length;
					var msgArr = [];
					var pmgGroupId = $('#pmg_groupId').val();
					for(var j = 0; j < subLen; j++){
						var nodeId = dms[j] + ",";
						for(var i = 0; i < rowLen; i++){
							var row = rows[i];
							var rowGroupId = row['groupId'];
							var belongToUnitId = row['belongToUnitId'];
							if(((pmgGroupId && pmgGroupId != rowGroupId) || (!pmgGroupId))
									&& belongToUnitId && (belongToUnitId+",").indexOf(nodeId) != -1){
								msgArr.push("【"+row['belongToUnitName']+"】已关联【"+row['groupName']+"】");
							}
						}
					}
					if(msgArr && msgArr.length){
						isExists = true;
						top.$.messager.alert("提示信息", msgArr.join("</br>"), "warning");
					}
				}			
			}
		}
		return !isExists;
	}catch(e){
		alert("aud$CheckUnit:\n"+e.message);
	}
}

//被评价单位过滤器, 分组中已经添加选择的单位过滤掉，不显示
function aud$orgFilter(data){
	try{
		if(data && data.length){
			var root = data[0];
			var children = root.children;
			var newChildren = [];
			if(children && children.length){
				var tabWin = aud$parentDialogWin();
				var groupWin = tabWin.$('#sureTeam').get(0).contentWindow;
				if(groupWin){
					var rows = groupWin.$('#groupList').datagrid('getRows');
					if(rows && rows.length){
						var pmgGroupId = $('#pmg_groupId').val();	
						var childLen = children.length;
						var rowsLen = rows.length;
						for(var i = 0; i <  childLen; i++){
							var node = children[i];
							var nodeId = node.id + ",";
							var isSame = false;
							for(var j = 0; j < rowsLen; j++){
								var row = rows[j];
								var rowGroupId = row['groupId'];
								var belongToUnitId = row['belongToUnitId'];
								if(((pmgGroupId && pmgGroupId != rowGroupId) || (!pmgGroupId))
										&& belongToUnitId && (belongToUnitId+",").indexOf(nodeId) != -1){
									isSame = true;
									break;
								}
							}
							if(!isSame){
								newChildren.push(node);
							}
						}
						root.children = newChildren;
					}
				}
			}
		}
		
		return data;
	}catch(e){
		alert("aud$orgFilter:\n"+e.message);
	}
}

</script>
<style type="text/css">
input[class~=editElement]{
	width:85% !important;
}
</style>
</head>
<<body style='padding:0px;margin:0px;overflow:hidden;'  class='easyui-layout' border='0' fit='true'>
	<div region='north' border='0' style='padding:0px;overflow:hidden;'>
		<div id='btnBar' style='text-align:right;padding-right:10px;margin-bottom:5px;border-bottom:1px solid #cccccc;width:100%;'>  
			<a id='gSaveBtn'  class="easyui-linkbutton editElement" iconCls="icon-save" style='border-width:0px;'>保存</a>	
 			<a id='gCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>	
	</div>
	<div region='center' border='0' title="" split="true" id="layoutCenter">
		<form id="groupForm" name="groupForm">
			<table class="ListTable" align="center" style='table-layout:fixed;margin-top:0px;'>
				<tr>
					<td class="EditHead" style="width:20%;" nowrap><font class='editElement' color='red'>*</font>分组名称</td>
					<td class="editTd"   >
						<input type='text' id="pmg_groupName" name="pmg.groupName" value="${pmg.groupName}"
						class="noborder editElement clear required" title="分组名称"/>
						<span id='view_groupName' class="noborder viewElement clear">${pmg.groupName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%;" nowrap><font class='editElement' color='red'>*</font>被评价单位</td>
					<td class="editTd"  >
						<input type='text' id='pmg_belongToUnitName' name='pmg.belongToUnitName' value="${pmg.belongToUnitName}" 
						 title='被评价单位' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='pmg_belongToUnitId' name='pmg.belongToUnitId' value="${pmg.belongToUnitId}" 
						 title='被评价单位Id' class="noborder editElement clear required" readonly/>
						<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
                                  title:'被评价单位选择',
                                  onlyLeafClick:true,
                                  checkbox:true,
								  param:{
								  	'serverCache':false,
									'customRoot':'被评价单位',
									'plugId':'SureassessScopeSelect',
								  	'rootParentId':'notnull',
				                    'beanName':'SureassessScope',
				                    'treeId'  :'auditCode',
				                    'treeText':'auditName',
				                    'treeParentId':'scopecode',
				                    'treeOrder':'scopecode',
				                    'whereHql':'interProId=\'${projectId}\'',
				                 }, 
				                 onBeforeSure:aud$CheckUnit,
				                 onTreeLoadFilter:aud$orgFilter                              
						})"></a>
						<span id='view_belongToUnitName' class="noborder viewElement clear">${pmg.belongToUnitName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:25%;" nowrap><font class='editElement' color='red'>*</font>分组类别</td>
					<td class="editTd"  >
						<input type='hidden' id="pmg_groupTypeName" name="pmg.groupTypeName" value="${pmg.groupTypeName}"
						class="noborder editElement clear required" title="分组名称"/>
						<select id="pmg_groupType" name="pmg.groupType" 
						class="editElement clear required" panelHeight="auto" editable="false">
							<option value="zhengti">整体</option>
							<option value="fenbu" selected>分部</option>
						</select>
						<span id='view_groupTypeName' class="noborder viewElement clear">${pmg.groupTypeName}</span>
					</td>
				</tr>		
			</table>
			<input type='hidden' id="pmg_groupId" name="pmg.groupId" value="${pmg.groupId}"/>
			<input type='hidden' id="pmg_projectFormId" name="pmg.projectFormId" value="${pmg.projectFormId}"/>
		</form>		
	</div>
</body>
</html>