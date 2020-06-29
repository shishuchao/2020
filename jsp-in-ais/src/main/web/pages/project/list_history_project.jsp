<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
				<s:form action="listHistoryProject" namespace="/project" method="post" name="myform" id="myform">
										<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<input type="hidden" name="condition" value="yes" reload="false"/>
						<tr >
							<td class="EditHead">
						                   项目编号
					        </td>
					       <td class="editTd">
						      <s:textfield cssClass="noborder" name="project_code" maxlength="50"/>
					       </td>
							<td class="EditHead">
								项目名称
							</td>
							<td class="editTd">
								<s:textfield cssClass="noborder" name="project_name" maxlength="50"/>
							</td>
						</tr>
						<tr >
							
							<td class="EditHead">
								项目年度
							</td>
							<td class="editTd" colspan="3">
								    <select editable="false" id="w_plan_year" class="easyui-combobox" name="archives_year">
								       <option value="">&nbsp;</option>
								       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(5,10)" id="entry">
								         <option value="<s:property value="key"/>"><s:property value="value"/></option>
								       </s:iterator>
								    </select>	 
							</td>
						</tr>
						</table>
				</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
		        	列表默认当年，其他年度请使用查询&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
		    </div>
		</div>	
		<div region="center">
			<table id="projectList"></table>
		</div>
		<div id="resDiv">
			<span id="result"></span>
		</div>
		<jsp:include page="/pages/frReportFlow/ajaxloading.jsp"></jsp:include>
		<script type="text/javascript">
			
			/*
			* 查询
			*/
			function doSearch(){
				document.getElementById('myform').action = "${contextPath}/project/listHistoryProject.action";
	        	$('#projectList').datagrid({
	    			queryParams:form2Json('myform')
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
				resetForm('myform');
			}
			
		$(function (){
			showWin('dlgSearch');
			if('${empty archives_year}'=='true'){
				var d = new Date();
				$('#w_plan_year').combo('setValue',d.getFullYear());
				$('#w_plan_year').combo('setText',d.getFullYear());
			}
			// 初始化生成表格			
			datagrid=$('#projectList').datagrid({
				url : "<%=request.getContextPath()%>/project/listHistoryProject.action?querySource=grid",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				pageSize: 20,
				border:false,
				singleSelect:false,
				remoteSort: false,
				onLoadSuccess:function(){
					doCellTipShow('projectList');
				},
				toolbar:[{
					id:'search',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('dlgSearch');
					}
				},'-',
				{
						id:'base',
						text:'基础数据',
						iconCls:'icon-ok',
						handler:function() {
							synchronousBaseInfo();
						}
				},'-',
				{
					id:'sys',
					text:'历史成果数据',
					iconCls:'icon-publish',
					handler:function(){
						synchronous();
					}
				}
				],
				frozenColumns:[[
					{field:'synStatus',
						title:'同步状态',
						width:'10%',
						halign:'center',
						align:'center',
						sortable:true
					},
					{field:'project_name',
					 title:'项目名称',
					 width:'25%',
					 halign:'center',
					 align:'left', 
					 sortable:true	
					}
				]],
				columns:[[  
					{field:'archives_year',
						 			title:'项目年度',
						 			halign:'center',
						 			align:'center',
									sortable:true,
						 			width:'5%'
							},
					{field:'pro_type_name',
						title:'项目类别',
						width:'8%',
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'archives_unit_name',
						 title:'审计单位',
						 width:'20%',
						 halign:'center', 
						 align:'left', 
						 sortable:true
					},
					{field:'audit_object_name',
						 title:'被审计单位',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 width:'20%'
					},
					{field:'archives_start_man_name',
						 title:'档案发起人',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 width:'15%'
					}
				]]   
			}); 
			
			$('#resDiv').window({
				title:'基础数据同步结果',
				width:'600px',
				height:'360px',
				closed:true
			});
		});

			function synchronous(){
				var rows = datagrid.datagrid("getSelections");
				var formIds = new Array();
				if (rows.length > 0) {
	                for (var i = 0; i < rows.length; i++) {
	                	if(rows[i].synStatus == '未同步') {
							formIds.push(rows[i].project_id);
						}
	                }
	            }
				if(formIds.length < rows.length) {
					showMessage2('请选择待同步的审计项目！');
					return false;
				}else {
					$.messager.confirm('提示','历史成果数据迁移，确定是否继续？',function(flag){
						if(flag){
							frloadOpen();
							$.ajax({
							url:'${contextPath}/project/synchronousHistory.action',
							async:true,
							type:'POST',
							dataType:'JSON',
							data:{'formIds':formIds.join(",")},
							success:function(data){
								frloadClose();
								if(data.code == '0'){
									showMessage2('同步成功！');
									$('#projectList').datagrid('reload');
								}else{
									showMessage2('同步失败：'+data.failedTables);
								}
							}
						});
						}
					});
				}
			}

			function synchronousBaseInfo(){
				$.messager.confirm('提示','基础数据迁移，确定是否继续？',function(flag){
					if(flag){
						frloadOpen();
						$.ajax({
							url:'${contextPath}/project/synchronousBaseInfo.action',
							async:true,
							type:'POST',
							dataType:'JSON',
							success:function(data){
								frloadClose();
								var result = "";
								var k = 1;
								for(i in data) {
									if(i != '') {
										result += k + "、" +i + "：" + data[i] + "<br>";
										k++;
									}
								}
								$('#result').html(result);
								$('#resDiv').window('open');

								/*if(data.code == '0'){
									showMessage2('同步成功！');
								}else{
									showMessage2('同步失败：'+data.failedTables);
								}*/
							}
						});
					}
				});
			}

		</script>
	</body>
</html>
