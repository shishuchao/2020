<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题一览</title>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/easyui/boot.js"></script>   
		<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
<body class="easyui-layout" fit='true' border='0'>
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">	
			<s:form id="searchForm" name="searchForm" action="listAll" namespace="/plan/year" method="post">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead" style="width:15%">问题标题</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="ledgerProblem.audit_con" maxlength="50" cssStyle="width:80%"/>
						</td>
						<td class="EditHead" style="width:15%">问题编号</td>
						<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="ledgerProblem.serial_num" maxlength="50" cssStyle="width:80%"/>
						</td>
					</tr>
                    <tr >
						<td class="EditHead" style="width:15%">底稿名称</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="ledgerProblem.manuscript_name" maxlength="50" cssStyle="width:80%"/>
						</td>
						<td class="EditHead" style="width:15%">问题点</td>
						<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="ledgerProblem.problem_name" maxlength="50" cssStyle="width:80%"/>
						</td>
					</tr>
					  <tr >
						<td class="EditHead" style="width:15%">是否整改</td>
						<td class="editTd" style="width:35%">
							<select id="isReportquery" class="easyui-combobox" name="ledgerProblem.isInReport" style="width:175px;" editable="false" panelHeight="auto">
							       <option value="">&nbsp;</option>
							       <s:iterator value='#@java.util.LinkedHashMap@{"是":"是","否":"否"}' id="entry">
								         <s:if test="${ledgerProblem.isInReport==key}">
							       			<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
							       		 </s:if>
							       		 <s:else>
									        <option value="<s:property value="key"/>"><s:property value="value"/></option>
							       		 </s:else>
							       </s:iterator>
							    </select>	
						</td>
						  <td class="EditHead" style="width:15%">是否入报告</td>
						  <td class="editTd" style="width:35%">
							  <select id="isReportquery2" class="easyui-combobox" name="ledgerProblem.isToReport" style="width:175px;" editable="false" panelHeight="auto">
								  <option value="">&nbsp;</option>
								  <s:iterator value='#@java.util.LinkedHashMap@{"是":"是","否":"否"}' id="entry">
									  <s:if test="${ledgerProblem.isToReport==key}">
										  <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
									  </s:if>
									  <s:else>
										  <option value="<s:property value="key"/>"><s:property value="value"/></option>
									  </s:else>
								  </s:iterator>
							  </select>
						  </td>
					</tr>
				</table>
			</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn" style="text-align: right;">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
		    </div>
		</div>
	
	
	<!-- 	<div id="ledgerProblemList">
		</div> 
		 -->
		<div region="center" border='0'>
			<table id="ledgerProblemList"></table>
		</div>
		<div id="sendBack_div" title="调整问题编号" style='overflow:hidden;padding:0px;'>
				<s:form id="sendBackForm" action="" namespace="" method="post" >
					<table class="ListTable" align="center" >
						<tr>
							<td align="left" class="EditHead" nowrap>问题编号</td>
							<td class="editTd">
								<%-- <s:textfield name="serial_num" id ="serial_num" cssStyle="width:200px;"/> --%>
								<%--  <s:property value="acode" /> --%>
								<span id="acode" style="width:10%"></span>
								<span>-</span>
								<%-- <s:textfield id="ayear" name="ayear" cssStyle="width:30%"  />
								<span>-</span> --%>
								<s:textfield id="ashu" name="ashu" cssStyle="width:30%"  />
								<s:hidden name="acode"  id="acodes"/>
								<s:hidden name="ledgerProblem.serial_num" id="ledgerProblem.serial_num"/>
								<s:hidden name="ledgerProblem.id"/>
								<input  type="hidden"  name="project_id" id="project_id"/>
								<input  type="hidden"  name="projectType" id="projectType"/>
							</td> 
						</tr>
					</table>
				</s:form>
				<input type="hidden" name="ledgerProblem_id" id="ledgerProblem_id"/>
				<div style='text-align:center;' id='exportBtnDiv' style='padding:10px;'>
	        		<a id='sendId'  class="easyui-linkbutton"  iconCls="icon-save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
	        		<a id='closeWinSjyd' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</a>
			    </div>
		</div>
		<div id="inReport" title="整改问题" style='overflow:hidden;padding:0px;'>
			<s:form id="sendBackForm" action="" namespace="" method="post" >
					<table class="ListTable" align="center" >
						<tr class="listtablehead">
							<td valign="middle" nowrap="nowrap" class="EditHead" style="width: 10%">
								是否整改：
							</td>
							<td class="editTd" style="width: 90%">
								<select id="isReportE" class="easyui-combobox" name="ledgerProblem.isInReport" style="width:160px;" editable="false" data-options="panelHeight:50">
							       <s:iterator value="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" id="entry">
									   <s:if test="${ledgerProblem.isInReport==key}">
										   <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
									   </s:if>
									   <s:else>
										   <option value="<s:property value="key"/>"><s:property value="value"/></option>
									   </s:else>
							       </s:iterator>
							    </select>	
							</td>
						</tr>
						<tr class="listtablehead">
							<td valign="middle" nowrap="nowrap" class="EditHead " style="width: 10%"><span id="remarkColour" style="color:red;">*</span>
								整改说明：
							</td>
							<td class="editTd" style="width: 90%">
								<s:textarea id="remarks" name="ledgerProblem.remarks" cssClass="noborder" cssStyle="width:100%" />
							</td>
						</tr>
					</table>
				</s:form>
				<input  type="hidden" name="inReport_id" id="inReport_id"/>
				<br>
				<div style='text-align:center;' id='InReportBtnDiv' style='padding:10px;'>
	        		<a  id='saveId'  class="easyui-linkbutton"  iconCls="icon-save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
	        		<a  id='closeInReport' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</a>							        
			    </div>
		</div>
		<div id="toReport" title="入报告问题" style='overflow:hidden;padding:0px;'>
			<s:form id="sendBackForm" action="" namespace="" method="post" >
				<table class="ListTable" align="center" >
					<tr class="listtablehead">
						<td valign="middle" nowrap="nowrap" class="EditHead" style="width: 10%">
							是否入报告：
						</td>
						<td class="editTd" style="width: 90%">
							<select id="isToReport" class="easyui-combobox" name="ledgerProblem.isToReport" style="width:160px;" editable="false" data-options="panelHeight:50">
								<s:iterator value="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" id="entry">
									<s:if test="${ledgerProblem.isToReport == key}">
										<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:if>
									<s:else>
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:else>
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr class="listtablehead">
						<td valign="middle" nowrap="nowrap" class="EditHead " style="width: 10%"><span id="reportRemarksColour" style="color:red;">*</span>
							入报告说明：
						</td>
						<td class="editTd" style="width: 90%">
							<s:textarea id="reportRemarks" name="ledgerProblem.reportRemarks" cssClass="noborder" cssStyle="width:100%" />
						</td>
					</tr>
				</table>
			</s:form>
			<input  type="hidden" name="toReport_id" id="toReport_id"/>
			<br>
			<div style='text-align:center;' id='ToReportBtnDiv' style='padding:10px;'>
				<a  id='saveToReport'  class="easyui-linkbutton"  iconCls="icon-save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a  id='closeToReport' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</a>
			</div>
		</div>
		<div id="planName" title="项目信息" style="overflow:hidden;padding:0px">
            <iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
 		 </div>
		<script type="text/javascript">
		<%String view=request.getParameter("view");%>
		<%String right=request.getParameter("isView");%>
			var g1;
			$(function(){
				showWin('dlgSearch');
                g1 = $('#ledgerProblemList').datagrid({
					url : "${contextPath}/proledger/problem/mainUi.action?projectview=${projectview}&querySource=grid&project_id=<%=request.getAttribute("project_id")%>&taskId=-1&interaction=${interaction}",
					method:'post',
					showFooter:false,
					rownumbers:true, 
				 	pagination:true, 
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					//singleSelect:true,
					pageSize:20,
					remoteSort: false,
					selectOnCheck: false,
					<s:if test="${view == 'view'} || ${isView == 'true'}">
					toolbar:[
 						      {
							    	id:"search",text:'查询',iconCls:'icon-search',handler:function(){
 							    		searchWindShow('dlgSearch');
						    	}}, '-',
						{id:'viewLedgerOwner',text:'查看',iconCls:'icon-view',
							handler:function(){
								viewLedgerOwner();
							}},'-',
						{id:'expLedgerOwner',text:'导出',iconCls:'icon-export',
							handler:function(){
								expLedgerOwner();
							}},'-',helpBtn
					],
					</s:if>
					<s:else>
					toolbar:[
					      {id:"search",text:'查询',iconCls:'icon-search',handler:function(){
						          searchWindShow('dlgSearch');
 						      }},'-',
						<s:if test="${projectStartObject.planProcess eq 'simplified'}">
								{
									id:'addLedgerOwner',
									text:'新增',
									iconCls:'icon-add',
									handler:function(){
										addLedgerOwner();
									}
								},'-',
								{
									id:'editLedgerOwner',
									text:'修改',
									iconCls:'icon-edit',
									handler:function(){
										editLedgerOwner();
									}
								},'-',
								{
									id:'delLedgerOwner',
									text:'删除',
									iconCls:'icon-delete',
									handler:function(){
										delLedgerOwner();
									}
								},'-',
						</s:if>
							{id:'changeLedgerNum',text:'调整问题编号',iconCls:'icon-edit-gray',
								handler:function(){
									changeLedgerNum();
								}},'-',
							{id:'inLedgerOwner',text:'整改问题设定',iconCls:'icon-edit-red',
								handler:function(){
									inLedgerOwner();
								}},'-',
							{id:'toReportSet',text:'是否入报告',iconCls:'icon-edit-blue',
								handler:function(){
									toReport();
								}},'-',
							{id:'expLedgerOwner',text:'导出',iconCls:'icon-export',
								handler:function(){
									expLedgerOwner();
								}},'-',helpBtn
						],
					</s:else>
					onLoadSuccess:function(){
						initHelpBtn();
					},
	               	frozenColumns:[[
	                     {field:'id',width:'50', checkbox:true, align:'center'},
	    				 {field:'manuscript_id',width:'50', hidden:true, align:'center'},         
	                   
                         {field:'audit_con',title:'问题标题',width:200,halign:'center',align:'left', sortable:true,
	                        formatter:function(value,rowData,rowIndex){
	                    	return '<a href=\"javascript:void(0)\" onclick=\"toOPenProblemWindow(\''+rowData.manuscript_id+'\',\''+rowData.id+'\');\">'+rowData.audit_con+'</a>';
                            }}
				   	]],
					columns:[[
                         {field:'serial_num',title:'问题编号',align:'center', sortable:true},
                         <s:if test="${projectStartObject.planProcess ne 'simplified'}">
                           {field:'manuscript_name',title:'底稿名称',width:200,halign:'center',align:'left', sortable:true,
  						   formatter:function(value,rowData,rowIndex){
  		                      if(value != null && value != ""){
  			                return '<a href=\"javascript:void(0)\" onclick=\"toOPenWindow(\''+rowData.manuscript_id+'\');\">'+value+'</a>';
  		                    }		
                             }},
                             {field:'taskName',title:'审计事项',sortable:true, align:'center'},
                          {field:'digao_state',title:'底稿状态',sortable:true, align:'center'},
  					   </s:if>
  						{field:'problem_all_name',title:'问题类别', width:250,halign:'center',align:'left',sortable:true},
						{field:'problem_name',title:'问题点', width:250,halign:'center',align:'left',sortable:true},
						{field:'problem_money',title:'涉及金额（万元）',width:120,halign:'center',align:'right',sortable:true,
                            formatter:function(value,rowData,rowIndex){
								if (value != null) {
									value=  (parseFloat(value).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
									//return value +"/万元";
									return value;
								}
                			}
						},
						{field:'problemCount',title:'发生数量',width:100,sortable:true,halign:'center',align:'right',
                            formatter:function(value,rowData,rowIndex){
								if (value == null) {
									return '0';
								}else{
									return value;
								}
                			}
						},
						{field:'ofsDetail',title:'重要程度', width:100,halign:'center',align:'center',sortable:true},
						{field:'lp_owner',title:'问题发现人', width:100,halign:'center',align:'left',sortable:true},
						{field:'isInReport',title:'是否整改',align:'center',sortable:true,
							formatter:function(value,rowData,rowIndex){
						    	if(value == ''){
						    	    return '否';
								}
								return value;
							}
						},
						{field:'remarks', title:'整改说明',width:100,halign:'center',align:'left',sortable:true,hidden:true},
						{field:'isToReport',title:'是否入报告',align:'center',sortable:true,
                            formatter:function(value,rowData,rowIndex){
                                if(value == ''){
                                    return '否';
                                }
                                return value;
                            }
                        },
						{field:'reportRemarks', title:'入报告说明',width:100,halign:'center',align:'left',sortable:true,hidden:true}
					]]  
				});
				//单元格tooltip提示
				$('#ledgerProblemList').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
			});

			function doSearch(){
	        	$('#ledgerProblemList').datagrid({
	    			queryParams:form2Json('searchForm')
	    		});
	    		$('#dlgSearch').dialog('close');
	        }
			function restal(){
				resetForm('searchForm');
			}
			function doCancel(){
				$('#dlgSearch').dialog('close');
			}
			//调整问题编号
			function changeLedgerNum(){
				var rows = $('#ledgerProblemList').datagrid('getChecked');
				var project_id = '${project_id}';
				if(rows.length == 1){
					$.ajax({
						   type: "POST",
						   url: "/ais/proledger/problem/editSerialNum.action",
						   data: {"project_id":project_id,"id":rows[0].id},
						   success: function(data){
							   if(data.flag == '1'){
								 	//打开调整问题窗口
									$('#sendBack_div').window('open');
									
									document.getElementById('acode').innerHTML=data.acode;
									$('#acodes').val(data.acode);
									//$('#ayear').val(data.ayear);
									$('#ashu').val(data.ashu);
									$('#project_id').val(data.project_id);
									$('#projectType').val(data.projectType);
								 	
									//关闭窗口
									$('#closeWinSjyd').bind('click',function(){
										$('#sendBack_div').window('close');
									})
								//	$('#serial_num').val(rows[0].serial_num);
									$('#ledgerProblem_id').val(rows[0].id);
							   }else{
								   showMessage1("只有组长，主审和项目领导有权限操作!");
							   }
						   }
	            	
	            	});	
					
				}else{
					$.messager.show({
						title:"提示信息",
						msg:"请选择一条数据进行操作！",
						timeout:5000,
						showType:'slide'
					});
				}
				
			}
			$('#sendId').bind('click',function(){
				var project_id = $('#project_id').val();
				var projectType = $('#projectType').val();
				var id = $('#ledgerProblem_id').val();
				var acode=document.getElementById("acodes").value;
				
				/* if("" == $.trim($('#ayear').val())){
					$.messager.show({
						title:"提示信息",
						msg:"问题编号年度不能为空！",
						timeout:5000,
						showType:'slide'
					});
					return;
				} */
				if("" == $.trim($('#ashu').val())){
					$.messager.show({
						title:"提示信息",
						msg:"问题编号编号不能为空！",
						timeout:5000,
						showType:'slide'
					});
					return;
				}
				var  vatest=/^[0-9]*[1-9][0-9]*$/;
				/* var year= vatest.test($.trim($('#ayear').val()));
				if(!year){
					$.messager.show({
						title:"提示信息",
						msg:"年度输入必须为整数数字！",
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
				      
				if($.trim($('#ayear').val()).length != 4 ){
					$.messager.show({
						title:"提示信息",
						msg:"年度为4 位数字！",
						timeout:5000,
						showType:'slide'
					});
					return;
				 } */
				var va= vatest.test($.trim($('#ashu').val()));
				if(!va){
				   	$.messager.show({
						title:"提示信息",
						msg:"编号输入必须为整数数字！",
						timeout:5000,
						showType:'slide'
					});
				 	return false;
				}
				var ashu=$.trim($('#ashu').val());
				/* if(ashu.length==1){
				 	ashu='00'+ashu;
				}else if(ashu.length==2){
				 	ashu='0'+ashu;
				}else if(ashu.length>3){
				 	$.messager.show({
						title:"提示信息",
						msg:"编号输入位数必须小于3个！",
						timeout:5000,
						showType:'slide'
					});
				 	return false;
				}
                var changeSerial_num= acode+"-"+$.trim($('#ayear').val())+"-"+ashu; */
				$.ajax({
					dataType:'json',
					url : "/ais/proledger/problem/saveSerialNum.action",
					//data:{"id":id,"ledgerProblem.serial_num":changeSerial_num},
					data:{"id":id,"ledgerProblem.serial_num":ashu},
					type: "POST",
					success: function(data){
	                   	if(data.type == 'ok'){
	                	   window.parent.$.messager.show({
	   						title:"提示信息",
	   						msg:"保存成功！",
	   						timeout:5000,
	   						showType:'slide'
	   					});
					   	window.close();
					   	window.location.reload="/ais/proledger/problem/mainUi.action?projectview=${projectview}&view=process&project_id="+project_id+"&projectType="+projectType;
	                   }else if(data.type == 'rest'){
	                	   window.parent.$.messager.show({
		   						title:"提示信息",
		   						msg:"编号存在！",
		   						timeout:5000,
		   						showType:'slide'
						   });
	                   }else{
	                	   	window.parent.$.messager.show({
		   						title:"提示信息",
		   						msg:"保存失败！",
		   						timeout:5000,
		   						showType:'slide'
							});
	                   }
	               	},
	               	error:function(data){
	            	   	window.parent.$.messager.show({
	   						title:"提示信息",
	   						msg:"请求失败！",
	   						timeout:5000,
	   						showType:'slide'
					   	});
	               	}
				}); 
			});

			$(function(){
				$('#sendBack_div').window({
					width:550,
					height:150,
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
				$('#inReport').window({
					width:500,
					height:200,
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
				$('#toReport').window({
					width:500,
					height:200,
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
				$('#isReportE').combobox({
					onChange:function(newValue,oldValue){
						if(newValue=="否"){
							$("#remarkColour").show();
						}else{
							$("#remarkColour").hide();
						}
					}
				});
				$('#isToReport').combobox({
					onChange:function(newValue,oldValue){
						if(newValue=="否"){
							$("#reportRemarksColour").show();
						}else{
							$("#reportRemarksColour").hide();
						}
					}
				});
			});
			
			//查看
			function viewLedgerOwner(){
				var rows = $('#ledgerProblemList').datagrid('getChecked');
				if(rows.length == 1){
					var viewSjwtUrl  = "${contextPath}/operate/manu/viewAll.action?crudId="+rows[0].manuscript_id+"&interaction=${interaction}";
					/* window.open(viewSjwtUrl); */
					//window.parent.addTab('tabs','查看审计一览问题','tempframe',viewSjwtUrl,true); 
					aud$openNewTab('查看审计一览问题',viewSjwtUrl,true);
				}else{
					$.messager.show({
						title:"提示信息",
						msg:"请选择一条数据进行操作！",
						timeout:5000,
						showType:'slide'
					});
				}
			}

			//原来此功能是是否入报告，后来变成是否整改了。。。各位看官请注意，不要被isInReport这个小妖精迷惑啊。。。
			function inLedgerOwner(){
				var rows = $('#ledgerProblemList').datagrid('getChecked');
				if(rows.length != 0){
					if(rows[0].isInReport == "否"){
						$("#remarkColour").show();
				    }else{
				       $("#remarkColour").hide();
					}
					var selectIds = '';
					var project_id = '${project_id}';
					for(var i=0;i<rows.length;i++){
						var id=rows[i].id;
			        	selectIds = selectIds + id +',';
					}
					$.ajax({
						   type: "POST",
						   url: "${contextPath}/proledger/problem/checkinReportCondition.action",
						   data: {"ids":selectIds},
						   success: function(returnValue){
						   		if(returnValue=='2'){
						   			showMessage1("所选底稿中存在未复核完毕的底稿，只有复核完毕的底稿才能做整改问题设定!");
					            	return;						   			
						   		}else if(returnValue=='3'){
						   			showMessage1("所选底稿中存在已完成问题整改设定的底稿，请重新选择!");
					            	return;
					            }else{
					            	$.ajax({
										type: "POST",
										url: "/ais/proledger/problem/inReportView.action",
										data: {"str":selectIds,"project_id":project_id},
										success: function(msg){
											if(msg == '1'){
												$('#inReport').window('open');
												$('#remarks').val(rows[0].remarks);
												if (rows[0].isInReport == null){
													$('#isReportE').combobox('setValue', "是");
												}else{
													$('#isReportE').combobox('setValue', rows[0].isInReport);
												}

												$('#inReport_id').val(selectIds);
										   	}else{
											   	showMessage1("只有组长，主审和项目领导有权限操作!");
										   	}
										}
					            	});
					            }
						   }
					});
				}else{
					top.$.messager.show({
	            		title:"提示信息",
	            		msg:"请选择一条数据进行操作！",
	            		timeout:5000,
	            		showType:'slide'
	            	});
				}
			}

			//是否整改保存事件
			$('#saveId').bind('click',function(){
				var isReport = $('#isReportE').combobox('getValue');
				var remarks = $('#remarks').val();
				var inReport_id = $('#inReport_id').val(); 
				if(isReport == '否'){
					if($.trim(remarks) == ""){
					 	$.messager.show({
							title:"提示信息",
							msg:"整改说明不能为空,请完善信息!",
							timeout:5000,
							showType:'slide'
						});
						return false;
				 	}
				}
				//ajax实时验证
				$.ajax({
				   type: "POST",
				   url: "${contextPath}/proledger/problem/checkinReportCondition.action",
				   data: {"ids":inReport_id},
				   success: function(returnValue){
						if(returnValue=='2'){
							showMessage1("所选底稿中存在未复核完毕的底稿，只有复核完毕的底稿才能做整改问题设定!");
							return;
						}else{
							$.ajax({
								type: "POST",
								dataType:'json',
								url : "/ais/proledger/problem/doInReport.action",
								data:{
									'ledgerProblem.remarks':remarks,
									'ledgerProblem.isInReport':isReport,
									'str':inReport_id
								},
								success: function(data){
									if(data.type == 'ok'){
										$('#inReport').window('close');
										showMessage2("保存成功！");
										window.location.reload();
									}else{
										showMessage2("保存失败！");
									}
								},
								error:function(data){
									showMessage2("请求失败！");
								}
							});
						}
				   }
				});
			});

			//是否整改关闭按钮
			$('#closeInReport').bind('click',function(){
				$('#inReport').window('close');
			});


			//是否入报告
			function toReport(){
				var rows = $('#ledgerProblemList').datagrid('getChecked');
				if(rows.length != 0){
					if(rows[0].isToReport == "否"){
						$("#reportRemarksColour").show();
					}else{
						$("#reportRemarksColour").hide();
					}
					var selectIds = '';
					var project_id = '${project_id}';
					for(var i=0;i<rows.length;i++){
						var id=rows[i].id;
						selectIds = selectIds + id +',';
					}
					$.ajax({
						type: "POST",
						url: "${contextPath}/proledger/problem/checkinReportCondition.action",
						data: {"ids":selectIds},
						success: function(returnValue){
							if(returnValue=='2'){
								showMessage1("所选底稿中存在未复核完毕的底稿，只有复核完毕的底稿才能做入报告设定!");
								return;
							}else{
								$.ajax({
									type: "POST",
									url: "/ais/proledger/problem/inReportView.action",
									data: {"str":selectIds,"project_id":project_id},
									success: function(msg){
										if(msg == '1'){
											$('#toReport').window('open');
											$('#reportRemarks').val(rows[0].reportRemarks);
											if (rows[0].isToReport == null){
												$('#isToReport').combobox('setValue', "是");
											}else{
												$('#isToReport').combobox('setValue', rows[0].isToReport);
											}

											$('#toReport_id').val(selectIds);
										}else{
											showMessage1("只有组长，主审，项目领导有权限操作!");
										}
									}

								});
							}
						}
					});
				}else{
					top.$.messager.show({
						title:"提示信息",
						msg:"请选择一条数据进行操作！",
						timeout:5000,
						showType:'slide'
					});
				}
			}

			//是否入报告保存事件
			$('#saveToReport').bind('click',function(){
				var isToReport = $('#isToReport').combobox('getValue');
				var reportRemarks = $('#reportRemarks').val();
				var toReport_id = $('#toReport_id').val();
				if(isToReport == '否'){
					if($.trim(reportRemarks) == ""){
						showMessage1("入报告说明不能为空,请完善信息！");
						return false;
					}
				}
				//ajax实时验证
				$.ajax({
					type: "POST",
					url: "${contextPath}/proledger/problem/checkinReportCondition.action",
					data: {"ids": toReport_id},
					success: function(returnValue){
						if(returnValue=='2'){
							showMessage1("所选底稿中存在未复核完毕的底稿，只有复核完毕的底稿才能做入报告设定!");
							return;
						}else{
							$.ajax({
								type: "POST",
								dataType:'json',
								url : "/ais/proledger/problem/doToReport.action",
								data:{
									'ledgerProblem.reportRemarks':reportRemarks,
									'ledgerProblem.isToReport':isToReport,
									'str':toReport_id
								},
								success: function(data){
									if(data.type == 'ok'){
										$('#toReport').window('close');
										showMessage2("保存成功！");
										window.location.reload();
									}else{
										showMessage2("保存失败！");
									}
								},
								error:function(data){
									showMessage2("请求失败！");
								}
							});
						}
					}
				});
			});

			//是否入报告关闭按钮
			$('#closeToReport').bind('click',function(){
				$('#toReport').window('close');
			});

			/*
			$('#planName').window({
				width:500,
				height:200,
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true
			});
			//入报告问题关闭事件
			function closeWin(){
				$('#planName').window('close');
			}
			//入报告问题保存事件
			function saveCloseWin(){
				$('#planName').window('close');
				showMessage1("保存成功！");
			}
			*/
			function expLedgerOwner(){
				var rows = $('#ledgerProblemList').datagrid('getChecked');
				var selectIds = '';
				for(var i=0;i<rows.length;i++){
					var id=rows[i].id;
			        selectIds = selectIds + id +',';
				}
	
				window.open("${contextPath}/proledger/problem/expLedgerProblemList.action?taskId=-1&permission=<%=request.getParameter("permission")%>&isView=${owner}&project_id=<%=request.getParameter("project_id")%>&interaction=${interaction}&selectIds="+selectIds,"","height=700px, width=800px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
			}

			function toOPenWindow(id){
				var viewSjwtUrl11  = "${contextPath}/operate/manu/viewAll.action?crudId="+id+"&interaction=${interaction}&view=${param.view}";
				//window.parent.addTab('tabs','查看审计底稿','tempframe',viewSjwtUrl11,true);
				aud$openNewTab('查看审计底稿',viewSjwtUrl11,true);
			}

			// 查看问题
			function toOPenProblemWindow(manuscript_id,problemId){
				var viewSjwtUrl  = "${contextPath}/proledger/problem/view.action?manuscript_id="+manuscript_id+"&&isView=true&id="+problemId +"&interaction=${interaction}&project_id=<%=request.getParameter("project_id")%>";
				//window.parent.addTab('tabs','查看问题','tempframe',viewSjwtUrl,true);
				aud$openNewTab('查看问题',viewSjwtUrl,true);
			}

			//增加审计问题
			function addLedgerOwner(){
				var addSjwtUrl  = '${contextPath}/proledger/problem/editDigao.action?project_id=${projectStartObject.formId}&id=0';
				aud$openNewTab('审计问题-新增',addSjwtUrl,true);
			}

			//修改审计问题
			function editLedgerOwner(){
				var rows = $('#ledgerProblemList').datagrid('getChecked');
				if(rows.length == 1){
					var editSjwtUrl = '${contextPath}/proledger/problem/editDigao.action?project_id=${projectStartObject.formId}&id='+rows[0].id;
					aud$openNewTab('审计问题-修改',editSjwtUrl,true);
				}else{
					$.messager.alert("提示信息","请选择一条数据进行操作！","info");
				}
			}

			//删除审计问题
			function delLedgerOwner(){
				var rows = $('#ledgerProblemList').datagrid('getChecked');
				var selectIds = "";
				if(rows.length != 0){
					$.messager.confirm("提示信息","确认删除这 "+rows.length+" 条数据吗？",function(r){
						if(r){
							for(var i=0;i<rows.length;i++){
								var id = rows[i].proLedgerProblem_id;
								selectIds = selectIds + id +',';
							}
							$.ajax({
								type: "POST",
								dataType:'json',
								url : "/ais/proledger/problem/delLedgerProblem.action",
								data:{ "ids":selectIds,'manuscriptType':'digao'},
								success: function(data){
									if(data.type == 'ok'){
										showMessage2('删除成功','提示信息',5000,'slide');
										$('#ledgerProblemList').datagrid('reload');
										$('#ledgerProblemList').datagrid('uncheckAll');
									}else{
										showMessage2('删除失败','提示信息',5000,'slide');
									}
								},
								error:function(data){
									showMessage2('请求失败！');
								}
							});
						}
					});
				}else{
					$.messager.alert("提示信息","请选择一条数据进行操作！","info");
				}
			}
		</script>
	</body>
</html>