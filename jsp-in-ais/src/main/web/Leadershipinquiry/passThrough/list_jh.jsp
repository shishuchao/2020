<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>计划穿透页面</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
					<s:form id="searchForm" name="searchForm" action="planCountByFwAndNd" namespace="/Leadershipinquiry" method="post">
						<s:token/>
						<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
							<tr >
								<td class="EditHead" >计划状态</td>
								<td class="editTd">
								    <select class="easyui-combobox" name="status" editable="false">
								       <option value="">请选择</option>
										<option value="0">未启动</option>
										<option value="1">正在执行</option>
										<option value="2">执行完毕</option>
								    </select>
								</td>
								<td class="EditHead">审计单位</td>
								<td class="editTd">
									<s:buttonText2 name="searchSjdw" cssClass="noborder" cssStyle="width:71.5%"
												   hiddenName="hidenSjdw"
												   doubleOnclick="showSysTree(this,
         											{url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
           											title:'请选择审计单位',
                             						param:{
                               							'p_item':3
                             								},
                              						checkbox:false
         											})"
												   doubleSrc="${contextPath }/easyui/1.4/themes/icons/search.png"
												   doubleCssStyle="cursor:hand;border:0" readonly="true" />
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
		<div region="center" border='0'>
			<table id="yearList"></table>
		</div>
		<script type="text/javascript">
			function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			/*
			* 查询
			*/
			function doSearch(){
	        	$('#yearList').datagrid({
	    			queryParams:form2Json('searchForm')
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
				resetForm('searchForm');
				// doSearch();
			}
			

			function planName(id, w_plan_name){
				var viewUrl = "${contextPath}/plan/year/viewBU.action?selectedTab=yearDetailListDiv&crudId="+id;
				aud$openNewTab( w_plan_name,viewUrl,false);
			}
			
			$(function(){
				var bodyW = $('body').width();
				//查询
				showWin('dlgSearch');
				//var d = new Date();
				loadSelectH();
				//$('#w_plan_year').combobox('setValue',d.getFullYear());
				// 初始化生成表格
				$('#yearList').datagrid({
					url : "<%=request.getContextPath()%>/Leadershipinquiry/planCountByFwAndNd.action?querySource=grid&proyear=${param.proyear}&sjdw=${param.sjdw}&t="+new Date().getTime() ,
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
					singleSelect:true,
					remoteSort: true,
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch',750);
							}
						}
					],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					columns:[[
						{field:'status_name',title:'计划状态',sortable:true,halign:'center',align:'left',width:0.06*bodyW+'px',
							formatter:function (value,rowData,rowIndex) {
							debugger;
						    if(rowData.status_name == undefined){
                                if(rowData.xmType == 'syOff') {
                                    var stagename = rowData.processName;
                                    if(stagename == '实施' || stagename == '终结' || stagename == '准备' || stagename == null) {
                                        stagename = '正在执行';
                                    }
                                    if(stagename == '已完成'){
                                        stagename = '执行完毕';
									}
                                    return stagename;
                                } else {
                                    if(rowData.prepare_closed==null || rowData.prepare_closed == '' || rowData.prepare_closed=='0'){
                                        return '正在执行'
                                    }
                                    if (rowData.report_closed==null || rowData.report_closed == '' || rowData.report_closed=='0'){
                                        return '正在执行'
                                    }
                                    if (rowData.archives_closed==null || rowData.archives_closed == '' || rowData.archives_closed=='0'){
                                        return '正在执行'
                                    }
                                    if (rowData.rework_closed==null || rowData.rework_closed== ''|| rowData.rework_closed=='0'){
                                        return '执行完毕'
                                    } else {
                                        return '执行完毕'
                                    }
                                }
							}else{
                                if(rowData.xmType == 'syOff' && (rowData.status_name == '新增已审批' || rowData.status_name == '调整已审批')) {
                                    return '正在执行';
								}else if((rowData.xmType == 'bs' || rowData.xmType == undefined) && (rowData.status_name == '新增已审批' || rowData.status_name == '调整已审批')){
                                    return '未启动';
                                }
                                return rowData.status_name;
							}
							}},
						{field:'w_plan_name',
							title:'计划名称',
							width:0.25*bodyW+'px',
							halign:'center',
							align:'left',
							sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                if(rowData.w_plan_name == undefined){
                                    return rowData.project_name;
                                }else{
                                    return rowData.w_plan_name;
								}
                            }
						},
						{field:'w_plan_code',title:'计划编号',width:0.1*bodyW+'px',sortable:true,halign:'center',align:'left',
                            formatter:function(value,rowData,rowIndex){
						    		if(rowData.w_plan_code == undefined){
						    		    return rowData.plan_code;
									}else{
						    		    return rowData.w_plan_code;
									}
                                }
						},
						{field:'w_plan_year',
							title:'计划年度',
							sortable:true, 
							halign:'center',
							align:'center',
							width:0.1*bodyW+'px',
                            formatter:function(value,rowData,rowIndex){
                                if(rowData.w_plan_year == undefined){
                                    return rowData.pro_year;
                                }else{
                                    return rowData.w_plan_year;
								}
                            }
						},
                        {field:'pro_type_name',
                            title:'项目类别',
                            width:0.1*bodyW+'px',
                            halign:'center',
                            align:'left',
                            sortable:true
                        },
						{field:'audit_dept_name',
							 title:'审计单位',
							 width:0.1*bodyW+'px',
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'audit_object_name',
							 title:'被审计单位',
							 halign:'center',
							 align:'left',
							 sortable:true,
							width:0.15*bodyW+'px'
						}
					]]   
				});
				//单元格tooltip提示
				$('#yearList').datagrid('doCellTip', {
					onlyShowInterrupt:true,
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
			});
		</script>
	</body>
</html>