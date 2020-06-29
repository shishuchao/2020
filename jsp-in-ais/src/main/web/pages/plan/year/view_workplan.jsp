<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
	    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>年度计划</title>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/autosize.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript">
		$(function(){
			showWin('dlgSearch');
			var year_id = '${crudId}';
			var year_idNormal = '${crudId}';
			$('#year_id').val('${crudId}');
			$('#year_idNormal').val('${crudId}');
			$('#yearDetailList').datagrid({
                url : "<%=request.getContextPath()%>/plan/year/view.action?querySource=grid",
				queryParams:{year_id:year_id},
				method:'post',
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				idField:'formId',
				border:false,
				singleSelect:false,
				remoteSort: false,
				toolbar:[{
					id:'search',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('dlgSearch',750);
					}
				}
				<%--<s:if test="${magOrganization.fid == '1000' && fromAdjust != 'yes'}">--%>
				<%--<s:if test="${fromAdjust != 'yes'}">
					,'-',{
						id:'approval',
						text:'批复',
						iconCls:'icon-ok',
						handler:function() {
							var rows = $('#yearDetailList').datagrid('getSelections');
							approval(rows,'yearDetailList');
						}
					}
					<s:if test="${approvaled != '1'}">
					,'-',{
						id:'approval',
						text:'批复完结',
						iconCls:'icon-ok',
						handler:function() {
							var rows = $('#yearDetailList').datagrid('getSelections');
							approvaled(rows,'yearDetailList');
						}
					}
					</s:if>
				</s:if>--%>
				],
				frozenColumns:[[
				       			{field:'status_name',title:'计划状态',width:'120',align:'center',halign:'center',sortable:true,
									formatter:function(value,rowData,rowIndex){
										if(rowData.status == '1113' && rowData.w_plan_type_name == '年度计划'){
											return "年度已审批";
										}else{
											return value;
										}
									}
				       			},
				       			{field:'w_plan_name',
									title:'项目名称',
									width:300,
									align:'left',
									sortable:true,
									formatter:function(value,rowData,rowIndex){
										return '<a href=\"javascript:void(0)\" onclick=\"viewYearDetailUrl(\''+rowData.formId+'\');\">'+rowData.w_plan_name+'</a>';
									},
									halign:'center'
								}
				]],
				columns:[[
				    /*{field:'isApproval',
						title:'集团统一批复',
						width:120,
						align:'center',
						sortable:true,
						halign:'center',
						formatter:function(value,rowData,rowIndex){
							if(value == '1') {
								return '已批复';
							}else{
								return '未批复';
							}
						}
					},*/
					{field:'audit_object_name',
						title:'被审计单位名称',
						width:150,
						align:'left',
						sortable:true,
						halign:'center'
					},
					{field:'lastAudYear',
						title:'上次审计年度',
						width:100,
						align:'center',
						sortable:true,
						hidden:true
					},
					{field:'lastProTypeName',
						 title:'上次审计类型',
						 width:100, 
						 align:'center', 
						 sortable:true,
						hidden:true
					},
					{field:'audit_start_time',
						 title:'审计期间开始',
						 width:100, 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
		   			        if(value != '' && value != null){
			   			        return value.substring(0,10);
		   			        }
						 },
						halign:'center'
					},
					{field:'audit_end_time',
						 title:'审计期间结束',
						 width:100, 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
		   			        if(value != '' && value != null){
			   			        return value.substring(0,10);
		   			        }
						 },
						halign:'center'
					},
					{field:'pro_type_name',
						 title:'审计类型',
						 width:100, 
						 align:'center', 
						 sortable:true
					},
					{field:'w_plan_year',
						 title:'审计年度',
						 width:100, 
						 align:'center', 
						 sortable:true,
						halign:'center',
						hidden:true
					},
					{field:'w_plan_month',
						 title:'审计月度',
						 width:100, 
						 align:'center', 
						 sortable:true,
						halign:'center'
					},
					{field:'sourcePlanName',
	                    title:'被调整项目',
	                    width:150,
	                    align:'center',
	                    halign:'center',
						formatter:function (value,row,index) {
                            if(row['adjustedDetailId'] != null&&row['adjustedDetailId'] != ''){
                                return '<a href="javascript:;" onclick="aud$openNewTab(\''+value+'\',\'${contextPath}/plan/detail/view.action?crudId='+row['adjustedDetailId']+'\',true);">'+value+'</a>';
                            }
	                    }
	                }
				]]
			});
			/*
			showWin('dlgSearchNormal');
			$('#normalDetailList').datagrid({
				url : "<%=request.getContextPath()%>/plan/year/view.action?querySource=grid&grade=1001",
				queryParams:{year_idNormal:year_idNormal},
				method:'post',
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				idField:'formId',
				border:false,
				singleSelect:false,
				remoteSort: false,
				toolbar:[{
					id:'search',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('dlgSearchNormal',750);
					}
				}
				<s:if test="${magOrganization.fid == '1000' && fromAdjust != 'yes'}">
					,'-',{
						id:'approval',
						text:'批复',
						iconCls:'icon-ok',
						handler:function() {
							var rows = $('#normalDetailList').datagrid('getSelections');
							approval(rows, 'normalDetailList');
						}
					}
					<s:if test="${approvaled != '1'}">
					,'-',{
						id:'approval',
						text:'批复完结',
						iconCls:'icon-ok',
						handler:function() {
							var rows = $('#yearDetailList').datagrid('getSelections');
							approvaled(rows,'yearDetailList');
						}
					}
					</s:if>
				</s:if>
				],
				frozenColumns:[[
				       			{field:'byYearShenPi',title:'计划状态',width:'120',align:'center',
				       				halign:'center',sortable:true,formatter:function(value,rowData,rowIndex){
				       					if(rowData.status == '1111' || rowData.status == '1112') {
				       						return rowData.status_name;
				       					}
				       					if(rowData.status == '4000'){
				       			          return rowData.status_name;
									    }
				       			     	if(rowData.status == '8000'){
				       			          return rowData.status_name;
									    }
				       			     	if(rowData.status == '9000'){
				       			          return rowData.status_name;
									    }
				       			     	if(rowData.status == '1115'){
				       			          return rowData.status_name;
									    }
	                                    if(value == '1'){
	                                        return "年度已审批";
	                                    }else{
	                                        return rowData.status_name;
						   			     }
									 },
				       			},
				       			{field:'w_plan_name',
									title:'项目名称',
									width:100,
									align:'left',
									sortable:true,
									formatter:function(value,rowData,rowIndex){
										if(rowData.detail_plan_name != null && rowData.detail_plan_name != ''){
											return '<a href=\"javascript:void(0)\" onclick=\"viewUrl(\''+rowData.detail_form_id+'\');\">'+rowData.detail_plan_name+'</a>';
										}else{
											return '<a href=\"javascript:void(0)\" onclick=\"viewYearDetailUrl(\''+rowData.formId+'\');\">'+rowData.w_plan_name+'</a>';
										}
									},
									halign:'center'
								}
				]],
				columns:[[
					{field:'isApproval',
						title:'集团统一批复',
						width:120,
						align:'center',
						sortable:true,
						halign:'center',
						formatter:function(value,rowData,rowIndex){
							if(value == '1') {
								return '已批复';
							}else{
								return '未批复';
							}
						}
					},
					{field:'audit_object_name',
						title:'被审计单位名称',
						width:120,
						align:'left',
						sortable:true,
						halign:'center'
					},
					{field:'lastAudYear',
						title:'上次审计年度',
						width:80,
						align:'center',
						sortable:true
					},
					{field:'lastProTypeName',
						 title:'上次审计类型',
						 width:100, 
						 align:'center', 
						 sortable:true
					},
					{field:'audit_start_time',
						 title:'审计期间开始',
						 width:100, 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
		   			        if(value != '' && value != null){
			   			        return value.substring(0,10);
		   			        }
						 },
						halign:'center'
					},
					{field:'audit_end_time',
						 title:'审计期间结束',
						 width:100, 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
		   			        if(value != '' && value != null){
			   			        return value.substring(0,10);
		   			        }
						 },
						halign:'center'
					},
					{field:'pro_type_name',
						 title:'审计类型',
						 width:100, 
						 align:'center', 
						 sortable:true
					},
					{field:'w_plan_year',
						 title:'审计年度',
						 width:100, 
						 align:'center', 
						 sortable:true,
						halign:'center'
					},
					{field:'w_plan_month',
						 title:'审计月度',
						 width:100, 
						 align:'center', 
						 sortable:true,
						halign:'center'
					}
				]]
			});
			*/
			var v = $('#yearPlanPanel').val();
			var qtabs = $('#qtabs');
			if(v && qtabs){
				v === 'yearBasicInfoDiv' ? qtabs.tabs('select','基本信息') : qtabs.tabs('select','重要项目');
			}

			qtabs.tabs({
				onSelect:function(title,index){
					if(title == '基本信息'){
						$("#planBasicInfoForm").find("textarea").each(function(){
							autoTextarea(this);
						});
					}
				}
			});
			
			//单元格tooltip提示
			$('#yearDetailList').datagrid('doCellTip', {
				onlyShowInterrupt:true,
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			
			});

			/*
			//单元格tooltip提示
			$('#normalDetailList').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			
			});
			*/
		});
		</script>
	</head>
	<body>
		<input id='yearPlanPanel' type='hidden' value='${param.selectedTab}' />
		<%--<div  style="width: 60%;position:absolute;top:0px;left:30%;text-align: left;z-index: 1000;">--%>
			<%--<a href="javascript:;" onclick="coverAuditObject();">审计计划单位数量覆盖率${coverRate}，未覆盖单位：${uncovered}个</a>--%>
		<%--</div>--%>
		<div id="qtabs" class="easyui-tabs" fit="true">
			<div id='yearBasicInfoDiv' title='基本信息'>
				<form id="planBasicInfoForm">
					<table id="planTable" cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
						<%--<tr >
							<td colspan="4" align="left" class="topTd">
								&nbsp;年度计划信息
							</td>
						</tr>--%>
						<tr>
							<td class="EditHead">
								计划状态

							</td>
							<td class="editTd">
								<s:property value="crudObject.status_name" />
							</td>
							<td class="EditHead" nowrap>
								年度计划编号
							</td>
							<td class="editTd">
								<s:property value="crudObject.w_plan_code" />
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								计划名称
							</td>
							<td class="editTd" colspan="3">
								<s:property value="crudObject.w_plan_name" />
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								计划年度
							</td>
							<td class="editTd">
								<s:property value="crudObject.w_plan_year" />
							</td>
							<td class="EditHead">
								审计单位
							</td>
							<td class="editTd">
								<s:property value="crudObject.audit_dept_name" />
							</td>
						</tr>

						<tr>
							<td class="EditHead" style="width: 15%">
								计划管理员
							</td>
							<td class="editTd">
								<s:property value="crudObject.w_charge_person_name" />
							</td>
							<td class="EditHead" style="width: 15%">
								计划编制日期
							</td>
							<td class="editTd">
								<s:property value="crudObject.planDate" />
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap>
								风险评估结果<!-- 审计对象及范围 --><br/><div style="text-align:right;"><font color=DarkGray>(限2000字)</font></div>
							</td>
							<td class="editTd" colspan="3">
								<textarea class='noborder'  name="crudObject.audObjAndScope" readonly="readonly"
										  rows="5" style="width:100%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${crudObject.audObjAndScope}</textarea>
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap>
								审计重点<br/><div style="text-align:right"><font color=DarkGray>(限2000字)</font></div>
							</td>
							<td class="editTd" colspan="3">
								<textarea class='noborder'  name="crudObject.audImportant" readonly="readonly"
										  rows="5" style="width:100%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${crudObject.audImportant}</textarea>
							</td>
						</tr>
						<tr>
							<td class="EditHead" nowrap>
								工作要求<br/><div style="text-align:right"><font color=DarkGray>(限2000字)</font></div>
							</td>
							<td class="editTd" colspan="3">
								<textarea class='noborder'  name="crudObject.audRequest" readonly="readonly"
										  rows="5" style="width:100%;overflow-y:visible;line-height:150%;" UNSELECTABLE='on'>${crudObject.audRequest}</textarea>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								附件
							</td>
							<td class="editTd" colspan="3">
								<div data-options="fileGuid:'${crudObject.w_file}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>
							</td>
						</tr>
					</table>
				</form>
				<div align="center">
					<jsp:include flush="true"
						page="/pages/bpm/list_taskinstanceinfo.jsp" />
				</div>
				<br />
			</div>
			<div id='yearDetailListDiv' title='预选项目'>
				<div style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit="true">
					<div id="dlgSearch" class="searchWindow">
						<div class="search_head">
							<s:hidden name="crudId" />
							<s:hidden name="taskInstanceId" />

							<input name="selectedTab" type="hidden" value="yearDetailListDiv" />
							<s:form id="yearDetailPlanSearchForm" name="yearDetailPlanSearchForm" action="view" namespace="/plan/year">
								<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
									<tr >
										<td class="EditHead">
											项目名称
										</td>
										<td class="editTd">
											<s:hidden name="year_id" id="year_id"/>
											<s:textfield id="w_plan_name" cssClass="noborder" name="w_plan_name" cssStyle="width:160px;"/>
										</td>
										<td class="EditHead">
											计划编号
										</td>
										<td class="editTd">
											<s:textfield id="w_plan_code" cssClass="noborder" name="w_plan_code" cssStyle="width:160px;" />
										</td>
									</tr>
									<tr >
										<td class="EditHead" >
											月度
										</td>
										<td class="editTd">
											<select id="w_plan_month" class="easyui-combobox" name="w_plan_month" style="width:160px;"  editable="false">
												<option value="">&nbsp;</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
												<option value="8">8</option>
												<option value="9">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
											</select>
										</td>
										<td class="EditHead">
											项目组长
										</td>
										<td class="editTd">
											<s:buttonText2 id="pro_teamleader_name" cssStyle="width:160px;"
														   name="pro_teamleader_name" cssClass="noborder"
														   hiddenId="pro_teamleader"
														   hiddenName="pro_teamleader"
														   doubleOnclick="showSysTree(this,{
										  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										  title:'&nbsp;&nbsp;&nbsp;请选择项目组长',
										  type:'treeAndEmployee'

										})"
														   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
														   doubleCssStyle="cursor:hand;border:0" />
										</td>
									</tr>
									<tr >
										<td class="EditHead">
											审计单位
										</td>
										<td class="editTd" colspan="3">
											<s:buttonText2 id="audit_dept_name" cssStyle="width:160px;"
														   name="audit_dept_name" cssClass="noborder"
														   hiddenName="audit_dept"
														   hiddenId="audit_dept"
														   doubleOnclick="showSysTree(this,{
											url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
											title:'&nbsp;&nbsp;&nbsp;请选择审计单位',
											param:{
											  'p_item':1,
											  'orgtype':1,
											  'beanName':'UOrganization'
											}
										});"
														   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
														   doubleCssStyle="cursor:hand;border:0" />
										</td>
									</tr>
								</table>
							</s:form>
						</div>
						<div class="serch_foot">
							<div class="search_btn">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch();">查询</a>&nbsp;
								<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal();">重置</a>&nbsp;
								<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
							</div>
						</div>
					</div>
					<div region="center">
						<table id="yearDetailList"></table>
					</div>
				</div>
			</div>
			<!--
			<div title='一般项目'>
				<div style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit="true">
					<div id="dlgSearchNormal" class="searchWindow">
						<div class="search_head">
							<s:hidden name="crudId" />
							<s:hidden name="taskInstanceId" />

							<s:form id="normalForm" name="normalForm" action="view" namespace="/plan/year">
								<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
									<tr >
										<td class="EditHead">
											计划名称
										</td>
										<td class="editTd">
											<s:hidden name="year_idNormal" id="year_idNormal"/>
											<s:textfield id="w_plan_name" cssClass="noborder" name="w_plan_name" cssStyle="width:160px;"/>
										</td>
										<td class="EditHead">
											计划编号
										</td>
										<td class="editTd">
											<s:textfield id="w_plan_code" cssClass="noborder" name="w_plan_code" cssStyle="width:160px;" />
										</td>
									</tr>
									<tr >
										<td class="EditHead" >
											月度
										</td>
										<td class="editTd">
											<select id="w_plan_month" class="easyui-combobox" name="w_plan_month" style="width:160px;"  editable="false">
												<option value="">&nbsp;</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
												<option value="8">8</option>
												<option value="9">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
											</select>
										</td>
										<td class="EditHead">
											项目组长
										</td>
										<td class="editTd">
											<s:buttonText2 id="pro_teamleader_name" cssStyle="width:160px;"
														   name="pro_teamleader_name" cssClass="noborder"
														   hiddenId="pro_teamleader"
														   hiddenName="pro_teamleader"
														   doubleOnclick="showSysTree(this,{
										  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										  title:'&nbsp;&nbsp;&nbsp;请选择项目组长',
										  type:'treeAndEmployee'

										})"
														   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
														   doubleCssStyle="cursor:hand;border:0" />
										</td>
									</tr>
									<tr >
										<td class="EditHead">
											审计单位
										</td>
										<td class="editTd" colspan="3">
											<s:buttonText2 id="audit_dept_name" cssStyle="width:160px;"
														   name="audit_dept_name" cssClass="noborder"
														   hiddenName="audit_dept"
														   hiddenId="audit_dept"
														   doubleOnclick="showSysTree(this,{
											url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
											title:'&nbsp;&nbsp;&nbsp;请选择审计单位',
											param:{
											  'p_item':1,
											  'orgtype':1
											}
										});"
														   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
														   doubleCssStyle="cursor:hand;border:0" />
										</td>
									</tr>
								</table>
							</s:form>
						</div>
						<div class="serch_foot">
							<div class="search_btn">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearchNormal();">查询</a>&nbsp;
								<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restalNormal();">重置</a>&nbsp;
								<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancelNormal()">取消</a>
							</div>
						</div>
					</div>
					<div region="center">
						<table id="normalDetailList"></table>
					</div>
				</div>
			</div>
			-->
		</div>
		<script type="text/javascript">
			/*
			 * 查询
			 */
			function doSearch(){
				$('#yearDetailList').datagrid({
					queryParams:form2Json('yearDetailPlanSearchForm')
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
				resetForm('yearDetailPlanSearchForm');
				$('#year_id').val('${crudId}');
				doSearch();
			}

            /*
             * 查询
             */
            function doSearchNormal(){
                $('#normalDetailList').datagrid({
                    queryParams:form2Json('normalForm')
                });
                $('#dlgSearchNormal').dialog('close');
            }
            /*
             * 取消
             */
            function doCancelNormal(){
                $('#dlgSearchNormal').dialog('close');
            }
            /**
             重置
             */
            function restalNormal(){
                resetForm('normalForm');
                $('#year_idNormal').val('${crudId}');
                doSearchNormal();
            }

			function viewUrl(id){
                var viewUrl = '<%=request.getContextPath()%>/plan/detail/view.action?crudId='+id;
                aud$openNewTab('项目查看',viewUrl,false);
            }
			function viewYearDetailUrl(id){
			  var viewUrl = '<%=request.getContextPath()%>/plan/detail/view.action?crudId='+id;
                aud$openNewTab('项目查看',viewUrl,false);
			}
            function coverAuditObject(){
                var coverRate = encodeURI('${coverRate}');
                aud$openNewTab('审计计划单位覆盖情况','${contextPath}/plan/3year/queryCoverUncoverAuditObject.action?yearPlanId=${workPlan3Year.formId}&covered=${covered}&uncovered=${uncovered}&coverRate='+coverRate,false);
            }
            
            function approval(rows, tableId){
            	if(rows.length > 0) {
            		var formIds = new Array();
            		for(i in rows) {
            			formIds.push(rows[i].formId);
            			$.ajax({
            				url:'${contextPath}/plan/detail/approval.action',
            				type:'post',
            				async:false,
            				data:{'formIds':formIds.join(','),'status':'1'},
            				success:function(data){
            					if(data == '1') {
            						showMessage1('批复成功');
            						$('#' + tableId).datagrid('reload');
            					}
            				}
            			});
            		}
            	} else {
            		showMessage1('请选择数据！');
            	}
            }
            
            function approvaled(){
            	$.messager.confirm('操作提示','确认批复完结？',function(flag){
            		if(flag) {
            			$.ajax({
            				url:'${contextPath}/plan/detail/approvaled.action',
            				type:'post',
            				async:false,
            				data:{'crudId':'${crudId}'},
            				success:function(data){
            					if(data == '1') {
            						showMessage1('批复完结成功');
            						window.location.reload();
            					}
            				}
            			});
            		}
            	});
            }
		</script>

	</body>
</html>