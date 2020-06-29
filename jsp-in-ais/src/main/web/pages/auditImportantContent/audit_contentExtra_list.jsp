<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	</head>
	<body class="easyui-layout">	
	<table id="extraList"  style='overflow:hidden;'></table>	
	<script type="text/javascript">	
	
		$(function(){
			// 初始化生成表格
			$('#extraList').datagrid({
				url : '<%=request.getContextPath()%>/auditImportantContent/listExtra.action?importantContentId=${param.importantContentId}&querySource=grid',
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:true,
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
						window.location='<%=request.getContextPath()%>/auditImportantContent/addExtra.action?importantContentId=${param.importantContentId}';
					}						
				}],
				frozenColumns:[[
				       			{field:'importantContentExtraName',title:'名称',width:'350',sortable:true,align:'center'}
				]],
				columns:[[  					
				{field:'xxx',
					title:'操作',
					width:200,
					align:'center',
					fit:true,
					sortable:true,
					formatter:function(value,row,index){
						var param = [row.importantContentExtraId];
						var btn2 = "修改,editExtra,"+param.join(',')+"-btnrule-删除,deleteExtra,"+param.join(',');
						           
						return ganerateBtn(btn2);
					}
				}
				]]   
			}); 
		});
		
		//修改
        function editExtra(s){
        	window.location='<%=request.getContextPath()%>/auditImportantContent/addExtra.action?importantContentId=${param.importantContentId}&importantContentExtraId='+s;
		} 
		function deleteExtra(s){
			var bln=true;			
			$.messager.confirm('提示信息', '删除后可能影响其它业务的正常执行!  确定删除?', function(r){
				if(r){
					$.ajax({
					  type: "POST",
					  url: '<%=request.getContextPath()%>/auditImportantContent/deleteExtra.action',
					  dataType:"text",
					  data:{importantContentExtraId:s},
					  success: function(data){
						  if(data == 'ok'){
							  gback();
						  }
						  showMessage1('删除成功！');
						  $('#extraList').datagrid('reload');
					  }
					});
				}
			});
		}
		
		
	</script>	
	</body>
</html>
