<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>审计问题分配列表</title>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
     	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="list_decide_seac" class="searchWindow">
		<div class="search_head">
		<s:form name="myform"  id ="myform" action="decideProblemListView" namespace="/proledger/problem" method="post">
			<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width:15%">是否关闭</td>
					<td class="editTd" style="width:35%">
						<!--<s:select theme="ufaud_simple" templateDir="/strutsTemplate"  cssClass="easyui-combobox"
						 name="middleLedgerProblem.is_closed" list="#@java.util.LinkedHashMap@{'是':'是','否':'否'}"
						  listKey="key" listValue="value" emptyOption="true" />-->
						 <select editable="false" class="easyui-combobox" name="middleLedgerProblem.is_closed" data-options="panelHeight:'auto'" style="width:80%" >
							<option value="">&nbsp;</option>
							<s:iterator value="#@java.util.LinkedHashMap@{'是':'是','否':'否'}" id="entry">
								 <option value="<s:property value="key"/>"><s:property value="value"/></option>
							</s:iterator>
						</select> 
					</td >
					<td class="EditHead">项目年度</td>
					<td class="editTd">
						<select id="w_plan_year" class="easyui-combobox" style="width:80%" name="middleLedgerProblem.pro_year"  editable="false">
							<option value="">&nbsp;</option>
							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,10)" id="entry">
								<s:if test="${middleLedgerProblem.pro_year == key}">
									<option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:if>
								<s:else>
									<option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:else>
							</s:iterator>
						</select>
					</td>

				</tr>
				<tr>
					<td class="EditHead">跟踪人</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="middleLedgerProblem.tracker_name" maxlength="50" cssStyle="width:80%"/>
					</td>
					<td class="EditHead">关闭人</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="middleLedgerProblem.closer_name" maxlength="50" cssStyle="width:80%"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:15%">项目名称</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="middleLedgerProblem.project_name" maxlength="50" cssStyle="width:80%"/>
					</td>
					<td class="EditHead" style="width:15%">项目编号</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="middleLedgerProblem.project_code" maxlength="50" cssStyle="width:80%"/>
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计单位</td>
					<td class="editTd">
						<s:buttonText2 name="middleLedgerProblem.audit_dept_name" cssClass="noborder" cssStyle="width:80%"
							hiddenName="middleLedgerProblem.audit_dept" doubleOnclick="showSysTree(this,
									{url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
           											title:'请选择审计单位',
                             						param:{
                               							'p_item':3
                             								},
                              						checkbox:true
         											})"
							doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
					<td class="EditHead">被审计单位</td>
					<td class="editTd">
						<s:buttonText2 name="middleLedgerProblem.audit_object_name" cssClass="noborder" cssStyle="width:80%"
							hiddenName="middleLedgerProblem.audit_object"
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
				<tr>
					<td class="EditHead">问题类别</td>
					<td class="editTd">
						<s:buttonText  id="problems" hiddenId="middleLedgerProblem.sort_big_code" cssClass="noborder" cssStyle="width: 80%"
									   name="middleLedgerProblem.sort_big_name"
									   hiddenName="middleLedgerProblem.sort_big_code"
									   doubleOnclick="showSysTree(this,{
								url:'${contextPath}/plan/detail/problemCategoryTree.action',
								//onlyLeafCheck:true,
								title:'请选择问题类别'
							})"
									   doubleSrc="/resources/images/s_search.gif"
									   doubleCssStyle="cursor:hand;border:0" readonly="true" />
					</td>
					<td class="EditHead">问题点</td>
					<td class="editTd">
						<s:buttonText id="problem_name" hiddenId="problem_code" cssClass="noborder" cssStyle="width:80%"
						    name="middleLedgerProblem.problem_name"
							hiddenName="middleLedgerProblem.problem_code"
							doubleOnclick="showSysTree(this,{
									url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
/*				    				param:{
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
			<s:hidden id="crudIdStrings" name="crudIdStrings"/>
		</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#list_decide_seac').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center">
			<table id="list"></table>
	</div>
	<div id="lrsjyd_div" title="分配跟踪人" style='overflow:hidden;padding:0px;'> 	  		
     		<form id='lrsjyd_form' name='sjsx_form' method="POST" style='height:150px;overflow-y:auto;padding:10px;margin:0px;border:1px solid #cccccc;' >
		        <table class="ListTable" align="center" >
		        	<tr>
		        		<td class='edithead' ><font style='color:red'>*</font>&nbsp;问题跟踪人</td>
		        		<td class='editTd' colspan=3>
		        			<s:buttonText2 id="tracker_name" hiddenId="tracker_code" cssClass="noborder"
								name="middleLedgerProblem.tracker_name" 
								hiddenName="middleLedgerProblem.tracker_code"
								doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
	                                  param:{
	                                     'p_item':1,
	                                     'orgtype':1
	                                  },
	                                  title:'请选择问题跟踪人',
	                                  type:'treeAndEmployee',
	                                  defaultDeptId:'${user.fdepid}'
									})"  
								doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0"
								readonly="true"
								maxlength="500" title="问题跟踪人"/>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class='edithead' ><font style='color:red'>*</font>&nbsp;跟踪整改结果提醒时间</td>
		        		<td class='editTd' colspan=3>
		        			<input class="noborder" type='text' id='tracker_date'  name='middleLedgerProblem.tracker_date' onclick='calendar()' readOnly style='width:84px;'>
		        		</td>
		        	</tr>
		        </table>
     		</form>
    		<div style='text-align:center;' id='trackBtnDiv' style='padding:15px;'>
	       		<button  id='saveSjyd'     class="easyui-linkbutton"  iconCls="icon-save">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
	       		<button  id='closeWinSjyd' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</button>							        
		    </div>
   </div>
    <div id="closer_div" title="分配关闭人" style='overflow:hidden;padding:0px;'> 	  		
      		<form id='closer_form' name='closer_form' method="POST" style='height:150px;overflow-y:auto;padding:10px;margin:0px;border:1px solid #cccccc;' >
			        <table class="ListTable" align="center" >
			        	<tr>
			        		<td class='edithead' ><font style='color:red'>*</font>&nbsp;问题关闭人</td>
			        		<td class='editTd' colspan=3>
			        			<s:buttonText2 id="closer_name" hiddenId="closer_code" cssClass="noborder"
									name="middleLedgerProblem.closer_name" 
									hiddenName="middleLedgerProblem.closer_code"
									doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
		                                  param:{
		                                     'p_item':1,
		                                     'orgtype':1
		                                  },
		                                  title:'请选择问题关闭人',
		                                  type:'treeAndEmployee',
		                                  defaultDeptId:'${user.fdepid}'
										})"  
									doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0"
									readonly="true"
									maxlength="500" title="问题关闭人"/>
			        		</td>
			        	</tr>
			        </table>
      		</form>
     		<div style='text-align:center;' id='closeBtnDiv' style='padding:15px;'>
        		<button  id='saveCloser'     class="easyui-linkbutton"  iconCls="icon-save">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
        		<button  id='closeWinCloser' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</button>							        
		    </div>
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
			function exportExcel(){
				var rows = $('#list').datagrid("getChecked");
	            var ids = "";
				if (rows.length > 0) {
					 for (var i = 0; i < rows.length; i++) {
						 ids +=rows[i].id+",";
					} 
					document.getElementById('myform').action = "<%=request.getContextPath()%>/proledger/problem/exportDecideProblemList.action?ids="+ids;
					$('#myform').submit();
				}else{
					showMessage1('请先勾选需要导出的整改问题');
				} 
			}
			
			
			function exportExcelAll(){
				document.getElementById('myform').action = "<%=request.getContextPath()%>/proledger/problem/exportDecideProblemList.action";
				$('#myform').submit();
			}
	    	//查询
			showWin('list_decide_seac');
	    	var bodyW = $('body').width();
	    	$(function(){
				//$('body').layout('collapse','north');
				$('#list').datagrid({
					url : "<%=request.getContextPath()%>/proledger/problem/decideProblemListView.action?querySource=grid",
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					//width:'100%',
					//height:'70%',
					fit:true,
					idField:'id',	
					border:false,
				//	singleSelect:true,
				//    checkbox:true,
					pageSize: 20,
					remoteSort: false,
					toolbar:[{
								id:'searchObj',
								text:'查询',
								iconCls:'icon-search',
								handler:function(){
									searchWindShow('list_decide_seac');
								}
							},'-',
							{
								id:'toExcel',
								text:'勾选导出',
								iconCls:'icon-export',
								handler:function(){
									exportExcel();
								}
							},'-',
	                        {
	                            id:'toExcel',
	                            text:'导出全部',
	                            iconCls:'icon-export',
	                            handler:function(){
	                                exportExcelAll();
	                            }
	                        },'-',helpBtn
							],
					onLoadSuccess:function(){
						initHelpBtn();
						doCellTipShow('list');
					},
					frozenColumns:[[
					       		//	{field:'crudIds',width:bodyW * 0.05 + 'px', hidden:true, align:'center'},
					       		    {field:'id',checkbox:true,halign:'center', align:'center',title:'选择'},
					       			{field:'is_closed',title:'是否关闭',width:'80px',align:'center',sortable:true,
					       					formatter:function(value ,rowData,rowIndex){
					       						if(rowData.is_closed=='是'){
						       						return '是';
						       					}else{
						       						return '否';
						       					}
					       					}	
					       				},
					       			{field:'project_name',title:'项目名称',width:bodyW * 0.1 + 'px',sortable:true,halign:'center',align:'left',
					       				formatter:function(value,row,index){
											 return '<a href=\"javascript:void(0)\" onclick=\"openMsg(\''+row.project_id+'\');\">'+value+'</a>';
										 }
					       			},
					       			{field:'f_mend_opinion_name',title:'整改状态评价',width:bodyW * 0.1 + 'px',sortable:true,halign:'center',align:'center',

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
								width:bodyW * 0.08 + 'px',
								halign:'center',
								align:'left',
								sortable:true,
								formatter:function(value,rowData,rowIndex){
									//return '<a href="${contextPath}/proledger/problem/viewMiddle.action?id='+rowData.id+'" target="_blank" >'+value+'</a>';
									return '<a href=\"javascript:void(0)\" onclick=\"openViewMiddle(\''+rowData.id+'\');\">'+value+'</a>';
						}},
						{field:'audit_con',
							title:'问题标题',
							sortable:true,
							width:bodyW * 0.08 + 'px',
							halign:'center',
							align:'left'
						},
						{field:'describe',
							title:'问题描述',
							sortable:true,
							width:bodyW * 0.08 + 'px',
							halign:'center',
							align:'left'
						},
						/*{field:'creater_date',
							title:'问题所属期间',
							sortable:true, 
							width:bodyW * 0.08 + 'px',
							halign:'center',
							align:'left'
						},*/
						{field:'sort_big_name',
							 title:'问题类别',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'left',
							 sortable:true
						},
						{field:'problem_name',
							 title:'问题点',
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },
						{field:'problem_money',
							 title:'涉及金额（万元）',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'right',
							 sortable:true
							,formatter:aud$gridFormatMoney
							 },
						{field:'problemCount',
							 title:'发生数量（个）',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'right',
							 sortable:true
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
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },
						{field:'audit_dept_name',
							 title:'审计单位',
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },	 
						{field:'mend_term_date',
							 title:'整改期限',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'left',
							 sortable:true
							 },
					/* 	{field:'zeren_dept',
							 title:'整改责任部门',
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 }, */
						{field:'zeren_company',
							 title:'责任单位',
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'left', 
							 sortable:true
					 		 },
						/*{field:'zeren_person',
							 title:'整改负责人',
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },
						{field:'mend_method',
							 title:'整改方式',
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },
						{field:'examine_method',
							 title:'检查方式',
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 }, */
						{field:'tracker_name',
							 title:'跟踪人',
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },
						{field:'closer_name',
							 title:'关闭人',
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'left', 
							 sortable:true
							 },
						{field:'track_num',
							 title:'跟踪记录',
							 width:bodyW * 0.08 + 'px',
							 halign:'center', 
							 align:'center',
							 sortable:false,
							 formatter:function(value,rowData,rowIndex){
									//return '<a href="${contextPath}/proledger/problem/trackList.action?crudIdStrings='+rowData.id+'&onlyView='+true+'" target="_blank" >'+value+'</a>';
									return '<a href=\"javascript:void(0)\" onclick=\"openTrackList(\''+rowData.id+'\');\">'+value+'</a>';
						}}
							 
					]] 
				});

			});
			function doSearch(){
				$('#list').datagrid({
					queryParams:form2Json('myform')
				});
				$('#list_decide_seac').dialog('close');
			}
			function restal(){
				resetForm('myform');
				/*doSearch();*/
			}
	    </script>
	     <script type="text/javascript">
			// 初始化
			$(function(){
				document.getElementsByName("middleLedgerProblem.audit_dept_name")[0].value = "${user.fdepname}";
				document.getElementsByName("middleLedgerProblem.audit_dept")[0].value = "${user.fdepid}";
				$('#lrsjyd_div').window({   
					width:500,   
					height:250,   
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
				// 打开录入窗口时，清空录入框
				$('#assign_tracker').bind('click',function(){
					if(assignTracker()){
						$('#lrsjyd_div').window('open');
						clearTrackerDiv();
					}
				});
				// 关闭录入窗口
				$('#closeWinSjyd').bind('click',function(){
					$('#lrsjyd_div').window('close');
				});
				
				// 清空分配跟踪人表单
				function clearTrackerDiv(){
					var arr = ['tracker_name','tracker_code','tracker_date'];
					$.each(arr, function(i, ele){
						$('#'+ele).val('');
					});
					var num=Math.random();
					var rnm=Math.round(num*9000000000+1000000000);
				}
				
				// 保存跟踪人
				$('#saveSjyd').bind('click',function(){
					var crudIdStrings = $('#crudIdStrings').val();
					$.ajax({
						dataType:'json',
						url : "${contextPath}/proledger/problem/saveTracker.action?crudIdStrings="+crudIdStrings,
						data: $('#lrsjyd_form').serialize(),
						type: "POST",
						success: function(data){
							$.messager.alert('提示信息','保存成功！','info');
						},
						error:function(data){
							$.messager.alert('提示信息','请求失败！','error');
						}
					});
				});
				
				$('#closer_div').window({   
					width:500,   
					height:250,   
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				});
				// 打开录入窗口时，清空录入框
				$('#assign_closer').bind('click',function(){
					if(assignTracker()){
						$('#closer_div').window('open');
						clearCloserDiv();
					}
				});
				
				// 清空分配关闭人表单
				function clearCloserDiv(){
					var arr = ['closer_name','closer_code'];
					$.each(arr, function(i, ele){
						$('#'+ele).val('');
					});
					var num=Math.random();
					var rnm=Math.round(num*9000000000+1000000000);
				}
				// 关闭录入窗口
				$('#closeWinCloser').bind('click',function(){
					$('#closer_div').window('close');
				});
				$('#saveCloser').bind('click',function(){
					var crudIdStrings = $('#crudIdStrings').val();
					$.ajax({
						dataType:'json',
						url : "${contextPath}/proledger/problem/saveCloser.action?crudIdStrings="+crudIdStrings,
						data: $('#closer_form').serialize(),
						type: "POST",
						success: function(data){
							$.messager.alert('提示信息','保存成功！','info');
						},
						error:function(data){
							$.messager.alert('提示信息','请求失败！','error');
						}
					});
				});
			});
			
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
			function assignTracker(){
				if($("input[name='id']:checkbox:checked").length>0){
				      var crudIdStrings = '';
				      $("input[name='id']:checkbox:checked").each(function(){
				      		crudIdStrings += $(this).val()+',';
				      })
				      $('#crudIdStrings').val(crudIdStrings);
				      return true;
				}else{
				      alert('没有选择审计问题');
				      return false;
				}
			}
			function cleanForm(){
				document.getElementsByName("middleLedgerProblem.project_code")[0].value = "";
				document.getElementsByName("middleLedgerProblem.audit_object")[0].value = "";
				document.getElementsByName("middleLedgerProblem.audit_object_name")[0].value = "";
				document.getElementsByName("middleLedgerProblem.is_closed")[0].value = "";
				document.getElementsByName("middleLedgerProblem.audit_dept_name")[0].value = "";
				document.getElementsByName("middleLedgerProblem.audit_dept")[0].value = "";
				document.getElementsByName("middleLedgerProblem.problem_name")[0].value = "";
				document.getElementsByName("middleLedgerProblem.problem_code")[0].value = "";
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
