<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目列表-项目浏览页</title>
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
			<s:form id="myform" name="myform" action="listAll.action" namespace="/project" method="post">
	         <table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<%-- <td  class="EditHead" style="width:15%">
						项目编号
					</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="crudObject.project_code" cssStyle="width:80%" maxlength="50"/>
					</td> --%>
					<td class="EditHead" style="width:20%">
						项目编号
					</td>
					<td class="editTd" style="width:33%">
						<s:textfield cssClass="noborder" name="crudObject.project_code" cssStyle="width:80%" maxlength="50"/>
					</td>
					<td class="EditHead" style="width:15%">
						项目名称
					</td>
					<td class="editTd" style="width:32%">
						<s:textfield cssClass="noborder" name="crudObject.project_name" cssStyle="width:80%" maxlength="50"/>
					</td>
				</tr>
				<s:if test="'${projectType}'!=@ais.project.ProjectContant@NBZWPG">
				<tr >
					<td class="EditHead" >
						计划类别
					</td>
					<td class="editTd">
						<select id="plantype" data-options="panelHeight:'auto'" class="easyui-combobox" name="crudObject.plan_type" style="width:80%" editable="false">
					       <option value="<s:property value="code"/>">请选择</option>
					       <s:iterator value="basicUtil.planTypeList" >
					         <option value="<s:property value="code"/>"><s:property value="name"/></option>
					       </s:iterator>
					    </select>		
					</td>
					<td class="EditHead">
						项目类别
					</td>
					<td class="editTd">
							<!--<s:doubleselect id="pro_type" doubleId="pro_type_child"
								doubleList="basicUtil.planTypeList[top]"
								doubleListKey="code" doubleListValue="name" listKey="code"
								listValue="name" name="crudObject.pro_type"
								list="basicUtil.PlanProjectTypeMap4Zhongjian.keySet()"
								doubleName="crudObject.pro_type_child" theme="ufaud_simple"
								templateDir="/strutsTemplate" display="${varMap['pro_typeRead']}"
								emptyOption="true" />-->
							<select class="easyui-combobox" data-options="panelHeight:'auto'" name="crudObject.pro_type" style="width:80%"  editable="false">
						       <option value="">请选择</option>
						       <s:iterator value="basicUtil.PlanProjectTypeMap4Zhongjian.keySet()" id="entry">
						         <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       </s:iterator>
						    </select>	
					</td>
				</tr>
			</s:if>
				<tr >
					<td class="EditHead">
						所属单位
					</td>
					<td class="editTd">
						<s:buttonText2 name="crudObject.audit_dept_name" cssClass="noborder"
							hiddenName="crudObject.audit_dept" cssStyle="width:80%"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'请选择审计单位',
                                  param:{
                                    'p_item':1,
                                    'orgtype':1
                                  }
								})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0" readonly="true" />
					</td>
					<td class="EditHead">
						被审计单位
					</td>
					<td class="editTd">
						<s:buttonText2 name="crudObject.audit_object_name" cssClass="noborder"
							hiddenName="crudObject.audit_object" cssStyle="width:80%"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
                              cache:false,
							  checkbox:true,
							  title:'请选择被审计单位'
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0" readonly="true" />
					</td>
				</tr>
				<tr >
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
						<select class="easyui-combobox" name="crudObject.pro_year" id="pro_year" style="width:80%"  editable="false">
					       <option value="">请选择</option>
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
					</td>
				</tr>
				 <tr >
					 <td class="EditHead">
						 作业模式
					 </td>
					 <td class="editTd">
						 <select class="easyui-combobox" name="crudObject.xmType" id="xmType" style="width:80%"  editable="false">
							 <option value="">请选择</option>
							 <s:iterator value='#@java.util.LinkedHashMap@{"bs":"在线","syOff":"离线"}' id="entry">
								 <option value="<s:property value="key"/>"><s:property value="value"/></option>
							 </s:iterator>
						 </select>
					 </td>
				 </tr>
				<input type="hidden" name="condition" value="yes" reload="false"/>
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
			<table id="projectList"></table>
		</div>
		<script type="text/javascript">
	        function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			/*
			* 查询
			*/
			function doSearch(){
	        	datagrid.datagrid('options').queryParams = form2Json('myform');
				datagrid.datagrid('reload');
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
				resetForm('myform');
				/*doSearch();*/
			}
			//导出全部项目
			function exportAllProject(){
                document.getElementById('myform').action = "<%=request.getContextPath()%>/project/exportProject.action?isCommon=${isCommon}&source=process";
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
					document.getElementById('myform').action = "<%=request.getContextPath()%>/project/exportProject.action?isCommon=${isCommon}&crudIds="+ids;
                    $('#myform').submit();
				}else{
					showMessage1('请先勾选需要导出的项目');
				}

			}
			var datagrid;
			$(function(){
				var bodyW = $('body').width();
			    var isCommon = '${isCommon}';
				showWin('dlgSearch');
			  //  $('body').layout('collapse','north');
			  //  $(document).bind("contextmenu",function(e){return false;});//禁用右键菜单
			    //if('${empty crudObject.pro_year}'=='true'){
					var d = new Date();
					$('#pro_year').combobox('setValue',d.getFullYear());
				//	$('#pro_year').combo('setText',d.getFullYear());
				//}
			    // 初始化生成表格
				datagrid = $('#projectList').datagrid({
				    url:"<%=request.getContextPath()%>/project/listAll.action?querySource=grid&isCommon="+isCommon,
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					pageSize:20,
					fit: true,
    				fitColumns:true,
					idField:'formId',
					border:false,
					remoteSort: true,
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch');
							}
						},'-',
                        {
                            id:'toExcel',
                            text:'导出',
                            iconCls:'icon-export',
                            handler:function(){
                                exportProject();
                            }
                        },'-',
                        {
                            id:'toExcel',
                            text:'导出全部',
                            iconCls:'icon-export',
                            handler:function(){
                                exportAllProject();
                            }
                        },'-',helpBtn
					],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					columns:[[
						{field:'formId',checkbox:true,halign:'center', align:'center',title:'选择'},
						{field:'is_closed',title:'状态',halign:'center',align:'center',sortable:true, width:0.06*bodyW+'px',
							formatter:function(value,rowData,rowIndex){
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
						{field:'project_name',
								title:'项目名称',
								width:0.25*bodyW+'px',
								halign:'center',
								align:'left', 
								sortable:true,
								formatter:function(value,rowData,rowIndex){
									if(rowData.xmType == 'syOff') {
										return '<a href=\"javascript:void(0)\" onclick=\"planNameSyOff(\''+rowData.project_name+'\',\''+rowData.plan_form_id+'\',\''+rowData.formId+'\',\''+rowData.processCode+'\');\">'+rowData.project_name+'</a>';
									} else {
										if(rowData['isInProject']){
											return '<a href=\"javascript:void(0);\" onclick=\"goProjectMenuEdit(\''+rowData.formId+'\',\''+rowData.prepare_closed+'\',\''+rowData.actualize_closed+'\',\''+rowData.report_closed+'\',\''+rowData.archives_closed+'\',\''+rowData.planProcess+'\',\''+rowData.rework_closed+'\');\" >'+value+'</a>';
										}else{
											if(isCommon == 'Y') {
												return value;
											} else {
												return '<a href=\"javascript:void(0);\" onclick=\"goProjectMenu(\''+rowData.formId+'\',\''+rowData.prepare_closed+'\',\''+rowData.actualize_closed+'\',\''+rowData.report_closed+'\',\''+rowData.archives_closed+'\',\''+rowData.planProcess+'\');\" >'+value+'</a>';
											}
										}
									}

								}
						},
						{field:'project_code',title:'项目编号',width:0.1*bodyW+'px',sortable:true,halign:'center',align:'left'},
						{field:'pro_year',
							title:'项目年度',
							halign:'center',
							width:0.1*bodyW+'px',
							sortable:true, 
							align:'center',
							hidden:true
						},
						{field:'pro_starttime',
							title:'开始日期',
							halign:'center',
							width:0.1*bodyW+'px',
							sortable:true,
							align:'center'
						},
						{field:'audit_dept_name',
							title:'所属单位',
							width:0.15*bodyW+'px',
							halign:'center',
							align:'left',
							sortable:true
						},
						{field:'pro_type_name',
							 title:'项目类别',
							 halign:'center',
							width:0.1*bodyW+'px',
							 align:'left',
							 sortable:true,
							formatter:function(value,rowData,rowIndex){
								if(rowData.pro_type_child_name != null && rowData.pro_type_child_name != '') {
									return rowData.pro_type_child_name;
								} else {
									return value;
								}
							}
						},
						{field:'xmType',
							title:'作业模式',
							halign:'center',
							width:0.06*bodyW+'px',
							align:'center',
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								if(value == 'syOff') {
									return "离线";
								} else {
									return "在线";
								}
							}
						},
                        {field:'curStep',
                            title:'当前阶段',
                            halign:'center',
                            align:'center',
                            sortable:false,
							width:0.06*bodyW+'px',
                            formatter:function(value, rowData, rowIndex){
								if(rowData.xmType == 'syOff') {
									var stagename = rowData.processName;
									if(stagename == null || stagename == '') {
										stagename = '准备';
									} else if(stagename == '已完成') {
										stagename = '完结';
									}
									return stagename;
								} else {
									if(rowData.prepare_closed==null || rowData.prepare_closed == '' || rowData.prepare_closed=='0'){
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
									} else {
										return '完结'
									}
								}
                            }
                        }
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
				
			});
			function planNameSyOff(title, id, startId, processCode) {
				//var url = "${contextPath}/plan/detail/view.action?crudId=" + id;
				var url = "${contextPath}/plan/detail/viewProcess.action?projectId=" + id + "&startId=" + startId + "&processCode=" + processCode;
				aud$openNewTab("离线-" + title, url, true);
			}

			function goProjectMenuEdit(projectid,prepare_closed,actualize_closed,report_closed,archives_closed,planProcess,rework_closed){
				var stage = "";
                if(planProcess == 'simplified'){
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
                    }else{
                        stage = "prepare";
                    }
                }

				var udswin = null;
				if(rework_closed =='1'){
					udswin = window.open(
							'${contextPath}/project/prepare/projectIndex.action?crudId='
							+ projectid + '&stage=' + stage + '&source=view&projectview=view', '',
							'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
				}else{
					udswin = window.open(
							'${contextPath}/project/prepare/projectIndex.action?crudId='
							+ projectid + '&stage=' + stage + '&view=', '',
							'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
				}
				if (udswin) {
					udswin.moveTo(0, 0);
					udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
				}
			}

			function goProjectMenu(projectid,prepare_closed,actualize_closed,report_closed,archives_closed,planProcess){
				var stage = "";
				if(planProcess == 'simplified'){
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
					}else{
						stage = "prepare";
					}
				}
				var udswin = window.open(
						'${contextPath}/project/prepare/projectIndex.action?crudId='
						+ projectid + '&stage=' + stage + '&source=view&projectview=view', '',
						'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
				if (udswin) {
					udswin.moveTo(0, 0);
					udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
				}
			}
			
 		</script>
	</body>
</html>
