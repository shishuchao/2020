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

	$('#mSaveBtn').bind('click', function(){
		saveMember();
	})
	$('#mCloseBtn').bind('click', function(){
		aud$closeTab();
	})
	
	setTimeout(function(){
		var tabWin = aud$parentDialogWin();
		var sureWin = tabWin.$('#sureTeam').get(0).contentWindow;
		var curGroupId = sureWin.$('#curGroupId').val() || $('#pm_groupId').val();
		var curGroupName = sureWin.$('#curGroupName').val()|| $('#pm_groupName').val();;
		var curGroupType = sureWin.$('#curGroupType').val();
		var curGroupTypeName = sureWin.$('#curGroupTypeName').val();
		curGroupType ? $('#pm_groupType').val(curGroupType) : null;
		curGroupTypeName ? $('#pm_groupTypeName').val(curGroupTypeName) : null;
		curGroupId   ? $('#pm_groupId').val(curGroupId)   : null;
		curGroupName ? $('#pm_atgroup').val(curGroupName) : null;		
		var proMemberId = $('#pm_proMemberId').val();
		var memberRows = sureWin.$('#memberList').datagrid('getRows');
		//alert(curGroupType +"\n"+ $('#pm_atgroup').val());
		if(!curGroupType && $('#pm_atgroup').val()){
			if($('#pm_atgroup').val().indexOf("整体") != -1){
				curGroupType = "zhengti";
			}else{
				curGroupType = "fenbu";
			}
		}
		
		if("${ztleader}" == "true" || "${ztleader}" == true){
			$('#pm_atgroup').css('border-width','0px');
			$('#pm_atgroup_select').remove();
			$('#pm_role').append("<option value='zuzhang'>组长</option>");
		}/*else if(curGroupType){
			if(curGroupType == "zhengti"){
				$('#pm_role').append("<option value='zuyuan'>组员</option>");
				$('#pm_role').append("<option value='zhushen'>主审</option>");
			}else if(curGroupType == "fenbu"){
				//判断小组长是否存在
				var isHaveXiaoZuZhang = false;
				if(curGroupId){					
					$.each(memberRows, function(i, row){
						if(row['groupId'] == curGroupId 
								&& row['role'] == "xiaozuzhang" 
								&& row['userId'] != $('#pm_userId').val()){
							isHaveXiaoZuZhang = true;
						}
					});
				}
				$('#pm_role').append("<option value='zuyuan'>组员</option>");
				$('#pm_role').append("<option value='zhushen'>主审</option>");
				if(!isHaveXiaoZuZhang){					
					$('#pm_role').append("<option value='xiaozuzhang'>小组长</option>");
				}
			}
		}*/else{			
			$('#pm_role').append("<option value='zuyuan'>组员</option>");
			$('#pm_role').append("<option value='zhushen'>主审</option>");
			$('#pm_role').append("<option value='xiaozuzhang'>小组长</option>");
		}
		$('#pm_role').combobox({
			editable:false,
			panelHeight:'auto',
			onSelect:function(rec){
				$('#pm_roleName').val(rec.text);
				$('#pm_belongToUnitId, #pm_belongToUnitName, #pm_userName, #pm_userId').val('');
				var roleVal = rec.value;
				if(roleVal == 'zuzhang' || roleVal == 'xiaozuzhang'){
					var isExists = aud$checkMemberExists({
						"projectId":"${projectId}",
						"groupId"  :$('#pm_groupId').val(),
						"roleId"   :roleVal
					});
					//alert('isExists='+isExists)
					if(isExists){
						$('#pm_userName, #pm_userId').val('');
					}
				}
			}
		});
		if(proMemberId){
			$('#pm_role').combobox('setValue', '${pm.role}');
			$('#userSelectDiv').remove();
		}else{		
			$('#pm_roleName').val($('#pm_role').combobox('getText'));
		}
		
	},0);
	
	//保存组员
	function saveMember(){
		try{
			aud$saveForm('memberForm', "${contextPath}/intctet/prepare/assessScheme/saveProjectMember.action", function(data){
				if(data){
					data.msg ? showMessage1(data.msg) : null;	
					if(data.type == 'info'){
		  				var tabWin = aud$parentDialogWin();
		  				var sureWin = tabWin.$('#sureTeam').get(0).contentWindow;
		  				if(sureWin){	  					
		        			sureWin.memberListrefresh({
		        	   			"query_eq_groupId":$('#pm_groupId').val()
		        	   		});
		  				}
		  				$('#mCloseBtn').trigger('click');
					}
		 		}
		    });
		}catch(e){
			alert("saveMember:\n"+e.message);
		}
	}
});

//小组成员选择确定前执行
function aud$UserSelectOnBeforeSure(curContext, dms, mcs){
	try{
		//alert(dms+"\n"+mcs)
		var roleName = $('#pm_role').combobox('getText');
		var roleId = $('#pm_role').combobox('getValue');
		var groupId = $('#pm_groupId').val();
		var isSingleSelect = roleId == 'zuzhang' || roleId == 'xiaozuzhang' ? true : false;
		if(isSingleSelect && dms.length > 1){
			//top.$.messager.alert("提示信息","【"+roleName+"】只能选择一人", "warning");
			showMessage1("【"+roleName+"】只能选择一个人");
			return false;
		}else{
			var param = {
				"projectId":"${projectId}",
				"groupId"  :groupId,
				"roleId"   :roleId
			};
			if(!isSingleSelect){				
				param = $.extend({}, param, {
					"userId"   :dms.join(",")
				});
			}
			return !aud$checkMemberExists(param);
		}
	}catch(e){
		alert('aud$UserSelectOnBeforeSure:\n'+e.message);
	}
}

function aud$checkMemberExists(param){
	var isExists = false;
	$.ajax({
		url:"${contextPath}/intctet/prepare/assessScheme/checkMemberExists.action",
		dataType:'json',
		async:false,
		type: "post",
		data: param,
		beforeSend:function(){
			aud$loadOpen();
			return true;
		},
		success: function(data){
			aud$loadClose();
			data.msg ? showMessage1(data.msg) : null;
			isExists = data.isExists
			//alert('isExists='+isExists)
		},
		error:function(data){
			aud$loadClose();
			top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
		}
	});
	return isExists;
}

//小组成员选择的确定事件
function aud$UserSelectOnAfterSure(){
	try{
		var rows = $(this).datagrid("getChecked");
		var orgIdArr = [], orgNameArr = [];
		if(rows && rows.length){		
			$.each(rows, function(i, row){
				//alert(row['name']+"\n"+row['company']+"\n"+row['companyCode']);
				orgIdArr.push(row['companyCode']);
				orgNameArr.push(row['company']);
			});
		}
		$('#pm_belongToUnitId').val(orgIdArr && orgIdArr.length ? orgIdArr.join(",") : "");
		$('#pm_belongToUnitName').val(orgNameArr && orgNameArr.length ? orgNameArr.join(",") : "");
	}catch(e){
		alert('aud$UserSelectOnAfterSure:\n'+e.message);
	}
}

//复核权限确定事件
function aud$AuthOnAfterSure(){
	try{
		var chkNodes = $(this).tree('getChecked');
		var arr = [];
		if(chkNodes && chkNodes.length){
			$.each(chkNodes, function(i, chkNode){
			 	var attr = chkNode.attributes;
			 	var json = new Function("return " + attr)();
				var mrlLevel = json.mrlLevel;
				mrlLevel ? arr.push(mrlLevel) : null;
			});
		}
		$('#pm_mrlLevel').val(arr && arr.length ? arr.join(",") : '');		
	}catch(e){
		alert('aud$AuthOnAfterSure:\n'+e.message);
	}
}

//获得分组的类型
function aud$getGroupType(dms){
	try{
		var snode = $(this).tree('getSelected');
		if(snode){
			var attr = snode.attributes;
			var json = new Function("return " + attr)();
			$('#pm_groupType').val(json.groupType);
			$('#pm_groupTypeName').val(json.groupTypeName);
		}	
	}catch(e){
		alert('aud$getGroupType:\n'+e.message);
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
			<a id='mSaveBtn'  class="easyui-linkbutton editElement" iconCls="icon-save" style='border-width:0px;'>保存</a>	
 			<a id='mCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a>				
		</div>	
	</div>
	<div region='center' border='0' title="" split="true" id="layoutCenter">
		<form id="memberForm" name="memberForm">
			<table class="ListTable" align="center" style='table-layout:fixed;margin-top:0px;'>
				<tr>
					<td class="EditHead" style="width:20%;" nowrap><font class='editElement' color='red'>*</font>所属分组</td>
					<td class="editTd"   >
						<input type='text' id='pm_atgroup' name='pm.atgroup' value="${pm.atgroup}" 
						 title='所属分组' class="noborder editElement clear required" readonly/>
						<input type='hidden' id='pm_groupId' name='pm.groupId' value="${pm.groupId}" 
						 title='所属分组Id' class="noborder editElement clear required" readonly/>
						<a  id="pm_atgroup_select" class="easyui-linkbutton  editElement "
							 iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
                                  title:'所属分组选择',
                                  onlyLeafClick:true,
								  param:{
								  	'serverCache':false,
									'customRoot':'项目分组',
									'plugId':'InterMemberGroupSelect',
								  	'rootParentId':'notnull',
				                    'beanName':'InterMemberGroup',
				                    'treeId'  :'groupId',
				                    'treeText':'groupName',
				                    'treeParentId':'groupType',
				                    'treeOrder':'createTime',
				                    'whereHql':'projectFormId=\'${projectId}\'',
				                    'treeAtrributes':'groupType,groupTypeName'
				                 },
				                 onAfterSure:aud$getGroupType                             
						})"></a>
						<span id='view_atgroup' class="noborder viewElement clear">${pm.atgroup}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:20%;" nowrap><font class='editElement' color='red'>*</font>所属类型</td>
					<td class="editTd"   >
						<input type='hidden' id="pm_groupType"     name="pm.groupType"     value="${pm.groupType}" 
							title='所属类型Code' class="noborder editElement clear required" readonly/>
						<input type='text' id="pm_groupTypeName" name="pm.groupTypeName" value="${pm.groupTypeName}" 
							title='所属类型' class="noborder editElement clear required"  style="border-width:0px;" readonly/>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:20%;" nowrap><font class='editElement' color='red'>*</font>项目角色</td>
					<td class="editTd">
						<input type='hidden' id='pm_roleName' name='pm.roleName' value="${pm.roleName}" 
						 title='项目角色' class="noborder editElement clear required" readonly/>
						<select class="editElement clear required"  id="pm_role" name="pm.role"  panelHeight="auto">

						</select>
						<span id='view_roleName' class="noborder viewElement clear">${pm.roleName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:20%;" nowrap><font class='editElement' color='red'>*</font>小组成员</td>
					<td class="editTd" >
						<div id="userSelectDiv">					
							<input type='text' id='pm_userName' name='pm.userName' value="${pm.userName}" 
							 title='小组成员名称' class="noborder editElement clear required" readonly/>
							<input type='hidden' id='pm_userId' name='pm.userId' value="${pm.userId}" 
							 title='小组成员Id' class="noborder editElement clear required" readonly/>
							<a  class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
								onclick="showSysTree(this,{
	                                  title:'小组成员选择',
									  param:{
									  	'rootParentId':'0',
					                    'beanName':'UOrganizationTree',
					                    'treeId'  :'fid',
					                    'treeText':'fname',
					                    'treeParentId':'fpid',
					                    'treeOrder':'fcode'
					                 },
					                 type:'treeAndUser',
					                 onAfterSure:aud$UserSelectOnAfterSure,
					                 onBeforeSure:aud$UserSelectOnBeforeSure
							})"></a>
						</div>
						<span id='view_userName' class="noborder  clear">${pm.userName}</span>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:20%;" nowrap>复核权限</td>
					<td class="editTd"   >
						<input type='text' id='pm_checkAuthority' name='pm.checkAuthority' value="${pm.checkAuthority}" 
						 title='复核权限' class="noborder editElement clear " readonly/>
						<input type='hidden' id='pm_checkAuthorityCode' name='pm.checkAuthorityCode' value="${pm.checkAuthorityCode}" 
						 title='复核权限Id' class="noborder editElement clear " readonly/>
						<a class="easyui-linkbutton  editElement " iconCls="icon-search" style='border-width:0px;'
							onclick="showSysTree(this,{
                                  title:'复核权限选择',
                                  onlyLeafClick:true,
                                  checkbox:true,
								  param:{
								  	'serverCache':false,
									'customRoot':'复核权限',
									'plugId':'ManuReviewLevelSelect',
								  	'rootParentId':'notnull',
				                    'beanName':'ManuReviewLevel',
				                    'treeId'  :'mrlId',
				                    'treeText':'mrlName',
				                    'treeParentId':'code',
				                    'treeOrder':'code',
				                    'treeAtrributes':'mrlLevel'
				                 }, 
                                 onAfterSure:aud$AuthOnAfterSure				                 
						})"></a>
						<span id='view_checkAuthority' class="noborder viewElement clear">${pm.checkAuthority}</span>
					</td>
				</tr>
			</table>
			<input type='hidden' id="pm_proMemberId"   name="pm.proMemberId"   value="${pm.proMemberId}"/>
			<input type='hidden' id="pm_projectFormId" name="pm.projectFormId" value="${pm.projectFormId}"/>
			<input type='hidden' id="pm_mrlLevel"      name="pm.mrlLevel"      value="${pm.mrlLevel}"/>
			<input type='hidden' id="pm_belongToUnitId"   name="pm.belongToUnitId"   value="${pm.belongToUnitId}"/>
			<input type='hidden' id="pm_belongToUnitName" name="pm.belongToUnitName" value="${pm.belongToUnitName}"/>
			
		</form>		
	</div>
</body>
</html>