<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<title></title>
		
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>

		<script type="text/javascript">
			var unidValues="";
			function nodeEdit(){
				if(myCheckOne()){
					url="${contextPath}/system/omEdit.action?abf.ffunid="+unidValues;
					window.location.href=url;
				}else{
					return false;
				}
			}
			function nodeDel(){
				if(myCheckOne()){
					top.$.messager.confirm('确认','您确认想要删除记录吗？',function(b){
						if(!b){return;}
						url="${contextPath}/system/omDel.action?abf.ffunid="+unidValues;
						window.location.href=url;	
					});
		
				}else{
					return false;
				}
			}
			function myCheckOne(){
				var row= $('#its').datagrid("getSelections");
				if(row.length!=1){
					$.messager.show({title:'提示信息',msg:'请先选中一个再进行操作!'});
					return false;
				}else{
					unidValues = row[0].ffunid;
				}
				return true;
			}
			function myCheck(){
				var row= $('#its').datagrid("getSelections");
				if(row.length!=1){
					$.messager.show({title:'提示信息',msg:'请先选中一个再进行操作!'});
					return false;
				}else{
					unidValues = row[0].ffunid;
				}
				return true;
			}
		</script>
	</head>
	<body class="easyui-layout">
	
	<div region="center" >
		<table id="its"></table>
		<center>
			<s:form action="omAdd" namespace="/system" id="searchForm" name="searchForm">
				<input type="hidden" id="ffunid" name="abf.ffunid" value="${abf.ffunid}">
				<input type="hidden" name="isMenu" value="N">
			</s:form>
		</center>
	</div>
		<script type="text/javascript">
		var ffunid = document.getElementById('ffunid');
        function doSearch(){
        	document.getElementById('searchForm').submit();
        }
		$(function(){
			// 初始化生成表格
			$('#its').datagrid({
				url : '<%=request.getContextPath()%>/system/omListNode.action?querySource=grid&abf.ffunid='+ffunid.value,
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'add',
						text:'增加',
						iconCls:'icon-add',
						handler:function(){
							doSearch();
								
						}
					},
					{
						id:'editd',
						text:'修改',
						iconCls:'icon-edit',
						handler:function(){
							nodeEdit();
						}
					},
					{
						id:'delete',
						text:'删除',
						iconCls:'icon-remove',
						handler:function(){
							nodeDel();
						}
					}
				],
				frozenColumns:[[
				       			{field:'id',width:'50px', checkbox:true, align:'center'},
				       			{field:'ffunid',title:'功能序号',width:'100px',align:'center',
									formatter:function(value,rowData,rowIndex){
										return rowData.ffunid;
							}},
				       			{field:'ffundisplay',title:'功能名称',width:'250px',sortable:true,align:'center'}
				    		]],
				columns:[[  
					{field:'ffunname',
							title:'功能方法映射',
							width:250,
							align:'center', 
							sortable:true
					}
				]]   
			}); 
		});
	</script>	
	</body>
</html>