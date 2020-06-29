<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
<title>项目组成员添加、修改、查看</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>

<script type="text/javascript">
$(function(){
	initCombobox('pm_checkAuthority');
	var isView = "${view}";
	var fileContainer = isView ? 'view_attachFile' : 'edit_attachFile';
	isView ?  $('.editElement').hide() : $('.viewElement').hide();
	var parentTabId = '${parentTabId}';
	var curTabId = aud$getActiveTabId();
 	if(!isView){		
		$("#mebSaveBtn").bind('click', function(){
			 var value = $('#pm_role').combobox('getText');//角色
        	 $("#pm_roleName").val(value);
        	 var groupId = $('#pm_groupId').combobox('getText');//所属分组
    		 $("#pm_atgroup").val(groupId);
		   	 aud$saveForm('proMemberForm', "${contextPath}/intctet/prepare/assessScheme/saveProMember.action", function(data){
				 if(data){
					 data.msg ? showMessage1(data.msg) : null;	
					 if(data.type == 'info'){
						var proMemberId = data.proMemberId;
						if(proMemberId){
							 $('#pm_proMemberId').val(proMemberId);
						}
						
						// 刷新tab页里面的dvAudProjectList列表
						aud$getTabIframByTabId(parentTabId).proMebList.refresh();
						aud$closeTab(curTabId, parentTabId);					
					 }
				 }
			 });
		});
	}else{
		$("#mebSaveBtn").remove();
	} 
	$("#mebCloseBtn").bind('click', function(){
		aud$closeTab(curTabId, parentTabId);
	});
	
	$('#aslayout').layout('resize'); 
	
	 function initCombobox(id){  
	        var value = "";  
	        //加载下拉框复选框  
	        $('#'+id).combobox({  
	            url:'${contextPath}/intctet/prepare/assessScheme/getComboboxData.action', //后台获取下拉框数据的url  
	            method:'post',  
	            panelHeight:200,//设置为固定高度，combobox出现竖直滚动条  
	            valueField:'CODE',  
	            textField:'NAME',  
	            multiple:true,  
	           formatter: function (row) { //formatter方法就是实现了在每个下拉选项前面增加checkbox框的方法  
	                var opts = $(this).combobox('options');  
	                return '<input type="checkbox" class="combobox-checkbox">' + row[opts.textField]  
	            },  
	           onLoadSuccess: function () {  //下拉框数据加载成功调用  
	                var opts = $(this).combobox('options');  
	                var target = this;  
	                var values = $(target).combobox('getValues');//获取选中的值的values  
	               $.map(values, function (value) {  
	                    var el = opts.finder.getEl(target, value);  
	                   el.find('input.combobox-checkbox')._propAttr('checked', true);   
	              })  
	           },  
	           onSelect: function (row) { //选中一个选项时调用  
	                var opts = $(this).combobox('options');  
	                //获取选中的值的values  
	               $("#"+id).val($(this).combobox('getValues'));  
	                 
	               //设置选中值所对应的复选框为选中状态  
	                var el = opts.finder.getEl(this, row[opts.valueField]);  
	                el.find('input.combobox-checkbox')._propAttr('checked', true);  
	          },  
	            onUnselect: function (row) {//不选中一个选项时调用  
	                var opts = $(this).combobox('options');  
	                //获取选中的值的values  
	                $("#"+id).val($(this).combobox('getValues'));  
	                var el = opts.finder.getEl(this, row[opts.valueField]);  
	               el.find('input.combobox-checkbox')._propAttr('checked', false);  
	            }  
	        });  
	    }  
});
</script>
<style type="text/css">
input[class~=editElement]{
	width:85% !important;
}
</style>
</head>
	<body style='padding:0px;margin:0px;overflow:hidden;' id="aslayout" class='easyui-layout' border='0' fit='true'>
	<div region="north" border="0">
 	    <div align = "right">
 	    	<a id='mebSaveBtn'  class="easyui-linkbutton" iconCls="icon-save" style='border-width:0px;'>保存</a>
            <a id='mebCloseBtn' class="easyui-linkbutton" iconCls="icon-cancel" style='border-width:0px;'>关闭</a> 
 	   </div>
 	</div>
	<div region='center' border='0'>
	<form  id='proMemberForm' name='proMemberForm' method="POST" >
	 	    <input type='hidden' id="pm_projectFormId" name="pm.projectFormId"  class="noborder editElement clear" value="${projectFormId}"/>
			<input type='hidden' id="pm_proMemberId" name="pm.proMemberId"  class="noborder editElement clear" value="${pm.proMemberId}"/>
			<table class="ListTable" align="center" style='table-layout:fixed;'>
				<tr>
					<td class="EditHead" style="width:15%;"><font class="editElement"  color=red>*</font>所属小组</td>
					<td class="editTd" style="width:35%;">
					   <input type='hidden' id="pm_atgroup" name="pm.atgroup"  class="noborder editElement clear" value="${pm.atgroup}"/>
						 <s:if test="${view != true}">
						 	<select class="easyui-combobox" name="pm.groupId" style="width:150px;" id="pm_groupId"  panelHeight="auto">
							   <option value="">&nbsp;</option>
							   <s:iterator value="allgroupName">
							       		<s:if test="${pm.groupId== key}">
											<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
										</s:if>
								 		<s:else> 
											<option value="<s:property value="key"/>"><s:property value="value"/></option>
								 		 </s:else>  
							    </s:iterator> 
							</select>
						 </s:if>
						<s:else>
							<span id='view_atgroup' class="noborder viewElement clear">${pm.atgroup}</span>
						</s:else>
					</td>
					<td class="EditHead"><font class="editElement"  color=red>*</font>项目角色</td>
					<td class="editTd">
					<input type='hidden' id='pm_roleName' name='pm.roleName' title="项目角色" value="${pm.roleName}"
						  class="noborder editElement clear required" readonly/>
					 <s:if test="${view != true}">
						<select class="easyui-combobox" id="pm_role" name="pm.role" style="width:80%;" panelHeight="auto">
						   	   	<option value="">&nbsp;</option>
								<s:iterator value="@ais.project.ProjectUtil@getProRolesList()">
						        <s:if test="${pm.role ==key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
								 </s:if>
								 <s:else>
									 <option value="<s:property value="key"/>"><s:property value="value"/></option>
								 </s:else>
						    	</s:iterator>
						</select>
					</s:if>
					<s:else>
						<span id='view_roleName' class="noborder viewElement clear" >${pm.roleName}</span>
					</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead" ><font class="editElement"  color=red>*</font>姓名</td>
					<td class="editTd" style="width:35%;">
						<input type='text' id='pm_userName' name='pm.userName' title="人员" value="${pm.userName}"
						 class="noborder editElement clear required" readonly/>
						<input type='hidden' id='pm_userId' name='pm.userId' title="人员Code"  value="${pm.userId}"
						class="noborder editElemepmnt clear"/>
						<img  style="cursor:hand;border:0" src="/ais/resources/images/s_search.gif" class=" editElement "
							onclick="showSysTree(this,{
                                  title:'请选择姓名',
                                  type:'treeAndUser',
                                 // defaultDeptId:'${user.fdepid}',
                                  //defaultUserId:'${user.floginname}',
                                  // 是否显示复选框
                                  checkbox:true,
								  param:{
								  	'rootParentId':'0',
				                    'beanName':'UOrganizationTree',
				                    'treeId'  :'fid',
				                    'treeText':'fname',
				                    'treeParentId':'fpid',
				                    'treeOrder':'fcode'
				                 }                                  
						})"></img>
						<span id='view_userName' class="noborder viewElement clear" style='width:50%;display:inline;'>${pm.userName}</span>
					</td>
					<td class="EditHead"><font class="editElement"  color=red>*</font>复核级次</td>
					<td class="editTd">
 						 <input id='pm_checkAuthority' name='pm.checkAuthority' class="easyui-combobox  noborder editElement clear required"
						title='底稿复核级次' panelHeight="auto" style="width: 240px;"  />  
					</td>
				</tr>
			</table>
			
		</form>					
	</div>
	<!-- 引入公共文件 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>