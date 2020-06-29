<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计问题分配列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="easyui-dialog" title="查询条件" modal="true" closed="true" draggable="true"  style="width:600px;height:300px;overflow:hidden">
			<div class="panel layout-panel layout-panel-center" style="width: 586px; left: 6px; top: 30px;">
			<div region="center" title="" class="panel-body panel-body-noheader layout-body" style="width: 584px; height: 234px;">
				<s:form id="myForm" name="myForm" action="jobdecideProblemList" namespace="/proledger/problem">
					<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
							<td class="EditHead" style="width:15%">是否关闭</td>
							<td class="editTd" style="width:35%">
								<select class="easyui-combobox" name="middleLedgerProblem.is_closed" style="width:150px;"  editable="false" data-options="panelHeight:'auto'">
									<option value="">&nbsp;</option>
									<option value="是">是</option>
									<option value="否">否</option>
								</select>
								<input type="hidden" name="project_id" value="${project_id}" />
							</td>
							<td class="EditHead" style="width:15%">项目编号</td>
							<td class="editTd" style="width:35%">
								<s:textfield cssClass="noborder" name="middleLedgerProblem.project_code"  maxlength="50" /></td>
						</tr>
						<tr>
							<td class="EditHead" >审计单位</td>
							<td class="editTd">
								<s:buttonText2 cssClass="noborder" cssStyle="width:150px;" name="middleLedgerProblem.audit_dept_name"
									hiddenName="middleLedgerProblem.audit_dept"
									doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
									  title:'审计单位',
									  param:{
										'p_item':1,
										'orgtype':1
									  }
									})"
									doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0" readonly="true" /></td>
							<td class="EditHead" nowrap>被审计单位</td>
							<td class="editTd">
								<s:buttonText2 cssClass="noborder" cssStyle="width:150px;" name="middleLedgerProblem.audit_object_name"
									hiddenName="middleLedgerProblem.audit_object"
									doubleOnclick="showSysTree(this,
									{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
										cache:false,
										checkbox:true,
										title:'被审计单位树'
									})"
									doubleSrc="${pageContext.request.contextPath}/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0" readonly="true" /></td>
						</tr>
						<tr>
							<td class="EditHead" >问题点</td>
							<td class="editTd" colspan="3">
								<s:buttonText cssClass="noborder" cssStyle="width:150px;" id="problem_name"  hiddenId="problem_code"
									name="middleLedgerProblem.problem_name"
									hiddenName="middleLedgerProblem.problem_code"
									doubleOnclick="showSysTree(this,{
										//url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
										param:{
											'rootParentId':'0',
											'beanName':'LedgerTemplateNew',
											'treeId'  :'id',
											'treeText':'name',
											'treeParentId':'fid',
											'treeOrder':'orderNO'
										},
										onlyLeafCheck:true,
										title:'请选择问题点'
									})"
									doubleSrc="/resources/images/s_search.gif"
									doubleCssStyle="cursor:hand;border:0" readonly="true" /></td>
						</tr>
					</table>
					<s:hidden id="crudIdStrings" name="crudIdStrings" />
				</s:form>
			</div>
			</div>
			<div class="panel layout-panel layout-panel-south" style="width: 586px; left: 6px; top: 266px;">
			<div region="south" border="false" style="text-align: right; padding-right: 20px; width: 566px; height: 26px;" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body">
				<div style="display: inline;" align="right">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
			</div>
			</div>
		</div>
		<div region="center" >
			<table id="resultList"></table>
		</div>
		<div id="planName" title="项目信息" style="overflow:hidden;padding:0px">
			<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div>
		<div id="viewMiddle" title="定稿问题查看" style="overflow:hidden;padding:0px">
	    	<iframe id="openViewMiddle" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
	  	<div id="trackList" title="审计问题整改跟踪列表" style="overflow:hidden;padding:0px">
	  		<iframe id="openTrackList" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  	</div>
		<script type="text/javascript"> 
			$(function(){
				$('#resultList').datagrid({
					//url : "${contextPath}/proledger/problem/jobdecideProblemList.action?crudIdStrings=${crudIdStrings}&querySource=grid",
					url : "${contextPath}/proledger/problem/jobdecideProblemList.action?querySource=grid&project_id=${project_id}&view=${view}",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					pageSize: 20,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					border:false,
					singleSelect:true,
					remoteSort: false,
					onClickRow:function(index, row){
						changeButtonState(row.is_closed,row.tracker_code);
					},
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								freshGrid();
							}
						}/* ,
						{
							id:'export',
							text:'导出Excel',
							iconCls:'icon-export',
							handler:function(){
								exportM();
							}
						} */
			<s:if test="list.size!=0 and (view != 'view')">
				<s:if test="operateRole=='yes'">
						,{
							id:'assign_tracker',
							text:'分配跟踪人',
							iconCls:'icon-user',
							handler:function() {
								if (assignTracker()) {
									//------默认为整改期限前1个月-------
									var crudIdStrings = $('#crudIdStrings').val();
									var arr = crudIdStrings.split(',');
									if (arr.length == 2) {
										var a = crudIdStrings;
										if (a != "") {
										    /*去掉分配跟踪人默认日期
											var b = getPreMonth(a);
											$('#tracker_date').val(b);*/
											$('#tracker_date').val("");
										} else {
											clearTrackerDiv();
										}
									} else {
										clearTrackerDiv();
									}
									//分配信息初始化
									$.ajax({
										dataType : 'json',
										url : "${contextPath}/proledger/problem/closeProblem!initProblemInfo.action",
										data : {
											'problemId' : crudIdStrings
										},
										type : "POST",
										success : function(data) {
											/* var dataResult = unique(data);
											alert(dataResult);
											if(null!=dataResult[1] && dataResult[1]!='')
											$("#inittracker option[value="+dataResult[1]+"]").attr("selected",true);
											if(null!=dataResult[2] && dataResult[2]!=''){
												$("#tracker_date").val(dataResult[2]);						
											} */
											if(null!=data[1] && data[1]!='')
											$("#inittracker option[value="+data[1]+"]").attr("selected",true);
											if(null!=data[2] && data[2]!=''){
												$("#tracker_date").val(data[2]);						
											}
										}
									});
									
									$('#lrsjyd_div').window('open');

								}
							}
						}
						,{
							id:'close_track',
							text:'关闭问题',
							iconCls:'icon-delete',
							handler:function() {
								if (assignTracker()) {
									$('#closer_div').window('open');
									clearCloserDiv();
									$("#close_desc").val('');
								}
							}
						}
				</s:if>
						,{
							id:'zgls',
							text:'跟踪记录',
							iconCls:'icon-edit',
							handler:function() {
								var rows=$('#resultList').datagrid('getSelections');
								var count = rows.length;
								if (count == 1) {
									var crudId = '';
									for(i=0;i < count;i++){
										crudId += rows[i].id ;
									}
									window.location.href = '/ais/proledger/problem/jobtrackList.action?project_id=${project_id}&crudIdStrings='
											+ crudId;
								}else {
									showMessage1("请选择一条信息!");
								}
							}
						}
			</s:if>
					],
					frozenColumns:[[
						/* {field:'project_code',title:'项目编号',width:200,halign:'center',align:'right',sortable:true,
							formatter:function(value,row,index){
								return '<a href=\"javascript:void(0)\" onclick=\"openMsg(\''+row.project_id+'\');\">'+value+'</a>';
							}
						}, */
						{field:'project_name',title:'项目名称',width:200,halign:'center',align:'left',sortable:true},
						
						{field:'serial_num',title:'审计问题编号',width:200,halign:'center',align:'center',sortable:true,
							formatter:function(value,row,index){
								return '<a href=\"javascript:void(0)\" onclick=\"openViewMiddle(\''+row.id+'\');\">'+value+'</a>';
							}
						},
						{field:'audit_con',title:'问题标题',width:300,halign:'center',align:'left',sortable:true}
					]],
					columns:[[
						{field:'is_closed',title:'是否关闭',halign:'center',align:'center',sortable:true,
							formatter:function(value,row,index){
								if(row.is_closed=='是') return '是';
								return '否';
							}
						},
						/*{field:'creater_date',title:'问题所属期间',halign:'center',align:'left',sortable:true},*/
						{field:'sort_big_name',title:'问题类别',halign:'center',align:'left',sortable:true},
						{field:'problem_name',title:'问题点',width:200,halign:'center',align:'left',sortable:true},
						{field:'problem_money',title:'发生金额（万元）',halign:'center',align:'left',sortable:true}, //<fmt:formatNumber value="${row.problem_money}" pattern="0.00"/>
						{field:'problemCount',title:'发生数量(个)',halign:'center',align:'left',sortable:true},
						{field:'audit_object_name',title:'被审计单位',halign:'center',align:'left',sortable:true},
						{field:'mend_term_date',title:'整改期限',halign:'center',align:'left',sortable:true},
						/* {field:'describe',title:'问题摘要',width:300,halign:'center',align:'left',sortable:true},
						{field:'audit_advice',title:'处理决定',width:300,halign:'center',align:'left',sortable:true}, *///sortName="examine_method"
						{field:'tracker_name',title:'跟踪人',halign:'center',align:'left',sortable:true},
						{field:'track_num',title:'跟踪记录',halign:'center',align:'left',sortable:true,
							formatter:function(value,row,index){
								return '<a href=\"javascript:void(0)\" onclick=\"openTrackList(\''+row.id+'\');\">'+value+'</a>';
							}
						}
					]]
				}); 
			});
			
			//数组去重
			function unique(arr) {
			    var result = [], hash = {};
			    for (var i = 0, elem; (elem = arr[i]) != null; i++) {
			        if (!hash[elem]) {
			            result.push(elem);
			            hash[elem] = true;
			        }
			    }
			    return result;
			}
			
		    function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			/*
			* 查询
			*/
			function doSearch(){
	        	$('#resultList').datagrid({
	    			queryParams:form2Json('myForm')
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
	        function restal(){//onclick="window.location.href='${pageContext.request.contextPath}/project/getlistMembers.action?crudId=${crudId}'"
				var id=$("#crudIdStrings").val();
				resetForm('myForm');
				$("#crudIdStrings").val(id);
				//doSearch();
			}

			// 初始化
			$(function() {
				//整改落实
				$("#zgls").click(function() {});

				$('#close_track').bind('click', function() {});

				$("#saveCloser").bind("click",function() {
					if(frmCheck(document.getElementById('closer_form'),'closer_table')==false){
						return false;
					}
					var crudId = $('#crudIdStrings').val();
					$.messager.confirm('确认','确定关闭吗？', function(r){
						if (r) {
							if (assignTracker()) {
								var close_desc = $("#close_desc").val();
								$.ajax({
									dataType : 'json',
									url : "${contextPath}/proledger/problem/closeProblem.action",
									data : {
										'crudIdStrings' : crudId,
										'close_desc' : close_desc
									},
									type : "POST",
									success : function(data) {
										showMessage2("关闭成功！");
										$('#closer_div').window('close');
										window.location.reload();
									},
									error : function(data) {
										showMessage2("请求失败！");
									}
								});
							}
						}
					});
				});

				$('#lrsjyd_div').window({
					width : 500,
					height : 250,
					modal : true,
					collapsible : false,
					maximizable : false,
					minimizable : false,
					inline:false,
					zIndex:-1,
					closed : true
				});
				// 打开录入窗口时，清空录入框
				$('#assign_tracker').bind('click', function() {});
				// 关闭录入窗口
				$('#closeWinSjyd').bind('click', function() {
					$('#lrsjyd_div').window('close');
				});

				// 清空分配跟踪人表单
				function clearTrackerDiv() {
					var arr = [ 'tracker_name', 'tracker_code', 'tracker_date' ];
					$.each(arr, function(i, ele) {
						$('#' + ele).val('');
					});
				}

				// 保存跟踪人
				$('#saveSjyd').bind('click',function() {
					if(frmCheck(document.getElementById('lrsjyd_form'),'lrsjyd_table')==false){
						return false;
					}
					var crudIdStrings = $('#crudIdStrings').val();
					var flag = false;
					$.ajax({
						dataType : 'json',
						url : "${contextPath}/proledger/problem/saveTracker.action?crudIdStrings="
								+ crudIdStrings,
						data : $('#lrsjyd_form').serialize(),
						type : "POST",
						async:false,
						success : function(data) {
							showMessage2("保存成功");
							flag = true;
						},
						error : function(data) {
							showMessage2("请求失败！");
						}
					});
					if(flag){
						$('#lrsjyd_div').window('close');
						window.location.reload();
					}
				});

				$('#closer_div').window({
					width : 500,
					height : 250,
					modal : true,
					collapsible : false,
					maximizable : false,
					minimizable : false,
					closed : true
				});
				// 打开录入窗口时，清空录入框
				$('#assign_closer').bind('click', function() {
					if (assignTracker()) {
						$('#closer_div').window('open');
						clearCloserDiv();
					}
				});

				// 清空分配关闭人表单
				function clearCloserDiv() {
					var arr = [ 'closer_name', 'closer_code' ];
					$.each(arr, function(i, ele) {
						$('#' + ele).val('');
					});
					var num = Math.random();
					var rnm = Math.round(num * 9000000000 + 1000000000);
				}
				// 关闭录入窗口
				$('#closeWinCloser').bind('click', function() {
					$('#closer_div').window('close');
				});
				$('#saveCloser1').bind('click',function() {
					var crudIdStrings = $('#crudIdStrings').val();
					$.ajax({
						dataType : 'json',
						url : "${contextPath}/proledger/problem/saveCloser.action?crudIdStrings="
								+ crudIdStrings,
						data : $('#closer_form').serialize(),
						type : "POST",
						success : function(data) {
							showMessage2("保存成功！");
						},
						error : function(data) {
							showMessage2("请求失败！");
						}
					});
				});
			});

			function assignTracker() {
				var rows=$('#resultList').datagrid('getSelections');
				if(rows.length > 0){
					var crudIdStrings = '';
					for(i=0; i<rows.length; i++){
						crudIdStrings += rows[i].id + ',';
					}
					$('#crudIdStrings').val(crudIdStrings);
					return true;
				}else {
					showMessage1("没有选择审计问题");
					return false;
				}

			}

			/**
			 * 获取上一个月
			 *
			 * @date 格式为yyyy-mm-dd的日期，如：2014-01-25
			 */
			function getPreMonth(date) {
				var arr = date.split('-');
				var year = arr[0]; //获取当前日期的年份
				var month = arr[1]; //获取当前日期的月份
				var day = arr[2]; //获取当前日期的日
				var days = new Date(year, month, 0);
				days = days.getDate(); //获取当前日期中月的天数
				var year2 = year;
				var month2 = parseInt(month) - 1;
				if (month2 == 0) {
					year2 = parseInt(year2) - 1;
					month2 = 12;
				}
				var day2 = day;
				var days2 = new Date(year2, month2, 0);
				days2 = days2.getDate();
				if (day2 > days2) {
					day2 = days2;
				}
				if (month2 < 10) {
					month2 = '0' + month2;
				}
				var t2 = year2 + '-' + month2 + '-' + day2;
				return t2;
			}

			function changeButtonState(is_closed, tracker_code) {
				var trackerButton = $('#assign_tracker');//分配跟踪人
				var closerButton = $('#close_track');//分配关闭人	
				var zgls = $('#zgls');//整改落实
				if (is_closed == '' || is_closed == null) {
					if (trackerButton && closerButton) {
						trackerButton.linkbutton('enable');
						closerButton.linkbutton('enable');
					}
					if('${null!=user?user.floginname:null}' == tracker_code){
						if (zgls) {
							zgls.linkbutton('enable');
						}
					}else{
						if (zgls) {
							zgls.linkbutton('disable');
						}
					}
				} else {
					if (trackerButton && closerButton) {
						trackerButton.linkbutton('disable');
						closerButton.linkbutton('disable');
					}
					if (zgls) {
						zgls.linkbutton('disable');
					}
				}
				return;
			}

			function openMsg(projectid){
				var viewUrl = "${contextPath}/proledger/problem/viewPro.action?crudId="+projectid;
				$('#showPlanName').attr("src",viewUrl);
				$('#planName').window('open');
			}
			$('#planName').window({
				width:950, 
				height:400,  
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
				var openViewUrl = "${contextPath}/proledger/problem/trackList.action?crudIdStrings="+id+"&problemcode=problemcode&view=view";
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
		<div id="lrsjyd_div" title="分配跟踪人" style='overflow:hidden;padding:0px;'>
			<form id='lrsjyd_form' name='sjsx_form' method="POST"
				style='height:150px;overflow-y:auto;padding:10px;margin:0px;border:1px solid #cccccc;'>
				<table id="lrsjyd_table" class="ListTable" align="center">
					<tr>
						<td class="EditHead"><font style='color:red'>*</font>&nbsp;问题跟踪人</td>
						<td class="editTd" colspan=3>
							<%-- <s:select list="#request.memberList" name="middleLedgerProblem.tracker_code" listKey="userId" listValue="userName" id="inittracker"></s:select> --%>
							<select id="tracker_code" class="easyui-combobox" name="middleLedgerProblem.tracker_code" editable="false" style="width:150px;" data-options="panelHeight:'auto'">
						       <option value="">&nbsp;</option>
						       <s:iterator value="#request.memberList" id="entry">
							         <s:if test="${middleLedgerProblem.tracker_code==userId}">
						       			<option selected="selected" value="<s:property value="userId"/>"><s:property value="userName"/></option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="userId"/>"><s:property value="userName"/></option>
						       		 </s:else>
						       </s:iterator>
						    </select>
						 <%--<s:buttonText2 id="tracker_name" hiddenId="tracker_code"
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
											maxlength="500" title="问题跟踪人"/>--%>
						</td>
					</tr>
					<tr>
						<td class="EditHead"><font style='color:red'>*</font>&nbsp;跟踪整改结果提醒时间</td>
						<td class="editTd" colspan=3>
							<input class="easyui-datebox" editable="false" type='text' id='tracker_date'  name='middleLedgerProblem.tracker_date' style='width:150px;'>
						</td>
					</tr>
				</table>
			</form>
			<div style='text-align:center;' id='trackBtnDiv' style='padding:15px;'>
				<button id='saveSjyd' class="easyui-linkbutton" iconCls="icon-save">保存</button>
				&nbsp;&nbsp;
				<button id='closeWinSjyd' class="easyui-linkbutton" iconCls="icon-cancel">关闭</button>
			</div>
		</div>

		<div id="closer_div" title="问题关闭说明"
			style='overflow:hidden;padding:0px;'>
			<form id='closer_form' name='closer_form' method="POST"
				style='height:150px;overflow-y:auto;padding:10px;margin:0px;border:1px solid #cccccc;'>
				<table id='closer_table' class="ListTable" align="center">
					<tr>
						<td class="EditHead"><font style='color:red'>*</font>&nbsp;问题关闭说明</td>
						<td class="editTd" colspan=3>
							<s:textarea cssClass="noborder" id="close_desc" name="close_desc" cssStyle="width:100%;height:70px;overflow-y:hidden"></s:textarea>
						</td>
					</tr>
				</table>
			</form>
			<div style='text-align:center;' id='closeBtnDiv' style='padding:15px;'>
				<button id='saveCloser' class="easyui-linkbutton" iconCls="icon-save">保存</button>
				&nbsp;&nbsp;
				<button id='closeWinCloser' class="easyui-linkbutton" iconCls="icon-cancel">关闭</button>
			</div>
		</div>

	</body>
</html>
