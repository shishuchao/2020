<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>预选项目计划</title>
<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>   
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>

 
</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
				<s:form id="searchForm" name="searchForm" action="statisView" namespace="/plan/year">
					<s:hidden name="crudObject.formId" />
					<s:hidden id="auditDeptId" name="crudObject.audit_dept" />
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
							<td align="left" class="EditHead" nowrap="nowrap">项目名称</td>
							<td align="left" class="editTd"><s:textfield cssClass="noborder" name="searchCondition.w_plan_name" /></td>
							<td align="left" class="EditHead">计划编号</td>
							<td align="left" class="editTd"><s:textfield cssClass="noborder" name="searchCondition.w_plan_code" /></td>
						</tr>
							<%--
                            <tr>
                                <td align="left" class="EditHead">计划月度</td>
                                <td align="left" class="editTd">
                                     <select class="easyui-combobox" name="searchCondition.w_plan_month" style="width:150px;"  id="searchConditionid" editable="false">
                                        <option value="">&nbsp;</option>
                                       <s:iterator value="{'1','2','3','4','5','6','7','8','9','10','11','12'}" id="entry">
                                         <option value="${entry }">${entry }</option>
                                       </s:iterator>
                                    </select>
                                </td>
                                <td align="left" class="EditHead">项目组长</td>
                                <td align="left" class="editTd">
                                    <s:buttonText2 cssClass="noborder" id="searchCondition.pro_teamleader_name"
                                        name="searchCondition.pro_teamleader_name"
                                        hiddenId="searchCondition.pro_teamleader"
                                        hiddenName="searchCondition.pro_teamleader"
                                        doubleOnclick="showSysTree(this,
                                        { url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                          title:'请选择负责人',
                                          type:'treeAndEmployee'
                                        })"
                                        doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
                                        doubleCssStyle="cursor:hand;border:0" />
                                </td>
                            </tr>
                            --%>
						<tr>
							<td align="left" class="EditHead">计划月度</td>
							<td align="left" class="editTd">
								<select class="easyui-combobox" name="searchCondition.w_plan_month" style="width:150px;"  id="searchConditionid" editable="false">
									<option value="">&nbsp;</option>
									<s:iterator value="{'1','2','3','4','5','6','7','8','9','10','11','12'}" id="entry">
										<option value="${entry }">${entry }</option>
									</s:iterator>
								</select>
							</td>
							<td align="left" class="EditHead">审计单位</td>
							<td align="left" class="editTd" colspan="3">
								<s:buttonText2 cssClass="noborder" id="searchCondition.audit_dept_name"
									  name="searchCondition.audit_dept_name" readonly="true"
									  hiddenName="searchCondition.audit_dept"
									  hiddenId="searchCondition.audit_dept"
									  doubleOnclick="showSysTree(this,{
									  url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
									  title:'请选择审计实施单位'
									})"
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
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetQuery();">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
			</div>
	    </div>
		<div region="center" border='0'>
			<div id="layer" style="display: none" align="center">
				<img src="${contextPath}/images/uploading.gif"> <br> 正在读取，请稍候......
			</div>
			<div align="left" id="errorInfo1" style="color:red">
				<s:if test="%{#tipList.size != 0}">
					<s:iterator value="%{#tipList}">
						&nbsp;&nbsp;&nbsp;●<s:property value="%{position}" />：<s:property value="%{errorInfo}" />
						<br>
					</s:iterator>
				</s:if>
			</div>
			<div align="left" id="errorInfo2" style="color:red">
				<s:if test="%{#tipMessage != null}">
					&nbsp;&nbsp;&nbsp;●<s:property value="%{#tipMessage.errorInfo}" />
				</s:if>
			</div>
			<table id="yearDetailList"></table>
			<%--<div id="audSearch" style="overflow: hidden;"></div>--%>
		</div>
	    <s:if test="varMap['importDetailRead']==null?true:varMap['importDetailRead']">
			<s:if test="${(crudObject.status_name=='正在执行'||crudObject.status_name == '计划草稿'||crudObject.status_name == '正被审批')&&crudObject.formId!=null&&crudObject.formId!=''}">
				<div id="importProjects" class="easyui-window" closed="true">
					<s:form id="importForm" action="importDetail" namespace="/plan/year" method="post" enctype="multipart/form-data" onsubmit="wait();">
						<s:hidden name="crudId" />
						<s:hidden name="taskInstanceId" />
						<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
							<tr>
								<td align="left" class="EditHead" style="vertical-align: middle;">选择文件</td>
								<td class="editTd" align="left"><s:file name="template" size="66%" cssStyle="font-size:15px" accept="application/vnd.ms-excel"/></td>
								<td class="editTd" align="right"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-import'" id="importButton" onclick="submit_dr();">导入</a></td>
								<td class="editTd" align="right"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-download'" id="download" onclick="load()">下载模板</a></td>
							</tr>
						</table>
						<s:hidden name="listStatus" />
					</s:form>
				</div>
			</s:if>
		</s:if>
		

<script type="text/javascript">
	/*
	 * 取消
	 */
	function doCancel(){
		$('#dlgSearch').dialog('close');
	}
	function submit_dr(){
		var template = document.all('template').value;
		if(template == ''){
			$.messager.alert('系统提示',"请先选择要导入的文件",'warning');			
			return;
		}
		jQuery("#importForm").submit();		
	}
	function wait() {
		$('#importProjects').window('close');		
		document.getElementById("importButton").disabled = true;
		document.getElementById("layer").style.display = "";
		document.getElementById("errorInfo1").style.display = "none";
		document.getElementById("errorInfo2").style.display = "none";		
 	}    
	function load() {
		$('#download').linkbutton('disable');
		var auditDeptId = document.getElementById('auditDeptId').value;
		window.location.href = "${contextPath}/templatedownload?file=workplandetail_template.xls&&type=YearPlanDetail&&auditDeptId="+auditDeptId;
	}
	/*
	修改选中的单条计划
	 */
	function update() {
		var row = $('#yearDetailList').datagrid('getSelected');//document.getElementsByName("detail_plan_id");
		if(row!=null){
            var detailId = row.formId;
			 if(row.status == '1113'){
                 top.$.messager.confirm('确认','即将调整已审批的项目计划，确认吗？',function (r) {
                     if(r){
                         $.ajax({
                             url:'${contextPath}/plan/detail/copyDetail.action',
                             data:{"adjust3Year":"yes","crudId":detailId,"copyStatus":'2',"yearFormId":"${crudId}"},
                             type:'post',
                             success:function (data){
                                 if (data.newCrudId != ""){
									 showMessage1("调整项目计划成功！");
                                 	if(data.needAudit == 'Y') {
										parent.refresh();
									} else if(data.needAudit == 'N') {
                                 		$('#yearDetailList').datagrid('reload');
									}
                                 }
                             }
                         })
                     }
                 });
			 }else{
			 	if(row.status == '1000') {
					showMessage1("该项目为草稿状态，请直接进行编辑");
				} else {
					showMessage1("该项目"+row.status_name+"，无法进行调整");
				}
				 return;
             }
		}else{
			showMessage1("请先选择需要调整的记录！");
		}
	}
    /**
     * 重要项目完善信息
     */
    function fillInfo() {
        var row = $('#yearDetailList').datagrid('getSelected');
        if(row!=null){
            if(row.status_name != '三年计划已审批'){
                $.messager.alert('错误',"只能为三年计划已审批的记录完善信息",'warning');
                return;
            }
            var detailId = row.formId;
            window.location.href = "${contextPath}/plan/detail/edit.action?fillInfo=yes&planUpdate=yes&fromAdjust=${fromAdjust}&crudId=" + detailId + "&option=edityuxuan&yearFormId=${crudId}";
        }else{
            $.messager.alert('错误',"请先选择需要完善信息的记录！",'error');
        }
    }

	/*
		删除选中的单条计划
	 */
	function deleteDetail() {
		var row = $('#yearDetailList').datagrid('getSelected');
		if(row){
			var detailId = row.formId;
			var state=row.status;
            if(state=='1000'||state == '1113' || state== '1114'){
				$.messager.confirm('确认','确定要删除选中的明细信息吗？',function(r){
					if(r){
						$.ajax({
							type:'post',
							url:'${contextPath}/plan/year/deleteYuxuan.action?fromAdjust=${fromAdjust}&module=${module}&crudId=' + detailId,
							async:false,
							success:function(data){
								if(data == 'Y'){
									parent.refresh();
								} else {
									$('#yearDetailList').datagrid('reload');
								}
							}
						});
					}
				});
			}else{
                $.messager.alert('系统提示','该项目计划已执行，不能被删除！','error');
			}
		}else{
			$.messager.alert('提示信息','请先选择要删除的记录！','error');
		}
	}
	/*
		增加计划明细
	 */
	function addPlanItem(year_form_id, year) {
		var ids = document.getElementsByName("detail_plan_id");
		for ( var i = 0; i < ids.length; i++) {
			if (ids[i].checked == true) {
				showMessage1('新增操作请不要选择明细信息!');
				return false;
			}
		}
		//删除立项，在创建预选项目计划时同时创建一条项目计划
        var url = '<%=request.getContextPath()%>/plan/detail/editDetail.action?fromAdjust=${fromAdjust}&option=addyuxuan&yearFormId=${crudId}';
        aud$openNewTab('新增项目计划',url,true);

		<%--if('${searchCondition.plan_grade}' == '1000'){--%>
			<%--var url = '<%=request.getContextPath()%>/plan/detail/editDetail.action?fromAdjust=${fromAdjust}&option=addyuxuan&yearFormId=${crudId}&crudObject.plan_grade=${searchCondition.plan_grade}&crudObject.plan_grade_name='+encodeURI('重要项目');--%>
			<%--aud$openNewTab('重要项目',url,true);--%>
		<%--}else{--%>
            <%--var url = '<%=request.getContextPath()%>/plan/detail/editDetail.action?fromAdjust=${fromAdjust}&option=addyuxuan&yearFormId=${crudId}&crudObject.plan_grade=${searchCondition.plan_grade}&crudObject.plan_grade_name='+encodeURI('一般项目');--%>
            <%--aud$openNewTab('一般项目',url,true);--%>
		<%--}--%>
	}

	function refresh() {
		$('#yearDetailList').datagrid('reload');
	}
	
	function getRowNum() {
		var rows = $('#yearDetailList').datagrid('getRows');
		return rows.length;
	}
</script>
<script type="text/javascript">
	$(function(){
		showWin('dlgSearch');

		var needAudit = '${needAudit}';
		if(needAudit == 'Y') {
			parent.refresh();
		}
		
		// 初始化生成表格
		$('#yearDetailList').datagrid({
			url : "<%=request.getContextPath()%>/plan/year/statisView.action?crudId=${crudId}&querySource=grid&searchCondition.plan_grade=${searchCondition.plan_grade}&planGrade=${planGrade}",
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			fitColumns:true,
			idField:'id',	
			border:false,
			singleSelect:true,
			pageSize:20,
			remoteSort: false,
			toolbar:[{
				id:'search',
				text:'查询',
				iconCls:'icon-search',
				handler:function(){
					searchWindShow('dlgSearch',750);
				}
			},'-',{
				text:'新增',
				id:'add',
				iconCls:'icon-add',
				handler:function(){
					addPlanItem('${crudObject.formId}','${crudObject.w_plan_year}');
				}
			},'-',
			<s:if test="${fromAdjust == 'yes'}">
			{
				text:'调整',
				id:'update',
				iconCls:'icon-edit',
				handler:function(){
					update();
				}
			},'-',
			</s:if>
			{
				text:'删除',
				id:'delete',
				iconCls:'icon-delete',
				handler:function(){
					deleteDetail();
				}
			},'-',
			<s:if test="${empty tempNew}">
				{
				text:'导入预选项目',
				id:'export',
				iconCls:'icon-import',
				handler:function(){
					$('#download').linkbutton('enable');
					$('#importProjects').window('open');
				}
			},'-',
            </s:if>
			{
				text:'多年未被审计单位检索',
				id:'export',
				iconCls:'icon-search',
				handler:function(){
					doAudSearch();
				}
			},'-',{
				text:'经济责任人筛选',
				id:'resPerson',
				iconCls:'icon-search',
				handler:function(){
					var url = '${contextPath}/mng/economyduty/economyDutyAction!listEconomyForWorkplan.action?fromAdjust=${fromAdjust}&yearFormId=${crudId}';
					aud$openNewTab('经济责任人筛选',url,true);
				}
			}
			],
			onClickCell:function(rowIndex, field, value) {
				if(field == 'w_plan_name') {
					var rows = $('#yearDetailList').datagrid('getRows');
					var row = rows[rowIndex];
					if(row.status&&row.status=='1000') {
						var url = "${contextPath}/plan/detail/editDetail.action?planUpdate=yes&fromAdjust=${fromAdjust}&crudId=" + row.formId + "&option=edityuxuan&yearFormId=${crudId}";
						aud$openNewTab('编辑',url,true);
					} else {
						var url = '${contextPath}/plan/detail/view.action?crudId='+row.formId;
						aud$openNewTab(row.w_plan_name, url, true);;
					}
				}
			},
			frozenColumns:[[
			       			{field:'status_name',title:'计划状态',width:'120',align:'center',
			       				halign:'center',sortable:true,formatter:function(value,rowData,rowIndex){
                                    if(rowData.status == '1113' && rowData.w_plan_type_name == '年度计划'){
                                        return "年度已审批";
                                    }else{
                                        return value;
					   			     }
								 }
			       			},
			       			{field:'w_plan_name',title:'项目名称',width:'350', align:'left',halign:'center',sortable:true
								,formatter:function (value,row,index) {
									var result;
									if(row.status=='1000') {
										result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
									} else {
										result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
									}
									return result;
								}
			       			}
			    		]],
			columns:[[
				{field:'w_plan_code',
					title:'计划编号',
					width:150,
					align:'center',
					sortable:true,
					halign:'center',
					hidden:true
				},
                {field:'version',
                    title:'版本',
                    width:150,
                    align:'left',
                    sortable:true,
                    halign:'center',
					hidden:true
                },
				{field:'audit_object_name',
						title:'被审计单位名称',
						width:150,
						align:'left',
						sortable:true,
						halign:'center'
				},
/*				{field:'lastAudYear',
					title:'上次审计年度',
					width:100, 
					align:'center',
					sortable:true,
					halign:'center',
					hidden:true
				},
				{field:'lastProTypeName',
					 title:'上次审计类型',
					 width:100, 
					 align:'center', 
					 sortable:true,
					 hidden:true
				},*/
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
				}
				<%--<s:if test="${searchCondition.plan_grade eq '1000'}">--%>
                ,{field:'sourcePlanName',
                    title:'被调整项目',
                    width:150,
                    align:'center',
                    halign:'center',
					hidden:true,
					formatter:function (value,row,index) {
						if(row['adjustedDetailId'] != null&&row['adjustedDetailId'] != ''){
						    return '<a href="javascript:;" onclick="aud$openNewTab(\''+value+'\',\'${contextPath}/plan/detail/view.action?crudId='+row['adjustedDetailId']+'\',true);">'+value+'</a>';
						}
                    }
                }
				<%--</s:if>--%>
			]]   
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
	function doSearch(){
		$('#yearDetailList').datagrid({
			queryParams:form2Json('searchForm')
	    });
	    $('#yearDetailList').datagrid('clearSelections');
		$('#dlgSearch').dialog('close');
    }
	function resetQuery(){
		resetForm('searchForm');
	}
	function doAudSearch() {
		/*$('#audSearch').dialog({
			title:'多年未被审计单位检索',
			width: 750,
			height: 300,
			closed: false,
			cache: false,
			fit:true,
			maximizable:true,
			minimizable:false,
			resizable:true,
			content: '<iframe  id="unaudDept" src="${contextPath}/plan/detail/unauditedDepSearch!unauditedDepartmentSearch.action?fromAdjust=${fromAdjust}&crudId=${crudId}&yearFormId=${crudId}" width="100%" height="100%" marginheight="0"  marginwidth="0"  frameborder="0" scrolling="auto" ></iframe>',
			modal: true
		});*/
		var url = '${contextPath}/plan/detail/unauditedDepSearch!unauditedDepartmentSearch.action?fromAdjust=${fromAdjust}&crudId=${crudId}&yearFormId=${crudId}';
		aud$openNewTab('多年未被审计单位检索', url, true);
	}

	</script>
</body>
</html>
