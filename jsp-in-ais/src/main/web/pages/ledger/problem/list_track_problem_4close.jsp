<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题整改跟踪关闭列表</title>
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
		<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
				<s:form name="myform" id="myform" action="closeProblemList" namespace="/proledger/problem" method="post">
					<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr >
							<td class="EditHead" style="width:15%">
								是否关闭
							</td>
							<td class="editTd" style="width:35%">
								<select editable="false" data-options="panelHeight:'auto'" class="easyui-combobox" name="middleLedgerProblem.is_closed" style="width:80%">
									<option value="">&nbsp;</option>
									<s:iterator value="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" id="entry">
										 <option selected ="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:iterator>
								</select>
							</td>

							<td class="EditHead" style="width:15%">
								项目名称
							</td>
							<td class="editTd" style="width:35%">
								<s:textfield name="middleLedgerProblem.project_name" maxlength="50" cssStyle="width:80%" cssClass="noborder"/>
							</td>
						</tr>
						<tr>
							<td class="EditHead">
								审计单位
							</td>
							<td class="editTd">
								<s:buttonText2 name="middleLedgerProblem.audit_dept_name" cssClass="noborder"
									hiddenName="middleLedgerProblem.audit_dept" cssStyle="width:80%"
									doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										  title:'请选择审计单位',
		                                  param:{
		                                    'p_item':3
		                                  }
										})"
									doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0" readonly="true" />
							</td>
							<td class="EditHead">
								被审计单位
							</td>
							<td class="editTd">
								<s:buttonText2 name="middleLedgerProblem.audit_object_name" cssStyle="width:80%"
									hiddenName="middleLedgerProblem.audit_object" cssClass="noborder"
									doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
		                              cache:false,
									  checkbox:true,
									  title:'请选择被审计单位'
									})"
									doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0" readonly="true" />
							</td>
						</tr>
						<tr >
							<td class="EditHead" >
								问题点
							</td>
							<td class="editTd" colspan="3">
								<s:buttonText id="problem_name" hiddenId="problem_code" cssClass="noborder"
									cssStyle="width:32%" name="middleLedgerProblem.problem_name"
									hiddenName="middleLedgerProblem.problem_code"
									doubleOnclick="showSysTree(this,{
						    				url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
/*						    				param:{
							    				'rootParentId':'0',
												'beanName':'LedgerTemplateNew',
												'treeId'  :'id',
												'treeText':'name',
												'treeParentId':'fid',
												'treeOrder':'orderNO'
											},*/
						    				onlyLeafCheck:true,
						    				title:'请选择问题点'
										})"
									doubleSrc="/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0" readonly="true" />
							</td>
						</tr>
					</table>
				</s:form>
				<s:form id="trackform" name="trackform" action="trackList" namespace="/proledger/problem" method="post" >
					<s:hidden id="crudIdStrings" name="crudIdStrings"/>
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
		<div region="center">
			<table id="list"></table>
		</div>
		<div id="planName" title="项目基本信息" style="overflow:hidden;padding:0px">
            <iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
	  	<div id="viewMiddle" title="定稿问题查看" style="overflow:hidden;padding:0px">
	            <iframe id="openViewMiddle" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
	  	<div id="trackList" title="审计问题整改跟踪列表" style="overflow:hidden;padding:0px">
	            <iframe id="openTrackList" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
		<script type="text/javascript">
			function assignTracker(){
				var rows =$('#list').datagrid('getSelections');
				if(rows.length>1){
					showMessage1("只能选择一条数据！");
					return false;
				}else if(rows.length>0){
					crudIdStrings = rows[0].id+',';
					//alert(crudIdStrings);
				    $('#crudIdStrings').val(crudIdStrings);
				    return true;				
				}else{
				    showMessage1('请选择一条审计问题！');
			        return false;
				}
			}
			$(function(){
				showWin('dlgSearch');
				//$('body').layout('collapse','north');
                datagrid=$('#list').datagrid({
					url : "<%=request.getContextPath()%>/proledger/problem/closeProblemList.action?querySource=grid",
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					//width:'100%',
					//height:'70%',
					fit:true,
					fitColumns:false,
					//idField:'crudIds',
					border:false,
					singleSelect:true,
					pageSize: 20,
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
						id:'close_track',
						text:'关闭',
						iconCls:'icon-cancel',
						handler:function(){
							if(assignTracker()){
								$.messager.confirm('确认','确定关闭吗？', function(r){
									if(r){
                                        var selectedRows = $('#list').datagrid('getChecked');
									    if(selectedRows[0].f_mend_opinion_name == null ){
                                            $.messager.show({title:'提示信息',msg:'未整改跟踪的问题不允许关闭!'});
                                            return;
										}
                                        if(selectedRows[0].is_closed == '是'){
                                            $.messager.show({title:'提示信息',msg:'该问题已经关闭，不要重复关闭!'});
                                            return;
                                        }
                                        if(selectedRows[0].closer_name == null){
                                            $.messager.show({title:'提示信息',msg:'该问题没有关闭人，不能关闭!'});
                                            return;
										}
										if(selectedRows[0].closer_name != '${user.fname}'){
                                            $.messager.show({title:'提示信息',msg:'该问题的关闭人不是当前登录人，不能关闭!'});
                                            return;
										}
										var crudIdStrings = $('#crudIdStrings').val();
										$.ajax({
											dataType:'json',
											url : "${contextPath}/proledger/problem/closeProblem.action",
											data: {'crudIdStrings':crudIdStrings},
											type: "POST",
											success: function(data){
												showMessage1('关闭成功！');
												$('#list').datagrid('reload');
											},
											error:function(data){
												showMessage1('请求失败！');
											}
										});
									}
								});
							}
						}
					},'-',
					{
						id:'cancel_close_track',
						text:'恢复',
						iconCls:'icon-recover',
						handler:function(){
							if(assignTracker()){
								var selectedRows = $('#list').datagrid('getChecked');
								if(selectedRows[0].is_closed == '是'){
									$.messager.confirm('确认','确定将当前问题恢复到未关闭状态吗？', function(r){
										if(r){
											var crudIdStrings = $('#crudIdStrings').val();
											$.ajax({
												dataType:'json',
												url : "${contextPath}/proledger/problem/closeProblem.action",
												data: {'crudIdStrings':crudIdStrings, 'cancelClose':'1'},
												type: "POST",
												success: function(data){
													showMessage1('恢复成功！');
													$('#list').datagrid('reload');
												},
												error:function(data){
													showMessage1('请求失败！');
												}
											});
										}
									});
								}else{
									$.messager.show({title:'提示信息',msg:'该问题未关闭，请选择已经关闭的问题!'});
									return;
								}
							}
						}
					}
					,'-',helpBtn],
					onLoadSuccess:function(){
						initHelpBtn();
						doCellTipShow('close_track');
					},
					frozenColumns:[[
						{field:'crudIds',width:'50px', hidden:true, align:'center'},
						{field:'is_closed',title:'是否关闭',halign:'center',align:'center',sortable:true,
							formatter:function(value ,rowData,rowIndex){
								if(rowData.is_closed=='是'){
									return '是';
								}else{
									return '否';
								}
							}	
						},
						{field:'project_name',title:'项目名称',width:'280px',sortable:true,halign:'center',align:'left',
							formatter:function(value,row,index){
								return '<a href=\"javascript:void(0)\" onclick=\"openMsg(\''+row.project_id+'\');\">'+value+'</a>';
							}
						},
	       				{field:'f_mend_opinion_name',title:'整改状态评价',width:'180px',sortable:true,halign:'center',align:'center',
                            formatter:function(value,rowData,rowIndex){
	       				    	if(value == '未整改'){
									return  ["<label style='cursor:hand;color:red;'>",value,"</label>"].join('') ;
                                }else if(value == '部分整改'){
                                    return  ["<label style='cursor:hand;color:blue;'>",value,"</label>"].join('') ;
								}else{
	       				    	    return value;
								}
                            }
		       			}
					]],
					columns:[[
						{field:'serial_num',
							title:'审计问题编号',
							width:'200px',
							halign:'center',
							align:'left', 
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								//return '<a href="${contextPath}/proledger/problem/viewMiddle.action?id='+rowData.id+'" target="_blank" >'+value+'</a>';
								return '<a href=\"javascript:void(0)\" onclick=\"openViewMiddle(\''+rowData.id+'\');\">'+value+'</a>';
							}
						},
						{
							field:'audit_con',
							title:'问题标题',
							width:200,
							halign:'center',
							align:'left',
							sortable:true
						},
						/*{field:'creater_date',
							title:'问题所属期间',
							sortable:true,
							halign:'center', 
							align:'left'
						},*/
						{field:'sort_big_name',
							title:'问题类别',
							halign:'center',
							align:'left', 
							sortable:true
						},
						{field:'problem_name',
							title:'问题点',
							width:200,
							halign:'center', 
							align:'left', 
							sortable:true
						},
						{field:'problem_money',
							title:'涉及金额（万元）',
							halign:'center',
							align:'right',
							sortable:true
							,formatter:aud$gridFormatMoney
						},
						{field:'problemCount',
							title:'发生数量（个）',
							halign:'center',
							align:'right',
							sortable:false
							,formatter:function (value,rowData,rowIndex) {
								if (value == null){
									return '0';
								}else{
									return value;
								}
							}
						},
						{field:'audit_object_name',
							title:'被审计单位',
							width:200, 
							halign:'center',
							align:'left', 
							sortable:true
						},
						{field:'audit_dept_name',
							title:'审计单位',
							width:200,
							halign:'center', 
							align:'left', 
							 sortable:true
						},	 
						{field:'mend_term_date',
							title:'整改期限',
							halign:'center',
							align:'right', 
							sortable:true
						},
					/* 	{field:'zeren_dept',
							title:'整改责任部门',
							width:100,
							halign:'center', 
							align:'left', 
							sortable:true
						}, */
						{field:'zeren_company',
							title:'责任单位',
							width:100,
							halign:'center', 
							align:'left', 
							sortable:true
						},
					/* 	{field:'zeren_person',
							title:'整改负责人',
							halign:'center',
							align:'left', 
							sortable:true
						},
						{field:'mend_method',
							title:'整改方式',
							width:100,
							halign:'center', 
							align:'left', 
							sortable:true
						},
						{field:'examine_method',
							title:'检查方式',
							width:100,
							halign:'center', 
							align:'left', 
							sortable:true
						}, */
						{field:'tracker_name',
							title:'跟踪人',
							halign:'center',
							align:'left', 
							sortable:true
						},
						{field:'track_num',
							title:'跟踪记录',
							halign:'center',
							align:'center',
							sortable:false,
							formatter:function(value,rowData,rowIndex){
								//return '<a href="${contextPath}/proledger/problem/trackList.action?crudIdStrings='+rowData.id+'&onlyView='+true+'" target="_blank" >'+value+'</a>';
								return '<a href=\"javascript:void(0)\" onclick=\"openTrackList(\''+rowData.id+'\');\">'+value+'</a>';
							}
						}	 
					]] 
				}); 
				$('#close_track').bind('click',function(){});
	/* 			//单元格tooltip提示
				$('#list').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					onlyShowInterrupt:true,
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				}); */
			});
           /*
		    * 查询
		    */
			function doSearch(){
				/*$('#list').datagrid({
                    querySource:form2Json('myform')
				});*/
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
		    function openMsg(projectid){
				//var viewUrl = "${contextPath}/proledger/problem/viewPro.action?crudId="+projectid;
				var viewUrl = "${contextPath}/plan/detail/view.action?startId="+projectid;
                $('#showPlanName').attr("src",viewUrl);
                $('#planName').window('open');
			}
			$('#planName').window({
				width:950, 
				height:450,  
				modal:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true    
			});
		
			function openViewMiddle(id){
				var openViewUrl = "${contextPath}/proledger/problem/viewMiddle.action?id="+id;
				$('#openViewMiddle').attr("src",openViewUrl);
				$('#viewMiddle').window('open');
			}
			$('#viewMiddle').window({
				width:950, 
				height:450,  
				modal:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true    
			});
			function openTrackList(id){
				var openViewUrl = "${contextPath}/proledger/problem/trackList.action?crudIdStrings="+id+"&onlyView=true";
				$('#openTrackList').attr("src",openViewUrl);
				$('#trackList').window('open');
			}
			$('#trackList').window({
				width:950, 
				height:450,  
				modal:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true    
			});
		</script>
	</body>
</html>
