<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>添加被审计单位资料</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<!-- 
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/swfload/uploadFile.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/csswin/common.js"></script>
		<s:head theme="ajax" />
		 -->
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<s:form id="myForm" action="saveAccessoryList" namespace="/auditAccessoryList">
			<div region="center" style="overflow:hidden;">
			<s:hidden name="operateAuth" id="operateAuth" />
			<s:hidden name="cruProId" value="${cruProId}" />
			<s:hidden name="auditUuid" value="${auditUuid}" />
			<s:include value=""></s:include>
<s:if test="${editIndex == '0' || editIndex == '1'}">
			<table cellpadding=0 cellspacing=1 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width:40%">
						<font color="red">*</font>&nbsp;资料清单
					</td>
					<td class="editTd" style="width:60%">
						<s:if test="${operateAuth==1}">
							<s:textfield name="auditUnionName" cssStyle="width:200px;z-index:9999" maxlength="50" cssClass="noborder"/>
						</s:if>
						<s:else>
							<s:textfield name="auditUnionName" cssStyle="width:200px;" maxlength="50" readonly="true" cssClass="noborder"/>
						</s:else>
					</td>
				</tr>
				<tr>
					<td class="EditHead">
						是否必传
					</td>
					<td class="editTd">
					<s:if test="${uploadRole==2}">
						<s:textfield name="needDo" cssStyle="width:200px;" readonly="true" />
					</s:if>
					<s:else>
						<select class="easyui-combobox" data-options="panelHeight:'auto'" name="needDo" style="width:200px;"  editable="false">
							<option value="是" <s:if test="${needDo=='是'}">selected</s:if>>是</option>
							<option value="否" <s:if test="${needDo=='否'}">selected</s:if>>否</option>
					    </select>	
					</s:else>
					</td>
				</tr>
				<%-- <tr>
					<td class="EditHead">
						审核
					</td>
					<td class="editTd">
					<s:if test="${uploadRole==2}">
						<s:textfield name="checkOption" cssStyle="width:200px;" readonly="true" />
					</s:if>
					<s:else>
						<select class="easyui-combobox" data-options="panelHeight:'auto'" name="checkOption" style="width:200px;"  editable="false">
							<option value="通过" <s:if test="${checkOption=='通过'}">selected</s:if>>通过</option>
							<option value="驳回" <s:if test="${checkOption=='驳回'}">selected</s:if>>驳回</option>
							<option value="未提交" <s:if test="${checkOption=='未提交'}">selected</s:if>>未提交</option>
							<option value="已提交" <s:if test="${checkOption=='已提交'}">selected</s:if>>已提交</option>
					    </select>
					</s:else>
					</td>
				</tr> --%>
			</table>
</s:if>
<s:elseif test="${uploadRole==1}">
			<table cellpadding=0 cellspacing=1 border=0 align="center" class="ListTable" style="margin-top:0">
			<!-- 模板上传 -->
				<tr>
					<td class="editTd" colspan=2 style="width:50%">
						<!-- <div id="accelerysModel" align="center">
							<s:property escape="false" value="accessoryListModel" />
						</div> -->
						<div id="templates"></div>
					</td>
				</tr>
				<tr>
					<td class="editTd" colspan=2>
				        <div style="color:red;margin-top:15px;">*温馨提示：仅支持03版的excel文件汇总；excel模板只能包含标题行（其他空白单元格不能有边框等格式），否则将无法成功汇总。</div>
					</td>
				</tr>
			</table>
</s:elseif>
		</div>
<s:if test="${editIndex == '0' || editIndex == '1'}">
		<div region="south" border="false" style="text-align:right;padding-right:20px;">
			<div style="display: inline;" align="right">
			<!--<s:if test="${uploadRole==1}">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-import'" onclick="UploadModel('accelerysModel','${auditUuid}')">上传模板</a>
			</s:if>
				&nbsp;&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="UploadResource('accelerysResource','${auditUuid}')">上传附件</a>
				&nbsp;&nbsp;-->
				<a id="saveButton" class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="myFun()">保存</a>
				&nbsp;&nbsp;
				<a id="exitButton" class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeme(true)">取消</a>
			</div>
		</div>
</s:if>
	</s:form>
<script type="text/javascript">
<s:if test="${editIndex == '0' || editIndex == '1'}">
	var isNew = '${isNew}';
	function closeme(flag) {
		//if (isNew=='true')
			window.parent.closedlg(flag);
		//else if(closerow)
		//	closerow(${editIndex},flag);
		//else if(window.parent.closerow)
		//	window.parent.closerow(${editIndex},flag);
	}
      function validate() {
          var flag = false;
          var auditUnionName = document.getElementsByName("auditUnionName")[0];
          if (auditUnionName.value) {
              flag = true;
          }
          return flag;
      }
      
      function myFun(){
		var auditUnionName = document.getElementsByName("auditUnionName")[0];
		if(''==auditUnionName){
			window.parent.$.messager.show({
				title:'消息',
				msg:'资料清单不能为空！'
			});
			return false;
		}
		$('#myForm').form('submit',{
       		onSubmit:function(){
           		return true; //当表单验证不通过的时候 必须要return false 
           	},
	        success:function(result){
	        	closeme(false);
				window.parent.$.messager.show({
					title:'消息',
					msg:'保存成功！'
				});
	        }
	    });
      }
$(document).ready(function(){
	myForm_auditUnionName.focus();
});	
</s:if>
<s:elseif test="${uploadRole==1}">
	var editIndex='${editIndex}';
	var action;
	if (editIndex.substr(0,1)=='2')
		action='saveTemplate.action';
	else
		action='saveAccessory.action';
	editIndex=editIndex.substr(1);
	$(function(){
		$('#templates').fileUpload({
			fileGuid:editIndex,
			isAdd:true,
			isEdit:false,
			isDel:false,
			fileGridTitle:'',
		 	callbackGridHeight:450,
			onFileSubmitSuccess:function(data,options){
				jQuery.ajax({
					url:'${contextPath}/auditAccessoryList/'+action,
					type:'POST',
					data:{"savetype":"new","guid":options.fileGuid,"aaid":"${auditUuid}"},
					dataType:'json',
					async:'false',
					success:function(data){
						$.messager.show({
							title:'提示信息',
							msg:'上传成功！'
						});
					},
					error:function(){
					}
				});
			}
		});
	});
</s:elseif>
/*
function UploadModel(idName,uuid) {
	if(isNew){
		window.parent.$.messager.show({
			title:'消息',
			msg:'请先保存资料清单基本信息，然后再上传模板和附件！'
		});
		return ;
	}
    var contextPath = '${contextPath}';
	var deletePermission = 'true';
	var isEdit = "false";
	var width = 850;
	var height = 450;
    uploadFileModel(contextPath,uuid,deletePermission,isEdit,idName,width,height,'模板');
}
function UploadResource(idName,uuid){
	var operateAuth = document.getElementById("operateAuth").value;//用来判断用户角色，组长、主审、组员
	if(isNew){
		window.parent.$.messager.show({
			title:'消息',
			msg:'请先保存资料清单基本信息，然后再上传模板和附件！'
		});
		return ;
	}
	
	var contextPath = '${contextPath}';
	var deletePermission = 'true';
	var isEdit = "false";
	var width = 650;
	var height = 450;
	var obj = window.document.getElementById("templateGuid");
	var index = obj.selectedIndex;
	var templateGuid = obj.options[index].value;
	if(templateGuid==''){
		window.parent.$.messager.show({
			title:'消息',
			msg:'请选择附件对应的模板，然后再上传！'
		});
		return false;
	}
	uploadFileResource(contextPath,uuid,deletePermission,isEdit,idName,width,height,'附件',templateGuid,operateAuth)
}
function auth(accessoryId){
	showPopWin('${pageContext.request.contextPath}/pages/auditAccessoryList/searchdatamuti.jsp?url=${contextPath}/project/memberList.action&crudId=${cruProId}&accessoryId='+accessoryId,600,350,'被审计单位资料授权');
}
function deleteFile(fileId,guid,auditUuid,accessoryId,isDelete,isEdit,appType,title){
    $.messager.confirm('确认', '确认删除吗？', function(r){
    	if (r){
    		if(title=="模板"){
        		DWREngine.setAsync(false);
    	        DWREngine.setAsync(false);DWRActionUtil.execute(
    	            { namespace:'/auditAccessoryList', action:'deleteTemplate', executeResult:'false' },
    	            {'fileId':fileId,'auditUuid':auditUuid,'accessoryId':accessoryId,'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
    	            xxx1);
    	        function xxx1(data){
    	            document.getElementById('accelerysModel').innerHTML=data['accessoryListModel'];
    	        }
            
           }else{
        	     DWREngine.setAsync(false);
    	         DWREngine.setAsync(false);DWRActionUtil.execute(
    	         { namespace:'/auditAccessoryList', action:'deleteAccessory', executeResult:'false' },
    	         {'fileId':fileId,'auditUuid':auditUuid, 'accessoryId':accessoryId,'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
    	                 xxx2);
    	         function xxx2(data) {
    	             document.getElementById('accelerysResource').innerHTML = data['accessoryListResource'];
    	         }
           }
    	}
    });
}*/
</script>
	</body>
</html>