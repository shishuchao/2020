<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>入报告问题</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
		<script language="javascript" type="text/javascript" src="${contextPath}/resources/js/common.js"></script> 
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body >
		<div id="operate-opr_ledger_list_mid">
		</div>
		<div id="audit_improtant_content"  >
		</div>
		<div id="audit_important_content_extra">
		</div>
		<script type="text/javascript">
			$(function(){
				showWin("audit_improtant_content","审计重点内容");
				showWin("audit_important_content_extra","审计重点分类修改");
				$('#operate-opr_ledger_list_mid').datagrid({
					url : "<%=request.getContextPath()%>/proledger/problem/projectLedgerProblemMain.action?querySource=grid&project_id=<%=request.getAttribute("project_id")%>&importantContentId=${importantContentId}",
							//project_problem_middle_list.jsp
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
					singleSelect:true,
					pageSize:20,
					remoteSort: false,
					selectOnCheck: false,
					
					<s:if test="${isLeader == '1'}">
						<s:if test="${view != 'view'}">
						toolbar:[
							{id:'viewLedgerOwner',text:'查看',iconCls:'icon-view',
								handler:function(){
									viewLedgerOwner();
								}},
							{id:'delLedgerOwner',text:'删除',iconCls:'icon-delete',
								handler:function(){
									delLedgerOwner();
								}},
							{id:'expLedgerOwner',text:'导出',iconCls:'icon-export',
								handler:function(){
									expLedgerOwner();
								}},
							{id:'auditImportantEdit',text:'审计重点内容',iconCls:'icon-edit',
								handler:function(){
									auditImportantEdit();
								}}
						],
						</s:if>
					
						<s:else>
						toolbar:[
							{id:'viewLedgerOwner',text:'查看',iconCls:'icon-view',
								handler:function(){
									viewLedgerOwner();
								}},
							{id:'expLedgerOwner',text:'导出',iconCls:'icon-export',
								handler:function(){
									expLedgerOwner();
								}}
						],
						</s:else>
					</s:if>	
						<s:else>
					toolbar:[
								{id:'viewLedgerOwner',text:'查看',iconCls:'icon-view',
									handler:function(){
										viewLedgerOwner();
									}}
							],
						</s:else>
					frozenColumns:[[
						{field:'id',width:'50', checkbox:true, align:'center'},
						{field:'manuscript_id',width:'50', hidden:true, align:'center'},
						{field:'audit_con',title:'问题标题',width:250,sortable:true, halign:'center',align:'left'},
						{field:'manuscript_name',title:'底稿名称',width:200,halign:'center',align:'left', sortable:true,
								formatter:function(value,rowData,rowIndex){
									return '<a href=\"javascript:void(0)\" onclick=\"toOPenWindow(\''+rowData.manuscript_id+'\');\">'+value+'</a>';
						}},
						{field:'serial_num',title:'问题编号',align:'center', sortable:true}
					 ]],
					columns:[[
						{field:'problem_all_name',title:'问题类别',width:240,sortable:true, halign:'center',align:'left'},
						{field:'problem_name',title:'问题点', width:240,halign:'center',align:'left',sortable:true},
						{field:'problem_money',title:'发生金额',halign:'center',align:'right',sortable:true},
						{field:'problemCount',title:'发生数量',sortable:true,halign:'center',align:'right'},
						{field:'problem_grade_name',title:'审计发现类型',align:'center',sortable:true},
						/* {field:'audit_law',title:'法规依据',width:250,halign:'center',align:'left',sortable:true},
						{field:'aud_mend_advice',title:'处理建议',width:200,halign:'center',align:'left',sortable:true}, */
						{field:'creater_name',title:'问题发现人',halign:'center',align:'left',sortable:true},
						{field:'remarks', title:'备注说明',width:80,halign:'center',align:'left',sortable:true},
						{field:'xxx',title:'审计重点分类',width:130,halign:'center',align:'center', sortable:false,
							 formatter:function(value,row,index){
								 var temp = row.importantExtraName;
								if(temp==null){
									temp = "";
								}
								 var importantExtraName = "<div style=\"border:1px solid transparent;width:75px; float:left;white-space:nowrap;text-overflow:ellipsis;overflow:hidden; \">"+temp+"</div>";
								 var id='<div style=\"border:1px solid transparent;width:40px;float:left;\">&nbsp;<a href=\"javascript:void(0)\" onclick=\"importantExtraEdit(\''+row.id+'\');\">修改</a></div>';
								 <s:if test="${isLeader == '1'}">
									<s:if test="${view != 'view'}">
										return importantExtraName+id;
									</s:if>
								</s:if>
								<s:else>
									return importantExtraName;
								</s:else>
							 }
						}
					]]  
				});
				//单元格tooltip提示
				$('#operate-opr_ledger_list_mid').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						backgroundColor : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
			});
			//审计重点内容
			function auditImportantEdit(){
				var url = "<%=request.getContextPath()%>/proledger/problem/auditImportant.action?project_id=<%=request.getAttribute("project_id")%>";
		   		showWinIf('audit_improtant_content',url,'请选择重点内容',800,400);
			}
			function importantExtraEdit(id){
				var importantContentId = '${ importantContentId }';
				if( importantContentId == null || importantContentId == undefined || importantContentId == ''){
					$.messager.show({
						title: "提示信息",
						msg: "请先选择审计重点内容！"
					});
					return false;
				}
				var url = "<%=request.getContextPath()%>/proledger/problem/auditImportantExtra.action?project_id=<%=request.getAttribute("project_id")%>&id="+id;
		   		showWinIf('audit_important_content_extra',url,'审计重点内容修改',650,200);
			}
			//查看
			function viewLedgerOwner(){
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				if(rows.length == 1){
					var viewSjwtUrl  = "${contextPath}/proledger/problem/view1.action?id="+rows[0].id+"&interaction=${interaction}&crudId="+rows[0].manuscript_id;
					/* window.open(viewSjwtUrl); */
					window.parent.addTab('tabs','查看入报告问题','tempframe',viewSjwtUrl,true); 
				}else{
					$.messager.show({title:'提示信息',msg:'请选择一条数据进行操作！'});
				}
			}
			//导出
			function expLedgerOwner(){
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				var selectIds = '';
				if(rows.length != 0){
					for(var i=0;i<rows.length;i++){
						var id=rows[i].id;
			        	selectIds = selectIds + id +',';
					}
					window.open("${contextPath}/proledger/problem/expMiddleLedgerProblemList.action?report=report&project_id=<%=request.getParameter("project_id")%>&id="+selectIds,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
				}else{
					$.messager.show({title:'提示信息',msg:'请选择一条数据进行操作！'});
				}
			}
			//删除
			function delLedgerOwner(){
				var rows = $('#operate-opr_ledger_list_mid').datagrid('getChecked');
				var selectIds = "";
				if(rows.length != 0){
					$.messager.confirm("提示信息","确认删除这 "+rows.length+" 条数据吗？",function(r){
						if(r){
							for(var i=0;i<rows.length;i++){
								var id = rows[i].id;
								selectIds = selectIds + id +',';
							}
							$.ajax({
			                    type: "POST",
			                    dataType:'json',
			                    url : "/ais/proledger/problem/delLedgerProblem.action",
			                    data:{ "ids":selectIds},
			                    success: function(data){
			                        if(data.type == 'ok'){
			                        	showMessage2('删除成功！','消息','0');
			                            window.location.reload();
			                        }else{
			                        	showMessage2('删除失败！','消息','0');
			                        }
			                    },
			                    error:function(data){
			                    	showMessage2('请求失败！','消息','0');
			                    }
			                });
						}
				 });
				}else{
					$.messager.alert("提示信息","请选择一条数据进行操作！","info");
				}
				
			}
			function toOPenWindow(id){
				var viewSjwtUrl11  = "${pageContext.request.contextPath}/operate/manu/viewAll.action?crudId="+id+"&interaction=${interaction}&view=${param.view}";
				window.parent.addTab('tabs','查看审计底稿','tempframe',viewSjwtUrl11,true); 
			}
		</script>
	</body>
</html>