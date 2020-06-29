<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<s:head theme="ajax" />
	<title>审计重点内容查看</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:10%;
			padding:1px;
		}
	</STYLE>
	<script language="javascript">		
		function searchrecal(){
			document.searchForm.reset(); 
			doSearch();
		}
		  //查看
	    function viewContent(s){
	    	var url = "${contextPath}/auditImportantContent/listExtraContent.action?importantContentId="+s;
			$('#myFrame').attr("src",url);
			$('#extraWin').window('open')        
		} 
    </script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div id="auditImportantSearch" class="searchWindow">
		<div class="search_head">
			<form id="searchForm" name="searchForm" onsubmit="return true;" 
				action="/auditImportantContent/list.action" method="post" style="">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" style="width:15%;">名称</td>
						<!--标题栏-->
						<td class="editTd" tyle="width:35%;">
							<!--一般文本框-->
							<s:textfield cssClass="noborder"  name="auditImportant.importantContentName" cssStyle="width:80%;" />
						</td>
						<td class="EditHead" tyle="width:15%;">编制人</td>
						<!--标题栏-->						
						<td class="editTd" tyle="width:35%;">
							<s:textfield cssStyle="width:80%;" cssClass="noborder" 
								name="auditImportant.proAuthorName"></s:textfield>							
							<img src="<%=request.getContextPath()%>/resources/images/s_search.gif"
								onclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										param:{
											'p_item':1,
											'orgtype':1
										},
									      title:'请选择编制人',
									      // 审计人员选择模式
									      type:'treeAndEmployee'
									})"
								border=0 style="cursor: hand">							
						</td>
					</tr>
					<tr >
						<td class="EditHead">编制日期</td>
						<td class="editTd" colspan="3">
							<input name="auditImportant.proDate1" title="单击选择日期"  style="width:45%;" class="easyui-datebox noborder" editable='false'/>
							-
							<input name="auditImportant.proDate2" title="单击选择日期"  style="width:45%;" class="easyui-datebox noborder" editable='false'/>
						</td>
					</tr>
				</table>
				<s:hidden name="type" />
			</form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="searchrecal()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#auditImportantSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center" border='0' >		
		<table id="cunlist"></table>
	</div>
	<div id="extraWin" title="扩展选项" style='overflow:hidden;'> 	  		
			<iframe id="myFrame" name="myFrame" src="" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>				
    </div>
	<script type="text/javascript">
        function doSearch(){
        	$('#cunlist').datagrid({
    			queryParams:form2Json('searchForm')
    		});
    		$('#auditImportantSearch').dialog('close');
        }
		$(function(){
			showWin('auditImportantSearch');			
			// 初始化生成表格
			$('#cunlist').datagrid({
				url : "<%=request.getContextPath()%>/auditImportantContent/list.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 20,
				fitColumns: true,
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'searchObj',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('auditImportantSearch');
						}
					}],
				columns:[[
					{field:'importantContentName',
			       	 title:'名称',
			       	 width:200,
			       	 halign:'center',
			       	 align:'left',
			       	 sortable:true,
			       	 formatter:function(value,row,index){
							 return '<a href="javascript:void(0);" onclick=\"viewContent(\''+row.importantContentId+'\'); return false;\">'+row.importantContentName+'</a>';
						 }
			       	},
					{field:'typeName',
							title:'类别名称',
							width: 150,
							halign:'center',
							align:'left',
							sortable:true
						},
					{field:'typeName2',
						title:'子类别名称',
						sortable:true,
						width: 150,
						halign:'center',
						align:'left'
					},
					{field:'proAuthorName',
						 title:'编制人',
						 width: 100,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'proDate',
						 title:'编制日期',
						 halign:'center',
						 width: 60,
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,index){
							if(value!=null){
								return value.substring(0,10);
							}
						 }
					}
				]]   
			});
			window.setTimeout(function(){			
				$('#extraWin').window({
					width:600,
					height:300,
					collapsible:false,
					maximizable:true,
					minimizable:false,
					modal:true,
					closed:true
				});
			},10);
		});
	</script>	
</body>
</html>

