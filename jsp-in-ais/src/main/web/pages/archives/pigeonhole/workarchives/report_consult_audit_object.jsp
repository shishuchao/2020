<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计报告查阅</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<link href="<%=request.getContextPath()%>/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/jquery.multiSelect.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
		<s:form action="reportConsult" namespace="/archives/workprogram/pigeonhole" method="post" id="reportForm">
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td align="left" class="EditHead" style="width:15%">
							报告名称
						</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="reportFile" cssStyle="width:80%" cssClass="noborder" maxlength="50" />
						</td>
						<td align="left" class="EditHead" style="width:15%">
							项目编号
						</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="project_code" cssStyle="width:80%" cssClass="noborder" maxlength="50" />
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead" style="width:15%">
							项目名称
						</td>
						<td align="left" class="editTd"  style="width:35%">
						   <s:textfield name="project_name2" cssStyle="width:80%" cssClass="noborder" maxlength="50" />
						</td>
						<td align="left" class="EditHead" style="width:15%">
							项目年度
						</td>
						<td align="left" class="editTd" style="width:35%">
							<select id="w_plan_year" class="easyui-combobox" style="width: 175px" name="project_year" editable="false">
								<option value="">&nbsp;</option>
								<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,10)" id="entry">
									<option value="<s:property value='key'/>"><s:property value='value'/></option>
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr >
						<td align="left" class="EditHead" style="width:15%">
							审计单位
						</td>
						<td align="left" class="editTd"  style="width:35%">
						   <s:textfield name="audit_dept_name" cssStyle="width:80%" cssClass="noborder" maxlength="50" />
						</td>
						<td align="left" class="EditHead" style="width:15%">
						</td>
						<td align="left" class="editTd"  style="width:35%">
						</td>
					</tr>
				</table>
			</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
		    </div>
		</div>
		<div region="center" >
			<table id="resultList"></table>
		</div>
		<script type="text/javascript">
		function closeWin(){
			$('#subwindow').window('close');
		}
        function freshGrid(){
			$('#dlgSearch').dialog('open');
		}
		
		/*
		* 查询
		*/
		function doSearch(){
		
        	$('#resultList').datagrid({
    			queryParams:form2Json('reportForm')
    		});
			$('#dlgSearch').dialog('close');

        }
        /*
		* 取消
		*/
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}
		/**
			重置
		*/	
		function restal(){
            resetForm("dlgSearch");
		}

		
		$(function(){
	        showWin('dlgSearch');
	        doSearch();
	        var project_id = '${project_id}';
			$('#resultList').datagrid({
				url : "<%=request.getContextPath()%>/archives/workprogram/pigeonhole/reportConsultByAuditObject.action?querySource=grid&project_id="+project_id,
	            method:'post',
	            showFooter:false,
	            rownumbers:true,
	            pagination:true,
	            striped:true,
	            fit: true,
	            pageSize: 20,
	            idField:'id',
	            singleSelect:false,
	            border:false,
				toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch');
						}
					},'-',helpBtn
				],
				onLoadSuccess:function(){
					initHelpBtn();
					doCellTipShow('resultList');
				},
				columns:[[
					{field:'reportFile',title:'报告名称',halign:'center',width:'15%',align:'left',sortable:true			
					},
				 	{field:'project_code',
						 title:'项目编码',
						 width:'15%', 
						 halign:'center',
						 align:'left', 
						 sortable:true
					}, 
 					{field:'project_name',
						 title:'项目名称',
						 width:'15%', 
						 halign:'center',
						 align:'left', 
						 sortable:true

					}, 
 					{field:'pro_type_name',
						 title:'项目类型',
						 width:'15%', 
						 halign:'center',
						 align:'left', 
						 sortable:true
					}, 
 					{field:'pro_year',
						 title:'项目年度',
						 width:'7%', 
						 halign:'center',
						 align:'left', 
						 sortable:true
					}, 
		 			{field:'audit_dept_name',
						 title:'审计单位',
						 width:'13%', 
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'audit_object_name',
						 title:'被审计单位',
						 width:'13%', 
						 halign:'center',
						 align:'left', 
						 sortable:true
					}
				]]   
			}); 
			
		});
		</script>	
	</body>
</html>
