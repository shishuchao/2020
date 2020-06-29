<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<s:head theme="ajax" />
	<title>重点内容维护</title>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell-c1-xxx {
			height:10%;
			padding:1px;
		}
	</STYLE>
	<script language="javascript">
        //重置
		function searchrecal(){
			var url = "${contextPath}/auditImportantContent/list.action";
		    window.location = url;
		}
        
       //增加重点内容
        function add(){
       	    var url = '${contextPath}/auditImportantContent/addContent.action';
            showWinIf('editWin',url,'新增重点内容','850',450);
 	    }
	   //修改
        function editContent(s){
    	    var url = "${contextPath}/auditImportantContent/addContent.action?importantContentId="+s;
   		    showWinIf('editWin',url,'修改重点内容','800',400);
		} 		
		//删除
        function deleteContent(s){			 
			$.messager.confirm('提示信息','删除时会一同将附带的扩展内容删除，确认删除这条记录?',function(flag){
				if(flag){
					searchForm.action = "${contextPath}/auditImportantContent/delete.action?importantContentId="+s;
					searchForm.submit();
				}
			});
		}
		//扩展选项
        function extraWindow(s){	
			var url = "${contextPath}/auditImportantContent/listExtra.action?importantContentId="+s;
			$('#myFrame').attr("src",url);
			$('#extraWin').window('open')
		}
       //调用父窗口方法
		function useParentFun(){
			this.opener.stopx();  
		}		
	</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div id="listSearch" class="searchWindow">
		<div class="search_head">
			<s:form id="searchForm" action="list.action" namespace="/auditImportantContent">
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead">名称
						</td>
						<!--标题栏-->
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="auditImportant.importantContentName" />
							<!--一般文本框-->
						</td>
						<td class="EditHead">编制人</td>
						<!--标题栏-->						
						<td class="editTd">
							<s:textfield  cssClass="noborder" cssStyle="width:80%" name="audTemplate.proAuthorName"></s:textfield>
							<s:hidden name="audTemplate.proAuthorCode" />&nbsp;
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
							<input name="auditImportant.proDate1" title="单击选择日期"  style="width:28%" class="easyui-datebox" editable='false'/>
							-
							<input name="auditImportant.proDate2" title="单击选择日期"  style="width:28%;" class="easyui-datebox" editable='false'/>
						</td>
					</tr>
				</table>
				<s:hidden name="type" />
			</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch();">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="searchrecal();">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#listSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center"  border='0'>
		<table id="its"></table>
	</div>
	
	<div id="editWin"></div>
	<div id="extraWin" title="添加扩展选项" style='overflow:hidden;'> 	  		
			<iframe id="myFrame" name="myFrame" src="" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>				
    </div>
	<script type="text/javascript">
		 function doSearch(){
	       	$('#its').datagrid({
	   			queryParams:form2Json('searchForm')
	   		});
	   		$('#listSearch').dialog('close');
	     }
		 $(function(){
		 	//查询
			showWin('editWin','审计重点内容修改');
		 	//查询
			showWin('listSearch');
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/auditImportantContent/list.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				fit: true,
				pageSize:20,
				fitColumns:true,
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('listSearch');
					}
				},
				{
					id:'newYear',
					text:'增加',
					iconCls:'icon-add',
					handler:function(){
						add();
					}
				}],
				frozenColumns:[[
				       			{field:'importantContentName',title:'名称',width:260,halign:'center',align:'left',sortable:true},
				    		]],
				columns:[[  
					{field:'typeName',
							title:'类别名称',
							width:150,
							halign:'center',
							align:'left', 
							sortable:true
						},
					{field:'typeName2',
						title:'子类别名称',
						width:150,
						sortable:true,
						halign:'center',
						align:'left'
					},
					{field:'proAuthorName',
						 title:'编制人',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'proDate',
						 title:'编制日期',
						 halign:'center',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,index){
							if(value!=null){
								return value.substring(0,10);
							}
						 }
					},
					{field:'xxx',
						 title:'操作',
						 halign:'center',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
						 	var param = [row.importantContentId];
							var btn2 = "修改,editContent,"+param.join(',')+"-btnrule-删除,deleteContent,"+param.join(',')
							           +"-btnrule-扩展选项,extraWindow,"+param.join(',');
							return ganerateBtn(btn2);
						 }
					}
				]]   
			});
			window.setTimeout(function(){			
				$('#extraWin').window({
					width:800,
					height:400,
					modal:true,
					collapsible:false,
					maximizable:true,
					minimizable:false,
					closed:true
				});
			},10);
		});
	</script>	
</body>
</html>

