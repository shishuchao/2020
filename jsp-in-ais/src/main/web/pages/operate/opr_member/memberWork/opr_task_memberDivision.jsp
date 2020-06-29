<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<title>审计分工</title>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<style type="text/css">
		.datagrid-header td, .datagrid-body td, .datagrid-footer td {
			padding: 0px !important;
		}
	</style>
    </head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	    <div region="west" split="true"  border="0" style="width:300px;padding:0px;margin:0px;overflow:hidden;">
			<!-- <div style="width: 100%;position:absolute;top:0px;" id="div1" align="center" > -->
			<div region="north" >
				<table class="ListTable" align="center" style='width:100%; padding: 0px; margin: 0px;'>
					<tr class="EditHead">
						<td>
							<span style='float: left; text-align: left;'>被审计单位</span>
						</td>
					</tr>
				</table>
			</div>
			<div region="center">
				<ul id="groupTree"></ul>
			</div>
		</div>
		<div region="center">
			<table id="matterTreeGrid" style='width:100%; padding: 0px; margin: 0px;'></table>
		</div>
		
		
		<div id="toReport" title="批量分工" style='overflow:hidden;padding:0px;'>
			<s:form id="sendBackForm" action="" namespace="" method="post" >
				<table class="ListTable" align="center" >
					<tr class="listtablehead">
						<td valign="middle" nowrap="nowrap" class="EditHead" style="width: 10%">
							<span id="reportRemarksColour" style="color:red;">*</span>执行人
						</td>
						<td class="editTd" style="width: 90%">
							<select id="apm_taskAssign" class="easyui-combobox" name="audProMember.taskAssign" style="width:160px;" 
								editable="false" data-options="multiple:true, data: memberList, valueField: 'code', textField: 'name' ">
								<%-- <s:iterator value="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" id="entry">
									<s:if test="${audProMember.taskAssign == key}">
										<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:else>
								</s:iterator> --%>
							</select>
						</td>
					</tr>
					<tr class="listtablehead">
						<td valign="middle" nowrap="nowrap" class="EditHead " style="width: 10%">
							执行开始时间
						</td>
						<td class="editTd" style="width: 90%">
							<input type="text" id="apm_taskStartTime" name="audProMember.taskStartTime"
									class="easyui-datebox" editable="false" style="width: 150px"/>
						</td>
					</tr>
					<tr class="listtablehead">
						<td valign="middle" nowrap="nowrap" class="EditHead " style="width: 10%">
							执行结束时间
						</td>
						<td class="editTd" style="width: 90%">
							<input type="text" id="apm_taskEndTime" name="audProMember.taskEndTime"
									class="easyui-datebox" editable="false" style="width: 150px"/>
						</td>
					</tr>
				</table>
				<input  type="hidden" name="audProMember.project_id" id="apm_project_id"/>
				<input  type="hidden" name="audProMember.groupId" id="apm_groupId"/>
				<input  type="hidden" name="audProMember.auditObject" id="apm_auditObject"/>
				<input  type="hidden" name="audProMember.taskId" id="apm_taskId"/>
			</s:form>
			<br>
			<div style='text-align:center;' id='ToReportBtnDiv' style='padding:10px;'>
				<a  id='saveToReport'  class="easyui-linkbutton"  iconCls="icon-save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a  id='closeToReport' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</a>
			</div>
		</div>
		
		
</body>
<script type="text/javascript">
	var editIndex = undefined;
	var isAllExpand = false;
	var saveRows=new Array();
	var memberListAll = eval('(${memberList})');
	var memberList=new Array();
	var taskGroupList = eval('(${taskGroupList})');
	var groupTaskList = new Array();
	$(function(){
		$('#toReport').window({
			width:500,
			height:200,
			modal:true,
			collapsible:false,
			maximizable:false,
			minimizable:false,
			closed:true
		});
		$("#groupTree").tree({
			url:'${contextPath}/project/memberDivisionLeft.action?project_id=${project_id}',
			onClick: function(node){
				$('#matterTreeGrid').treegrid('load',{'project_id':'${project_id}','groupId':node.parentId,'auditObject':node.id});
				memberList=new Array();
				for(var i=0;i<memberListAll.length;i++){
					if(node.parentId==memberListAll[i].groupId){
						memberList.push(memberListAll[i]);
					}
				}
				editIndex = undefined;
				$('#apm_taskAssign').combobox('loadData',memberList);
				
				//该组下的事项
				groupTaskList=new Array();
				for(var i=0;i<taskGroupList.length;i++){
					if(taskGroupList[i].taskGroupAssign.indexOf(node.parentId)!=-1){
						groupTaskList.push(taskGroupList[i].taskTemplateId);
					}
				}

				$('#matterTreeGrid').treegrid('uncheckAll');
			},
			onLoadSuccess:function(node, data){
				$('#groupTree').tree("expandAll", null);
				data[0].target.click();
			}
		});

		$('#matterTreeGrid').treegrid({
			url:'${contextPath}/project/memberDivisionRight.action',
			queryParams:{'project_id':'${project_id}'},
			idField:'taskTemplateId',
			treeField:'taskName',
			parentField:'taskPid',
			animate : true,
			//rownumbers : true,
			singleSelect:false,
			checkOnSelect:true,
			selectOnCheck:true,
			toolbar:[
				<s:if test="${type ne 'view'}">
				{
					id:'save',
					text:'保存',
					iconCls:'icon-save',
					handler:function(){
						if(editIndex != undefined){
							$('#matterTreeGrid').treegrid('endEdit', editIndex);
							editIndex = undefined;
						}
						var rows = $('#matterTreeGrid').treegrid('getChanges', "updated");
						if(rows && rows.length){
							//判断执行人不能为空
							for(var i=0;i<rows.length;i++){
								if(rows[i].taskAssign==''){
									showMessage1('执行人不能为空');
									return false;
								}
								//判断执行开始时间和结束时间的校验
								var  taskStartTime = rows[i].taskStartTime;
								var  taskEndTime = rows[i].taskEndTime;
								if(taskStartTime > taskEndTime){
									$.messager.alert("错误","执行开始时间必须小于等于执行结束时间!");
									return false;
								}
							}
							
							var sendData = null;
							var updateRowsJson = rows.length ? aud$rows2Json("updateRow", rows) : {};
							sendData = $.extend({}, updateRowsJson);

							$.ajax({
								url : "${contextPath}/project/saveDivision.action",
								dataType:'json',
								type: "post",
								data: sendData,
								beforeSend:function(){
									return sendData != null;
								},
								success: function(data){
					       			if(data.type = 'info'){
										$('#matterTreeGrid').treegrid('uncheckAll');
					       				$('#matterTreeGrid').treegrid('acceptChanges');
					       			}
									showMessage1(data.msg);
								},
								error:function(data){
									top.$.messager.show({title:'提示信息',msg:'请求失败！请检查网络配置或者与管理员联系！'});
								}
							});
						}else{
							showMessage1("更新成功");
						}
					}
				},
				</s:if>
				{
					id:'expand',
					text:'展开全部',
					iconCls:'icon-expand',
					handler:function(){
						allExpand();
					}
				}
				<s:if test="${type ne 'view'}">
				,{
					id:'assign',
					text:'批量分工',
					iconCls:'icon-user',
					handler:function(){
						var rows = $('#matterTreeGrid').treegrid('getChecked');
						if(rows && rows.length){
							var selectIds = [];
							for(var i=0;i<rows.length;i++){
								if (rows[i].template_type == '0' ){
								}else{
									selectIds.push(rows[i].taskTemplateId);
								}
							}
							$('#apm_taskAssign').combobox('clear');
							$('#apm_project_id').val(rows[0].project_id);
							$('#apm_groupId').val(rows[0].groupId);
							$('#apm_auditObject').val(rows[0].auditObject);
							$('#apm_taskId').val(selectIds.join(','));
							$('#toReport').window('open');
						}else{
							showMessage1("请至少选择一条数据");
						}
					}
				},
				{
					id:'cancel',
					text:'取消分工',
					iconCls:'icon-cancel',
					handler:function(){
						var rows = $('#matterTreeGrid').treegrid('getChecked');
						if(rows && rows.length){
							var selectIds = [];
							for(var i=0;i<rows.length;i++){
								selectIds.push(rows[i].taskTemplateId);
							}
							var project_id = rows[0].project_id;
							var groupId = rows[0].groupId;
							var auditObject = rows[0].auditObject;

							$.ajax({
								type: "POST",
								dataType: 'json',
								url : "${contextPath}/project/cancelDivisionBath.action",
								data: {'audProMember.taskId':selectIds.join(','), 'audProMember.project_id':project_id,
									   'audProMember.groupId':groupId, 'audProMember.auditObject':auditObject},
								success: function(data){
									if(data.type == 'info'){
										$('#matterTreeGrid').treegrid('uncheckAll');
										$('#matterTreeGrid').treegrid('load',{'project_id':project_id,'groupId':groupId,
											'auditObject':auditObject});
										showMessage2("取消成功！");
									}else{
										showMessage2("取消失败！");
									}
								},
								error:function(data){
									showMessage2("请求失败！");
								}
							});
						}else{
							showMessage1("请至少选择一条数据");
						}
					}
				}
				</s:if>
			],
			columns:[[
				{field:'taskTemplateId',align:'left',checkbox:true},
				{field:'taskName',title:'事项名称',width:'49%',align:'left',halign:'center'},
				{field:'taskAssign',title:'执行人',width:'25%',align:'center',halign:'center',
					editor:{type: 'combobox', options:  { multiple:true, data: memberList, valueField: "code", textField: "name", editable:false}},
					formatter:function(value, rowData) {
						if(value=='') return '';
						
						var memberName = "";
						var selArr = value.split(',');
						for(i in selArr){
							for(j in memberList) {
								if(memberList[j].code == selArr[i]) {
									memberName = memberName + ',' + memberList[j].name;
									break;
								}
							}
						}
						return memberName.substring(1);
					}},
				{field:'taskStartTime',title:'执行开始时间',width:'12%',align:'center',halign:'center',
					editor:{type:"datebox", options: {editable:false}}},
				{field:'taskEndTime',title:'执行结束时间',width:'12%',align:'center',halign:'center',
						editor:{type:"datebox", options: {editable:false}}}
			]],
			onExpand:function(row){
				if (!isAllExpand) return;
				var children = $('#matterTreeGrid').treegrid('getChildren',row.taskTemplateId);
				if(children.length>0){
					var c;
					for (var i=0;i<children.length;i++) {
						c  = children[i];
						if (c.state=='closed')
							$('#matterTreeGrid').treegrid("expand", c.taskTemplateId);
					}
				}
			},
			onDblClickCell:function(field, row){
				<s:if test="${type ne 'view'}">
				if(groupTaskList.length>0){
					var groupTaskStr = groupTaskList.join(',');
					//不是本组的事项，不允许编辑
					if(groupTaskStr.indexOf(row.taskTemplateId)==-1 || row.template_type == '0' ){
						/* $('#matterTreeGrid').treegrid('uncheckRow', row.taskTemplateId);
						$('#matterTreeGrid').treegrid('unselectRow', row.taskTemplateId);
						showMessage1("不是本组的审计事项"); */
					}else{
						if(editIndex == undefined){
							$('#matterTreeGrid').treegrid('beginEdit', row.taskTemplateId);
							editIndex=row.taskTemplateId;
						}else if(editIndex!=row.taskTemplateId){
							$('#matterTreeGrid').treegrid('endEdit', editIndex);
							$('#matterTreeGrid').treegrid('beginEdit', row.taskTemplateId);
							editIndex=row.taskTemplateId;
						}
						var ed = $('#matterTreeGrid').treegrid('getEditor', {id : editIndex, field : 'taskAssign'});
						$(ed.target).combobox('loadData',memberList);
					}
				}else{
					if ( row.template_type == '0' ){
						
					}else{
						if(editIndex == undefined){
							$('#matterTreeGrid').treegrid('beginEdit', row.taskTemplateId);
							editIndex=row.taskTemplateId;
						}else if(editIndex!=row.taskTemplateId){
							$('#matterTreeGrid').treegrid('endEdit', editIndex);
							$('#matterTreeGrid').treegrid('beginEdit', row.taskTemplateId);
							editIndex=row.taskTemplateId;
						}
						var ed = $('#matterTreeGrid').treegrid('getEditor', {id : editIndex, field : 'taskAssign'});
						$(ed.target).combobox('loadData',memberList);
					}

				}
				</s:if>
			},
			onAfterEdit:function(row,changes){
				var aa = row;
				saveRows.push(row);
			},
			onLoadSuccess:function(row, data){
				if(data.rows!=null)
				$('#matterTreeGrid').treegrid("expand", data.rows[0].taskTemplateId);
				//memberList = eval('${memberList}');
				/* var node = $('#matterTreeGrid').treegrid('find', '844AD842-1E47-8A49-D8D8-9974CBB4281F');
				if (node) {
	                var x = node.target.getElementsByClassName("tree-title");
	                var img = document.createElement("img");
	                img.src = "/ais/cloud/images/edit.gif";
	                x[0].parentNode.insertBefore(img, x[0]);
				} */
			},onCheck:function(row, checked){
				//$('#matterTreeGrid').treegrid('uncheckRow', '844AD842-1E47-8A49-D8D8-9974CBB4281F');
				if(groupTaskList.length>0){
					var groupTaskStr = groupTaskList.join(',');
					//不是本组的事项，不允许编辑
					if(groupTaskStr.indexOf(row.taskTemplateId)==-1){
						//$('#matterTreeGrid').treegrid('uncheckRow', row.taskTemplateId);
						//$('#matterTreeGrid').treegrid('unselectRow', row.taskTemplateId);
						//$('#matterTreeGrid').treegrid('unselectAll');
						showMessage1("不是本组的审计事项");
						setTimeout(function(){
							$('#matterTreeGrid').treegrid('unselectRow', row.taskTemplateId);
						}, 100);
					}
				}
			}
		});

		$('#saveToReport').bind('click',function(){
			var apm_taskAssign = $('#apm_taskAssign').combobox('getValues');
			if(apm_taskAssign.length==0){
				showMessage1("执行人不能为空");
				return false;
			}

            var startTime = $('#apm_taskStartTime').datebox("getValue").replace(/\s+/g, "").replace(/-/g,"\/");
            var endTime = $('#apm_taskEndTime').datebox("getValue").replace(/\s+/g, "").replace(/-/g,"\/");
            if(Date.parse(new Date(startTime)) > Date.parse(new Date(endTime))){
                showMessage1("执行结束时间不能早于执行开始时间");
                return false;
            }

			$.ajax({
				type: "POST",
				dataType: 'json',
				url : "${contextPath}/project/saveDivisionBath.action",
				data: $('#sendBackForm').serialize(),
				success: function(data){
					if(data.type == 'info'){
						$('#matterTreeGrid').treegrid('uncheckAll');
						$('#matterTreeGrid').treegrid('load',{'project_id':$('#apm_project_id').val(),'groupId':$('#apm_groupId').val(),
							'auditObject':$('#apm_auditObject').val()});
						$('#toReport').window('close');
						showMessage2("保存成功！");
						//window.location.reload();
					}else{
						showMessage2("保存失败！");
					}
				},
				error:function(data){
					showMessage2("请求失败！");
				}
			});
			
		});
		
		$('#closeToReport').bind('click',function(){
			$('#toReport').window('close');
		});
	});
	//全部展开
	function allExpand(){
		isAllExpand = true;
		$('#matterTreeGrid').treegrid("expandAll", null);
		window.setTimeout("isAllExpand = false;", 10000);
	}

</script>
</html>