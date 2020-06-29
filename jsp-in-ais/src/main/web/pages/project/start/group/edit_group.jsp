<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<base target="_self">
		<title>项目小组</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
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
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
  	<s:form id="groupForm" action="saveGroup" namespace="/project"> 
		<div region="center">
  		<s:token/>
  	  	<s:hidden id="projectFormId" name="projectFormId"/>
  		<s:hidden  id="groupId" name="groupId"/>
  		<s:hidden id="crudId" name="crudId"/>
  		<s:hidden name="group.groupType"/>
  		<s:hidden name="group.groupTypeName"/>
		<table id="projectGroupTable" cellpadding="0" cellspacing="1" border="0"  class="ListTable" align="center">
		
		<s:if test="${group.groupType == 'zhengti'}">
		  			<tr>
				<td class="EditHead" nowrap>
					
					整体组名称
				</td>
				<td class="editTd">
				   <s:property value="group.groupName" />
				   <s:hidden id="groupName" name="group.groupName"/>
				    <s:hidden id="description" name="group.description"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap>
					<font color=red>*</font>
					被审计单位
				</td>
				<td class="editTd">
					<!-- 被审计单位根节点id -->
					<s:buttonText2
							id="auditObjectName" name="group.auditObjectName"
							hiddenId="auditObject" hiddenName="group.auditObject"
							cssStyle="width:300px;" cssClass="noborder editElement required"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
							  param:{'departmentId':'${magOrganization.fid}'},
							  checkbox:true,
							  title:'被审计单位树'
							})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							title="被审单位" maxlength="1500"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap>
					整体组组长
				</td>
				<td class="editTd">
				     <s:property value="group.pro_teamleader_name"/>
				     <s:hidden id="pro_teamleader_name" name="group.pro_teamleader_name"/>
				     <s:hidden id="pro_teamleader" name="group.pro_teamleader"/>
				</td>
			</tr>
		</s:if>
		<s:else>
		 			<tr>
				<td class="EditHead" nowrap>
					<font color=red>*</font>
					分组名称
				</td>
				<td class="editTd">
				
					<s:textfield id="groupName" name="group.groupName" cssClass="noborder editElement required"
						maxlength="100" cssStyle="width:300px;" title="分组名称"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap>
					<font color=red>*</font>
					被审计单位
				</td>
				<td class="editTd">
					<!-- 被审计单位根节点id -->
					<s:buttonText2
							id="auditObjectName" name="group.auditObjectName"
							hiddenId="auditObject" hiddenName="group.auditObject"
							cssStyle="width:300px;" cssClass="noborder editElement required"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
							  param:{'departmentId':'${magOrganization.fid}'},
							  checkbox:true,
							  title:'被审计单位树'
							})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							title="被审单位" maxlength="1500"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap>
					<font color=red>*</font>
					分组说明
				</td>
				<td class="editTd">
					<s:textfield id="description" name="group.description" cssClass="noborder editElement required"
						maxlength="100" cssStyle="width:300px;" title="分组说明"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead" nowrap>
					<font color=red>*</font>
					分组组长
				</td>
				<td class="editTd">
					<s:buttonText2 id="pro_teamleader_name" hiddenId="pro_teamleader" cssClass="noborder editElement required"
									   name="group.pro_teamleader_name"
									   hiddenName="group.pro_teamleader"
									   doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                  param:{
                                  'p_item':3
                             			},
                                  singleSelect:true,
                                  title:'请选择项目组长',
                                  type:'treeAndEmployee'

								})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:pointer;border:0"
									   readonly="true"
								   cssStyle="width:300px;"
							 maxlength="100" title="分组组长"/>
				</td>
			</tr>
		
		</s:else>

		</table>
	</div>
	<div region="south" border="false" style="text-align:right;padding-right:20px;">
		<div style="display: inline;" align="right">
			<a class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="this.style.disabled='disabled';return toSave();">保存</a>&nbsp;&nbsp;
			&nbsp;&nbsp;
			<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="this.style.disabled='disabled';parent.close_win();">取消</a>
			
<%--			<input type="button" value="确定" onclick="this.style.disabled='disabled';return toSave();"/>--%>
<%--			&nbsp;&nbsp;--%>
<%--			<input type="button" value="取消" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/project/listGroups.action?crudId=${crudId}'"/>--%>
		</div>
	</div>
	</s:form>
	
	<script type="text/javascript">
	
		function isNameAlreadyExsit(){
			var result = 'Y';
			var groupName = document.getElementById('groupName').value;
			var currentGroupId = document.getElementById('groupId').value;
			var projectId = document.getElementById('crudId').value;
			var pro_teamleader = document.getElementById('pro_teamleader').value;
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/project/members', action:'isNameAlreadyExsit', executeResult:'false' }, 
				{'group.groupName':groupName,'group.groupId':currentGroupId,'group.proInfo.formId':projectId,'group.pro_teamleader':pro_teamleader},
				xxx);
			function xxx(data){
				var messages = data['messages'];
				if(messages != ''){
					result = messages;
				}
			}
			return result;
		}
	
		function toSave(){
			var auditObjects = document.getElementsByName('group.auditObject');
			if(!audEvd$validateform('groupForm')){
				return false;
			}

			var s = isNameAlreadyExsit();
			if (s== "Y"){
				window.parent.$.messager.show({
					title:'消息',
					msg:'小组名称已经存在,请更换一个小组名称!'
				});
				return false;
			}else if (s == "T"){
				window.parent.$.messager.show({
					title:'消息',
					msg:'用户在本分组已存在一个角色，请重新选怎！'
				});
				return false;
			}


			//groupForm.submit();
			//parent.close_win();
			//parent.window.location.reload();
			
			$('#groupForm').form('submit',{
        		onSubmit:function(){
            		return true; //当表单验证不通过的时候 必须要return false 
            	},
		        success:function(result){
	        		window.parent.close_win();
	        		window.parent.$('#list_groupList').datagrid('reload');
					window.parent.$.messager.show({
						title:'消息',
						msg:'保存成功！'
					});
		        }
		    });
		}
		
		
		$(function(){
			//问题类别树
			$('#auditObjectTrigger').bind('click', function(){
				var treeTarget = $('#auditObjectTrigger')[0];
				var audittree = showSysTree(treeTarget,{
				    title:'请选择被审计单位',
				    checkbox:true,
				    cache:false,
					param:{
						'serverCache':false,
				   	    "whereHql":"${audIds}",
					  	"rootParentId":"auditingObjectnull",
	                    "beanName":"AuditingObject",
	                    "treeId"  :"id",
	                    "treeText":"name",
	                    "treeParentId":"parentId",
	                   "treeOrder":"currentCode"
				   },
				   onAfterSure:function(){
				 		var jqTree = audittree.win.param.jqtree;
						var nodes = $(jqTree).tree('getChecked');
						var ids ="";
						var texts = "";
						
						for(var i= 0;i<nodes.length;i++){
							ids += nodes[i].id+",";
							texts+= nodes[i].text+",";
						}
						if(ids){
							ids = ids.substr(0,ids.length-1);
						}
						if(texts){
							texts = texts.substr(0,texts.length-1);
						}
					    $('#auditObject').val(ids);
						$('#auditObjectName').val(texts);  
				   }                                  
				})
			});
		})
	</script>
	
  </body>
</html>
