<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
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
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
				<s:form action="listMyProjectForUpdate" namespace="/project" method="post" name="myform" id="myform">
					<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<input type="hidden" name="condition" value="yes" reload="false"/>
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
						      <s:textfield cssClass="noborder" name="crudObject.project_code" cssStyle="width:80%" maxlength="50"/>
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
							<td class="EditHead" nowrap="nowrap">
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
								       <option value="">&nbsp;</option>
								       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(5,10)" id="entry">
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
		<div id="layer" style="display: none" align="center">
			<img src="${contextPath}/images/uploading.gif">
			<br>
			<br>
			正在进行数据同步，请稍候......
		</div>
		<script type="text/javascript">
			
			/*
			* 查询
			*/
			function doSearch(){
				document.getElementById('myform').action = "${contextPath}/project/listMyProject.action";
	        	$('#projectList').datagrid({
	    			queryParams:form2Json('myform')
	    		});
				$('#dlgSearch').dialog('close');
	        	return declareExport('false');
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
			
		$(function (){
			showWin('dlgSearch');
			//$('body').layout('collapse','north');
			if('${empty crudObject.pro_year}'=='true'){
				var d = new Date();
				$('#w_plan_year').combo('setValue',d.getFullYear());
				$('#w_plan_year').combo('setText',d.getFullYear());
			}
			// 初始化生成表格			
			datagrid=$('#projectList').datagrid({
				url : "<%=request.getContextPath()%>/project/listMyProjectForUpdate.action?querySource=grid",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
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
				},
				{
					id:'sys',
					text:'同步',
					iconCls:'icon-publish',
					handler:function(){
						synchronous();
					}
				}
				],
				frozenColumns:[[
								//{field:'formId',width:'50', checkbox:true,halign:'center', align:'center'},
				       			{field:'is_closed',title:'状态',halign:'center',width:'8%',align:'center',formatter:function(value,rowData,rowIndex){	
				       						if(rowData.is_closed=='closed'){
					       						return '已关闭';
					       					}else{
					       						return '进行中';
					       					}
		       							}
					       			},
				       			{field:'project_code',title:'项目编号',width:'19%',halign:'center',sortable:true,align:'left'}
				    		]],
				columns:[[  
					{field:'project_name',
							title:'项目名称',
							width:'25%',
							halign:'center',
							align:'left', 
							sortable:true,
							formatter:function(value ,rowData,rowIndex){
								if(rowData.is_closed=='running' || '@ais.project.ProjectSysParamUtil@isClosedProjectCanView()'){
									if(rowData.isUserInMembers=='suc'){
										if(rowData.is_closed=='running'){
											return '<a href=\"javascript:void(0)\" onclick=\"goProjectMenu(\''+rowData.formId+'\',\''+rowData.prepare_closed+'\',\''+rowData.actualize_closed+'\',\''+rowData.report_closed+'\',\''+rowData.archives_closed+'\',\''+''+'\');\">'+value+'</a>'; 				
										}else{
											return '<a href=\"javascript:void(0)\" onclick=\"goProjectMenu(\''+rowData.formId+'\',\''+rowData.prepare_closed+'\',\''+rowData.actualize_closed+'\',\''+rowData.report_closed+'\',\''+rowData.archives_closed+'\',\''+'view'+'\');\">'+value+'</a>';	
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
						width:'8%',
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'audit_dept_name',
						 title:'所属单位',
						 width:'8%',
						 halign:'center', 
						 align:'left', 
						 sortable:true
					},
					{field:'prepare_closed',
						 title:'准备',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 width:'5%',
						 formatter:function(value ,rowData,rowIndex){
		   						if(rowData.prepare_closed==null){
		       						return '未执行';
		       					}else if(rowData.prepare_closed=='1'){
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
						 width:'5%',
						 formatter:function(value ,rowData,rowIndex){
	   						if(rowData.actualize_closed==null){
	       						return '未执行';
	       					}else if(rowData.actualize_closed=='1'){
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
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 width:'5%',
						 formatter:function(value ,rowData,rowIndex){
	   						if(rowData.report_closed==null){
	       						return '未执行';
	       					}else if(rowData.report_closed=='1'){
	       						return '已完成';
	       					}else if(rowData.report_closed=='0' || rowData.report_closed=='2'){
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
						 width:'5%',
						 formatter:function(value ,rowData,rowIndex){
	   						if(rowData.archives_closed==null){
	       						return '未执行';
	       					}else if(rowData.archives_closed=='1'){
	       						return '已完成';
	       					}else if(rowData.archives_closed=='0' ){
		       					return '进行中';
	       					}else{
		       					return '未执行';
	       					}			
						}
					},
					{field:'rework_closed',
						 title:'整改',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 width:'5%',
						 formatter:function(value ,rowData,rowIndex){
	   						if(rowData.rework_closed==null){
	       						return '未执行';
	       					}else if(rowData.rework_closed=='1'){
	       						return '已完成';
	       					}else if(rowData.rework_closed=='0' ){
		       					return '进行中';
	       					}else{
		       					return '未执行';
	       					}			
						}
					}
				]]   
			}); 
			//单元格tooltip提示
			$('#projectList').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			
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
			
			
			function synchronous(){
				var rows = datagrid.datagrid("getSelections");
				var formIds = '';
				if (rows.length > 0) {
	                for (var i = 0; i < rows.length; i++) {
						formIds += rows[i].formId + ","
	                }
	            }
				if(formIds == '') {
					showMessage2('请选择待同步的审计项目！');
					return false;
				}else {
					$.messager.confirm('提示','数据同步将覆盖在线系统所产生的全部审计成果，确定是否继续？',function(flag){
						if(flag){
							$.ajax({
							url:'${contextPath}/project/synchronous.action',
							async:true,
							type:'POST',
							dataType:'JSON',
							data:{'formIds':formIds},
							success:function(data){								
								if(data.code == '0'){
									showMessage2('同步成功！');
								}else{
									showMessage2('同步失败：'+data.failedTables);
								}
							}
						});
						}
					});
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
		
		function goProjectMenu(projectid,prepare_closed,actualize_closed,report_closed,archives_closed,ifView){
			var stage = "";
			if(prepare_closed && prepare_closed == '0'){
				stage = "prepare";
			}else if(actualize_closed && actualize_closed == '0'){
				stage = "actualize";
			}else if(report_closed && report_closed == '0'){
				stage = "report";
			}else if(archives_closed && archives_closed =='0'){
				stage = "archives";
			}
			var udswin = null;
			//window.open("${contextPath}/project/prepare/projectIndex.action?stateNo="+stateNo+"&crudId="+projectid+"&view=view");
			if(archives_closed=='1'){//档案阶段已完成 在审计作业中项目不可以切换只显示当前的项目名称
                udswin = window.open(
						'${contextPath}/project/prepare/projectIndex.action?crudId='
								+ projectid + '&stage=' + stage + '&isView=2&view='+ifView, '',
								'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			}else{//审计作业中的项目可以切换
                udswin = window.open(
						'${contextPath}/project/prepare/projectIndex.action?crudId='
								+ projectid + '&stage=' + stage + '&view='+ifView, '',
								'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			}
			if (udswin) {
                udswin.moveTo(0, 0);
                udswin.resizeTo(window.screen.availWidth, window.screen.availHeight);
            }
		}
		</script>
	</body>
</html>
