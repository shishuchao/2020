<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目计划列表(项目启动)</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
     	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	</head>
	<script type="text/javascript">
		function chooseSub(){
			if(${userRole=='DUDAO'}&& ${type=='edit'}){//督导项目
				selectForm.action="${pageContext.request.contextPath}/plan/detail/listDetailStart.action?userRole=DUDAO&yearFormId=${yearFormId}&type=edit'";
			}else if(${type=='edit'}){//任务分配
				selectForm.action="${pageContext.request.contextPath}/plan/detail/listDetailStart.action?yearFormId=${yearFormId}&type=edit";
			}else if(${type=='view'}){//年度计划查看
				selectForm.action="${pageContext.request.contextPath}/plan/detail/listDetailStart.action?crudObject.w_plan_year=${crudObject.w_plan_year}&crudObject.year_id=${crudObject.year_id}&type=view'";
			}else{
				selectForm.action="${pageContext.request.contextPath}/plan/detail/listDetailStart.action?module=${module}'";
			}
			selectForm.submit();
		}
	</script>
	<body>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
			<s:form name="searchForm" id="searchForm" action="listDetailStart" namespace="/plan/detail">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<%--<td class="EditHead">
							计划状态
						</td>
						<td class="editTd">
							 <select editable="false" readonly="true" id="status" class="easyui-combobox" name="crudObject.status" style="width:150px;" >
							   <option value="">&nbsp;</option>
							   <s:iterator value="@ais.plan.constants.PlanState@planStateCodeNameMap" id="entry">
								 <option value="<s:property value="key"/>"><s:property value="value"/></option>
							   </s:iterator>
							</select>
						</td>--%>
							<td class="EditHead">计划年度</td>
							<td class="editTd">
								<select editable="false" id="plan_year" class="easyui-combobox" style="width:150px;" editable="false" panelHeight="200">
									<option value="">&nbsp;</option>
									<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:iterator>
								</select>
								<input type="hidden" name="crudObject.w_plan_year" id="w_plan_year"/>
							</td>
						<td class="EditHead">
							项目编号
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="crudObject.w_plan_code"  maxlength="50" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							计划月度
						</td>
						<td class="editTd">
							 <select editable="false" class="easyui-combobox" name="crudObject.w_plan_month" style="width:150px;" >
								   <option value="">&nbsp;</option>
								   <s:iterator value="{'1','2','3','4','5','6','7','8','9','10','11','12'}" id="entry">
									 <option value="${entry }">${entry }</option>
								   </s:iterator>
							</select>

						</td>
<%--						<td class="EditHead">
							执行月度
						</td>
						<td class="editTd">
							 <select editable="false" class="easyui-combobox" name="crudObject.w_plan_excute_month" style="width:150px;" >
								   <option value="">&nbsp;</option>
								   <s:iterator value="{'1','2','3','4','5','6','7','8','9','10','11','12'}" id="entry">
									 <option value="${entry }">${entry }</option>
								   </s:iterator>
							</select>
						</td>--%>
						<td class="EditHead">
							项目名称
						</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="crudObject.w_plan_name"  maxlength="50" />
						</td>
					</tr>
					<tr>
						<td class="EditHead">
							计划类别
						</td>
						<td class="editTd" colspan="3">
							<select editable="false" class="easyui-combobox" name="crudObject.w_plan_type_name" style="width:150px;">
								   <option value="">&nbsp;</option>
								   <s:iterator value="{'年度计划','临时计划'}" id="entry">
									 <option value="${entry }">${entry }</option>
								   </s:iterator>
							</select>
						</td>
					</tr>
<%--					<tr>
						<td class="EditHead">
							审计单位
						</td>
						<td class="editTd">
							<s:buttonText2 id="crudObject.audit_dept_name"
								 cssClass="noborder" name="crudObject.audit_dept_name"
								hiddenName="crudObject.audit_dept"
								hiddenId="crudObject.audit_dept"
								doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									  title:'审计单位',
									  param:{
										'p_item':1,
										'orgtype':1
									  }
									})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" maxlength="50" />
						</td>
						<td class="EditHead">
							项目组长
						</td>
						<td class="editTd">
							<s:buttonText2 id="crudObject.pro_teamleader_name"
								 cssClass="noborder" name="crudObject.pro_teamleader_name"
								hiddenId="crudObject.pro_teamleader"
								hiddenName="crudObject.pro_teamleader"
								doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									  param:{
										 'p_item':1,
										 'orgtype':1
									  },
									  title:'请选择负责人',
									  type:'treeAndEmployee'
									})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" maxlength="50" />
						</td>
					</tr>--%>
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

		<div region="center">
			<table id="resultList"></table>
		</div>
		<div id="planName" title="项目信息" style="overflow:hidden;padding:0px">
				<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div>
			<script type="text/javascript">
				/*
				 * 查询
				 */
				function doSearch(){
					$('#resultList').datagrid({
						queryParams:form2Json('searchForm')
					});
                    //单元格tooltip提示
                    $('#resultList').datagrid('doCellTip', {
						onlyShowInterrupt:true,
                        position : 'bottom',
                        maxWidth : '200px',
                        tipStyler : {
                            'backgroundColor' : '#EFF5FF',
                            borderColor : '#95B8E7',
                            boxShadow : '1px 1px 3px #292929'
                        }
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
					resetForm('searchForm');
//					doSearch();
				}
			
			var  userRole="${userRole=='DUDAO'}";
			var type="${type=='edit'}";
			$(function(){
                $('#plan_year').combobox({
                    onChange:function(newVal,oldVal){
                        $('#w_plan_year').val(newVal);
                    }
                });
			    if('${crudObject.w_plan_year}' == '') {
                    var now = new Date();
                    $('#plan_year').combobox('setValue', now.getFullYear());
                    $('#plan_year').combo('setText', now.getFullYear());
                    $('#w_plan_year').val(now.getFullYear());
                }else{
                    $('#plan_year').combobox('select', '${crudObject.w_plan_year}');
                }

			    var bodyW = $('body').width();
				//查询
				showWin('dlgSearch');
				// 初始化生成表格
				$('#resultList').datagrid({
					url : "<%=request.getContextPath()%>/plan/detail/listDetailStart.action?querySource=grid&userRole=${userRole}",
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:true,
					fitColumns:true,
					fit:true,
					border:false,
					cache:false,
					singleSelect:true,
					remoteSort: true,
					queryParams:{
					  'crudObject.w_plan_year':  $('#w_plan_year').val()
                    },
					toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch',750);
						}
					},'-',helpBtn
					/*,
					{
						id:'backButton',
						text:'返回',
						iconCls:'icon-undo',
						handler:function(){
							if(type=="true"){
								backYearList();
							}
							else if(userRole=="true"){
								backYearList('DUDAO');
							}
							else{
								backYearList('view')
							}

						}
					}*/
				],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					columns:[[
						{field:'w_plan_name',title:'项目名称',width:0.25*bodyW+'px',align:'left',halign:'center',sortable:true
							,
							formatter:function(value,rowData,rowIndex){
								return '<a href=\"javascript:void(0)\" onclick=\"planName(\''+rowData.formId+'\');\">'+rowData.w_plan_name+'</a>';
							}
						},
						{field:'w_plan_code',title:'项目编号',width:0.1*bodyW+'px',sortable:true,align:'center'},
						{field:'w_plan_year',
							title:'计划年度',
							width:0.08*bodyW+'px',
							sortable:true,
							align:'center'
						},
						{field:'w_plan_month',
								title:'计划月度',
								width:0.08*bodyW+'px',
								align:'center',
								sortable:true
								},
						{field:'w_plan_type_name',
							title:'计划类别',
							width:0.08*bodyW+'px',
							sortable:true,
							align:'center'
						},
						{field:'audit_dept_name',
							 title:'审计单位',
							 width:0.2*bodyW+'px',
							 align:'center',
							 sortable:true
						},
						{field:'operate',
							 title:'操作',
							 align:'center',
							 width:0.08*bodyW+'px',
							 sortable:false,
							 formatter:function(value,row,index){
								var param = [row.formId,row.status_name];
								var btn2 = "启动,updateDetailPlan,"+param.join(',');
								return ganerateBtn(btn2);
							 },
							halign:'center'
						}
					]]
				});
				//单元格tooltip提示
				$('#resultList').datagrid('doCellTip', {
					onlyShowInterrupt:true,
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
				if(userRole=="false"){
					$("#dudaoButton").linkbutton("disable");
					$("#nodudaoButton").linkbutton("disable");
					if(type=="false"){
						$("#backButton").linkbutton("disable");
					}
				}

				if(type=="false"){

					$("#updateButton").linkbutton("disable");
					$("#backButton").linkbutton("disable");
				}

			});
		</script>
		
			<script type="text/javascript">
			/*
			 * 督导
			 */
			 function supervise(status){
				 var ids=$('#resultList').datagrid('getSelections');
			 	var selPlanLength=0; 
			 	var updateIds = "";
			 	var superName = "";
			 	if(status=='true')
			 		superName = "督导";
			 	else
			 		superName = "不督导";
			 	for(var i=0;i<ids.length;i++){
						var status_name = rows2[i].status_name;
						if(status_name!='正在执行' && status_name!='等待执行'){
							alert("所选取的计划还处在" + status_name + "状态，不能进行" + superName + "操作");
							return 
						}
						updateIds += "'" + ids[i].formId + "',";
						selPlanLength++;
				}
				if(selPlanLength==0){
					alert("请选择要提交的计划！");
					return;
				}
				updateIds = updateIds.substring(0,updateIds.length-1);
			 	if(confirm("您确认" + superName + "吗？")){
			 		window.location.href="plan/detail/supervisePlan.action?status=" + 
			 			 status + "&updateIds=" + updateIds + "&yearFormId=${yearFormId}&type=edit"
			 	}
			 }
		    
		    /*
		     * 返回
		     */
		    function backYearList(flag){
		    	if(flag=='DUDAO')
		    		window.location.href="${contextPath}/plan/year/sendPlanYear.action?userRole=DUDAO";
		    	else
		    		window.location.href="${contextPath}/plan/year/sendPlanYear.action";
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
		
			/*
				修改选中的单条计划
			*/
			function updateDetailPlan(formId,status_name){
				/* var status=status_name;
				if(status&&(status=='计划草稿'||status == '三年计划已审批' || status == '新增已审批')){
					window.location.href="/ais/plan/detail/edit.action?yearFormId=${yearFormId}&isStart=start&crudId="+formId;
					}else{
						$.messager.show({
						title:'提示信息',
						msg:"明细计划已经审批或执行，不能修改！",
						timeout:5000,
						showType:'slide'
					});
					return false;

				} */
				window.location.href="/ais/plan/detail/edit.action?yearFormId=${yearFormId}&isStart=start&crudId="+formId;
			}
			/*
				改变底部按钮状态
			*/
			function changeButtonState(checkbox,status){
				var num=0;
				var id ;
				var Stname="";
				 var ids=$('#resultList').datagrid('getSelections');
				for(var i=0;i<ids.length;i++){
					if(i==0){
						id = ids[i].formId;
						num = num + 1;
						Stname=ids[i].status_name
					}
				}
				var subButton = document.getElementById('subButton');
				var updateButton = document.getElementById('updateButton');
				var deleteButton = document.getElementById('deleteButton');
				var adjustButton = document.getElementById('adjustButton');
				if(num>1){
					updateButton.disabled=true;
				}
				if(num==1){
					status =Stname;
					updateButton.disabled=true;
					if(status=='计划草稿'){
						updateButton.disabled=false;
					}
					if(status=='等待执行'){//只有这个状态才能延期,调整,注销,结转等
					}
				}
				if(num==0){
					updateButton.disabled=true;
				}
			}
			function planName(id){
				var viewUrl = "${contextPath}/plan/detail/view.action?crudId="+id;
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
		</script>

	
	</body>
</html>