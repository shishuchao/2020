<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目小组成员</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<!-- <link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" /> -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
        <script type="text/javascript">
        	function setProRole3(rec){
    			var zhengTiGroupId = $('#zhengTiGroupId').val();
   				var groupId = $('#groupId').combobox('getValue');
   				if(groupId != zhengTiGroupId){
					$('#role').combobox('reload','${contextPath}/pages/project/start/member/fenzu.json');
					$('#role').combobox('setValue', 'zuzhang');
             	}else{
             		$('#role').combobox('reload','${contextPath}/pages/project/start/member/zhengti.json');
             		$('#role').combobox('setValue', 'fuzeren');
             	}
        	}
 			$(document).ready(function(){
 				var zhengTiGroupId = $('#zhengTiGroupId').val();
 				var groupId = '${proMember.group.groupId}';
 				var groupText = $('#groupId').combobox('getText');
 				if('${roleView}' == "1" && groupText== '审计整体小组') {
 					$('#role').combobox({
 	 	        		url:'${contextPath}/pages/project/start/member/zhengti.json',
 	 	        	    valueField:'id',
 	 	        	    textField:'text',
 	 	             });
 				} else {
 					$('#role').combobox({
 	 	        		url:'${contextPath}/pages/project/start/member/fenzu.json',
 	 	        	    valueField:'id',
 	 	        	    textField:'text',
 	 	             });
 				}
 				
 				var role = '${proMember.role}';
	            if(role != null) {
	            	$('#role').combobox('setValue',role) ;
	            }
			}); 
        </script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	  	<s:form id="memberForm" action="saveMember" namespace="/project">
			<div region="center">
				<s:token/>
		  		<s:hidden name="crudId"/>
		  		<s:hidden name="proMemberId"/>
		  		<s:hidden name="proMemberIndex"/>
		  		<s:hidden name="isAddByPlan"/>
		  		<s:hidden name="addMemberOption"/>
		  		<s:hidden id="zhengTiGroupId" name="group.groupId"/>
				<table id="projectMemberTable" cellpadding="0" cellspacing="1" border="0" class="ListTable" align="center">
					<tr>
						<td class="EditHead" style='width:70px;' nowrap>
							<font color=red>*</font>
							分组名称
						</td>
						<td class="editTd" >
							<s:if test="${comeFrom == 'list'}">
						      	<select class="easyui-combobox"
									name="proMember.group.groupId" id="groupId" data-options="panelHeight:'auto',onSelect:function(rec){setProRole3(rec)}">
								       <s:iterator value="crudObject.proMemberGroups" >
								       		<s:if test="${proMember.group.groupId == groupId}">
								       			<option value="<s:property value="groupId"/>" selected="selected"><s:property value="groupName"/></option>
								       		</s:if>
						       		   		<s:else>
						       		   			<option value="<s:property value="groupId"/>"><s:property value="groupName"/></option>
						       		   		</s:else>
								       </s:iterator>
							    </select>
						    </s:if>
						    <s:else>
						      	<select class="easyui-combobox" editable="false"
									name="proMember.group.groupId" id="groupId" data-options="panelHeight:'auto',onSelect:function(rec){setProRole3(rec)}">
								       <s:iterator value="crudObject.proMemberGroups" >
								       		<s:if test="${proMember.group.groupId == groupId}">
								       			<option value="<s:property value="groupId"/>" selected="selected"><s:property value="groupName"/></option>
								       		</s:if>
						       		   		<s:else>
						       		   			<option value="<s:property value="groupId"/>"><s:property value="groupName"/></option>
						       		   		</s:else>
								       </s:iterator>
							    </select>
						    </s:else>
						</td>

						<td class="EditHead">
							<font color=red>*</font>
							项目角色
						</td>
						<td class="editTd">
							 <select name="proMember.role" id="role" data-options="editable:false,panelHeight:'auto'"></select>
						</td>
					</tr>
					
					<tr>
						<td class="EditHead">
							<font color=red>*</font>
							项目成员
						</td>
						<td class="editTd" colspan='3'>
							  <s:if test="${comeFrom == 'list'}">
							  		<s:textfield name="proMember.userName" cssClass="noborder" readonly="true"></s:textfield>
							  		<s:hidden name="proMember.userId" id="userId"></s:hidden>
							  </s:if>
							  <s:else>
							  	<div id='selectMemberDiv' style='width:100%;'>
								  	<input type='text' id='proMember_userName' name='proMember.userName' 
								  		value='${proMember.userName}'/>
								  	<input type='text' id='userId' name='proMember.userId' 
								  		value='${proMember.userId}'/>	  	
							  	</div>
							  </s:else>
						</td>
					</tr>
				</table>
			</div>
			<div region="south" border="false" style="text-align:right;padding-right:20px;">
				<div style="display: inline;" align="right">
					<a id="saveButton" class="easyui-linkbutton" iconCls="icon-save" href="javascript:void(0)" onclick="toSave()">保存</a>
					&nbsp;&nbsp;
					<a id="exitButton" class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="toCancel()">取消</a>
				</div>
			</div>
		</s:form>
	
	<script type="text/javascript">
	
	// 内部审计人员选择初始化
	function aud$showMemberWin(){			
	    var MemberTarget = $('#selectMemberDiv')[0];
	    var winJson = showSysTree(MemberTarget, {
	        container: MemberTarget,
	        queryBox:false,
	        url: '${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
	        param: {
	            'p_issel': 1,
	            'beanName': 'UOrganizationTree'
	        },
	        title: '请选择项目成员',
	        type: 'treeAndEmployee'
	    })
	    $('#proMember_userName,#userId').hide();
	    var winOption = winJson.win.param;
	    var tableInfoWrap = winOption.tableInfo;
	    window.aud$memberSelGrid = tableInfoWrap;
	    setTimeout(function(){
	    	$(winOption.addbtn).hide();
	    	$(winOption.clearbtn).hide();
	    	$(winOption.exitbtn).hide();
	    	$(winOption.layout).layout('panel','west').panel('resize', {
	    		'width':'200px'
	    	});
	    	$(winOption.layout).layout('remove', 'south')
	    	//.layout('panel','south').panel('resize', {
	    	//	'height':'1px'
	    	//});	    	
	    	$(winOption.layout).layout('resize');
	    },0);
	    
	}	
	// 内部审计人员：隐藏域赋值
	function aud$assignMemberVal(){
		var tableInfoWrap = window.aud$memberSelGrid;
		//alert("tableInfoWrap:"+tableInfoWrap)
        var dms = $(tableInfoWrap).data('dms'); 
        var mcs = $(tableInfoWrap).data('mcs');  
        $('#userId').val(dms ? dms.join(',') : '');
        $('#proMember_userName').val(mcs ? mcs.join(',') : '');
	}	
	
	$(function(){
		aud$showMemberWin();
	});

	
		/**
		*	选择系统内用户
		*/
		function selectUser(){
			
			showPopWin('${contextPath}/pages/system/search/mutiselect.jsp?url=${contextPath}/pages/system/morg/userindex4morg.jsp&paraname=proMember.userName&paraid=proMember.userId&p_issel=1',580,500)
			
		}
		
		function toCancel() {
			window.parent.closedlg();
		}
		
		/**
		*	从审计人员库选择
		*/
		function selectEmployee(){
			
			showPopWin('${contextPath}/pages/system/search/selectemployee.jsp?url=${contextPath}/pages/system/employeeindex.jsp&paraname=proMember.userName&paraid=proMember.userId&p_issel=1',580,500)
			
		}
		
		function toSave(){

			var memberForm = document.getElementById('memberForm');
			var groupId = $('#groupId').combobox('getValue');
			var role = $('#role').combobox('getValue');
			
			if(null==role || role==''){
				window.parent.$.messager.show({
					title:'提示信息',
					msg:'请选择项目角色！'
				});
				return false;
			}
			
			// 内部审计人员隐藏域赋值
			var comeFrom = '${comeFrom}';
			var oldGroupId = '';
			if(comeFrom!='list'){
				aud$assignMemberVal();
			} else {
				oldGroupId = '${proMember.group.groupId}';
				if(groupId == oldGroupId) {
					oldGroupId = "";
				}
			}
			var userId = document.getElementById('userId').value;
			if(userId==''){
				window.parent.$.messager.show({
					title:'提示信息',
					msg:'请选择要添加的组员！'
				});
				return false;
			}
			$('#saveButton').linkbutton('disable');
			$.ajax({
			    url: '<%=request.getContextPath()%>/project/checkPromember.action',
	            data: {"groupId":groupId,"userIds":userId,"proMemberId":"${proMemberId}","role":role,"project_id":"${crudId}","oldGroupId":oldGroupId},
				type:'post',
				async: false,
				success:function(data){
					if (data == "1" || data == '3'){
						var flag = true;
						if(data == '3') {
							$.messager.confirm('提示信息','修改分组将清空该用户在原小组的审计分工，是否继续？',function(r){
								if(r) {
									$('#memberForm').form('submit',{
										url:'${contextPath}/project/saveMember.action?userId='+userId+'&project_id=${crudId}&oldGroupId='+oldGroupId,
										onSubmit:function(){
											return true; //当表单验证不通过的时候 必须要return false
										},
										success:function(result){
											window.parent.closedlg();
											window.parent.$.messager.show({
												title:'提示信息',
												msg:'保存成功！'
											});
										}
									});
								}else{
									$('#saveButton').linkbutton('enable');
								}
							});
						} else {
							$('#memberForm').form('submit',{
								onSubmit:function(){
									return true; //当表单验证不通过的时候 必须要return false
								},
								success:function(result){
									window.parent.closedlg();
									window.parent.$.messager.show({
										title:'提示信息',
										msg:'保存成功！'
									});
								}
							});
						}
					 }else if ( data == "2"){
							window.parent.$.messager.show({
								title:'提示信息',
								msg:data+"项目必须有一个主审人员！"
							});
							$('#saveButton').linkbutton('enable');
					 }else{
						window.parent.$.messager.show({
							title:'提示信息',
							msg:data+"同一组只能有一个角色！"
						});
						$('#saveButton').linkbutton('enable');
					}
				}
			}); 
		}
	</script>
	</body>
</html>
