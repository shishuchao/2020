<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>档案信息查询</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>		
		<script type="text/javascript">
			function execExport(columns){
				document.getElementById("searchAll").action="exportExcel.action?"+columns;
				document.getElementById("searchAll").target="_blank";
				document.getElementById("searchAll").submit();
				document.getElementById("searchAll").action="searchAll.action";
				document.getElementById("searchAll").target="_self";
			}
		   /*
			* DisplayTag添加顶层Header
			*/
			function addTopTableHeader(){
		
				var listTable = document.getElementById('row');
				
				
				var newHeaderTr = tableHead.insertRow(0);
				
				var cellOne = document.createElement("th");
				cellOne.colSpan = 9;
				cellOne.className = "center_nowrap";
				cellOne.innerHTML = '档案信息';
				cellOne.style.textAlign = 'center';
				cellOne.style.fontWeight = 'bold';
				newHeaderTr.appendChild(cellOne);
				
				var cellTwo = document.createElement("th");
				cellTwo.colSpan = 17;
				cellTwo.className = "center_nowrap";
				cellTwo.innerHTML='项目信息';
				cellTwo.style.textAlign = 'center';
				cellTwo.style.fontWeight = 'bold';
				newHeaderTr.appendChild(cellTwo);
				
			}
					addTopTableHeader();
			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('archivesTable').style.display;
				if(isDisplay==''){
					document.getElementById('archivesTable').style.display='none';
				}else{
					document.getElementById('archivesTable').style.display='';
				}
			}		
			
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
			<s:form action="searchAll" namespace="/archives/pigeonhole" id="searchAll">
				<table id="archivesTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" >
					<tr >
						<td align="left" class="EditHead" style="width:15%">档案名称</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="pigeonholeObject.archives_name" cssStyle="width:80%" cssClass="noborder" size="20" />
						</td>
						<td align="left" class="EditHead" style="width:15%">档案年度</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="pigeonholeObject.archives_year" cssStyle="width:80%" cssClass="noborder" size="15" />
						</td>
					</tr>
					<tr >
						<td align="left" class="EditHead">档案编号</td>
						<td align="left" class="editTd">
							<s:textfield name="pigeonholeObject.archives_code" cssStyle="width:80%" cssClass="noborder" size="20"/>
						</td>
						<td align="left" class="EditHead">审计单位</td>
						<td align="left" class="editTd">
							<s:buttonText2 name="pigeonholeObject.archives_unit_name" size="15"
									hiddenName="pigeonholeObject.archives_unit" 
									cssStyle="width:80%" cssClass="noborder"
									doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									  param:{
	                                    'p_item':0,
	                                    'orgtype':1
	                                  },
									  title:'所属单位'
									})"
									doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0" readonly="true" 
									doubleDisabled="false"
									maxlength="100"/>	
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">被审单位</td>
						<td align="left" class="editTd">
							<s:buttonText2 id="pigeonholeObject.audit_object_name" hiddenId="pigeonholeObject.audit_object"
							name="pigeonholeObject.audit_object_name" hiddenName="pigeonholeObject.audit_object"
							cssStyle="width:80%"  cssClass="noborder"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                              cache:false,
							  checkbox:true,
                              height:500,
							  title:'被审计单位'
							})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
							title="被审单位" maxlength="1500"
							display="${varMap['audit_objectRead']}"
							doubleDisabled="!(varMap['audit_object_buttonWrite']==null?true:varMap['audit_object_buttonWrite'])" 
							/>
						</td>	
						<td align="left" class="EditHead">项目类别</td>
						<td align="left" class="editTd">
							<s:doubleselect id="pro_type" doubleId="pro_type_child" cssClass="easyui-combobox"
								doubleList="basicUtil.planProjectTypeMap[top]" doubleListKey="code" cssStyle="width:80%"
								doubleListValue="name" listKey="code" listValue="name" 
								name="pigeonholeObject.pro_type" list="basicUtil.planProjectTypeMap.keySet()"
								doubleName="pigeonholeObject.pro_type_child" theme="ufaud_simple"
								templateDir="/strutsTemplate"
								display="${varMap['pro_typeRead']}" emptyOption="true"/>
						</td>
					</tr>
					
				</table>
			</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
		    </div>
		 </div>
		
		<div region="center" >
			<table id="listArchivesDiv"></table>
		</div>
		<div id="commonPage"></div>
		<script type="text/javascript">
			/*
			* 查询
			*/
			function doSearch(){
		       $('#listArchivesDiv').datagrid({
	    			queryParams:form2Json('searchAll')
	    		});
				$('#dlgSearch').dialog('close');
		       }
		       /*
			* 取消
			*/
			function doCancel(){
				$('#dlgSearch').dialog('close');
			}
			/**
				重置
			*/	
			function restal(){
				resetForm('searchAll');
				//doSearch();
			}
			
			

			$(function(){
				showWin('commonPage','公用弹窗页面');
				showWin('dlgSearch');
				$('#listArchivesDiv').datagrid({
				url : "<%=request.getContextPath()%>/archives/pigeonhole/searchAll.action?querySource=grid",
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
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch');
						}
					},
					{
						id:'toWord',
						text:'导出',
						iconCls:'icon-export',
						handler:function(){
							toWord();
							
						}
					}
				],
				frozenColumns:[[
				    {field:'archives_status_name',
				       		title:'归档状态',
				       		width:100,
				       		halign:'center',
				       		align:'left',
				       		sortable:true,
				       		formatter:function(value,row,rowIndex){
								return row[0].archives_status_name;
					}},
				    {field:'archives_code',
				            title:'档案编号',
				            width:100,
				            halign:'center',
				            sortable:true,
				            align:'right',
				            formatter:function(value,row,rowIndex){
								return row[0].archives_code;
				    }}
				]],
				columns:[[  
					{field:'archives_name',
							title:'档案名称',
							width:280,
							halign:'center',
							align:'left', 
							sortable:true,
							formatter:function(value,row,rowIndex){
								return row[0].archives_name;
				    }},
					{field:'archives_secrecy_name',
						 title:'秘密等级',
						 width:100,
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						formatter:function(value,row,rowIndex){
								return row[0].archives_secrecy_name;
				    }},
					{field:'basic_save_year_name',
						 title:'保存期限(年)',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row[0].basic_save_year_name;
				    }},
					{field:'archives_start_man_name',
						 title:'档案发起人',
						 width:100,
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row[0].archives_start_man_name;
				    }},
					{field:'archives_year',
						 title:'档案年度',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
						    if (row[0].archives_time != null ) {
						    	return row[0].archives_time.substring(0,4);
						    }		
				    }},
					{field:'archives_time',
						 title:'归档日期',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
						        if (row[0].archives_time != null ) {
						        	return row[0].archives_time.substring(0,10);
						        }	
				    }},
					{field:'plan_code',
						 title:'计划编号',
						 width:200,
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row[1].plan_code;
				    }},
					{field:'project_name',
						 title:'项目名称',
						 width:200,
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row[0].project_name;
				    }},
					{field:'plan_form',
						 title:'计划来源',
						 width:80,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row[1].plan_form;
				    }},
					{field:'plan_type_name',
						 title:'计划类别',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row[1].plan_type_name;
				    }},
					{field:'plan_grade_name',
						 title:'计划等级',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row[1].plan_grade_name;
				    }},
					{field:'w_plan_year',
						 title:'计划年度',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
							if(row[2].w_plan_year!=null){
								return row[2].w_plan_year;
							}
						 }
					},
					{field:'w_plan_month',
						 title:'计划月度',
						 width:80,
						 halign:'center', 
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row[2].w_plan_month;
				    }},
					{field:'pro_type_name',
						 title:'项目类别',
						 width:150,
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row[1].pro_type_name;
				    }},
					{field:'pro_type_child_name',
						 title:'项目子类别',
						 width:150,
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						  formatter:function(value,row,rowIndex){
								return row[1].pro_type_child_name;
				    }},
					{field:'audit_dept_name',
						 title:'审计单位',
						 width:150,
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						formatter:function(value,row,rowIndex){
								return row[1].audit_dept_name;
				    }},
					{field:'audit_object_name',
						 title:'被审计单位',
						 width:150,
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						formatter:function(value,row,rowIndex){
								return row[1].audit_object_name;
				    }},
					{field:'audit_start_time',
						 title:'审计期间（起）',
						 width:120,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndedx){
							if(row[1].audit_start_time!=null){
								return row[1].audit_start_time.substring(0,10);
							}
						 }
					},
					{field:'audit_end_time',
						 title:'审计期间（止）',
						 width:120,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
							if(row[1].audit_end_time!=null){
								return row[1].audit_end_time.substring(0,10);
							}
						 }
					},
					{field:'projectZH',
						 title:'项目组长',
						 width:80,
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){						 	
						 		return row[1].projectZH;
				    }},
					{field:'projectZS',
						 title:'项目主审',
						 width:80,
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row[1].projectZS;
				    }},
					{field:'real_start_time',
						 title:'启动日期',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								if(row[1].real_start_time!=null){
									return row[1].real_start_time.substring(0,10);
								}	
						 }
					},{field:'real_closed_time',
						 title:'关闭日期',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
						 	if(row[1].real_closed_time != null){
							 	return row[1].real_closed_time.substring(0,10);
							 }
						 }
					}
				]]   
			}); 
		});
			
			function toWord(){
				var url = '${contextPath}/pages/archives/pigeonhole/columnSelector.jsp';
				showWinIf('commonPage',url,'选择窗口',530,400);
			}
			</script>
		
		
		
	</body>
</html>