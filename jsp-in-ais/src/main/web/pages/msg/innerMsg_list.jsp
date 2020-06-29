<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<title>消息列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>  
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
		//站内消息回复
		function openUrlByMsgIdReply(msgId,readFlag){
			window.location.href= 'innerMsg_reply.action?innerMsg.msgId='+msgId+'&readFlag='+readFlag;
		}		
		function showResponse(row){
			rows = row.parentElement.getElementsByTagName("tr");
			if (rows.length==1){
				location.reload();//刷新
			}else{
				row.parentElement.removeChild(row);
			}
		}
		//使用ajax删除，怎么不考虑分页也ajax刷新呢？
		function confirmDeleteMsg(msgId){
			if (confirm("确认要删除当前行吗?")) 
				window.location.href='${contextPath}/msg/innerMsg_del.action?innerMsg.msgId='+msgId+ '&readFlag=${readFlag}';
		}
		function refreshF(){
			$('#newsList').datagrid('reload');
		}
		/*if ("${mess}"=="saveOkForList"){
            var url = "${contextPath}/msg/innerMsg_edit.action?readFlag=3";
            window.location=url;
            $("button.close").click();
            // window.parent.$("#innermsgShow").css('display','none');
            // window.parent.$(".modal-backdrop.fade.in")[1].remove();
            window.parent.$("#newMessage").click();
		}*/
	</script>
<body class="easyui-layout" style="overflow:hidden;" fit='true' border='0'>
	<div region="center" border='0' style="overflow:hidden;">
		<table id="newsList"></table>
	</div> 
	<script type="text/javascript">
		$(function(){
			$('#newsList').datagrid({
				url : "<%=request.getContextPath()%>/msg/innerMsg_list.action?readFlag=${readFlag}&querySource=grid",
				method:'post',
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				border:false,
				singleSelect:true,
				remoteSort: false,
				onLoadSuccess:function(){
					doCellTipShow('newsList');
				},
				columns:[[
					{field:'isRead',
						title:'状态',
						width:50,
						align:'center',
						sortable:true,
						formatter:function (value, rowData, rowIndex) {
							if(value == '0') {
								return '未读';
							} else {
								return '已读';
							}
						}
					},
					{field:'fromUserName',
							title:'发送人',
							width:50,
							align:'center', 
							sortable:true
					},
					{field:'subject',
						title:'标题',
						width:200,
						sortable:true, 
						align:'left',
						halign:'center',
						formatter:function(value,rowData,rowIndex){
							return '<a href=\"javascript:void(0)\" onclick=\"openUrlByMsgId(\''+rowData.msgId+'\');\">'+value+'</a>';
						}
					},
					/*{field:'bodyText',
						 title:'内容',
						 width:200,
						 align:'left',
						 halign:'center',
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
							//return '<a href=\"javascript:void(0)\" onclick=\"openUrl(\'innerMsg_view.action?innerMsg.msgId='+rowData.msgId+'\');\">'+value+'</a>';
							 return value;
						 }
					},*/
					{field:'createTime',
						 title:'发送时间',
						 width:100, 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,index){
						    if(value != null && value != ''){
							   return value.replace('T',' ');
						    }
						 }
					},
					{field:'operate',
						 title:'操作',
						 width:100, 
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
							 return '<a href=\"javascript:void(0)\" onclick=\"openUrlByMsgIdReply(\''+row.msgId+'\',\'${readFlag}\');\">回复</a>|<a href=\"javascript:void(0)\" onclick=\"confirmDeleteMsg(\''+row.msgId+'\');\">删除</a>';
						 }
					}
				]]   
			});
			
		});
	</script>
</body>
</html>