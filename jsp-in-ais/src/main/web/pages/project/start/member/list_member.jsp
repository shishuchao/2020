<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目成员列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<!-- <link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" /> -->
		<!-- <link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" /> -->
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/datagrid-detailview.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<!--<div region="north" title="查询条件" data-options="split:false,collapsed:true" style="height:145px;">-->
		<div id="dlgSearch" class="easyui-dialog" title="查询条件" modal="true" closed="true" draggable="false" style="width:600px;height:300px;overflow:hidden">
			<div class="panel layout-panel layout-panel-center" style="width: 586px; left: 6px; top: 30px;">
			<div region="center" title="" class="panel-body panel-body-noheader layout-body" style="width: 584px; height: 234px;">
			<s:form id="myForm" name="myForm" action="getlistMembers" namespace="/project">
		  		<s:hidden name="crudId"/>
				<table cellpadding=0 cellspacing=1 border=0 align="center" class="ListTable">
					<tr style="display:none">
						<td class="EditHead">
							分组类型
						</td>
						<td class="editTd">
							<select class="easyui-combobox" data-options="panelHeight:'auto'" name="group.groupType" size="3" style="width:150px;"  editable="false">
								<option value="">&nbsp;</option>
								<option value="zhengti">整体</option>
								<option value="fenbu">分部</option>
						    </select>	
						</td>
						<td class="EditHead">
							分组名称
						</td>
						<td class="editTd">
							<s:textfield name="group.groupName" cssClass="noborder"/>
						</td>
					</tr>
					<tr class="listtablehead">
						<td class="EditHead">
							项目角色
						</td>
						<td class="editTd">
							<select class="easyui-combobox" data-options="panelHeight:'auto'" name="proMember.role" size="5" style="width:150px;"  editable="false">
								<option value="">&nbsp;</option>
								<option value="fuzeren">项目领导</option>
								<option value="zuzhang">项目组长</option>
								<!-- <option value="fuzuzhang">副组长</option> -->
								<option value="zhushen">项目主审</option>
								<option value="weihuren">维护人</option>
								<option value="zuyuan">项目参审</option>
						    </select>	
						</td>
						<td class="EditHead">
							所属单位
						</td>
						<td class="editTd">
							<s:textfield name="proMember.belongToUnitName" cssClass="noborder"/><!--  cssStyle="width:160px;" -->
						</td>
					</tr>
				</table>
			</s:form>
			</div>
			</div>
			<div class="panel layout-panel layout-panel-south" style="width: 586px; left: 6px; top: 266px;">
			<div region="south" border="false" style="text-align: right; padding-right: 20px; width: 566px; height: 26px;" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body">
				<div style="display: inline;" align="right">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="doReset()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
			</div>
			</div>
		</div>
		<div region="center" >
			<table id="resultList"></table>
		</div>
		<!-- <div id="dlg" class="easyui-dialog" title="对话框" closed="true" modal="true" style="width:800px;height:500px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div> -->
		<script type="text/javascript">
		var bodyWidth = $("body").width();
		var bodyHeight = $("body").height();
			function msg11(){
				$.messager.show({
					title:'提示信息',
					msg:'客户到底喜欢哪种样子呢？！'
				});
				$.messager.show({
					title:'提示信息',
					msg:'客户到底喜欢哪种样子呢？！',
					style:{
						top:document.body.scrollTop+document.documentElement.scrollTop
					}
				});
				$.messager.show({
					title:'提示信息',
					msg:'客户到底喜欢哪种样子呢？！',
					style:{
						right:'',
						bottom:''
					}
				});
			}
			function msg22(){
				msgbox('提示信息','客户到底喜欢哪种样子呢？！');
			}
			function msg55(){
				$.messager.alert('提示信息','客户到底喜欢哪种样子呢？！','info');
				$.messager.alert('警告','客户到底喜欢哪种样子呢？！','warning');
				$.messager.alert('错误','客户到底喜欢哪种样子呢？！','error');
			}
			function msg33(){
				window.parent.$.messager.show({
					msg:'<div style="color:blue;font-weight:bold;width:100%">提示：客户到底喜欢哪种样子呢？！</div>',
					style:{
						right:'',bottom:'',height:'50px',modal:false,
						top:document.body.scrollTop+document.documentElement.scrollTop
					}
				});
			}
			function msg44(){
				window.parent.$.messager.show({
					msg:'<span style="color:red;font-weight:bold;width:100%">错误：客户到底喜欢哪种样子呢？！</span>',
					style:{
						right:'',bottom:'',height:'50px',modal:true,
						top:document.body.scrollTop+document.documentElement.scrollTop
					}
				});
			}
		
			var interval;
			function msgbox(ttl,msg,secs){
				if (interval) clearInterval(interval);
				var time=1000;
				if (!secs) secs=5;
				$.messager.alert(' ',
					'<font size=\"2\" color=\"#666666\"><strong>'+msg+'</strong></font>',
					'infoSunnyIcon',
					function(){});
				$(".panel-title").append(ttl+"（"+secs+"秒后自动关闭）");
				interval=setInterval(fun,time);
				function fun(){
					if (!$(".messager-body")[0]) {
						clearInterval(interval);
						return;
					}
					--secs;
					if(secs==0){
				  		$(".messager-body").window('close');
				  		clearInterval(interval);
				  		return;
					}
					$(".panel-title").text("");
					$(".panel-title").append(ttl+"（"+secs+"秒后自动关闭）");
				}
			}
			
			var _curwai,_curnei,_curshen,_curuser;
			function closedlg(flag) {
				$(_curwai).dialog('destroy');
				$(_curnei).dialog('destroy');
				$(_curshen).dialog('destroy');
				$(_curuser).dialog('destroy');
				if(!flag) doSearch();
			}
			function closerow(index,flag) {
				if(!flag)
					doSearch();
		        else
		        	$('#resultList').datagrid('collapseRow',index);
			}
			$(function(){
				$('#resultList').datagrid({
					url : "${pageContext.request.contextPath}/project/getlistMembers.action?querySource=grid",
					queryParams : form2Json('myForm'),
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					pageSize: 20,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',
					border:false,
					singleSelect:true,
					remoteSort: false,					
					toolbar:[
						{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								freshGrid();
							}
						},'-',
						{
							id:'export',
							text:'导出Excel',
							iconCls:'icon-export',
							handler:function(){
								exportM();
							}
						},'-',
						<s:if test="${type ne 'view' }">
						{
							id:'searchEmployeeButton',
							text:'检索审计人员',
							iconCls:'icon-search',
							handler:function(){
								searchEmployee();
							}
						},'-',
						{
							id:'addMemberButton',
							text:'增加内部审计人员',
							iconCls:'icon-add',
							handler:function(){
								openAddMemberPage();
							}
						},'-',
						{
							id:'addOutSystemMemberButton',
							text:'增加外部审计人员',
							iconCls:'icon-add',
							handler:function(){
								openAddOutSystemMemberPage();
							}
						},'-',
						/*,{
							id:'deleteMemberButton',
							text:'删除',
							iconCls:'icon-delete',
							handler:function(){
								deleteMember();
							}
						}
						,{
							id:'modifyMemberButton',
							text:'修改',
							iconCls:'icon-edit',
							handler:function(){
								openModifyMemberPage();
							}
						}*/
						helpBtn
						</s:if>
						/*,{id:'msg1',text:'msg1',iconCls:'icon-add',handler:function(){msg11();}}
						,{id:'msg2',text:'msg2',iconCls:'icon-add',handler:function(){msg22();}}
						,{id:'msg5',text:'msg5',iconCls:'icon-add',handler:function(){msg55();}}
						,{id:'msg3',text:'msg3',iconCls:'icon-add',handler:function(){msg33();}}
						,{id:'msg4',text:'msg4',iconCls:'icon-add',handler:function(){msg44();}}*/
					],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					frozenColumns:[[
						/*{field:'',title:'选择',checkbox:true,halign:'center',align:'center',
							handler:function(value,row,index){
								//changeMemberButtonState(this,row.isAddByPlan,row.isOutSystem,row.role);
							}
						},*/
						{field:'userName',title:'项目成员',width:'10%',halign:'center',align:'left',sortable:true,
							formatter:function(value,row,index){
								if(row.isOutSystem!='Y') {
									return '<a style="color:blue" onclick="showUser(\''+row.userId+'\');" href="javascript:void(0);">'+value+'</a>&nbsp;';
								}
								return value;
							}
						}
					]],
					columns:[[
						{field:'roleName',title:'项目角色',width:'10%',halign:'center',align:'left',sortable:true},
						{field:'groupName',title:'所属分组',halign:'center',width:'10%',align:'center',sortable:true}, 
						{field:'belongToUnitName',title:'所属单位',width:'15%',halign:'center',align:'left',sortable:true,
							formatter:function(value,row,index){
								if(row.isOutSystem=='Y') return '外部审计人员';
								return row.belongToUnitName;
							}
						}, 
						{field:'sex',title:'性别',width:'5%',halign:'center',align:'left',sortable:true},
						{field:'birthday',title:'出生日期',width:'10%',halign:'center',align:'left',sortable:true},
						{field:'mobileTelephone',title:'手机号',width:'10%',halign:'center',align:'left',sortable:true},
						{field:'technicalPost',title:'职称级别',width:'5%',halign:'center',align:'left',sortable:true},
						{field:'duty',title:'职务',width:'5%',halign:'center',align:'left',sortable:true},
						{field:'state',title:'状态',width:'5%',wdith:100,halign:'center',align:'left',sortable:true,color:'red',
							 formatter:function(value,row,index){
								if(row.state=="Y"){
									return "在组";
								}							
								
								if(row.state=="N"){
									return "离组";
								}													
								
							},
							styler: function(value,row,index){
								if (value=="N"){
									return 'color:red';
								}
							}
						}						
						<s:if test="${type ne 'view' }">
						,{field:'proMemberId',title:'操作',halign:'center',align:'center',
							formatter:function(value,row,index){									
								var s='';	
								var k='';
								var roleView ='${roleView}';
								var roleGroupId ='${roleGroupId}';
								
								if (roleView == "1" ){
									 k = '1'
								}else if (roleView == "2" &&roleGroupId != null &&  roleGroupId.indexOf(row.groupId) != -1){
									 k = '1'
								}
								if (k == '1' ){
									if(row.isOutSystem!='Y') {
										s += '&nbsp;<a href="javascript:;" style="color:blue" onclick="openModifyMemberPage(\''+row.proMemberId+'\')">修改</a>';
									} else {
										s += '&nbsp;<a href="javascript:;" style="color:blue" onclick="openModifyOutMemberPage(\''+row.proMemberId+'\')">修改</a>';
									}

									s += '&nbsp;<a href="javascript:;" style="color:blue" onclick="deleteMember(\''+row.proMemberId+'\')">删除</a>';
									s += '&nbsp;<a href="javascript:;" style="color:blue" onclick="changeState(\''+row.proMemberId+'\',\''+row.userId+'\',\''+row.state+'\')">'+(row.state=="Y"?"离组":"在组")+'</a>';
								}										
								return s;
							}
						}
						</s:if>
						/*,{field:'proMemberId',title:'查看',halign:'center',align:'center',
							formatter:function(value,row,index){
								if(row.isOutSystem!='Y') {
									var s = '',s1,s2;
								<%
									if (ais.sysparam.util.SysParamUtil.getSysParam("ais.prepare.employee.link") == null
										|| ais.sysparam.util.SysParamUtil.getSysParam("ais.prepare.employee.link").equals("Y")) {
								%>
										s1='${contextPath}/mng/employee/employeeInfoView.action?ul='+row.userId;
										s2='人员信息';
										s += '<a onclick="var o=$(\'#dlg\');o.dialog({width:850,height:500,maximizable:true,resizable:true,draggable:true,title: \''+s2+'\'});o[0].children[0].src=\''+s1+'\';o.dialog(\'open\')" href="javascript:void(0);">'+s2+'</a>&nbsp;';
								<%
									}
								%>
									//s1='${contextPath}/mng/examproject/members/audProjectMembersInfo/joblookAtDetail.action?ul='+row.userId;
									s1='${contextPath}/mng/examproject/members/audProjectMembersInfo/lookAtDetail.action?ul='+row.userId;
									s2='人员状态';
									s += '<a onclick="var o=$(\'#dlg\');o.dialog({width:850,height:500,maximizable:true,resizable:true,draggable:true,title: \''+s2+'\'});o[0].children[0].src=\''+s1+'\';o.dialog(\'open\')" href="javascript:void(0);">'+s2+'</a>&nbsp;';
									return s;
								}
							}
						}*/
					]]
					/*,onCheck:function(idx,row){
						changeMemberButtonState(row.isAddByPlan,row.isOutSystem,row.role);
					}*/
					,loadFilter:function(data){
						if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
							data = {
								total: data.length,
								rows: data
							}
						}
						var dg = $(this);
						var opts = dg.datagrid('options');
						var pager = dg.datagrid('getPager');
						pager.pagination({
							onSelectPage:function(pageNum, pageSize){
								opts.pageNumber = pageNum;
								opts.pageSize = pageSize;
								pager.pagination('refresh',{
									pageNumber:pageNum,
									pageSize:pageSize
								});
								dg.datagrid('loadData',data);
							}
						});
						if (!data.originalRows){
							data.originalRows = (data.rows);
						}
						var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
						var end = start + parseInt(opts.pageSize);
						data.rows = (data.originalRows.slice(start, end));
						return data;
					}
				    //,view: detailview
				    ,detailFormatter: function(index,row){    
				        return '<div id="ddv-' + index + '" style="padding:5px 0"></div>';    
				    }    
				    ,onExpandRow: function(index,row){
						var dg = $(this);
				        $('#ddv-'+index).panel({
				            border:false,
				            cache:false,
				            href:'${contextPath}/project/editMember.action?crudId=${crudId}&comeFrom=list&proMemberId='+row.proMemberId+'&proMemberIndex='+index+'&isAddByPlan='+row.isAddByPlan,
				            onLoad:function(){
				                dg.datagrid('fixDetailRowHeight',index);
				            }
				        });
				        dg.datagrid('fixDetailRowHeight',index);
				    }
				}); 
			});
			
			function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			function doSearch(){
	        	$('#resultList').datagrid({
	    			queryParams:form2Json('myForm')
	    		});
				$('#dlgSearch').dialog('close');
	        	//$('#resultList').datagrid('reload');
	        }
	        function doReset(){//onclick="window.location.href='${pageContext.request.contextPath}/project/getlistMembers.action?crudId=${crudId}'"
				var id=$("#myForm_crudId").val();
				resetForm('myForm');
				$("#myForm_crudId").val(id);
				//doSearch();
			}
			function doCancel(){
				$('#dlgSearch').dialog('close');
			}
			/*
			* 成员信息
			*/
			function showUser(userid) {
				var arg = {width:950,height:450,closed:true,modal:true,maximizable:true,maximized:true,resizable:true,draggable:true,title: '人员信息'};
				var url = '${contextPath}/mng/employee/employeeInfoViewPrepare.action?ul='+userid;
				_curuser = _showDlg(arg,url);
			}
			/*
			* 导出成员
			*/
			function exportM(){
				document.getElementById('myForm').action='${contextPath}/project/exportMembers.action';
				document.getElementById('myForm').submit();
			}
			/**
			*	打开增加外部用户页面
			*/
			function openAddOutSystemMemberPage(){
				jQuery.ajax({
					url:'${contextPath}/project/prepare/isMyProject.action',
					type:'POST',
					data:{"crudId":'${crudId}'},
					dataType:'json',
					async:'false',
					success:function(data){
						if(1 == 1) {
							var url = '${contextPath}/project/editMember.action?crudId=${crudId}&addMemberOption=outSystem';
							var arg = {width:500,height:230,closed:true,modal:true,maximizable:false,resizable:false,draggable:false,title: '增加外部审计人员'};
							_curwai = _showDlg(arg,url);
						}else{
							$.messager.show({
								title:'提示信息',
								msg:'您不是项目组成员，不能进行操作！'
							});
						}
					},
					error:function(){
					}
				});
				
			}
			
			/**
				打开添加组员页面
			*/
			function openAddMemberPage(){
				jQuery.ajax({
					url:'${contextPath}/project/prepare/isMyProject.action',
					type:'POST',
					data:{"crudId":'${crudId}'},
					dataType:'json',
					async:'false',
					success:function(data){
						if(1 == 1) {
							var url = '${contextPath}/project/editMember.action?crudId=${crudId}';
							var arg = {width:800,height:460,closed:true,modal:true,maximizable:false,resizable:true,draggable:true,title: '增加内部审计人员'};
							_curnei = _showDlg(arg,url);
						}else{
							$.messager.show({
								title:'提示信息',
								msg:'您不是项目组成员，不能进行操作！'
							});
						}
					},
					error:function(){
					}
				});
			  	
			}
			
			/**
				打开检索内部审计人员页面
			*/
			function searchEmployee(){
				jQuery.ajax({
					url:'${contextPath}/project/prepare/isMyProject.action',
					type:'POST',
					data:{"crudId":'${crudId}'},
					dataType:'json',
					async:'false',
					success:function(data){
						if(1 == 1) {
							var url = '${contextPath}/mng/employee/searchEmployee.action?crudId=${crudId}';
							var arg = {width:900,height:465,closed:true,modal:true,maximizable:true,resizable:true,draggable:true,title: '检索审计人员'};
							_curshen = _showDlg(arg,url);
						}else{
							$.messager.show({
								title:'提示信息',
								msg:'您不是项目组成员，不能进行操作！'
							});
						}
					},
					error:function(){
					}
				});
			  	
			}

			/**
				删除组员
			*/
			/*function deleteMember(){
				var rows = $('#resultList').datagrid('getSelections');
				if (rows.length<=0) {
					$.messager.show({
						title:'提示信息',
						msg:'请选择要删除的项目成员！'
					});
					return;
				}
				for(var i=0; i<rows.length; i++){
					$.messager.confirm('确认', '确定要删除选定的项目成员吗？', function(r){
						if (r){
							jQuery.ajax({
								url:'${contextPath}/project/prepare/isMyProject.action',
								type:'POST',
								data:{"crudId":'${crudId}'},
								dataType:'json',
								async:'false',
								success:function(data){
									if(1 == 1) {
										jQuery.ajax({
											url:"${contextPath}/project/deleteMember.action?crudId=${crudId}&&proMemberId="+rows[i].proMemberId,
											type:'POST',
											async:'false',
											success:function(data){
												doSearch();
											}
										});										
										//var url = "${contextPath}/project/deleteMember.action?crudId=${crudId}&&proMemberId="+rows[i].proMemberId;
										//var o=$('#dlg');
										//o.panel({'title': '删除审计人员'});
										//o[0].children[0].src=url;
										//o.dialog('open');
									}else{
										$.messager.show({
											title:'提示信息',
											msg:'您不是项目组成员，不能进行操作！'
										});
									}
								},
								error:function(){
								}
							});
						}
					});
					break;
				}
			}*/
			function deleteMember(userid){
				$.messager.confirm('确认', '确定要删除选定的项目成员吗？', function(r){
					if (!r) return;
					jQuery.ajax({
						url:'${contextPath}/project/deleteMemberRole.action',
						type:'POST',
						data:{"project_id":'${crudId}','proMemberId':userid},
						dataType:'json',
						async:'false',
						success:function(data){
							if ( data ==  "1"){
								window.parent.$.messager.show({
									title:'提示信息',
									msg:"该用户是分组组长，请在分组中重新选择组长！"
								});
							}else{
								jQuery.ajax({
									url:"${contextPath}/project/deleteMember.action?crudId=${crudId}&&proMemberId="+userid,
									type:'POST',
									async:'false',
									success:function(data){
										//liululu 根据后台传来的data判断，flag值为false，提示删除失败信息。否则，提示删除成功。
										var jsdata = JSON.parse(data);
										if(jsdata.flag == "false"){
											window.parent.$.messager.show({
												title:'提示信息',
												msg:jsdata.msg
											});
										}else{
											doSearch();
											//liululu
											window.parent.$.messager.show({
												title:'提示信息',
												msg:jsdata.msg
											});
										}
										
									},
								});
							}

					
						},
						error:function(){
							$.messager.show({
								title:'提示信息',
								msg:'您不是项目组成员，不能进行操作！'
							});
						}
					});
				});
			}
			
			
		  /**
			    改变状态：在组/离组
		   */
		   function changeState(userid,floginname,stateValue){
			    //检验是否有未完成任务
				$.ajax({
					url:"${contextPath}/project/checkTask.action?crudId=${crudId}&&floginname="+floginname,
					type:'POST',
					async:'false',	
					success:function(data){
						if(data.task == "") {							
						    //改变状态：在组/离组					        
							$.ajax({
								url:"${contextPath}/project/changeState.action?crudId=${crudId}&&proMemberId="+userid,
								type:'POST',
								async:'false',	
								data:{'stateValue':stateValue},
								success:function(data){
									var jsdata = JSON.parse(data);
									if(jsdata.flag == "false"){
										window.parent.$.messager.show({
											title:'提示信息',
											msg:jsdata.msg
										});
									}else {
										$('#resultList').datagrid('clearSelections');
										$('#resultList').datagrid("reload");
										top.$.messager.show({
											title: '提示信息',
											msg: '状态修改为:' + (stateValue == "Y" ? "离组" : "在组") + ''
										});
									}
								}
							});
							$('#resultList').datagrid('clearSelections');
						}else if(data.task != "") {
							top.$.messager.show({
								title:'提示信息',
								msg:'该成员尚存在['+(data.task)+']未完成，不能设置离组！'
							});
							$('#resultList').datagrid('clearSelections');
						}
					}
				});
			}
			
			/**
				打开修改组员信息页面
			*/
			function openModifyMemberPage(proMemberId){
				var dg = $('#resultList');
				jQuery.ajax({
					url:'${contextPath}/project/prepare/isMyProject.action',
					type:'POST',
					data:{"crudId":'${crudId}'},
					dataType:'json',
					async:'false',
					success:function(data){
				        var url = '${contextPath}/project/editMember.action?comeFrom=list&crudId=${crudId}&proMemberId='+proMemberId;
						var arg = {width:780,height:420,closed:true,modal:true,maximizable:false,resizable:false,draggable:false,title: '编辑'};
				        _curnei = _showDlg(arg,url);
					},
					error:function(){
						$.messager.show({
							title:'提示信息',
							msg:'您不是项目组成员，不能进行操作！'
						});
					}
				});
			}

			function openModifyOutMemberPage(proMemberId){
				var dg = $('#resultList');
				jQuery.ajax({
					url:'${contextPath}/project/prepare/isMyProject.action',
					type:'POST',
					data:{"crudId":'${crudId}'},
					dataType:'json',
					async:'false',
					success:function(data){
						var url = '${contextPath}/project/editMember.action?addMemberOption=outSystem&comeFrom=list&crudId=${crudId}&proMemberId='+proMemberId;
						var arg = {width:780,height:420,closed:true,modal:true,maximizable:false,resizable:false,draggable:false,title: '编辑'};
						_curnei = _showDlg(arg,url);
					},
					error:function(){
						$.messager.show({
							title:'提示信息',
							msg:'您不是项目组成员，不能进行操作！'
						});
					}
				});
			}
			
			function refresh() {
				$('#resultList').datagrid('reload');
			}
		</script>
	</body>
</html>
