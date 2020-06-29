<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>清理垃圾数据</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	    <div region="center" border='0'>
			<table id="projectList"></table>
		</div>


		<script type="text/javascript">

			var datagrid;
			$(function(){
				var bodyW = $('body').width();
			    // 初始化生成表格
				datagrid = $('#projectList').datagrid({
				    url:"<%=request.getContextPath()%>/operate/cleanData/cleanDataBubbish.action",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize: 20,
    				fitColumns:true,
					idField:'formId',
					border:false,
					remoteSort: false,
					toolbar:[{
							id:'cleanLedgerTemplateNew',
							text:'问题库',
							iconCls:'icon-search',
							handler:function(){
								cleanLedgerTemplateNew();
							}
						},'-',
                        {
                            id:'cleanAuditMatter',
                            text:'事项库',
                            iconCls:'icon-search',
                            handler:function(){
                            	cleanAuditMatter();
                            }
                        },'-',
                        {
                            id:'cleanAudTemplate',
                            text:'审计方案库',
                            iconCls:'icon-search',
                            handler:function(){
                            	cleanAudTemplate();
                            }
                        },'-',
                        {
                            id:'cleanProjectAudTask',
                            text:'项目审计方案',
                            iconCls:'icon-search',
                            handler:function(){
                            	cleanProjectAudTask();
                            }
                        }
					],
					columns:[[
						
						{field:'detail',
							 title:'功能名称',
							 width:0.1*bodyW+'px',
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'clsName',
							title:'类名',
							width:0.1*bodyW+'px',
							halign:'center',
							align:'left',
							sortable:true
						},{field:'tableName',
							title:'表名',
							width:0.1*bodyW+'px',
							halign:'center',
							align:'left',
							sortable:true
						},
						{field:'id',
							title:'主键',
							width:0.4*bodyW+'px',
							halign:'center',
							align:'left',
							sortable:true
						}

					]]
				});
				//单元格tooltip提示
				$('#projectList').datagrid('doCellTip', {
					onlyShowInterrupt : true,
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
				
			});
                 //问题库
				function cleanLedgerTemplateNew(){
					$('#projectList').datagrid({
					    url:'${contextPath}/operate/cleanData/cleanLedgerTemplateNew.action'
					});
				}
				
                 //审计事项库
				function cleanAuditMatter(){
					$('#projectList').datagrid({
					    url:'${contextPath}/operate/cleanData/cleanAuditMatter.action'
					});
				}
				//审计方案模板库
				function cleanAudTemplate(){
					$('#projectList').datagrid({
					    url:'${contextPath}/operate/cleanData/cleanAudTemplate.action'
					});
				}
				//项目事项
				function cleanProjectAudTask(){
					$('#projectList').datagrid({
					    url:'${contextPath}/operate/cleanData/cleanProjectAudTask.action'
					});
				}
 		</script>
	</body>
</html>
