<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目列表</title>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
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
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="addDataSearch" class="searchWindow">
			<div class="search_head">
			<s:form id="searchForm" name="searchForm" namespace="/auditAccessoryList" action="listMyProject" method="post">
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" style="width:15%">项目编号</td>
						<td class="editTd" style="width:35%">
							<input id="uploadRole" type="hidden" value="${uploadRole}">
							<s:textfield cssClass="noborder" name="projectStartObject.project_code" maxlength="100" cssStyle="width:80%;" />
						</td>
						<td class="EditHead" style="width:15%">项目名称</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="projectStartObject.project_name" maxlength="100" cssStyle="width:80%;"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">审计单位</td>
						<td class="editTd">
							<s:buttonText2 cssClass="noborder" name="projectStartObject.audit_dept_name"
								hiddenName="projectStartObject.audit_dept" cssStyle="width:80%;"
								doubleOnclick="showSysTree(this,{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',title:'请选择审计单位',param:{'p_item':1,'orgtype':1}})"
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
						<td class="EditHead">被审计单位</td>
						<td class="editTd">
							<s:buttonText2 cssClass="noborder" name="projectStartObject.audit_object_name" hiddenName="projectStartObject.audit_object" cssStyle="width:80%;"
							doubleOnclick="showSysTree(this,{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                              cache:false,checkbox:true,height:500,title:'请选择被审计单位'})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif" doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
					</tr>
				</table>
			</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#addDataSearch').window('close')">取消</a>
				</div>
			</div>
		</div>
		<div region="center">
			<table id="projectList"></table>
		</div>
		<script type="text/javascript">
			 function doSearch(){
	        	$('#projectList').datagrid({
	    			queryParams:form2Json('searchForm')
	    		});
	        }
		//重置查询条件
			function restal(){
				resetForm('searchForm');
				//doSearch();
			}
		$(function(){
			//查询
			showWin('addDataSearch');
			$('#projectList').datagrid({
				url : "<%=request.getContextPath()%>/auditAccessoryList/listMyProject.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'searchObj',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('addDataSearch');
						}
					}],
				frozenColumns:[[
				       			{field:'is_closed',title:'状态',align:'left',halign:'center',sortable:true,
				       				formatter:function(value,rowData,rowIndex){
					       				if(rowData.is_closed=='closed'){
											return '已关闭';
					       				}else if(rowData.is_closed=='running'){
											return '进行中';
						       			}
				       				}
			       				},
				       			{field:'project_code',title:'项目编号',width:'280px',sortable:true,halign:'center',align:'left'}
				    		]],
				columns:[[
					{field:'project_name',
							title:'项目名称',
							width:150,
							align:'left',
							halign:'center',
							sortable:true
					},
					{field:'pro_type_name',
						title:'项目类别',
						sortable:true, 
						halign:'center',
						align:'left'
					},
					{field:'audit_dept_name',
						 title:'所属单位',
						 align:'left',
						 halign:'center', 
						 sortable:true
					},
					{field:'prepare_closed',
						 title:'准备',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
		       				if(rowData.prepare_closed=='1'){
								return '已完成';
		       				}else if(rowData.prepare_closed=='0'){
								return '进行中';
			       			}else{
								return '未执行';
				       		}
	       				}
	   				},
					{field:'actualize_closed',
						 title:'实施',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
		   					if(rowData.actualize_closed=='1'){
								return '已完成';
		       				}else if(rowData.actualize_closed=='0'){
								return '进行中';
			       			}else{
								return '未执行';
				       		}
	       				}
   					},
					{field:'report_closed',
						 title:'终结',
						 align:'left', 
						 halign:'center',
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
	   						if(rowData.report_closed=='1'){
								return '已完成';
		       				}else if(rowData.report_closed=='0'){
								return '进行中';
			       			}else{
								return '未执行';
				       		}
	       				}
	   				},
					{field:'archives_closed',
						 title:'档案',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
		   					if(rowData.archives_closed=='1'){
								return '已完成';
		       				}else if(rowData.archives_closed=='0'){
								return '进行中';
			       			}else{
								return '未执行';
				       		}
	       				}
	   				},
					{field:'rework_closed',
						 title:'整改',
						 align:'left', 
						 halign:'center',
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
		   					if(rowData.rework_closed=='1'){
								return '已完成';
		       				}else if(rowData.rework_closed=='0'){
								return '进行中';
			       			}else{
								return '未执行';
				       		}
	       				}
	   				},
					{field:'operate',
						 title:'操作',
						 align:'center', 
						 halign:'center',
						 sortable:false,
						 formatter:function(value,row,index){
						 	var param = [row.formId,row.pro_typee,row.pro_type_child];
					 		var btn2 = "";
						 	<s:if test="${uploadRole == 1}">
						 		btn2 = "资料管理,updateauditAccessory,"+param.join(',');
								var btn = '<a href=\"javascript:void(0)\" onclick=\"updateauditAccessory(\''+row.formId+'\',\''+row.pro_type+'\',\''+row.pro_type_child+'\');\">资料管理</a>';
						 	</s:if>
						 	<s:else>
						 		btn2 = "添加资料,addauditAccessory,"+param.join(',');
						 		var btn = '<a href=\"javascript:void(0)\" onclick=\"addauditAccessory(\''+row.formId+'\',\''+row.pro_type+'\',\''+row.pro_type_child+'\');\">添加资料</a>';
							</s:else>
							return ganerateBtn(btn2);
	   					}
					}
				]]
			}); 
		});
		function updateauditAccessory(id,type,typechild){
			window.location.href="/ais/auditAccessoryList/list.action?cruProId="+id+"&pro_type="+type+"&pro_type_child="+typechild;
		}
		function addauditAccessory(id,type,typechild){
			window.location.href="/ais/auditAccessoryList/list.action?cruProId="+id+"&pro_type="+type+"&pro_type_child="+typechild;
		}
		</script>
	</body>
</html>