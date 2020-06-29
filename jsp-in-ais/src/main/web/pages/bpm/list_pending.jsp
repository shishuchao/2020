<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML>
<html>
<head>
	<title>待办事项</title>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<STYLE type="text/css">
		.datagrid-cell {
			height:25px;
		}
		.datagrid-cell-rownumber {
			height:25px;
		}
	</STYLE>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="pendingSearch" class="searchWindow">
		<div class="search_head">
			<s:form name="myform" action="pending.action" namespace="/bpm/taskinstance" id="myform">
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" style="width: 15%">流程名称</td>
						<td class="editTd" colspan="3">
							<s:textfield id="processName" cssClass="noborder" name="taskInstance.processName" maxlength="50" cssStyle="width:90%" />
						</td>
						<td class="EditHead" style="width: 15%">项目名称</td>
						<td class="editTd" colspan="3">
							<s:textfield id="project_name" cssClass="noborder" name="taskInstance.project_name" maxlength="50" cssStyle="width:90%" />
						</td>
					</tr>
					<tr>
						<td class="EditHead" style="width: 15%">表单名称</td>
						<td class="editTd" colspan="3">
							<s:textfield id="formNameDetail" cssClass="noborder" name="taskInstance.formNameDetail" maxlength="50" cssStyle="width:90%" />
						</td>
						<td class="EditHead" style="width: 15%"></td>
						<td class="editTd" colspan="3">
						</td>
					</tr>
				</table>
			</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#pendingSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center"  fit="true">
		<table id="taskInstanceList"></table>
	</div>

	<script type="text/javascript">
		function restal(){
			resetForm('myform');
			/*doSearch();*/
		}
		function editPending(code,url){
			var processName=$('#processName').val();
			var project_name=$('#project_name').val();
			var formNameDetail=$('#formNameDetail').val();
			if(code != null && code != ''){
				window.location.href= '${contextPath}'+url+'&code='+code+'&processName='+processName+'&project_name='+project_name+'&formNameDetail='+formNameDetail; 
		 	}else{
				window.location.href= '${contextPath}'+url;
		 	}
		}


		function batchSubmitPendings(){

            var isFhDg = [];

            <c:forEach items="${listByfh}" var="temp" >
            isFhDg.push('${temp}');
            </c:forEach>

            var selectedRows = $('#taskInstanceList').datagrid('getChecked');

            if(selectedRows.length == 0){
                $.messager.show({title:'提示信息',msg:'请选择要批量复核的项目!'});
                return;
            }

            if(selectedRows.length == 1){
                editPending(selectedRows[0].plan_code,selectedRows[0].editUrl+"&todoback=1&flag=yes&project_id="+selectedRows[0].project_id);
            }else{

                $.messager.confirm('确认','确认要批量复核吗？',function(r){
                    if(r){
                        var plfhSelect = [];
                        var plfhProIds = [];
                        var plfhCodes = [];
                        var plfhformType = [];
                        for(var i = 0; i<selectedRows.length;i++){

                            if(isFhDg.indexOf(selectedRows[i].processName) == -1){
                                $.messager.show({title:'提示信息',msg:'请选择复核底稿的流程!'});
                                return;
							}

                            //这里应该取最后一个中划线，名称可能是 name-11-底稿,-11应该保留
                            var subSeRows = selectedRows[i].formNameDetail;
                            //var subSeRowsArys = subSeRows.split("-");
                            var subSeStr = subSeRows.substring(0,subSeRows.lastIndexOf('-'));
                            plfhSelect.push(subSeStr);

                            var plfhProId = selectedRows[i].project_id;
                            plfhProIds.push(plfhProId);

                            var plfhcode = selectedRows[i].formId;
                            plfhCodes.push(plfhcode);


                            var plfhtype = selectedRows[i].formType;
                            plfhformType.push(plfhtype);
                        }
                        var plfhSelectofString = plfhSelect.join(",");
                        var plfhProIdsofString = plfhProIds.join(",");
                        var plfhCodesofString = plfhCodes.join(",");
                        var plfhTypesofString = plfhformType.join(",");
                        $.ajax({
                            url : "/ais/operate/manu/plfhDg.action?todoback=1&flag=yes",
                            data: {"plfhProIds":plfhProIdsofString,"plfhSelect":plfhSelectofString,"plfhCodes":plfhCodesofString,"plfhTypes":plfhTypesofString},
                            type: "post",
                            dataType:'json',
                            success: function(data){
                                if(data.data == 'success'){
                                    $.messager.show({title:'提示信息',msg:'批量复核成功！'});
                                    $('#taskInstanceList').datagrid('reload');

                                }
                            },
                            error:function(data){
                                $.messager.show({title:'提示信息',msg:'请求失败！'});
                            }
                        });

                    }
                });


            }





        }
	    function doSearch(){
	    	$('#taskInstanceList').datagrid({
				queryParams:form2Json('myform')
			});
	    	$('#pendingSearch').window('close');
	    }
	    function setFormVal(){
	    	$('#processName').val('${processName}');
	    	$('#project_name').val('${project_name}');
	    	$('#formNameDetail').val('${formNameDetail}');
	    	doSearch();
	    }
		$(function(){
			showWin('pendingSearch');
			setFormVal();
			$('#taskInstanceList').datagrid({
				url : "<%=request.getContextPath()%>/bpm/taskinstance/pending.action?querySource=grid&processName=${processName}&project_name=${project_name}&formNameDetail=${formNameDetail}&type=${param.type}",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:false,
				striped:true,
				autoRowHeight:false,
				fit:true,
				pageSize: 20,
				idField:'id',
				fitColumns: false,	
				border:false,
				singleSelect:false,
				remoteSort: false,
				onLoadSuccess:function(){
					doCellTipShow('taskInstanceList');
				},
				toolbar:[{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('pendingSearch','800','200');
					}
				},'-',
                    {
                        id:'plfh',
                        text:'批量复核',
                        iconCls:'icon-ok',
                        handler:function(){
                            batchSubmitPendings();
                        }
                    }],
				frozenColumns:[[
                    {field:'formId',title:"复选框", halign:'center',checkbox:true, align:'center'},
                    {field:'processName',title:'流程名称',width:'120px',halign:'center',align:'left',sortable:true},
				       			{field:'project_name',title:'项目名称',width:'250px',sortable:true,halign:'center',align:'left'}
				    		]],
				columns:[[  
					{field:'formNameDetail',
							title:'表单名称',
							width:250,
							halign:'center',
							align:'left', 
							sortable:true
					},
					{field:'name',
						 title:'当前审批节点',
						 width:150, 
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'create',
						 title:'创建时间',
						 width:140,
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
						    if(value != null && value != ''){
							 	return value.replace('T',' ');
						    }
						 }
					},
					{field:'fromActorName',
						 title:'上一步处理人',
						 width:80,
						 halign:'center',
						 align:'center', 
						 sortable:true
					},
					{field:'draftsmanName',
						 title:'编写人',
						 halign:'center',
						 width:80, 
						 align:'center', 
						 sortable:true
					},
					{field:'reminderTimes',
						 title:'催办时间',
						 width:70,
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
							 if(rowData.reminderTimes == null){
								return '-';	
							 }else{
								return rowData.reminderTimes.substring(0,10);
							 }
						 }
					},
					{field:'operate',
						 title:'操作',
						 width:75, 
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,rowIndex){
						 	var param = [row.plan_code,row.editUrl+"&todoback=1&flag=yes&project_id="+row.project_id];
							var btn2 = "处理,editPending,"+param.join(',');
							return ganerateBtn(btn2);
						 }
					}
				]]   
			});
			 
		});
	</script>
</body>
</html>
