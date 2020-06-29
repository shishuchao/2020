<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>被审计单位采集数据上传</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" border='0'>
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
			<s:form namespace="/mng/audobj/data" action="listAuditObjectData" id="searchForm">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" style="width: 20%">
							状态
						</td>
						<td class="editTd" style="width: 30%">
							<s:if test="${view != 'true'}">
							<select editable="false" class="easyui-combobox" name="auditingObjectData.submitStatus" data-options="panelHeight:'auto'" style="width:80%" >
								<option value="">&nbsp;</option>
								<s:iterator value="#@java.util.LinkedHashMap@{'0':'未提交','1':'已提交'}" id="entry">
									<option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:iterator>
							</select>
							</s:if>
							<s:else>
								已提交
							</s:else>
						</td>
						<td class="EditHead" style="width: 20%">
							被审计单位
						</td>
						<td class="editTd" style="width: 30%">
							<s:if test="${exclude_child != 'true'}">
							<s:buttonText2 name="auditingObjectData.audit_object_name" cssClass="noborder" cssStyle="width:80%"
										   hiddenName="auditingObjectData.audit_object"
										   doubleOnclick="showSysTree(this,
											{
												url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
												param:{
													'departmentId':'${root_audit_object_depid}'
												},
												cache:false,
												checkbox:false,
												title:'请选择被审计单位'
											})"
										   doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
										   doubleCssStyle="cursor:hand;border:0" readonly="true"/>
							</s:if>
							<s:else>
								${curLevelAuditingObjectData}
							</s:else>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							数据文件名称
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectData.name" />
						</td>
						<td class="EditHead">
							年度
						</td>
						<td class="editTd">
							<select class="easyui-combobox" name="auditingObjectData.year" style="width:150px;" data-options="panelHeight:'auto',editable:false">
                                <option value="">&nbsp;</option>
								<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)">
									<s:if test="${auditingObjectData.year==key}">
										<option selected="selected" value="<s:property value="key"/>"><s:property value="key"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:else>
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							财务软件
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectData.sourceSoftwareName" />
						</td>
						<td class="EditHead">
							数据类型
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectData.sourceDataType" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							数据概述
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectData.sourceDataDescription" />
						</td>
						<td class="EditHead">
							备注
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectData.remark" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							上传人
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectData.uploaderName" />
						</td>
						<td class="EditHead">
							上传人所在单位
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="auditingObjectData.uploaderDeptName" />
						</td>
					</tr>
				</table>
			</s:form>
		</div>
		<div class="serch_foot">
			<div class="search_btn" style="text-align: right; margin-right: 5px;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="cleanForm()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			</div>
		</div>
	</div>
	<div region="center" border='0'>
		<table id="audDataGrid"></table>
	</div>

	<div id="uploadFileDiv" title="采集文件上传" style='overflow:hidden;padding:0px;display: none'>
		<form id='uploadFile_form' enctype="multipart/form-data" method="post" action="<%=request.getContextPath()%>/mng/audobj/data/uploadFile.action"
			  style='overflow-y:auto;padding:10px;margin:0px;border:1px solid #cccccc;'>
			<table id="uploadFile_table" class="ListTable" align="center" >
				<tr>
					<td class='EditHead'>选择文件</td>
					<td class='editTd'>
						<input type="file" name="uploadFile" size="50" id="uploadFile" accept=".AUD">
					</td>
				</tr>
				<tr>
					<td colspan="2" style="padding-top: 10px;">
						<font color="red">*</font>仅支持上传后缀为AUD的数据采集文件
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div id="setAuditObjDiv" title="对应被审计单位" style='overflow:hidden;padding:0px;display: none'>
		<form id='setAuditObj_form' method="post" style='overflow-y:auto;padding:10px;margin:0px;border:1px solid #cccccc;'>
			<table id="setAuditObj_table" class="ListTable" align="center" >
				<tr>
					<td class='EditHead'>被审计单位</td>
					<td class='editTd'>
						<s:buttonText2 id="setObjName" name="auditingObjectData.audit_object_name" cssClass="noborder" cssStyle="width:80%"
									   hiddenId="setObjCode" hiddenName="auditingObjectData.audit_object"
									   doubleOnclick="showSysTree(this,{
                                            url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                                            cache:false,
                                            param:{
                                                'auditedOrgIds':'${root_audit_object}'
                                            },
                                            title:'请选择被审计单位'
										})"
									   doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
									   doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
				</tr>
				<tr>
					<td class="EditHead">备注</td>
					<td class="editTd">
						<s:textarea id="setRemarks" name="auditingObjectData.remark" cssClass="noborder" cssStyle="width:100%" />
					</td>
				</tr>
			</table>
		</form>
	</div>

	<script type="text/javascript">
        function doSearch(){
            $('#audDataGrid').datagrid('options').queryParams = form2Json('searchForm');
            $('#audDataGrid').datagrid('reload');
            $('#dlgSearch').dialog('close');
        }
        function doCancel(){
            $('#dlgSearch').dialog('close');
        }
        function cleanForm(){
            resetForm('searchForm');
        }

		$(function(){
			showWin('dlgSearch');
			var bodyW = $('body').width();
			$('#audDataGrid').datagrid({
				url : '<%=request.getContextPath()%>/mng/audobj/data/listAuditObjectData.action?querySource=grid&exclude_child=${exclude_child}&root_audit_object=${root_audit_object}&view=${view}',
				method:'post',
				queryParams: form2Json('searchForm'),
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				fitColumns: true,
				idField:'id',
				border:false,
				singleSelect:false,
				pageSize:20,
				remoteSort: true,
				onClickRow:function(index, row){
					//changeButtonState(row.submitStatus);
				},
				toolbar:[
					{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch');
						}
					}
					<s:if test="${view != 'true'}">
					,'-'
					,{
						id:'upload',
						text:'上传',
						iconCls:'icon-upload2',
						handler:function(){
							$('#uploadFile').val('');
							$('#uploadFileDiv').window('open');
						}
					}
					,'-'
					,{
						id:'setAuditObj',
						text:'对应被审计单位',
						iconCls:'icon-edit',
						handler:function(){
							if(assignRow()){
								var rows=$('#audDataGrid').datagrid('getSelections');
								if(rows.length==1){
									$('#setObjCode').val(rows[0].audit_object);
									$('#setObjName').val(rows[0].audit_object_name);
									$('#setRemarks').val(rows[0].remark);
								}else{
									$('#setObjCode').val("");
									$('#setObjName').val("");
									$('#setRemarks').val("");
								}
								$('#setAuditObjDiv').window('open');
							}
						}
					}
					/*,'-'
					,{
						id:'save',
						text:'保存',
						iconCls:'icon-save',
						handler:function(){

						}
					}*/
					,'-'
					,{
						id:'submit',
						text:'提交',
						iconCls:'icon-ok',
						handler:function(){
							if(assignRow()){
								$.messager.confirm('提示消息', '提交后的数据不能删除，确认要提交吗？', function(r) {
									if (r) {
										var fileDataIds = '';
										var rows=$('#audDataGrid').datagrid('getSelections');
										if(rows.length>0){
											for(var i=0;i<rows.length;i++){
												fileDataIds +=rows[i].id+',';
											}
										}
										$.ajax({
											dataType:'json',
											url : "${contextPath}/mng/audobj/data/submitAuditObjectData.action?fileDataIds="+fileDataIds,
											type: "POST",
											success: function(data){
												showMessage2('提交成功！');
												$('#audDataGrid').datagrid('reload');
											},
											error:function(data){
												showMessage2('请求失败！');
											}
										});
									}else{
										return false;
									}
								});
							}
						}
					}
					,'-'
					,{
						id:'delete',
						text:'删除',
						iconCls:'icon-delete',
						handler:function(){
							if(assignRow()){
								$.messager.confirm('提示消息', '确认要删除选择的数据吗？', function(r) {
									if (r) {
										var fileDataIds = '';
										var rows=$('#audDataGrid').datagrid('getSelections');
										if(rows.length>0){
											for(var i=0;i<rows.length;i++){
												fileDataIds +=rows[i].id+',';
											}
										}
										$.ajax({
											dataType:'json',
											url : "${contextPath}/mng/audobj/data/deleteAuditObjectData.action?fileDataIds="+fileDataIds,
											type: "POST",
											success: function(data){
												showMessage2('删除成功！');
												$('#audDataGrid').datagrid('reload');
											},
											error:function(data){
												showMessage2('请求失败！');
											}
										});
									}else{
										return false;
									}
								});
							}
						}
					}
					</s:if>
				],
                frozenColumns:[[
                    <s:if test="${view != 'true'}">
                    {field:'id',title:'选择',checkbox:true},
                    {field:'submitStatus',title:'状态',width:bodyW * 0.1 + 'px',halign:'center',align:'center',sortable:true,
                        formatter:function(value,row,index){
                            if(value == '1'){
                                return '已提交';
                            }else{
                                return '未提交';
                            }
                        }
                    },
					</s:if>
                    {field:'audit_object_name',title:'被审计单位',width:bodyW * 0.2 + 'px',sortable:true,halign:'center',align:'left'},
                    {
                        field: 'name', title: '数据文件名称', width: bodyW * 0.2 + 'px', halign: 'center', align: 'left', sortable: true,
                        formatter: function (value, row, index) {
                            <s:if test="${download != true}">
                            return value;
                            </s:if>
                            <s:else>
                            return '<a href="javascript:download(\'' + row.id + '\')">' + value + '</a>';
                            </s:else>
                        }
                    }
                    ]],
				columns:[[
					{
						field: 'size', title: '大小', width: bodyW * 0.1 + 'px', halign: 'center', align: 'center', sortable: true,
						formatter: function (value, row, index) {
							if (value) {
								var unit = 'B';
								if (value >= 1024) {
									value = value / 1024;
									unit = 'KB';
								}
								if (value >= 1024) {
									value = value / 1024;
									unit = 'MB';
								}
								if (value >= 1024) {
									value = value / 1024;
									unit = 'GB';
								}

								if (unit != 'B') {
									value = value.toFixed(2);
								}
							}
							return value + unit;
						}
					},
					{field:'year', title:'年度', width:bodyW * 0.1 + 'px', halign:'center', align:'center', sortable:true},
					{field:'sourceSoftwareName', title:'财务软件', width:bodyW * 0.1 + 'px', halign:'center', align:'left', sortable:true},
					{field:'sourceDataType', title:'数据类型', width:bodyW * 0.1 + 'px', halign:'center', align:'left', sortable:true},
					{field:'sourceDataDescription', title:'数据概述', width:bodyW * 0.1 + 'px', halign:'center', align:'left', sortable:true},
					{field:'remark', title:'备注', width:bodyW * 0.1 + 'px', halign:'center', align:'left', sortable:true},
					{field:'uploaderName', title:'上传人', width:bodyW * 0.1 + 'px', halign:'center', align:'left', sortable:true},
					{field:'uploaderDeptName', title:'上传人所在单位', width:bodyW * 0.1 + 'px', halign:'center', align:'left', sortable:true},
					{field:'uploadTime', title:'上传时间', halign:'center', align:'center', width:bodyW * 0.15 + 'px', sortable:true}
				]]
			});

			//单元格tooltip提示
			$('#audDataGrid').datagrid('doCellTip', {
				onlyShowInterrupt:true,
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}

			});

			$('#uploadFileDiv').show();
			$('#uploadFileDiv').dialog({
				title:'采集文件上传',
				closed:true,
				collapsible:true,
				modal:true,
				width:600,
				height:200,
				buttons:[
					{
						id:'uploadBtn',
						text:'上传',
						iconCls:'icon-upload2',
						handler:function(){
							var uploadFile = $("#uploadFile").val();
							if("" == uploadFile){
								alert("上传文件不能为空！");
								return;
							}
							var fileType = uploadFile.substring(uploadFile.lastIndexOf(".")+1);
							if("AUD" != fileType){
								alert("请上传后缀为\".AUD\"格式的数据采集文件！");
								return;
							}

							$("#uploadFile_form").form('submit',{
								url:'${contextPath}/mng/audobj/data/uploadFile.action?audit_object=${root_audit_object}',
								onSubmit:function(){
									try{
										aud$loadOpen();
										//$('#uploadFileDiv').window('close');
									}catch(e){}
								},
								success:function(data){
									try{
										aud$loadClose();
										var data = jQuery.parseJSON(data);
										if(data && data.type == 'success') {
											showMessage2('上传成功！');
											$('#uploadFileDiv').window('close');
											$('#audDataGrid').datagrid('reload');
										}else{
											showMessage2('上传时发生错误！');
										}
									}catch(e){}
								},
								error:function () {
									showMessage2('上传时发生错误！');
								}
							});
						}
					}
					,{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$('#uploadFileDiv').dialog('close');
						}
					}
				]
			});

			//setAuditObjDiv
			$('#setAuditObjDiv').show();
			$('#setAuditObjDiv').dialog({
				title:'对应被审计单位',
				closed:true,
				collapsible:true,
				modal:true,
				width:600,
				height:200,
				buttons:[
					{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							var setObjName = $("#setObjName").val();
							if("" == setObjName){
								alert("请选择被审计单位！");
								return;
							}

							var fileDataIds = '';
							var rows=$('#audDataGrid').datagrid('getSelections');
							if(rows.length>0){
								for( var i=0;i<rows.length;i++){
									fileDataIds +=rows[i].id+',';
								}
							}
							$.ajax({
								dataType:'json',
								url : "${contextPath}/mng/audobj/data/setAuditObject.action?fileDataIds="+fileDataIds,
								data: $('#setAuditObj_form').serialize(),
								type: "POST",
								success: function(data){
									showMessage2('保存成功！');
									$('#setAuditObjDiv').window('close');
									$('#audDataGrid').datagrid('reload');
								},
								error:function(data){
									showMessage2('请求失败！');
								}
							});
						}
					}
					,{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$('#setAuditObjDiv').dialog('close');
						}
					}
				]
			});
		});
		function changeButtonState(submitStatus){
			var setAuditObjButton = $('#setAuditObj');
			var submitButton = $('#submit');
			var deleteButton = $('#delete');

			var hasSubmit = false;
			var rows = $('#audDataGrid').datagrid('getSelections');
			if (rows.length>0) {
				for (var i = 0; i < rows.length; i++) {
					if (rows[i].submitStatus=='1'){
						hasSubmit = true;
						break;
					}
				}
			}

			if(hasSubmit){
				setAuditObjButton.linkbutton('disable');
				submitButton.linkbutton('disable');
				deleteButton.linkbutton('disable');
			}else{
				setAuditObjButton.linkbutton('enable');
				submitButton.linkbutton('enable');
				deleteButton.linkbutton('enable');
			}
			return;
		}

		function assignRow() {
			var rows = $('#audDataGrid').datagrid('getSelections');
			if (rows.length == 0) {
				showMessage1('请选择要操作的数据行！');
				return false;
			} else {
				for (var i = 0; i < rows.length; i++) {
					if (rows[i].submitStatus == '1') {
						showMessage1('已提交的数据不能操作！');
						return false;
						break;
					}
				}
			}
			return true;
		}

		function download(id) {
			window.location = '<%=request.getContextPath()%>/mng/audobj/data/download.action?id=' + id;
		}
	</script>
</body>
</html>