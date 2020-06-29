<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>经济责任人基本信息列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript">
		function wait(){
			document.getElementById("submitButton").disabled = true;
			document.getElementById("layer").style.display = "";
			document.getElementById("errorInfo1").style.display = "none";
			document.getElementById("errorInfo2").style.display = "none";
			importForm.submit();
		}
		function dutyEdit(){
			var cbxs = document.getElementsByName("ids");
			var cbx_count = 0;
			var cbx_no = -1;
			for(var i=0;i<cbxs.length;i++){
				if(cbxs[i].checked){
					cbx_count++;
					cbx_no = i;
				}
			}
			if(cbx_count>1){
				$.messager.show({title:'消息',msg:'不能同时修改多责任人信息！'});
				return false;
			}
			if(cbx_no==-1){
				$.messager.show({title:'消息',msg:'没有选择要修改的责任人!'});
				return false;
			}
			document.forms[0].action="economyDutyAction!edit.action";
			document.forms[0].submit();
		}
		/*
		*  打开或关闭查询面板
		*/
		function triggerSearchTable(){
			var isDisplay = document.getElementById('planTable').style.display;
			if(isDisplay==''){
				document.getElementById('planTable').style.display='none';
			}else{
				document.getElementById('planTable').style.display='';
			}
		}
		//重置查询条件
		function restal(){
			$('#name').val('');
			$('#companyCode').val('');
			$('#company').val('');
			$('#department').val('');
			$('#duty').val('');
			$('#beginDate').datebox('setValue','');
			$('#endDate').datebox('setValue','');
		}
		function doSearch(){
        	$('#its').datagrid({
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

		function showEcondutyDlg(id) {
			var url = '${contextPath}/mng/economyduty/economyDutyAction!view.action?id=' + id + '&audobjid=${audobjid}&status=${param.status}&from=jzview';
			$('#showEcondutyDlgFrame').attr('src', url);
			$('#showEcondutyDlg').window('open');
		}
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
			<s:form  name="myform" id="searchForm"   namespace="/mng/economyduty" onsubmit="return delOrEdit('ids','责任人');">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td class="EditHead" sytle="width:15%">姓名</td>
						<td class="editTd" sytle="width:35%">
							<s:textfield cssClass="noborder"  name="econDutyBaseInfo.name" maxlength="50" id="name"/>
						</td>
						<td class="EditHead" sytle="width:15%">所属单位</td>
<!-- 						<td class="editTd" sytle="width:35%"> -->
<!-- 							<s:textfield cssClass="noborder"  name="econDutyBaseInfo.company" maxlength="50" /> -->
<!-- 						</td> -->
							<td class="editTd" sytle="width:35%">
									<s:buttonText cssClass="noborder"  name="econDutyBaseInfo.company" id="company" hiddenId="companyCode" hiddenName="econDutyBaseInfo.companyCode"
										doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
										   // json格式，url使用的参数
										   param:{
												'departmentId':'${audit_dept}'
										   },
										  checkbox:true,
										  title:'请选择经济责任人所属单位'
										})"
										doubleSrc="/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:hand;border:0" readonly="true" doubleDisabled="false"/>
							</td>
					</tr>
					<tr>
						<td class="EditHead">工作部门</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="econDutyBaseInfo.department" maxlength="50" id="department"/>
						</td>
						<td class="EditHead">职务</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="econDutyBaseInfo.duty" maxlength="50" id="duty"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">任职开始日期</td>
						<td class="editTd" colspan="5">
							<input type="text" name="econDutyBaseInfo.beginDate" class="easyui-datebox" editable="false" id="beginDate" title="单击选择日期" style="width: 150px" >
							——
							<input type="text" name="econDutyBaseInfo.endDate" class="easyui-datebox" editable="false" id="endDate" title="单击选择日期" style="width: 150px" >
						</td>
						<%-- <td align="left" class="listtabletr11">审计项目名称</td>
						<td align="left" class="listtabletr22">
							<s:textfield name="econDutyBaseInfo.w_plan_name" maxlength="50" />
						</td> --%>							
					</tr>						
				</table>
				<s:hidden name="audobjid"/>
				<s:hidden name="status"/>
				<s:hidden name="from"/>
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
	<div region="center" border='0' >
		<table id="its"></table>
	</div>
	<div id="showEcondutyDlg" title="经济责任人信息" style="overflow:hidden;padding:0">
		<iframe id="showEcondutyDlgFrame" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
	</div>

	<script type="text/javascript">
		$(function(){
			showWin('dlgSearch');
			$('#showEcondutyDlg').window({
				width: 950,
				height: 450,
				modal: true,
				collapsible: false,
				maximizable: true,
				minimizable: false,
				closed: true
			});
		    //$('body').layout('collapse','north');
		    //$(document).bind("contextmenu",function(e){return false;});//禁用右键菜单
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/mng/economyduty/economyDutyAction!listEconomyForWorkplan.action?fromAdjust=${fromAdjust}&yearFormId=${yearFormId}&activeTabId=${activeTabId}&querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:false,
				pageSize:20,
				remoteSort: false,
				toolbar: [
					{
						id: 'search',
						text: '查询',
						iconCls: 'icon-search',
						handler: function () {
							searchWindShow('dlgSearch');
						}
					},'-',{
						id: 'generate',
						text: '生成经济责任审计项目',
						iconCls: 'icon-edit',
						handler: function () {
							var rows = $('#its').datagrid('getChecked');
							if(rows == '') {
								showMessage1("请选择数据！");
								return;
							}
							var ids = new Array();
							var names = new Array();
							var companys = new Array();
							var companyCodes = new Array();
							for(i in rows) {
								ids.push(rows[i].id);
								names.push(rows[i].name);
								companys.push(rows[i].company);
								companyCodes.push(rows[i].companyCode);
							}
							if(ids.length > 0) {
								$.ajax({
									url:'${contextPath}/plan/detail/genWorkPlanDetail.action',
									type:'post',
									async:false,
									data:{'ids':ids.join(','),'names':names.join(","),'yearFormId':'${yearFormId}','companys':companys.join(','),'companyCodes':companyCodes.join(','),'fromAdjust':'${fromAdjust}'},
									success:function(data){
										var parentTabId = '${activeTabId}';
										var curTabId = aud$getActiveTabId();
										var frameWin = aud$getTabIframByTabId(parentTabId);
										if(data == 'N') {
											frameWin.$('#yuxuan').get(0).contentWindow.refresh();
										} else if(data == 'Y') {
											frameWin.refresh();
										}
										aud$closeTab(curTabId, parentTabId);
 									}
								});
							} else {
								showMessage1("请选择数据！");
							}
						}
					}
				],
				columns:[[
					{field:'id',title:'选择',checkbox:'true'},
	       			{field:'name',title:'姓名',width:80,align:'left',halign:'center',sortable:true,
		       			formatter:function(value,rowData,rowIndex){
							var onclick = "showEcondutyDlg('" + rowData.id + "')";
							return '<a href="javascript:' + onclick + '">' + rowData.name + '</a>';
		       			}
	       			},
	       			{field:'company',title:'所属被审计单位',width:150,halign:'center',align:'left',sortable:true},
	       			/* {field:'department',title:'工作部门',width:100,halign:'center',sortable:true,align:'left'}, */
					{field:'duty',
						title:'职务',
						width:80,
						halign:'center',
						align:'left',
						sortable:true
					},
					{field:'incumbencyState',
						title:'在职状态',
						width:80,
						halign:'center',
						sortable:true, 
						align:'center'
					},
					{field:'beginDate',
						 title:'任职开始日期',
						 width:100, 
						 halign:'center',
						 align:'center',
						 sortable:true
					},
					{field:'endDate',
						 title:'任职结束日期',
						 width:100, 
						 halign:'center',
						 align:'center',
						 sortable:true
					},
					{field:'audit_end_time',
						 title:'上次审计期间结束',
						 width:100, 
						 halign:'center',
						 align:'center',
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
							 return value ? value.substr(0, 10) : "";
						 }
					},
					{field:'yearNum',
						 title:'未审期间(年)',
						 width:100, 
						 halign:'center',
						 align:'right',
						 sortable:true,
						formatter:function (value) {
							var result = '';
							if (value) {
								var yearNumArr = (value + '').split(".");
								if(yearNumArr[0] > 0) {
									result = yearNumArr[0] + '年';
								}
								if(12*('0.'+ yearNumArr[1]) > 0) {
									result += (12*('0.'+ yearNumArr[1])).toFixed(2) + '月';
								}
								if(result == '') {
									result = '0月';
								}
							}
							return result;
						}
					}/*,
					{field:'projectNum',
						 title:'被审项目数',
						 width:70, 
						 halign:'center',
						 align:'right',
						 sortable:true
					},
					{field:'totalAuditReport',
						 title:'审计报告数',
						 width:70, 
						 halign:'center',
						 align:'right',
						 sortable:true
					}*/
				]]   
			}); 
		});
	</script>
	</body>
</html>
