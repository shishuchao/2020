<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>自定义台账查询</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DWRAction.js'></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/ais_functions.js"></script>
<%--	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell-c1-xxx {
			height:10%;
			padding:1px;
		}
	</STYLE>--%>
<script type="text/javascript">
	function validateDel(ids){
		$.messager.confirm('确认','确认删除吗?',function(flag){
			if(flag){
				$.ajax({
					url : '${pageContext.request.contextPath}/proledger/custom/delete.action',
					type : "POST",
					data : {"ids" : ids},
					success : function(){
						showMessage1('删除成功！');
						$('#its').datagrid('reload');
					}
				});
			}
		});
	}
	
	function editProledger(id){
		window.location.href="${pageContext.request.contextPath}/proledger/custom/edit.action?id="+id;
	}
</script>
</head>
<body class="easyui-layout">
		<div region="center" >
			<table id="its"></table>
		</div>
		<script type="text/javascript">
			// 初始化生成表格
			$('#its').datagrid({
				url :"${pageContext.request.contextPath}/proledger/copy/loadstring.action",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				pageSize: 20,
				fitColumns:false,
				border:false,
				singleSelect:false,
				remoteSort: false,
				idField:'id',
				toolbar:[{
						id:'add',
						text:'增加',
						iconCls:'icon-add',
						handler:function(){
							window.location='${pageContext.request.contextPath}/proledger/custom/edit.action?id=0';
						}
					},'-',{
					id:'delete',
					text:'删除',
					iconCls:'icon-delete',
						handler:function(){
							var ids = new Array();
							var rows = $("#its").datagrid('getChecked');
							for(i in rows) {
								if(typeof rows[i].id != 'undefined') {
									ids.push(rows[i].id);
								}
							}
							if(ids.length > 0) {
								validateDel(ids.join(","));
							} else {
								showMessage1("请选择数据！");
							}
						}
					},'-',helpBtn
				],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				onClickCell:function(rowIndex, field, value) {
					if(field == 'p_subject') {
						var rows = $('#its').datagrid('getRows');
						var row = rows[rowIndex];
						editProledger(row.id);
					}
				},
				frozenColumns:[[
								{field:'id',title:'选择',checkbox:true},
				       			{field:'p_subject',title:'专题',halign:'center',align:'left',sortable:true,
									formatter:function(value,rowData,rowIndex) {
										var result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
										return result;
									}
								},
				       			{field:'p_group',title:'组',sortable:true,align:'right'}
				    		]],
				columns:[[  
					{field:'p_headtitle',
							title:'上标题',
							width:200,
							halign:'center',
							align:'left', 
							sortable:true
					},
					{field:'p_headtitle_order',
						title:'上标题序列',
						halign:'center',
						align:'right', 
						sortable:true
					},
					{field:'p_undertitle',
						title:'下标题',
						width:150,
						halign:'center',
						align:'left', 
						sortable:true
					},
					{field:'p_undertitle_order',
						title:'下标题序列',
						halign:'center',
						align:'right', 
						sortable:true
					}
					,
					{field:'p_key',
						title:'下标题对应的键值',
						halign:'center',
						align:'left', 
						sortable:true
					},
					{field:'p_datatype',
						title:'下标题对应数据类型',
						halign:'center',
						align:'center', 
						sortable:true,
						formatter:function(value,rowData,rowIndex){
							 if(value=='String') {
						        return "文本类型";
						     }else if(value=='double'){
						        return "金额类型";
						     }else if(value=='date'){
						        return "日期类型";
						     }else if(value=='boolean'){
						        return "布尔类型";
						     } else if(value=='int'){
						        return "整数类型";
						     }else {
						     	return "";
						     }
						}
						           	
					},
					{field:'p_key',
						title:'下标题对应的键值',
						halign:'center',
						align:'left', 
						sortable:true
					}
					,
					{field:'p_sum',
						title:'公式',
						width:150,
						halign:'center',
						align:'left', 
						sortable:true
					},
					{field:'p_outdata',
						title:'外部数据',
						width:150,
						align:'left', 
						sortable:true
					},
					{field:'actualize_closed',
						title:'实施阶段',
						halign:'center',
						align:'center', 
						sortable:true,	
						formatter:function(value,rowData,rowIndex){
							  if(value==1){
					                return "是";
					              }
					              else{
					                return "否";
								}
						}
					},
					{field:'report_closed',
						title:'终结阶段',
						halign:'center',
						align:'center', 
						sortable:true,
						formatter:function(value,rowData,rowIndex){
							  if(value==1){
					                return "是";
					              }
					              else{
					                return "否";
								}
						}
					},
					{field:'rework_closed',
						title:'整改跟踪阶段',
						halign:'center',
						align:'center', 
						sortable:true,
						formatter:function(value,rowData,rowIndex){
							 if(value==1){
					              return "是";
					         }else{
					              return "否";
							 }
						}
					}/*,
					{field:'xxx',
						title:'操作',
						halign:'center',
						align:'center', 
						sortable:true,
						formatter:function(value,rowData,rowIndex){
							var param = [rowData.id];
							var btn2 = "修改,editProledger,"+param.join(',')+"-btnrule-删除,validateDel,"+param.join(',');
							return ganerateBtn(btn2);
						}
					}*/
				]]   
			}); 
	</script>	
	</body>
</html>
