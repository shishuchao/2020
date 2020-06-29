<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<STYLE type="text/css">
	/*.datagrid-row {
	  	height: 30px;
	}
	.datagrid-cell {
		height:10%;
		padding:1px;
	}*/
</STYLE>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
				<s:form id="download" />
				<s:form action="listMyProject" namespace="/project" method="post" name="myform" id="myform">
				 <input type="hidden" name="condition" value="yes" reload="false"/>
					<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr >
						<%-- 	<td class="EditHead" style="width:15%">
								项目编号
							</td>
							<td class="editTd" style="width:35%">
								<s:textfield cssClass="noborder" name="crudObject.project_code" cssStyle="width:80%" maxlength="50"/>
							</td> --%>
							<td class="EditHead" style="width:20%">
						                   项目编号
					        </td>
					       <td class="editTd" style="width:30%">
						      <s:textfield cssClass="noborder" name="crudObject.project_code"  cssStyle="width:80%"/>
					       </td>
							<td class="EditHead" style="width:15%">
								项目名称
							</td>
							<td class="editTd" style="width:35%">
								<s:textfield cssClass="noborder" name="crudObject.project_name" cssStyle="width:80%" maxlength="50"/>
							</td>
						</tr>
						<s:if test="'${projectType}'!=@ais.project.ProjectContant@NBZWPG">
						<tr class="listtablehead" height="23">
							<td class="EditHead">
								计划类别
							</td>
							<td class="editTd">
							    <select editable="false" id="plan_type" data-options="panelHeight:'auto'" class="easyui-combobox" name="crudObject.plan_type" style="width:80%" >
							       <option value="">&nbsp;</option>
							       <s:iterator value="basicUtil.planTypeList" id="entry">
							         <option value="<s:property value="code"/>"><s:property value="name"/></option>
							       </s:iterator>
							    </select>
							</td>
							<td class="EditHead">
								项目类别
							</td>
							<td class="editTd">
							    <s:buttonText name="crudObject.pro_type_name" cssClass="noborder"
										hiddenName="crudObject.pro_type" cssStyle="width:80%" 
										doubleOnclick="getItem('/pages/basic/code_name_tree_select.jsp','&nbsp;请选择项目类别',500,400)"
										doubleSrc="/resources/images/s_search.gif"
										doubleCssStyle="cursor:hand;border:0" readonly="true"
										doubleDisabled="false" />
								<input type="hidden" name="crudObject.pro_type_child" value="">
							</td>
						</tr>
					</s:if>
						<tr >
							<%-- <td class="EditHead" nowrap="nowrap">
								某阶段状态
							</td>
							<td class="editTd">
							    <select editable="false" id="searchStage" data-options="panelHeight:'auto'" class="easyui-combobox" name="crudObject.searchStage" style="width:39%" >
							       <option value="">&nbsp;</option>
							       <s:iterator value="@ais.project.ProjectUtil@getProjectAllStageFieldName()" id="entry">
							         <option value="<s:property value="key"/>"><s:property value="value"/></option>
							       </s:iterator>
							    </select>
							    <select  editable="false" id="stageStatus" data-options="panelHeight:'auto'" class="easyui-combobox" name="crudObject.stageStatus" style="width:39%" >
							       <option value="">&nbsp;</option>
							       <s:iterator value="#@java.util.LinkedHashMap@{'null':'未执行','0':'进行中','1':'已完成'}" id="entry">
							         <option value="<s:property value="key"/>"><s:property value="value"/></option>
							       </s:iterator>
							    </select> --%>
							   <td class="EditHead">
									当前阶段
								</td>
								<td class="editTd" >
			                        <select class="easyui-combobox" data-options="panelHeight:'auto'" name="crudObject.stageStatus" style="width:80%"  editable="false">
			                            <option value="">请选择</option>
			                            <s:iterator value="#@java.util.LinkedHashMap@{'准备':'准备','实施|终结':'实施|终结','归档':'归档','整改':'整改','完结':'完结'}" id="entry">
			                                <option value="<s:property value="key"/>"><s:property value="value"/></option>
			                            </s:iterator>
			                        </select>
								</td>
							<td class="EditHead">
								项目年度
							</td>
							<td class="editTd">
								<!--<s:select  name="crudObject.pro_year"  id="w_plan_year"
									list="@ais.project.ProjectUtil@getIncrementSearchYearList(5,10)"
									disabled="false"
									theme="ufaud_simple" templateDir="/strutsTemplate"  cssClass="easyui-combobox"
									 />-->
								    <select editable="false" id="w_plan_year" class="easyui-combobox" name="crudObject.pro_year" style="width:80%" >
								       <option value="">请选择</option>
								       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
								         <option value="<s:property value="key"/>"><s:property value="value"/></option>
								       </s:iterator>
								    </select>	 
							</td>
						</tr>
					</table>
					<s:if test="projectList.size!=0">
						<div align="right" style="width: 98%">
								<s:hidden id="export" name="export" />
						</div>
					</s:if>
				</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
		        	列表默认当年，其他年度请使用查询&nbsp;&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
		    </div>
		</div>	
		<div region="center">
			<table id="projectList"></table>
		</div>
		<div id="subwindow" class="easyui-window" title="" iconCls="icon-search" style="width:500px;height:500px;padding:5px;" closed="true">
			<div class="easyui-layout" fit="true">
				<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
					<iframe id="item_ifr" name="item_ifr" src="" frameborder="0" width="100%" height="100%" scrolling="auto" ></iframe>
				</div>
				<div region="south" border="false" style="text-align:right;padding:5px 0;">
				    <div style="display: inline;" align="right">
						<a class="easyui-linkbutton" iconCls="icon-ok" href="javascript:void(0)" onclick="saveF()">确定</a>
						<a class="easyui-linkbutton" iconCls="icon-remove" href="javascript:void(0)" onclick="cleanF()">清空</a>
						<a class="easyui-linkbutton" iconCls="icon-cancel" href="javascript:void(0)" onclick="closeWin()">关闭</a>
				    </div>
				</div>
			</div>
		</div>

		<div id="importProjects" class="easyui-window" closed="true">
			<s:form id="importForm" action="mutualToManage" namespace="/interact/interactProxyToWork" method="post" enctype="multipart/form-data" onsubmit="wait();">
				<s:hidden name="project_id" id="project_id"/>
				<s:hidden name="project_name" id="project_name"/>
				<s:hidden name="loginname" value="${user.floginname}"/>
				<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
					<tr>
						<td align="left" class="EditHead" style="vertical-align: middle;">选择文件</td>
						<td class="editTd" align="left"><s:file name="myfile" size="66%" cssStyle="font-size:15px" accept="application/zip" id="myfile"/></td>
						<td class="editTd" align="right"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-import'" id="importButton" onclick="submit_dr();">导入</a></td>
					</tr>
				</table>
			</s:form>
		</div>
		<script type="text/javascript">
			function wait() {
				$('#importProjects').window('close');
				document.getElementById("importButton").disabled = true;
				/*document.getElementById("layer").style.display = "";
				document.getElementById("errorInfo1").style.display = "none";
				document.getElementById("errorInfo2").style.display = "none";*/
			}

			function submit_dr(){
				var template = $('#myfile').val();
				var project_name = $('#project_name').val();
				if(template == '' ){
					$.messager.alert('系统提示',"请先选择要导入的文件",'warning');
					return;
				} else {
					if(template.indexOf(project_name) == -1){
						$.messager.alert('系统提示',"请选择正确项目导入!",'warning');
						return;
					}
					frloadOpen();
					jQuery("#importForm").submit();
				}
			}

			/*
			* 查询
			*/
			function doSearch(){
		 	//document.getElementById('myform').action = "${contextPath}/project/listMyProject.action";
	        	$('#projectList').datagrid({
	    			queryParams:form2Json('myform')
	    		});
				$('#dlgSearch').dialog('close');
	        	//return declareExport('false'); 
				
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
				resetForm('myform');
				//window.location.href='${contextPath}/project/listMyProject.action';
			}
		
			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('searchTable').style.display;
				if(isDisplay==''){
					document.getElementById('searchTable').style.display='none';
				}else{
					document.getElementById('searchTable').style.display='';
				}
			}

			/*
			* 每次提交查询之前都要设置一下export这个参数标识为是否为ExcelResult
			*/
			function declareExport(bool){
				document.getElementById('export').value=bool;
				return true;
			}
			
			//项目阶段点击操作
		function projectIndex(crudId,pr,ac,rp) {
		   var stateNo = '12';
				if(ac=="0"){
					stateNo = '21';
				}else if(rp=="0"){
					stateNo = '3';
				}
			var udswin = window.open(
					'${contextPath}/project/prepare/projectIndex.action?crudId='
							+ crudId + '&stateNo=' + stateNo, '',
							'height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			udswin.moveTo(0, 0);
			udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
		}
		
		function goProjectMenu(projectid,prepare_closed,actualize_closed,report_closed,archives_closed,rework_closed,ifView,process){
			var stage = "";
			if(process == 'simplified'){
			    stage = 'simplified';
			}else {
                if (prepare_closed && prepare_closed == '0') {
                    stage = "prepare";
                } else if (actualize_closed && actualize_closed == '0') {
                    stage = "actualize";
                } else if (report_closed && report_closed == '0') {
                    stage = "report";
                } else if (archives_closed && archives_closed == '0') {
                    stage = "archives";
                } else if (rework_closed && rework_closed == '0') {
                    stage = "rework";
                }
            }
			//window.open("${contextPath}/project/prepare/projectIndex.action?stateNo="+stateNo+"&crudId="+projectid+"&view=view");
			<%--if(archives_closed=='1'){//档案阶段已完成 在审计作业中项目不可以切换只显示当前的项目名称--%>
				<%--window.open(--%>
						<%--'${contextPath}/project/prepare/projectIndex.action?crudId='--%>
								<%--+ projectid + '&stage=' + stage + '&isView=2&view='+ifView, '',--%>
								<%--'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');--%>
			<%--}else{//审计作业中的项目可以切换--%>
            var udswin = null;
			if(rework_closed =='1'){
                udswin = window.open(
						'${contextPath}/project/prepare/projectIndex.action?crudId='
								+ projectid + '&stage=' + stage + '&source=view&projectview=view&isView=2&view=view', '',
								//'height=700px, width=1300px, fullscreen=yes, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
                    			'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			}else{
                udswin = window.open(
						'${contextPath}/project/prepare/projectIndex.action?crudId='
								+ projectid + '&stage=' + stage + '&view='+ifView, '',
								// 'height=700px, width=1300px, fullscreen=yes, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
            				    'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			}
            if (udswin) {
                udswin.moveTo(0, 0);
                udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
            }
		}
		//导出全部项目
		function exportAllProject(){
            document.getElementById('myform').action = "<%=request.getContextPath()%>/project/exportProject.action?myProject=Y";
            $('#myform').submit();
		}
		//导出勾选项目
        function exportProject(){
			var rows = datagrid.datagrid("getSelections");
            var ids = [];
            if (rows.length > 0) {
               for (var i = 0; i < rows.length; i++) {
                   ids.push(rows[i].formId);
               }
				document.getElementById('myform').action = "<%=request.getContextPath()%>/project/exportProject.action?crudIds="+ids+"&myProject=Y";
                $('#myform').submit();
            }else{
				showMessage1('请先勾选所需导出的项目');
			}

		}
		var datagrid;
		$(function (){
		    var bodyW = $('body').width();
            if('${message}' != null && '${message}' != '') {
				showMessage1('${message}');
			}
			showWin('dlgSearch');
			//$('body').layout('collapse','north');
			if('${empty crudObject.pro_year}'=='true'){
				var d = new Date();
				$('#w_plan_year').combo('setValue',d.getFullYear());
				$('#w_plan_year').combo('setText',d.getFullYear());
			}
			// 初始化生成表格			
			datagrid=$('#projectList').datagrid({
				url : "<%=request.getContextPath()%>/project/listMyProject.action?querySource=grid",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				fitColumns: true,
				pageSize: 20,
				border:false,
				singleSelect:false,
				remoteSort: false,
				toolbar:[{
					id:'search',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('dlgSearch');
					}
				},'-',
				{
					id:'export',
					text:'导出',
					iconCls:'icon-export',
					handler:function(){
						exportProject();
					}
				},'-',
                    {
                        id:'export',
                        text:'导出全部',
                        iconCls:'icon-export',
                        handler:function(){
                            exportAllProject();
                        }
                    }
				],
				
				onLoadSuccess:function(){
					doCellTipShow('projectList');
				},
				
				frozenColumns:[[
								{field:'formId',width:'50', checkbox:true,halign:'center', align:'center'},
				       			{field:'is_closed',title:'状态',halign:'center',width: bodyW*0.05+'px',align:'center',formatter:function(value,rowData,rowIndex){
										if(rowData.rework_closed == '1') {
											return "已完结";
										} else {
											if(rowData.is_closed == 'closed'){
												return '已关闭';
											}else if(rowData.is_closed == 'running'){
												return '进行中';
											}
										}
		       						}
								 },
				       			{field:'project_code',title:'项目编号',width: bodyW*0.1+'px',halign:'center',sortable:true,align:'center'}
				    		]],
				columns:[[  
					{field:'project_name',
							title:'项目名称',
							width: bodyW*0.14+'px',
							halign:'center',
							align:'left',
							sortable:true,
							formatter:function(value ,rowData,rowIndex){
								if(rowData.is_closed=='running' || '@ais.project.ProjectSysParamUtil@isClosedProjectCanView()'){
									if(rowData.isUserInMembers=='suc'){
										if(rowData.is_closed=='running'||rowData.rework_closed=='0'){
											return '<a href=\"javascript:void(0)\" onclick=\"goProjectMenu(\''+rowData.formId+'\',\''+rowData.prepare_closed+'\',\''+rowData.actualize_closed+'\',\''+rowData.report_closed+'\',\''+rowData.archives_closed+'\',\''+rowData.rework_closed+'\',\''+''+'\',\''+rowData.planProcess+'\');\">'+value+'</a>';
										}else{
											return '<a href=\"javascript:void(0)\" onclick=\"goProjectMenu(\''+rowData.formId+'\',\''+rowData.prepare_closed+'\',\''+rowData.actualize_closed+'\',\''+rowData.report_closed+'\',\''+rowData.archives_closed+'\',\''+rowData.rework_closed+'\',\''+'view'+'\',\''+rowData.planProcess+'\');\">'+value+'</a>';
										}
									}else{
										return '<a href="${contextPath}/project/view.action?viewPermission=full&crudId='+rowData.formId+'" target="_blank" >'+value+'</a>';
									}	
								}else{
									return rowData.project_name
								}	
							}	
					},
					{field:'pro_type_name',
						title:'项目类别',
						width:bodyW*0.08+'px',
						align:'center',
						sortable:true,
						formatter:function(value,rowData,rowIndex){
							if(rowData.pro_type_child_name != null && rowData.pro_type_child_name != '') {
								return rowData.pro_type_child_name;
							} else {
								return value;
							}
						}
					},
					{field:'planProcess',
						title:'审计流程',
						width:bodyW*0.07+'px',
						halign:'center',
						sortable:true,
						align:'center',
						formatter:function(value, rowData, rowIndex){
							if (rowData.planProcess=='standard'){
								return '标准流程'
							}else{
								return '简易流程'
							}
						}
					},
					{field:'zz',
						title:'组长',
						width:bodyW*0.05+'px',
						halign:'center',
						sortable:true,
						align:'center'
					},
					{field:'zs',
						title:'主审',
						width:bodyW*0.05+'px',
						halign:'center',
						sortable:true,
						align:'center'
					},
					{field:'audit_object_name',
						title:'被审计单位',
						width:bodyW*0.13+'px',
						halign:'center',
						sortable:true,
						align:'left'
					},
					{field:'audit_dept_name',
						 title:'审计单位',
						 width:bodyW*0.07+'px',
						 halign:'center', 
						 align:'center', 
						 sortable:true
					},
					{field:'curStep',
						title:'当前阶段',
						halign:'center',
						align:'center',
						sortable:false,
						width:bodyW*0.07+'px',
						formatter:function(value, rowData, rowIndex){
                            if(rowData.xmType == 'syOff') {
                                var stagename = rowData.processName;
                                if(stagename == null || stagename == '') {
                                    stagename = '准备';
                                }
                                if(stagename == '实施' || stagename == '终结') {
                                    stagename = '实施';
                                }
                                return stagename;
                            } else {
                                if((rowData.prepare_closed==null || rowData.prepare_closed == '' || rowData.prepare_closed=='0')&&rowData.planProcess=='standard'){
                                    return '准备'
                                }
                                if (rowData.report_closed==null || rowData.report_closed == '' || rowData.report_closed=='0'){
                                    return '实施|终结'
                                }
                                if (rowData.archives_closed==null || rowData.archives_closed == '' || rowData.archives_closed=='0'){
                                    return '归档'
                                }
                                if (rowData.rework_closed==null || rowData.rework_closed== ''|| rowData.rework_closed=='0'){
                                    return '整改'
                                }
                                return '完结';
                            }
						}
					},
					// {field:'prepare_closed',
					// 	 title:'准备',
					// 	 halign:'center',
					// 	 align:'center',
					// 	 sortable:true,
					// 	 width:'5%',
					// 	 formatter:function(value ,rowData,rowIndex){
		   			// 			if(rowData.prepare_closed==null){
		       		// 				return '未执行';
		       		// 			}else if(rowData.prepare_closed=='1'){
		       		// 				return '已完成';
		       		// 			}else if(rowData.prepare_closed=='0'){
			       	// 				return '进行中';
					// 			}else{
					// 				return '未执行';
					// 				}
					// 	}
					// },
					// {field:'actualize_closed',
					// 	 title:'实施',
					// 	 halign:'center',
					// 	 align:'center',
					// 	 sortable:true,
					// 	 width:'5%',
					// 	 formatter:function(value ,rowData,rowIndex){
	   				// 	/* 	if(rowData.actualize_closed==null){
	       			// 			return '未执行';
	       			// 		}else if(rowData.actualize_closed=='1'){
	       			// 			return '已完成';
	       			// 		}else if(rowData.actualize_closed=='0'){
		       		// 			return '进行中';
	       			// 		}else{
		       		// 			return '未执行';
	       			// 		}		 */
					// 		 if(rowData.report_closed==null){
		       		// 				return '未执行';
		       		// 			}else if(rowData.report_closed=='2' || rowData.report_closed=='1'){
		       		// 				return '已完成';
		       		// 			}else if(rowData.report_closed=='0'){
			       	// 				return '进行中';
		       		// 			}else{
			       	// 				return '未执行';
		       		// 			}
					// 	}
					// },
					// {field:'report_closed',
					// 	 title:'终结',
					// 	 halign:'center',
					// 	 align:'center',
					// 	 sortable:true,
					// 	 width:'5%',
					// 	 formatter:function(value ,rowData,rowIndex){
	   				// 		if(rowData.report_closed==null){
	       			// 			return '未执行';
	       			// 		}else if(rowData.report_closed=='1'){
	       			// 			return '已完成';
	       			// 		}else if( rowData.report_closed=='2'|| rowData.report_closed=='0'){
		       		// 			return '进行中';
	       			// 		}else{
		       		// 			return '未执行';
	       			// 		}
					// 	}
					// },
					// {field:'archives_closed',
					// 	 title:'档案',
					// 	 halign:'center',
					// 	 align:'center',
					// 	 sortable:true,
					// 	 width:'5%',
					// 	 formatter:function(value ,rowData,rowIndex){
	   				// 		if(rowData.archives_closed==null){
	       			// 			return '未执行';
	       			// 		}else if(rowData.archives_closed=='1'){
	       			// 			return '已完成';
	       			// 		}else if(rowData.archives_closed=='0' ){
		       		// 			return '进行中';
	       			// 		}else{
		       		// 			return '未执行';
	       			// 		}
					// 	}
					// },
					// {field:'rework_closed',
					// 	 title:'整改',
					// 	 halign:'center',
					// 	 align:'center',
					// 	 sortable:true,
					// 	 width:'5%',
					// 	 formatter:function(value ,rowData,rowIndex){
	   				// 		if(rowData.rework_closed==null){
	       			// 			return '未执行';
	       			// 		}else if(rowData.rework_closed=='1'){
	       			// 			return '已完成';
	       			// 		}else if(rowData.rework_closed=='0' ){
		       		// 			return '进行中';
	       			// 		}else{
		       		// 			return '未执行';
	       			// 		}
					// 	}
					// },
					<s:if test="${isDisplay == 'YY'}">
					{
						field:'operate',
						title:'操作',
						halign:'center',
						align:'center',
						sortable:false,
						width:bodyW*0.07+'px',
						formatter:function(value ,rowData,rowIndex){
							if(value == '1') {
								var exportIcon = 'icon-export';
								var exportUrl = "<a href=\"javascript:void(0)\" title='导出' class=\"l-btn l-btn-small l-btn-plain\" onclick=\"downloadZIP('"+rowData.projectCode+"','"+rowData.project_name+"');\">"
										+"<span class=\"l-btn-left l-btn-icon-left\">"
										+"<span class=\"l-btn-text\"></span>"
										+"<span class=\"l-btn-icon "+exportIcon+"\"></span>"
										+"</span>"
										+"</a>";
								var importIcon = 'icon-import';
								var importUrl = "<a href=\"javascript:void(0)\" title='导入' class=\"l-btn l-btn-small l-btn-plain\" onclick=\"importZIP('"+rowData.formId+"','"+rowData.project_name+"');\">"
										+"<span class=\"l-btn-left l-btn-icon-left\">"
										+"<span class=\"l-btn-text\"></span>"
										+"<span class=\"l-btn-icon "+importIcon+"\"></span>"
										+"</span>"
										+"</a>";
								return exportUrl + importUrl;
							} else {
								return '';
							}
						}
					}
					</s:if>
				]]
			}); 
			//单元格tooltip提示
			$('#projectList').datagrid('doCellTip', {
				onlyShowInterrupt:true,
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			
			});

			$('#importProjects').window({
				title:'预选项目导入',
				modal:true,
				width:900,
				minimizable: false,
				maximizable: false,
				collapsible: false,
				closed:true
			});
			
		});

		function getItem(url,title,width,height){
			$('#item_ifr').attr('src',url);
			$('#subwindow').window({
				title: title,
				width: width,
				height:height,
				modal: true,
				shadow: true,
				closed: false,
				collapsible:false,
				maximizable:false,
				minimizable:false
			});
		}
		function saveF(){
			var ayy = $('#item_ifr')[0].contentWindow.saveF();
			var ay = ayy[0].split(',');
			if(ay.length == 1){
				document.all('crudObject.pro_type').value=ayy[0];
			}else if(ay.length == 2){
				document.all('crudObject.pro_type_child').value=ay[0];
				document.all('crudObject.pro_type').value=ay[1];
			}
    		document.all('crudObject.pro_type_name').value=ayy[1];
    		closeWin();
		}
		function cleanF(){
			document.all('crudObject.pro_type').value='';
			document.all('crudObject.pro_type_name').value='';
    		document.all('crudObject.pro_type_child').value='';
    		closeWin();
		}
		function closeWin(){
			$('#subwindow').window('close');
		}
		function downloadZIP(projectCode,projectName){
			$.messager.confirm("提示","确定下发离线数据包？",function(r){
				if(r){
					var url="${contextPath}/interact/interactProxyToWork/mutualToWork.action?loginname=${user.floginname}&projectCode="+encodeURI(projectCode)+"&projectName="+encodeURI(projectName);
					download.action=url;
					download.submit();
				}
			});
		}

		function importZIP(project_id, project_name){
			$('#project_id').val(project_id);
			$('#project_name').val(project_name);
			$('#importProjects').window('open');
		}
		</script>
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
	</body>
</html>
