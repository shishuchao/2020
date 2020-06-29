<jsp:directive.page import="ais.framework.acegi.SecurityContextUtil"/>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>反馈意见列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<script type="text/javascript">
		function openUrl(url){
			window.open(url,"_blank",'width=700,height=400,resizable=yes');
		}
		function openUrlByMsgId(msgId){
			openUrl('innerMsg_view.action?innerMsg.msgId='+msgId);
		}
		function showResponse(row){
			rows = row.parentElement.getElementsByTagName("tr");
			if (rows.length==1){
				location.reload();//刷新
			}else{
				row.parentElement.removeChild(row);
			}
		}
		function confirmDeleteMsg(msgId){
			$.messager.confirm('提示信息', '确认要删除当前行吗?', function(isDel){
				if(isDel){
					window.location.href='${contextPath}/msg/innerMsg_del.action?innerMsg.msgId='+msgId+ '&readFlag=${readFlag}';
				}
			});
		}
		
		if ("${mess}"=="saveOkForList"){
			showMessage1("发送成功!");
		}
	</script>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center">
			<table id="objectList"></table>
		</div>
	
</body>	
		<script type="text/javascript">
		  $(function(){
		      $('#objectList').datagrid({
					url : "<%=request.getContextPath()%>/msg/innerMsg_originlist.action?querySource=grid&readFlag=${readFlag}&msgOrigin=${msgOrigin}",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize: 20,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					frozenColumns:[[
					       			{field:'msgId',halign:'center', checkbox:true, align:'center'}
					    		]],
					columns:[[  
						{field:'fromUserName',
							title:'发送人',
							width:100,
							halign:'center',
							align:'left', 
							sortable:true
						},
						{field:'subject',
							title:'标题',
							width:150,
							halign:'center', 
							align:'left',
							sortable:true
						},
						{field:'bodyText',
							 title:'内容',
							 width:200,
							 halign:'center', 
							 align:'left', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
							   return '<a href=\"javascript:void(0);\" onclick=\"openUrl(\'innerMsg_view.action?innerMsg.msgId=\''+rowData.msgId+');\" >'+value+'</a>';
							 }
						},
						{field:'createTime',
							 title:'发送时间',
							 halign:'center',
							 align:'right', 
							 sortable:true
						}
					]]   
				}); 
		  });
	</script>	 

</html>