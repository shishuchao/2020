<%@ page contentType="text/html;charset=UTF-8" language="java"
	import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>年度计划：预选项目：未审计单位检索结果</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src='${contextPath}/easyui/boot.js'></script>
		<script type="text/javascript" src='${contextPath}/easyui/contextmenu.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript">
			var year_form_id = '<s:property value="yearFormId"/>';
			var crudId = '<s:property value="crudId"/>';
			var planStatus = '<s:property value="planStatus"/>';

			//返回
			function back(){
				if("yes" == "${fromAdjust}"){ //判断是否是从计划调整模块中过来的
					parent.location.href="/ais/plan/year/edit.action?fromAdjust=${fromAdjust}&crudId=${crudId}";
				}else{
					if(planStatus != ""){
						//parent.location.href="/ais/plan/detail/editPlanItem.action?crudId="+crudId;
						parent.location.href="/ais/plan/detail/editPlanItem.action?yearFormId="+year_form_id +"&planStatus="+planStatus;
					}else{
						//parent.location.href="/ais/plan/detail/editPlanItem.action?crudId="+crudId;
						parent.location.href="/ais/plan/year/edit.action?crudId="+crudId+"&selectedTab=yearDetailListDiv";
					}
				}
				
			}
			//添加到项目
			function addToPlan(){
				var audObjIds = $('#unauditedDepartmentSearchList').datagrid('getChecked');
				//var audObjIds = $("[name='auditingObjectCheckBox']:checked");
				if(audObjIds.length <= 0){
					$.messager.show({
						title:'提示信息',
						msg:'请至少选择一个被审计单位！',
						timeout:5000,
						showType:'slide'
					});
					return;
				}
				if(audObjIds.length > 1){
					$.messager.show({
						title:'提示信息',
						msg:'只能选择一个被审计单位！',
						timeout:5000,
						showType:'slide'
					});
					return;
				}
				//var audNames = new Array();
				//var audIds = new Array();
				//for(var i=0;i<audObjNames.length;i++){
				//	audNames.push($(audObjNames[i]).attr("id"));
				//	audIds.push($(audObjNames[i]).val());
				//}
				//parent.location.href = "${contextPath}/plan/detail/editPlanItem.action?audIds="+audIds+"&unaudObjs="+encodeURI(encodeURI(audNames))+"&yearFormId="+year_form_id;
				parent.location.href = '${contextPath}/plan/detail/edit.action?fromAdjust=${fromAdjust}&isNyear=yes&option=addyuxuan&yearFormId='+year_form_id+"&audObjIds="+audObjIds[0].id;
			}
			//保存检索结果
			function saveSearchRecord(){
				var startTime = $("#startTime").datebox('getValue');
				var endTime = $("#endTime").datebox('getValue');
				if("" == startTime){
					$.messager.show({
						title:'提示信息',
						msg:'未审年度起始时间不能为空！',
						timeout:5000,
						showType:'slide'
					});
					return;
				}
				if("" == endTime){
					$.messager.show({
						title:'提示信息',
						msg:'未审年度结束时间不能为空！',
						timeout:5000,
						showType:'slide'
					});
					return;
				}
				$.ajax({
					url:'${contextPath}/plan/detail/unauditedDepSearch!saveSearchRecord.action',
					type:'post',
					data:{
						fromAdjust:'${fromAdjust}',
						startTime:startTime,
						endTime:endTime,
						yearFormId:'${yearFormId}',
						crudId:'${crudId}'
					},
					dataType:'json',
					success:function(data){
						if(data.succ == '1'){
							$.messager.show({
								title:'提示信息',
								msg:'保存成功！',
								timeout:5000,
								showType:'slide'
							});
						}
					}
				});
				//parent.location.href = "${contextPath}/plan/detail/unauditedDepSearch!saveSearchRecord.action?fromAdjust=${fromAdjust}&startTime="+startTime+"&endTime="+endTime+"&yearFormId="+year_form_id+"&crudId="+crudId;
			}
			//返回未审计查询结果记录
			function back2UnaudSearchRecord(){
				parent.location.href = "${contextPath}/plan/detail/unauditedDepSearch!unauditedDepartmentSearch.action?fromAdjust=${fromAdjust}&yearFormId="+year_form_id+"&crudId="+crudId;
			}

			function init(){
				var msg = '${searchMgs}';
				if(msg == 'N'){
					$.messager.show({
						title:'提示信息',
						msg:'未查询到记录！',
						timeout:5000,
						showType:'slide'
					});
				} 
			}
		</script>
	</head>
	<body onload="init();" style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
			<s:form id="searchForm"
					action="unauditedDepSearch!unauditedDepartmentSearchList.action?fromAdjust=${fromAdjust}"
					namespace="/plan/detail">
				<s:hidden name="crudId" value="${crudId}" />
				<s:hidden name="yearFormId" value="${yearFormId}" />
				<table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
					<tr>
						<td class="EditHead">
							<font color="red">*</font>未审年度开始
						</td>
						<td class="editTd">
							<input type="text" id="startTime" name="startTime" editable="false" class="easyui-datebox noborder" />
						</td>

						<td class="EditHead">
							<font color="red">*</font>未审年度结束
						</td>
						<td class="editTd">
							<input type="text" id="endTime" name="endTime" editable="false" class="easyui-datebox noborder" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							被审计单位
						</td>
						<td class="editTd" id="auditObjtContTd" colspan="3">
						<s:buttonText2 id="audit_object_name" hiddenId="audit_object" cssClass="noborder" cssStyle="width: 86%"
							name="crudObject.audit_object_name" 
							hiddenName="crudObject.audit_object"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
										   // json格式，url使用的参数
										   param:{
												'departmentId':'${audit_dept}'
										   },
										  checkbox:true,
										  title:'请选择经济责任人所属单位'
							})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0"
							readonly="true"
							doubleDisabled="!(varMap['audit_objectWrite']==null?true:varMap['audit_objectWrite'])" title="被审单位" maxlength="1500"/>
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
		<div region="center">
			<table id="unauditedDepartmentSearchList"></table>
		</div>
		<%-- <div align="center">
			<display:table id="auditingObject" name="${auditingObjectList}"
				class="its" pagesize="10"
				requestURI="${contextPath}/plan/detail/unauditedDepSearch!unauditedDepartmentSearchList.action">
				<display:column title="选择" headerClass="center" class="center">
					<input name="auditingObjectCheckBox" type="checkbox"
						id="${auditingObject.name}" value="${auditingObject.id}"
						onclick="changeMemberButtonState(this,'${member.isAddByPlan}','${member.isOutSystem}')" />
				</display:column>
				<display:column title="审计单位名称" headerClass="center" class="center"
					sortable="true">
					  ${auditingObject.projectStartObject.audit_dept_name }
				</display:column>
				<display:column property="name" title="被审计单位名称"
					headerClass="center" class="center" sortable="true" />
				<display:column title="上次审计年度" headerClass="center" class="center"
					sortable="true">
					  ${auditingObject.projectStartObject.lastAudYear}
				</display:column>
				<display:column title="上次审计类型" headerClass="center" class="center"
					sortable="true">
					  ${auditingObject.projectStartObject.lastProTypeName }
				</display:column>
				<display:column title="上次开始时间" headerClass="center" class="center"
					sortable="true">
					  ${auditingObject.projectStartObject.pro_starttime }
				</display:column>
				<display:column title="上次结束时间" headerClass="center" class="center"
					sortable="true">
					  ${auditingObject.projectStartObject.pro_endtime }
				</display:column>
				<display:column title="上次审计期间开始" headerClass="center"
					class="center" sortable="true">
					  ${auditingObject.projectStartObject.audit_start_time }
				</display:column>
				<display:column title="上次审计期间结束" headerClass="center"
					class="center" sortable="true">
					  ${auditingObject.projectStartObject.audit_end_time }
				</display:column>
				<display:column title="风险值" headerClass="center" class="center"
					sortable="true">
					  ${auditingObject.projectStartObject.riskValue }
				</display:column>

			</display:table>
			</br>
			</br>
			<div align="right" style="width: 96%;">
				<s:if test="#request.status == 'view'">
					<input id="addToPlanButton" type="button" style="cursor: pointer;"
						value="添加到计划" onclick="addToPlan()" />
				&nbsp;&nbsp;
				<input type="button" style="cursor: pointer;" value="返回检索记录"
						onclick="back2UnaudSearchRecord()" />
				&nbsp;&nbsp;
				<input type="button" style="cursor: pointer;" value="返回预选项目信息"
						onclick="back()" />
				&nbsp;&nbsp;
				</s:if>
				<s:else>
					<input id="addToPlanButton" type="button" style="cursor: pointer;"
						value="添加到计划" onclick="addToPlan()" />
				&nbsp;&nbsp;
				<input id="saveSearchRecordButton" type="button"
						style="cursor: pointer;" value="保存筛选结果"
						onclick="saveSearchRecord();" />
				&nbsp;&nbsp;
				<input type="button" style="cursor: pointer;" value="返回检索记录"
						onclick="back2UnaudSearchRecord()" />
				&nbsp;&nbsp;
				<input type="button" style="cursor: pointer;" value="返回预选项目信息"
						onclick="back()" />

				</s:else>
			</div>
			<br />
		</div> --%>
	</body>
	<script type="text/javascript">
		//检索未审计单位
		function doSearch(){
			var startTime = $("#startTime").datebox('getValue');
			var endTime = $("#endTime").datebox('getValue');
			if("" == startTime || "" == endTime){
				/* $.messager.show({
					msg:'检索开始时间/检索结束时间不能为空！',
					width:'auto',
					height:'auto',
					showType:'slide',
					timeout:5000,
					style:{
						right:'',
						top:document.body.scrollTop+document.documentElement.scrollTop,
						bottom:''
					}
				}); */
				showMessage1('未审年度开始/未审年度结束不能为空！');
				return;
			}
			var reg=new RegExp("-","g"); //创建正则RegExp对象
			var tempBeginTime=(startTime).replace(reg,"\/");
			var tempEndTime=(endTime).replace(reg,"\/");
			if(Date.parse(new Date(tempBeginTime))>Date.parse(new Date(tempEndTime))){
				/* $.messager.show({
					msg:'检索开始时间不能大于结束时间!',
					width:'auto',
					height:'auto',
					showType:'slide',
					timeout:5000,
					style:{
						right:'',
						top:document.body.scrollTop+document.documentElement.scrollTop,
						bottom:''
					}
				}); */
				showMessage1('检索开始时间不能大于结束时间！');
				return false;
			}
			$('#unauditedDepartmentSearchList').datagrid({
				queryParams:{startTime:startTime,endTime:endTime,auditName:$('#audit_object_name').val()}
			});
			$('#unauditedDepartmentSearchList').datagrid('clearSelections');
			$('#dlgSearch').dialog('close');
		}
		function resetQuery(){
			resetForm('searchForm');
			//doSearch();
		}
		/*
		 * 取消
		 */
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}
		$(function(){
			showWin('dlgSearch');
			var url='${contextPath}/plan/detail/unauditedDepSearch!unauditedDepartmentSearchList.action?querySource=grid&fromAdjust=${fromAdjust}&crudId=${crudId}&planStatus=${planStatus}&yearFormId=${yearFormId}';
			<s:if test="#request.status == 'view'">
			 url = '${contextPath}/plan/detail/unauditedDepSearch!unauditedDepartmentSearchList.action?querySource=grid&status=view&searchRecord=${searchRecord}&fromAdjust=${fromAdjust}&crudId=${crudId}&planStatus=${planStatus}&yearFormId=${yearFormId}';
			</s:if>
			$('#unauditedDepartmentSearchList').datagrid({
				url : url,
				method:'post',
				rownumbers:true,
				pagination:false,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				idField:'formId',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[
					<s:if test="#request.status == 'view'">
					/* {
						id:'addToPlanButton',
						text:'添加到计划',
						iconCls:'icon-add',
						handler:function(){
							addToPlan();
						}
					} */
//					,
//					{
//						id:'back2UnaudSearchRecord',
//						text:'返回检索记录',
//						iconCls:'icon-redo',
//						handler:function(){
//							back2UnaudSearchRecord();
//						}
//					},
//					{
//						id:'back',
//						text:'返回预选项目信息',
//						iconCls:'icon-redo',
//						handler:function(){
//							back();
//						}
//					}
					</s:if>
					<s:else>
					{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch',750);
						}
					},'-',/* {
						id:'addToPlanButton',
						text:'添加到计划',
						iconCls:'icon-add',
						handler:function(){
							addToPlan();
						}
					}, */
					{
						id:'saveSearchRecordButton',
						text:'保存筛选条件',
						iconCls:'icon-save',
						handler:function(){
							saveSearchRecord();
						}
					}
//					,
//					{
//						id:'back2UnaudSearchRecord',
//						text:'返回检索记录',
//						iconCls:'icon-redo',
//						handler:function(){
//							back2UnaudSearchRecord();
//						}
//					},
//					{
//						id:'back',
//						text:'返回预选项目信息',
//						iconCls:'icon-redo',
//						handler:function(){
//							back();
//						}
//					}
					</s:else>
				],
				columns:[[
					{field:'audit_dept_name',
						title:'审计单位',
						width:150,
						align:'left',
						halign:'center',
						sortable:true
					},
					{field:'audit_object_name',
						title:'被审计单位',
						align:'left',
						halign:'center',
						sortable:true
					},
					{field:'lastAudYear',
						 title:'上次审计年度',
						 width:80,
						 align:'center', 
						 sortable:true
					},
					{field:'lastProTypeName',
						title:'上次审计类型',
						width:150,
						align:'center',
						sortable:true
					},
					{field:'pro_starttime',
						 title:'上次开始时间',
						 width:80,
						 align:'center', 
						 sortable:true
					},
					{field:'pro_endtime',
						title:'上次结束时间',
						width:80, 
						align:'center',
						sortable:true
					},
					{field:'audit_start_time',
						 title:'上次审计期间开始',
						 width:80,
						 align:'center', 
						 sortable:true
					},
					{field:'audit_end_time',
						 title:'上次审计期间结束',
						 width:80,
						 align:'center', 
						 sortable:true
					}
				]]   
			});
		});
	</script>
</html>
