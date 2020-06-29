<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<title>选择审计重点内容</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/DWRAction.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
</head>
<body>
	<div id="audit_important_list">
	</div>
	<div id="audit_important_view">
	</div>
</body>
<script type="text/javascript">
	$(function(){
		showWin("audit_important_view","审计重点内容查看");
		$('#audit_important_list').datagrid({
			url : "<%=request.getContextPath()%>/proledger/problem/auditImportant.action?querySource=grid&project_id=<%=request.getAttribute("project_id")%>",
			method:'post',
			showFooter:false,
			rownumbers:true, 
		 	pagination:true, 
			striped:true,
			autoRowHeight:false,
			fit: true,
			fitColumns:false,
			idField:'id',
			border:false,
			pageSize:20,
			remoteSort: false,
			selectOnCheck: false,
			singleSelect:true,
			toolbar:[
				/* {id:'viewLedgerOwner',text:'查看',iconCls:'icon-view',
					handler:function(){
						viewAuditImportant();
					}}, */
				{id:'editLedgerOwner',text:'确定',iconCls:'icon-edit',
					handler:function(){
						editAuditImportant();
					}},
				{id:'cancleLedgerOwner',text:'返回',iconCls:'icon-cancel',
					handler:function(){
						cancleAuditImportant();
					}}
				],
			/* frozenColumns:[[
				{field:'id',width:'50', checkbox:true, align:'center'}
			]], */
			columns:[[
				{field:'importantContentName',title:'名称',width:200,halign:'center',align:'center',sortable:true,
					formatter:function(value,row,index){
						 return '<a href="javascript:void(0);" onclick=\"viewAuditImportant(\''+row.importantContentId+'\'); return false;\">'+row.importantContentName+'</a>';
					 }
				},
				{field:'typeName',title:'项目类别',width:200,halign:'center',align:'center',sortable:true},
				{field:'typeName2',title:'项目子类别',width:200,halign:'center',align:'center',sortable:true}
			]]  
		});
		//单元格tooltip提示
		$('#audit_important_list').datagrid('doCellTip', {
			position : 'bottom',
			maxWidth : '200px',
			tipStyler : {
				backgroundColor : '#EFF5FF',
				borderColor : '#95B8E7',
				boxShadow : '1px 1px 3px #292929'
			}
		});
	});
	//查看
	function viewAuditImportant(id){
		var url = "${contextPath}/auditImportantContent/listExtraContent.action?importantContentId="+id;
   		showWinIf('audit_important_view',url,'重点内容查看',600,300);
	}
	//返回
	function cancleAuditImportant(){
		parent.$('#audit_improtant_content').window('close');
	}
	//确定
	function editAuditImportant(){
		var rows = $('#audit_important_list').datagrid('getChecked');
		var selectIds = "";
		if(rows.length == 1){
			selectIds = selectIds + rows[0].importantContentId;
			$.ajax({
                type: "POST",
                dataType:'json',
                url : "/ais/proledger/problem/editAuditImportant.action?project_id=<%=request.getAttribute("project_id")%>",
                data:{ "ids":selectIds},
                success: function(data){
                    if(data.type == 'ok'){
                    	showMessage2('选择成功！','消息','0');
                        parent.$('#audit_improtant_content').window('close');
                        parent.window.location.reload();
                    }else{
                    	showMessage2('选择失败！','消息','0');
                    }
                },
                error:function(data){
                	showMessage2('请求失败！','消息','0');
                }
            });
		}else{
			$.messager.alert("提示信息","请选择一条数据进行操作！","info");
		}
	}
</script>
</html>