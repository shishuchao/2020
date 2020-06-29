<%@ page contentType="text/html;charset=UTF-8" language="java" import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>

<head>
    	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>风险报告类表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>

</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="searchWindow" title="查询条件">
		<div class="search_head">
			<s:form id="myForm" action="riskReportList" method="post" namespace="/riskManagement/management/riskReport" >
				<input type="hidden" name="view" value="${view}"/> 
				<s:token/>
				<table class="ListTable" align="center">
					<tr>
					<td align="left" class="EditHead">
							风险报告名称
						</td>
						<td align="left" class="editTd" >
							<s:textfield name="riskRep.riskReportName" title="查询书名称" id="riskReportName" cssClass="noborder"/>
						</td>
						<td align="left" class="EditHead">
							编制单位
						</td>
						<td align="left" class="editTd">
							<s:textfield id="audit_dept_name" name="riskRep.audit_dept_name" cssClass="noborder" />
						</td>
					</tr>
			 		<tr>
					<td align="left" class="EditHead">
							撰写人
						</td>
						<td align="left" class="editTd">
							<s:textfield id="create_author_name" name="riskRep.create_author_name" cssClass="noborder" />
						</td>
						<td class="EditHead">		
						                 所属年度
					        </td>
						<td class="editTd">
						<select class="easyui-combobox" name="riskRep.year" id="year" style="width:80%"  editable="false">
					       <option value="">请选择</option>
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
					    </td>
					</tr> 
				</table>
				<s:hidden name="ifFirstQuery" value="no"/>
			</s:form>
		</div>
		<div class="serch_foot">
			<div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetReport()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			</div>
		</div>
	</div> 
         <div region="center">
			<table id="list_reportList"></table>
		</div>
		<div id="tb">
		    <a href="javascript:void(0);" class="easyui-linkbutton" id="addReport" onclick="addReport()" data-options="iconCls:'icon-add',plain:true">增加</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" id="search" onclick="freshGrid()" data-options="iconCls:'icon-search',plain:true">查询</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" id="downloadReport" onclick="downloadReport()" data-options="iconCls:'icon-add',plain:true">下载报告模板</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" id="viewReport" onclick="viewReport()" data-options="iconCls:'icon-view',plain:true">查看</a>
			
			<a href="javascript:void(0);" class="easyui-linkbutton"  id="del" onclick="delReport()" data-options="iconCls:'icon-delete',plain:true">删除</a>
		</div>
		<script type="text/javascript">
		
		$(function(){
			//查询，使窗体排版正确
			showWin('dlgSearch');
			var d = new Date();
			$('#year').combobox('setValue',d.getFullYear());
			// 初始化生成表格
			$('#list_reportList').datagrid({
				url : "<%=request.getContextPath()%>/riskManagement/management/riskReport/riskReportList.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true, 
				pagination:false,
				striped:true,
				autoRowHeight:true,
				fit: true,
				fitColumns:false,
				border:false,
				singleSelect:false,
				remoteSort: false,
				toolbar: '#tb',
				columns:[[  
                	{field:'serial_num',
						title:'编号',
						sortable:true,
						halign:'center',
						width:'10%',
						align:'left'
					},
					 {field:'year',
						title:'所属年度',
						sortable:true,
						halign:'center',
						width:'7%',
						align:'left'
					},
                	{field:'riskReportName',
						title:'报告名称',
						sortable:true,
						halign:'center',
						width:'15%',
						align:'left'
					},
					{field:'reportTypeName',
						 title:'报告类型',
						 halign:'center', 
						 align:'center', 
						 width:'10%',
						 sortable:true
					},
					{field:'rp_statusName',
						 title:'报告状态',
						 halign:'center', 
						 align:'center', 
						 width:'10%',
						 sortable:true
					},
					{field:'audit_dept_name',
						title:'编制单位',
						sortable:true,
						halign:'center',
						width:'10%',
						align:'center'
					},
					{field:'create_author_name',
						 title:'撰写人',
						 halign:'center', 
						 align:'center', 
						 width:'10%',
						 sortable:true
					},
					{field:'operate',
						title:'操作',
						halign:'center',
						align:'right',
						 width:'6%',
						sortable:true,
						formatter:function(value,row,rowIndex){
							if('view' != "${view}"){
								var param = [row.id,row.rp_status];
								var btn2 = "修改,openRiskReportPage,"+param.join(',');
								return ganerateBtn(btn2);
							}
						
						}
					} 
				]]   
			}); 
			//单元格tooltip提示
			 $('#list_reportList').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				}); 
		});
		
		function addReport(){
			window.location.href = '${contextPath}/riskManagement/management/riskReport/editRiskReport.action?addReport=addReport';
			
		}
		    
		  function freshGrid(){;
				searchWindShow('dlgSearch',750);
			}
		  
			/*
			* 查询
			*/
			function doSearch(){
	        	$("#list_reportList").datagrid({
					queryParams:form2Json("myForm")
				});
				$('#dlgSearch').dialog('close');
	        }
			
			/*
			* 重置
			*/
			function resetReport(){
				resetForm('myForm');
				var d = new Date();
				$('#year').combobox('setValue',d.getFullYear());
				//doSearch();
			}
			/*
			* 取消
			*/
			function doCancel(){
				$('#dlgSearch').dialog('close');
			}
			
			function openRiskReportPage(selectedValue,status_code){
				if(status_code != null){
					 if("130" == status_code){
						$.messager.show({title:'提示信息',msg:'风险报告已被审批完成！'});
						return false;
					}
					if("140" == status_code){
						$.messager.show({title:'提示信息',msg:'风险报告已被注销！'});
						return false;
					} 
				}
					$.ajax({
						   type: "POST",
						   url: "${contextPath}/riskManagement/management/riskReport/riskReportValidate.action",
						   data: {"crudId":selectedValue},
						   success: function(reV){
								if(reV=='suc'){
									window.location.href = '${contextPath}/riskManagement/management/riskReport/editRiskReport.action?crudId='+selectedValue;
								}else if(reV=='nouser'){
									$.messager.show({title:'提示信息',msg:'只能修改自己撰写的风险报告!'});
								}else if(reV=='nostatus'){
									$.messager.show({title:'提示信息',msg:'只有草稿状态和本人正在审批的风险报告才能编辑!'});							
								}else if(reV=='fal'){
									$.messager.show({title:'提示信息',msg:'风险报告正在被审批!'});
								}else{
									$.messager.alert('提示信息','操作异常!','erro');
								}
						   }
					});		
			}
			
			// 删除 
			function delReport(){
				var ids = $("#list_reportList").datagrid("getChecked");
				if(ids.length == 0){
					$.messager.show({
						title:'提示消息',
						msg:'请选择一条信息！'
					})
					return false;
				}
				var crudIds = '';
				for(var i=0;i<ids.length;i++){
					crudIds+=ids[i].id+',';
				}
				$.messager.confirm('提示消息','确定删除风险报告吗？',function(isDel){
					if(isDel){
						$.ajax({
							url:"${contextPath}/riskManagement/management/riskReport/delRiskReport.action",
							type:'post',
							data:{'crudIds':crudIds},
							success:function(reV){
								if(reV== 'suc'){
									$.messager.show({title:'提示信息',msg:'删除成功!'});
									doSearch();
								}else if(reV=='nouser'){
									$.messager.show({title:'提示信息',msg:'只能删除自己撰写的审计报告!'});	
								}else if(reV=='fail140'){
									$.messager.show({title:'提示信息',msg:'已注销的风险报告，只有组长和主审才能删除!'});					
								}else{
									$.messager.show({title:'提示信息',msg:'只有草稿状态的风险报告才能删除!'});
								}
							}
						})
					}
				}); 
			}
			function  downloadReport(){
				var viewSjwtUrl  = "${contextPath}/riskManagement/knowledgeBase/riskReportTemplate/listRiskReportTemplate.action?view=view";
				window.parent.parent.addTab('tabs','查看风险报告模板','tempframe',viewSjwtUrl,true);
			
			}
			function viewReport(){
				  var ids  = $("#list_reportList").datagrid("getChecked");
				  
	
					if(ids.length != 1){
						$.messager.show({
							title:'提示消息',
							msg:'请选择一条信息！'
						})
						return false;
					}
				window.location.href = '${contextPath}/riskManagement/management/riskReport/viewRiskReport.action?crudId='+ids[0].id;
			}
		</script>
</body>
</html>