<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计日志列表</title>
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
				<s:form action="listAll" namespace="/auditLog" method="post" name="myform" id="myform">
					<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr >
							<td class="EditHead" style="width:20%">
						                  被审计单位
					        </td>
					       <td class="editTd" style="width:30%">
							   <s:buttonText2 cssClass="noborder" id="audit_object_name" hiddenId="audit_object"
											  name="auditLog.audit_object_name"
											  hiddenName="auditLog.audit_object"
											  doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
							  param:{
							    'auditedOrgIds':'${auditedOrgIds}'
							  },
							  cache:false,
							  checkbox:true,
							  title:'请选择被审计单位'
							})"
											  doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
											  doubleCssStyle="cursor:hand;border:0"
											  readonly="true"/>

					       </td>
							<td class="EditHead" style="width:15%">
								编制人
							</td>
							<td class="editTd" style="width:35%">
								<s:textfield cssClass="noborder" name="auditLog.createPerson" cssStyle="width:80%" maxlength="100"/>
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
		<div region="center">
			<table id="projectList"></table>
		</div>
		<script type="text/javascript">
			
			/*
			* 查询
			*/
			function doSearch(){
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
			var project_id = '${project_id}';
			var bodyW = $('body').width();
			// 初始化生成表格			
			datagrid=$('#projectList').datagrid({
				url : "<%=request.getContextPath()%>/auditLog/listAll.action?querySource=grid&project_id="+project_id,
				method:'post',
				//showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				pageSize: 20,
				border:false,
				singleSelect:false,
				remoteSort: false,
				toolbar:[{
					id:'search',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('dlgSearch');
					}
				},'-',
				<s:if test="${view != 'view'}">
				{
					id:'add',
					text:'新增',
					iconCls:'icon-add',
					handler:function(){
						addAuditLog();
					}
				},'-',
				{
					id:'submit',
					text:'提交',
					iconCls:'icon-ok',
					handler:function(){
						submitAuditLog();
					}
				},'-',
				{
					id:'delete',
					text:'删除',
					iconCls:'icon-delete',
					handler:function(){
						deleteAuditLog();
					}
				},'-',
				</s:if>
					helpBtn
				],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				onClickCell:function(rowIndex, field, value) {
					if(field == 'audit_object_name') {
						var rows = $('#projectList').datagrid('getRows');
						var row = rows[rowIndex];
						if(row.status&&row.status!='1') {
							window.location.href = '${contextPath}/auditLog/edit.action?id='+row.id+'&project_id='+project_id;
						} else {
							var url = '${contextPath}/auditLog/view.action?id='+row.id+'&project_id='+project_id;
							window.location.href=url;
						}
					}
				},
				columns:[[  
					{field:'id',width:'50', checkbox:true, align:'center'},
					{field:'status',
			 			title:'状态',
			 			halign:'center',
			 			align:'center', 
						sortable:true,
			 			width:bodyW*0.04+'px',
			 			formatter:function(value,rowData,rowIndex){
			 				if(value == '1'){
			 					return "已提交";
			 				}else{
			 					return "草稿";
			 				}
			 			}
					},
					{field:'audit_object_name',
						title:'被审计单位',
						width:bodyW*0.15+'px',
						halign:'center',
						sortable:true, 
						align:'left',
						formatter:function(value,rowData,rowIndex){
							var result;
							if(rowData.status!='1') {
								result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
							} else {
								result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
							}
							return result;
						}
					},
					{field:'today_finish_task',
						 title:'今日完成事项',
						 width:bodyW*0.20+'px',
						 halign:'center', 
						 align:'left', 
						 sortable:true
					},
					{field:'follow_up_task',
						 title:'后续关注事项',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 width:bodyW*0.19+'px',
					},
					{field:'assistanceMatters',
						 title:'需协助事项',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 width:bodyW*0.18+'px',
					},
					{field:'createPerson',
						 title:'编制人',
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 width:bodyW*0.06+'px',
					},
					{field:'createTime',
						 title:'编制时间',
						 align:'center',
						 sortable:true,
						 width:bodyW*0.08+'px',
					}
				]]   
			}); 
			//单元格tooltip提示
			$('#projectList').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '200px',
				onlyShowInterrupt:true,
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			
			});
			
		});
		
		function addAuditLog(){
			var project_id = '${project_id}';
			window.location.href = '/ais/auditLog/edit.action?id=&project_id='+project_id;
		}
		
		function viewAuditLog(){			
			var project_id = '${project_id}';
			var row = $('#projectList').datagrid('getSelected');
			if(row!=null && row.id != ""){
				window.location.href = '/ais/auditLog/view.action?id='+row.id+'&project_id='+project_id;
			}else{
				showMessage2("请选择一条记录！");	
			}
		}
		function editAuditLog(){
			var project_id = '${project_id}';
			var row = $('#projectList').datagrid('getSelected');
			if(row!=null){
				if(row.status == '1'){
					$.messager.alert('错误',"只能修改草稿状态的记录！",'warning');
					return;
				}else if(row.createPersonCode != '${user.floginname}'){
					$.messager.alert('错误',"只能修改自己的记录！",'warning');
					return;
				}else{
					window.location.href = '/ais/auditLog/edit.action?id='+row.id+'&project_id='+project_id;
				}
			}else{
				$.messager.alert('错误',"请先选择需要修改的记录！",'error');
			}
		}
		function submitAuditLog(){
			var project_id = '${project_id}';
			var rows = $('#projectList').datagrid('getChecked');
            if(!rows || rows.length == 0){
                showMessage1('请选择要提交的记录！');
                return false;
            }

            var ids = [];
			for(var i=0;i<rows.length;i++){
				if(rows[i].status == '1'){
					showMessage1('提交失败：只能提交草稿状态的记录！');
					return false;
				}
				if(rows[i].createPersonCode != '${user.floginname}'){
					showMessage1('提交失败：只能提交本人的记录！');
					return false;
				}
				ids.push(rows[i].id);
			}
            $.messager.confirm('提示信息','确定提交吗？',function(r){
            	if (r){
        			$.ajax({
        				type: "POST",
        				url: "${contextPath}/auditLog/submit.action",
        				data: {"ids":ids.join(',')},
        				success: function(data){
        					if(data.flag == '1'){
        						showMessage1("提交成功");	
        			     		window.location.reload();
        					}else{
        						showMessage1(data.msg);
        					}
        				}
        			});
            	}
            })
		}
		
		function deleteAuditLog(){
			var project_id = '${project_id}';
			var rows = $('#projectList').datagrid('getChecked');
            if(!rows || rows.length == 0){
                showMessage1('请选择要删除的记录！');
                return false;
            }
			
            var ids = [];
			for(var i=0;i<rows.length;i++){
				if(rows[i].status == '1'){
					showMessage1('删除失败：只能删除草稿状态的记录！');
					return false;
				}
				if(rows[i].createPersonCode != '${user.floginname}'){
					showMessage1('删除失败：只能删除本人的记录！');
					return false;
				}
				ids.push(rows[i].id);
			}

			$.messager.confirm('提示信息',"确定删除吗？",function(r){
				if (r){
					$.ajax({
						type: "POST",
						url: "${contextPath}/auditLog/delete.action",
						data: {"ids":ids.join(',')},
						success: function(data){
							if(data.flag == '1'){
								showMessage1("删除成功");	
					     		window.location.reload();
							}else{
								showMessage1(data.msg);
							}
						}
					});
				}
			})

		}
		</script>
	</body>
</html>
