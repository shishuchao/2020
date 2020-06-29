<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:directive.page import="ais.framework.util.UUID"/>

<html>
<title>应对方案</title>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
<script type="text/javascript">
 var editFlag = undefined; 
 var parentTabId = '${parentTabId}';
 var curTabId = aud$getActiveTabId();

 $(function(){
	 var bodyW = $('body').width();    
	 var bodyH = $('body').height(); 
	 frloadOpen();
	 var g1 = new createQDatagrid({
	        // 表格dom对象，必填
	        gridObject:$('#measureTable')[0],
	        // 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
	        boName:'HandleMeasure',
	        // 对象主键,删除数据时使用-默认为“id”；必填
	        pkName:'id',
	        whereSql:'proId=\'${handleProject.formId}\'',
	        order:'asc',
	        sort:'sn',
	        winWidth:800,
	        winHeight:250,
	        gridJson:{    
	            checkOnSelect:false,
	            selectOnCheck:false,
	            singleSelect:false,
	            rownumbers:false,
	            onLoadSuccess:frloadClose,
	            toolbar:[{
	            	text:'新增',
	            	iconCls:'icon-add',
	            	handler:function () {
	            		var uuid;
	            		$.ajax({
	            			url:'${contextPath}/riskManagement/management/riskHandle/getUuid.action',
	            			type:'POST',
	            			async:false,
	            			success:function(data) {
	            				uuid = data;
	            			}
	            		});
	            		$("#measureTable").datagrid('insertRow', {//在指定行添加数据，appendRow是在最后一行添加数据
	            			index: 0, // 行数从0开始计算
	            			row: {
	            			id: uuid,
	            			proId: '${handleProject.formId}',
	            			sn: '',
	            			meaName: '',
	            			meaDescribe: '',
	            			source: '',
	            			dutyDeptName: '',
	            			dutyPersonName: '',
	            			remark: ''
	            			}
	            		});
	            	}
	            }, '-', {  
	                text: '保存', iconCls: 'icon-save', handler: function () {  
	                    $("#measureTable").datagrid('endEdit', editFlag);  
	       
	                    //使用JSON序列化datarow对象，发送到后台。  
	                    var rows = $("#measureTable").datagrid('getChanges');
	       
	                    var rowstr = JSON.stringify(rows);  
	                    $.ajax({
	                    	url:'${contextPath}/riskManagement/management/riskHandle/saveHandleMeasure.action',
	                    	async:false,
	                    	type:'POST',
	                    	data:{'rowstr':rowstr},
	                    	success:function(data) {
	                    		if(data == '1') {
	                    			showMessage1('保存成功！');
	                    			$("#measureTable").datagrid('reload');
	                    		}
	                    	}
	                    });
	                }  
	            }, '-', {
	            	text: '删除', iconCls: 'icon-delete', handler: function () {
	            		var ids = '';
	            		var rows = $("#measureTable").datagrid('getChecked');
	            		for(i in rows) {
	            			ids += rows[i].id + ',';
	            		}
	            		if(ids == '') {
	            			showMessage1('请选择数据！');
	            		}else {
	            			$.post('${contextPath}/riskManagement/management/riskHandle/delHandleMeasure.action',{'ids':ids},function(data){
	            				if(data == '1') {
	            					showMessage1('删除成功！');
	            					$("#measureTable").datagrid('reload');
	            				}
	            			});
	            		}
	            	}
	            }] ,
	            frozenColumns:[[
					{field:'id', title:'选择', checkbox:true, align:'center', show:'false'},
					{field:'proId', title:'应对方案主键', hidden:true},
					{field:'sn',title:'编号', width:bodyW*0.1 + 'px',align:'center', sortable:true, show:'true', oper:'eq',
	   					editor: {//设置其为可编辑
		   				type: 'text',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
		   				options: { required: true}
	   					}
					},
					{field:'meaName',title:'措施名称', width:bodyW*0.14 + 'px',align:'center', sortable:true, type:'custom', target:$('#query_sdYear')[0],
	   					editor: {//设置其为可编辑
		   				type: 'text',
		   				options:{ required : true}
	   					}
					}
	            ]],
	            columns:[[
	               {field:'meaDescribe',title:'措施具体描述', width:bodyW*0.14 + 'px',align:'center', sortable:true, show:'true', oper:'like',
	            	   editor: {//设置其为可编辑
	            		   type: 'text'
	            	   }
	               },
	               {field:'source',width:bodyW*0.14 + 'px',title:'所需资源', align:'center', sortable:true, type:'custom', target:$('#query_tradePlate')[0],
	            	   editor: {//设置其为可编辑
	            		   type: 'text'
	            	   }
	               },
	               {field:'dutyDeptName',width:bodyW*0.14 + 'px',title:'责任部门', align:'center', sortable:true, show:'true', oper:'eq',
	            	   editor: {//设置其为可编辑
	            		   type: 'text'
	            		   }
	               },
	               {field:'dutyPersonName',width:bodyW*0.14 + 'px',title:'责任人', align:'center', sortable:true, show:'true', oper:'eq',
	            	   editor: {//设置其为可编辑
	            		   type: 'text'
	            		   }
	               },
	               {field:'remark',width:bodyW*0.14 + 'px',title:'备注', align:'center', sortable:true, show:'true', oper:'eq',
	            	   editor: {//设置其为可编辑
	            		   type: 'text'
	            		   }
	               },
	        	]],
	        	onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
	        		editFlag = undefined;//重置
	        	}, 
	        	onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
	            	if (editFlag != undefined) {
	            		$("#measureTable").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
	            	}
	            	if (editFlag == undefined) {
	            		$("#measureTable").datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
	            		editFlag = rowIndex;
	            	}
	            },
	        }
	    });	
	    g1.batchSetBtn([
			{'index':1, 'display':true},
			{'index':2, 'display':true},
			{'index':3, 'display':true},
			{'index':4, 'display':false},
			{'index':5, 'display':false},
			{'index':6, 'display':false},
	        {'index':7, 'display':false},
	        {'index':8, 'display':false}
	    ]);
});
 
 function saveForm() {
	 if (audEvd$validateform('myForm')) {
			$.post('${contextPath}/riskManagement/management/riskHandle/saveHandleProject.action',$('#myForm').serialize(),
									function(data) {
									if (data != '0') {
										$('#id').val(data);
										parent.asignByiframe1(
												$('#proName').val(),
												$('#proTarget').val(),
												$('#handleProject_proDescribe').val(),
												$('#orgLeader').val(),
												$('#flow').val(),
												$('#handleProject_source').val(),
												$('#handleProject_tool').val(),
												$('#planStartTime').datebox('getValue'),
												$('#planEndTime').datebox('getValue'),
												$('#creater').val(),
												$('#createrName').val(),
												$('#createTime').val(),
												$('#handleProject_remark1').val());
										showMessage1('保存成功！');
									} else {
										showMessage1('保存失败！');
									}
								});
	}
 }
 
 function check() {
	 var result = audEvd$validateform('myForm');
	 if(result) {
		 parent.asignByiframe1(
					$('#proName').val(),
					$('#proTarget').val(),
					$('#handleProject_proDescribe').val(),
					$('#orgLeader').val(),
					$('#flow').val(),
					$('#handleProject_source').val(),
					$('#handleProject_tool').val(),
					$('#planStartTime').datebox('getValue'),
					$('#planEndTime').datebox('getValue'),
					$('#creater').val(),
					$('#createrName').val(),
					$('#createTime').val(),
					$('#handleProject_remark1').val());
	 }
	 return result;
 }
</script>
</head>
<body>
       	<div data-options="region:'center',split:true">
    	<s:form id="myForm">
    		<s:hidden name="handleProject.formId" id="id"></s:hidden>
    		<s:hidden name="handleProject.retId"></s:hidden>
    		<s:hidden name="handleProject.status"></s:hidden>
    		<s:hidden name="crudId"></s:hidden>
    		<table id='myTable' cellpadding=1 cellspacing=1 border=0 class="ListTable">
    			<tr>
	   				<td class="EditHead"><font color="red">*</font>方案名称</td>
    				<td class="editTd">
    					<s:textfield name="handleProject.proName" maxlength="100" cssClass="noborder editElement required" id="proName"></s:textfield>
    				</td>
    				
    				<td class="EditHead">方案解决的具体目标</td>
    				<td class="editTd">
    					<s:textfield name="handleProject.proTarget" maxlength="100" cssClass="noborder" id="proTarget"></s:textfield>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					<font color="red">*</font>方案描述
    					<div style="float: center"><font color="red">（1000字以内）</font></div>
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='handleProject_proDescribe' name='handleProject.proDescribe'
				 			class="noborder editElement required clear len1000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${handleProject.proDescribe}</textarea>
					</td>
    			</tr>
    			<tr>
	   				<td class="EditHead"><font color="red">*</font>所需的组织领导</td>
    				<td class="editTd">
    					<s:textfield name="handleProject.orgLeader" maxlength="100" cssClass="noborder editElement required" id="orgLeader"></s:textfield>
    				</td>
    				
    				<td class="EditHead">所涉及的管理及业务流程</td>
    				<td class="editTd">
    					<s:textfield name="handleProject.flow" maxlength="100" cssClass="noborder" id="flow"></s:textfield>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					<font color="red">*</font>所需的条件、手段等资源
    					<div style="float: center"><font color="red">（1000字以内）</font></div>
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='handleProject_source' name='handleProject.source'
				 			class="noborder editElement required clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${handleProject.source}</textarea>
					</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					风险管理工具
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='handleProject_tool' name='handleProject.tool'
				 			class="noborder editElement clear len200" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${handleProject.tool}</textarea>
					</td>
    			</tr>
    			<tr>
	   				<td class="EditHead"><font color="red">*</font>计划开始时间</td>
    				<td class="editTd">
    					<input type="text" id="planStartTime" name="handleProject.planStartTime" value="${handleProject.planStartTime}"
								class="easyui-datebox" editable="false"/>
    				</td>
    				
    				<td class="EditHead"><font color="red">*</font>计划完成时间</td>
    				<td class="editTd">
    					<input type="text" id="planEndTime" name="handleProject.planEndTime" value="${handleProject.planEndTime}"
								class="easyui-datebox" editable="false"/>
    				</td>
    			</tr>
    			<tr>
	   				<td class="EditHead">编制人</td>
    				<td class="editTd">
    					<s:property value="handleProject.createrName"/>
    					<s:hidden name="handleProject.creater" id="creater"></s:hidden>
    					<s:hidden name="handleProject.createrName" id="createrName"></s:hidden>
    				</td>
    				
    				<td class="EditHead">编制时间</td>
    				<td class="editTd">
    					<s:property value="handleProject.createTime"/>
    					<s:hidden name="handleProject.createTime" id="createTime"></s:hidden>
    				</td>
    			</tr>
    			<tr>
    				<td class="EditHead">
    					备注
    				</td>
    				<td class="editTd" colspan="3">
						<textarea type='text' id='handleProject_remark1' name='handleProject.remark1'
				 			class="noborder editElement clear len1000" style='border-width:0px;height:50px;width:99%;overflow:hidden;' >${handleProject.remark1}</textarea>
					</td>
    			</tr>
    		</table>
    	</s:form>
    	</div>
    	<div id="measureDiv" data-options="region:'south',split:true" style="height:40%">   	 	
            <table id='measureTable' title="应对措施"></table>
       	</div>
    
    <!-- 自定义查询条件  -->
   <select id="query_year" name="query_year" style='width:130px; display:none;'></select>
   <select id="query_status" name="query_status" style="width:130px;display:none;"></select>
   <select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select> 
   <!-- ajax请求前后提示 -->
   <jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
</html>
