<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<s:text id="title" name="'未发布流程'"></s:text>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title><s:property value="#title" /></title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<SCRIPT type="text/javascript">
		function refresh(){
			//流程发布时，可以同步刷新已发布流程的页签---LIHAIFENG 2007-11-28
			//window.parent.frames['publishedflow'].location.reload();
			parent.refreshPublishedflow();
		}
	</SCRIPT>
	
</head>
<body  class="easyui-layout">
	<div region="center" border="0px">
		<table id="bpmDefinitionList"></table>
	</div>
	<div id="commonPage"></div>
	<script type="text/javascript">
		function ToAdd(){
			var url = "${contextPath}/bpm/definition/edit.action";
			showWinIf('commonPage',url,'添加流程定义','',200);
		}
		function ToEdit(id){
			var url = "${contextPath}/bpm/definition/edit.action?bpmDefinition.id="+id;
			showWinIf('commonPage',url,'修改流程定义','',200);
		}
		$(function(){
			showWin('commonPage','公共弹框页面');
			$('#bpmDefinitionList').datagrid({
				url : "<%=request.getContextPath()%>/bpm/definition/list_unpublished.action?querySource=grid",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize:20,
				fitColumns:true,
				idField:'id',
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'newYear',
						text:'添加新的流程',
						iconCls:'icon-add',
						handler:function(){
							ToAdd();
						}
					}
				],
				columns:[[  
					{field:'name2Display',title:'流程名称',width:100,halign:'center',align:'left',sortable:true},
				    {field:'table_name',title:'业务对象',width:80,sortable:true,halign:'center',align:'left'},
					{field:'form_name',
							title:'表单类型',
							width:100,
							halign:'center',
							align:'left', 
							sortable:true
					}
					<s:if test="${view ne 'view'}">
					,
					{field:'operate',
						 title:'操作',
						 align:'center', 
						 sortable:false,
						 width:150,
						 formatter:function(value,row,index){
							return '<a href="javascript:void(0);" onclick=\"ToEdit(\''+row.id+'\');\">修改</a>'
									+'&nbsp;&nbsp;'+
									'<a href=\"javascript:void(0)\" onclick="window.open(\'${contextPath}/bpm/definition/design.action?bpmDefinition.id='+row.id+'\',\'设计流程\',\'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no\')">设计流程</a>'
									+'&nbsp;&nbsp;'+
									'<a href=\"javascript:void(0)\" onclick=\"publish(\''+row.id+'\');\">发布流程</a>'	
									+'&nbsp;&nbsp;'+
									'<a href=\"javascript:void(0)\" onclick=\"del(\''+row.id+'\');\">删除</a>';
						 }
					}
					</s:if>
				]]   
			}); 
		});
		function publish(id){
			$.messager.confirm('提示信息','确认发布该流程吗？',function(flag){
				if(flag){
			//	window.location.href="${contextPath}/bpm/definition/publish.action?bpmDefinition.id="+id;
			//	refresh();
				$.ajax({
				    type:'post',
					url:'${contextPath}/bpm/definition/publish.action',
					data:{'bpmDefinition.id':id},
					datatype:'json',
					success:function(data){
						if(data.er != null && data.er != "" ){
							$.messager.alert('错误信息',data.er,'error');
							return false;
						}else{
							window.location.reload();
							refresh();
						}
					}
				});
				}
			});
		}
		function del(id){
			$.messager.confirm('提示信息','确认删除该流程吗？',function(flag){
				if(flag){
					window.location.href="${contextPath}/bpm/definition/delete.action?id="+id;
				}
			});
		}
	</script>
</body>
</html>